# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Probabilistic programming powered by JAX"
HOMEPAGE="
	https://pypi.org/project/numpyro/
	https://github.com/pyro-ppl/numpyro
"
SRC_URI="
	https://github.com/pyro-ppl/numpyro/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/jax[${PYTHON_USEDEP}]
	dev-python/multipledispatch[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/scipy[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}/${PN}-0.17.0-fix-test-wo-funsor.patch" )

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare

	# Remove tests which require tensorflow_probability
	sed -i \
		-e '/T(dist.Beta,/d' \
		-e '/T(dist.BetaProportion,/d' \
		-e '/T(dist.Chi2,/d' \
		-e '/T(dist.Gamma,/d' \
		-e '/T(dist.InverseGamma,/d' \
		-e '/T(dist.StudentT,/d' \
		-e '/(dist.StudentT, (2.0, 0.0, 1.0))/d' \
		test/test_distributions.py || die
}

python_test() {
	local -x CI=1

	local EPYTEST_DESELECT=(
		# Requires funsor
		'test/infer/test_mcmc.py::test_discrete_site_without_infer_enumerate'
		'test/test_pickle.py::test_pickle_hmc_enumeration'
		# Requires tensorflow_probability
		'test/test_distributions_util.py::test_no_tracer_leak_at_lazy_property_sample'
		# Failed: DID NOT RAISE UserWarning
		'test/test_distributions.py::test_interval_censored_validate_sample'
	)

	# test-inference
	epytest test/infer/test_mcmc.py

	# test-modeling
	epytest -k "not test_example" \
		--ignore=test/infer/ \
		--ignore=test/contrib/ \
		--ignore=test/pyroapi \
		test
}
