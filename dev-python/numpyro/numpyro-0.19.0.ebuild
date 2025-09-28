# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

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

python_test() {
	local EPYTEST_DESELECT=(
		# Requires tensorflow_probability
		'test/test_distributions.py::test_cdf_and_icdf[Beta-<lambda>-params6]'
		'test/test_distributions.py::test_cdf_and_icdf[Beta-<lambda>-params7]'
		'test/test_distributions.py::test_cdf_and_icdf[Beta-<lambda>-params8]'
		'test/test_distributions.py::test_cdf_and_icdf[BetaProportion-<lambda>-params10]'
		'test/test_distributions.py::test_cdf_and_icdf[BetaProportion-<lambda>-params11]'
		'test/test_distributions.py::test_cdf_and_icdf[BetaProportion-<lambda>-params9]'
		'test/test_distributions.py::test_cdf_and_icdf[Chi2-<lambda>-params12]'
		'test/test_distributions.py::test_cdf_and_icdf[Chi2-<lambda>-params13]'
		'test/test_distributions.py::test_cdf_and_icdf[Gamma-<lambda>-params30]'
		'test/test_distributions.py::test_cdf_and_icdf[Gamma-<lambda>-params31]'
		'test/test_distributions.py::test_cdf_and_icdf[InverseGamma-<lambda>-params51]'
		'test/test_distributions.py::test_cdf_and_icdf[InverseGamma-<lambda>-params52]'
		'test/test_distributions.py::test_cdf_and_icdf[InverseGamma-<lambda>-params53]'
		'test/test_distributions.py::test_cdf_and_icdf[StudentT-<lambda>-params110]'
		'test/test_distributions.py::test_cdf_and_icdf[StudentT-<lambda>-params111]'
		'test/test_distributions.py::test_cdf_and_icdf[StudentT-<lambda>-params112]'
		'test/test_distributions.py::test_dist_pytree[GaussianCopulaBeta-None-params36]'
		'test/test_distributions.py::test_dist_pytree[GaussianCopulaBeta-None-params37]'
		'test/test_distributions.py::test_dist_pytree[GaussianCopulaBeta-None-params38]'
		'test/test_distributions.py::test_dist_shape[prepend_shape0-GaussianCopulaBeta-None-params36]'
		'test/test_distributions.py::test_dist_shape[prepend_shape0-GaussianCopulaBeta-None-params37]'
		'test/test_distributions.py::test_dist_shape[prepend_shape0-GaussianCopulaBeta-None-params38]'
		'test/test_distributions.py::test_dist_shape[prepend_shape1-GaussianCopulaBeta-None-params36]'
		'test/test_distributions.py::test_dist_shape[prepend_shape1-GaussianCopulaBeta-None-params37]'
		'test/test_distributions.py::test_dist_shape[prepend_shape1-GaussianCopulaBeta-None-params38]'
		'test/test_distributions.py::test_dist_shape[prepend_shape2-GaussianCopulaBeta-None-params36]'
		'test/test_distributions.py::test_dist_shape[prepend_shape2-GaussianCopulaBeta-None-params37]'
		'test/test_distributions.py::test_dist_shape[prepend_shape2-GaussianCopulaBeta-None-params38]'
		'test/test_distributions.py::test_expand[sample_shape0-prepend_shape0-GaussianCopulaBeta-None-params36]'
		'test/test_distributions.py::test_expand[sample_shape0-prepend_shape0-GaussianCopulaBeta-None-params37]'
		'test/test_distributions.py::test_expand[sample_shape0-prepend_shape0-GaussianCopulaBeta-None-params38]'
		'test/test_distributions.py::test_expand[sample_shape0-prepend_shape1-GaussianCopulaBeta-None-params36]'
		'test/test_distributions.py::test_expand[sample_shape0-prepend_shape1-GaussianCopulaBeta-None-params37]'
		'test/test_distributions.py::test_expand[sample_shape0-prepend_shape1-GaussianCopulaBeta-None-params38]'
		'test/test_distributions.py::test_expand[sample_shape1-prepend_shape0-GaussianCopulaBeta-None-params36]'
		'test/test_distributions.py::test_expand[sample_shape1-prepend_shape0-GaussianCopulaBeta-None-params37]'
		'test/test_distributions.py::test_expand[sample_shape1-prepend_shape0-GaussianCopulaBeta-None-params38]'
		'test/test_distributions.py::test_expand[sample_shape1-prepend_shape1-GaussianCopulaBeta-None-params36]'
		'test/test_distributions.py::test_expand[sample_shape1-prepend_shape1-GaussianCopulaBeta-None-params37]'
		'test/test_distributions.py::test_expand[sample_shape1-prepend_shape1-GaussianCopulaBeta-None-params38]'
		'test/test_distributions.py::test_independent_shape[GaussianCopulaBeta-None-params38]'
		'test/test_distributions.py::test_jit_log_likelihood[GaussianCopulaBeta-None-params36]'
		'test/test_distributions.py::test_jit_log_likelihood[GaussianCopulaBeta-None-params37]'
		'test/test_distributions.py::test_jit_log_likelihood[GaussianCopulaBeta-None-params38]'
		'test/test_distributions.py::test_log_prob_gradient[GaussianCopulaBeta-None-params36]'
		'test/test_distributions.py::test_log_prob_gradient[GaussianCopulaBeta-None-params37]'
		'test/test_distributions.py::test_log_prob_gradient[GaussianCopulaBeta-None-params38]'
		'test/test_distributions.py::test_log_prob[False-prepend_shape0-GaussianCopulaBeta-None-params36]'
		'test/test_distributions.py::test_log_prob[False-prepend_shape0-GaussianCopulaBeta-None-params37]'
		'test/test_distributions.py::test_log_prob[False-prepend_shape0-GaussianCopulaBeta-None-params38]'
		'test/test_distributions.py::test_log_prob[False-prepend_shape1-GaussianCopulaBeta-None-params36]'
		'test/test_distributions.py::test_log_prob[False-prepend_shape1-GaussianCopulaBeta-None-params37]'
		'test/test_distributions.py::test_log_prob[False-prepend_shape1-GaussianCopulaBeta-None-params38]'
		'test/test_distributions.py::test_log_prob[False-prepend_shape2-GaussianCopulaBeta-None-params36]'
		'test/test_distributions.py::test_log_prob[False-prepend_shape2-GaussianCopulaBeta-None-params37]'
		'test/test_distributions.py::test_log_prob[False-prepend_shape2-GaussianCopulaBeta-None-params38]'
		'test/test_distributions.py::test_log_prob[True-prepend_shape0-GaussianCopulaBeta-None-params36]'
		'test/test_distributions.py::test_log_prob[True-prepend_shape0-GaussianCopulaBeta-None-params37]'
		'test/test_distributions.py::test_log_prob[True-prepend_shape0-GaussianCopulaBeta-None-params38]'
		'test/test_distributions.py::test_log_prob[True-prepend_shape1-GaussianCopulaBeta-None-params36]'
		'test/test_distributions.py::test_log_prob[True-prepend_shape1-GaussianCopulaBeta-None-params37]'
		'test/test_distributions.py::test_log_prob[True-prepend_shape1-GaussianCopulaBeta-None-params38]'
		'test/test_distributions.py::test_log_prob[True-prepend_shape2-GaussianCopulaBeta-None-params36]'
		'test/test_distributions.py::test_log_prob[True-prepend_shape2-GaussianCopulaBeta-None-params37]'
		'test/test_distributions.py::test_log_prob[True-prepend_shape2-GaussianCopulaBeta-None-params38]'
		'test/test_distributions.py::test_mean_var[GaussianCopulaBeta-None-params36]'
		'test/test_distributions.py::test_mean_var[GaussianCopulaBeta-None-params37]'
		'test/test_distributions.py::test_mean_var[GaussianCopulaBeta-None-params38]'
		'test/test_distributions.py::test_sample_gradient[GaussianCopulaBeta-None-params36]'
		'test/test_distributions.py::test_sample_gradient[GaussianCopulaBeta-None-params37]'
		'test/test_distributions.py::test_sample_gradient[GaussianCopulaBeta-None-params38]'
		# Requires funsor
		'test/infer/test_mcmc.py::test_discrete_site_without_infer_enumerate'
	)
	local -x CI=1
	epytest test/infer/test_mcmc.py
	epytest -x -k "not test_example" \
		--ignore=test/infer/ \
		--ignore=test/contrib/ \
		--ignore=test/pyroapi \
		test
}
