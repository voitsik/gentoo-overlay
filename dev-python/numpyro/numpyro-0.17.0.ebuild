# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Probabilistic programming powered by JAX"
HOMEPAGE="
	https://pypi.org/project/numpyro/
	https://github.com/pyro-ppl/numpyro
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

PATCHES=( "${FILESDIR}/${P}-fix-test-wo-funsor.patch" )

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=(
		# fails randomly
		test/test_diagnostics.py::test_hpdi
		test/test_distributions.py::test_zero_inflated_logits_probs_agree
		# tensorflow_probability
		#test/test_distributions.py::test_dist_shape[prepend_shape0-GaussianCopulaBeta-None-params30]
		#test/test_distributions.py::test_dist_shape[prepend_shape0-GaussianCopulaBeta-None-params31]
		#test/test_distributions.py::test_dist_shape[prepend_shape0-GaussianCopulaBeta-None-params32]
		#test/test_distributions.py::test_dist_shape[prepend_shape1-GaussianCopulaBeta-None-params30]
		#test/test_distributions.py::test_dist_shape[prepend_shape1-GaussianCopulaBeta-None-params31]
		#test/test_distributions.py::test_dist_shape[prepend_shape1-GaussianCopulaBeta-None-params32]
		#test/test_distributions.py::test_dist_shape[prepend_shape2-GaussianCopulaBeta-None-params30]
		#test/test_distributions.py::test_dist_shape[prepend_shape2-GaussianCopulaBeta-None-params31]
		#test/test_distributions.py::test_dist_shape[prepend_shape2-GaussianCopulaBeta-None-params32]
		#test/test_distributions.py::test_sample_gradient[GaussianCopulaBeta-None-params30]
		#test/test_distributions.py::test_sample_gradient[GaussianCopulaBeta-None-params31]
		#test/test_distributions.py::test_sample_gradient[GaussianCopulaBeta-None-params32]
		#test/test_distributions.py::test_jit_log_likelihood[GaussianCopulaBeta-None-params30]
		#test/test_distributions.py::test_jit_log_likelihood[GaussianCopulaBeta-None-params31]
		#test/test_distributions.py::test_jit_log_likelihood[GaussianCopulaBeta-None-params32]
		#test/test_distributions.py::test_log_prob[False-prepend_shape0-GaussianCopulaBeta-None-params30]
		#test/test_distributions.py::test_log_prob[False-prepend_shape0-GaussianCopulaBeta-None-params31]
		#test/test_distributions.py::test_log_prob[False-prepend_shape0-GaussianCopulaBeta-None-params32]
		#test/test_distributions.py::test_log_prob[False-prepend_shape1-GaussianCopulaBeta-None-params30]
		#test/test_distributions.py::test_log_prob[False-prepend_shape1-GaussianCopulaBeta-None-params31]
		#test/test_distributions.py::test_log_prob[False-prepend_shape1-GaussianCopulaBeta-None-params32]
		#test/test_distributions.py::test_log_prob[False-prepend_shape2-GaussianCopulaBeta-None-params30]
		#test/test_distributions.py::test_log_prob[False-prepend_shape2-GaussianCopulaBeta-None-params31]
		#test/test_distributions.py::test_log_prob[False-prepend_shape2-GaussianCopulaBeta-None-params32]
		#test/test_distributions.py::test_log_prob[True-prepend_shape0-GaussianCopulaBeta-None-params30]
		#test/test_distributions.py::test_log_prob[True-prepend_shape0-GaussianCopulaBeta-None-params31]
		#test/test_distributions.py::test_log_prob[True-prepend_shape0-GaussianCopulaBeta-None-params32]
		#test/test_distributions.py::test_log_prob[True-prepend_shape1-GaussianCopulaBeta-None-params30]
		#test/test_distributions.py::test_log_prob[True-prepend_shape1-GaussianCopulaBeta-None-params31]
		#test/test_distributions.py::test_log_prob[True-prepend_shape1-GaussianCopulaBeta-None-params32]
		#test/test_distributions.py::test_log_prob[True-prepend_shape2-GaussianCopulaBeta-None-params30]
		#test/test_distributions.py::test_log_prob[True-prepend_shape2-GaussianCopulaBeta-None-params31]
		#test/test_distributions.py::test_log_prob[True-prepend_shape2-GaussianCopulaBeta-None-params32]
		#'test/test_distributions.py::test_cdf_and_icdf[Beta-<lambda>-params6]'
		#'test/test_distributions.py::test_cdf_and_icdf[Beta-<lambda>-params7]'
		#'test/test_distributions.py::test_cdf_and_icdf[Beta-<lambda>-params8]'
		#'test/test_distributions.py::test_cdf_and_icdf[BetaProportion-<lambda>-params9]'
		#'test/test_distributions.py::test_cdf_and_icdf[BetaProportion-<lambda>-params10]'
		#'test/test_distributions.py::test_cdf_and_icdf[BetaProportion-<lambda>-params11]'
		#'test/test_distributions.py::test_cdf_and_icdf[Chi2-<lambda>-params12]'
		#'test/test_distributions.py::test_cdf_and_icdf[Chi2-<lambda>-params13]'
		#'test/test_distributions.py::test_cdf_and_icdf[Gamma-<lambda>-params26]'
		#'test/test_distributions.py::test_cdf_and_icdf[Gamma-<lambda>-params27]'
		#'test/test_distributions.py::test_cdf_and_icdf[InverseGamma-<lambda>-params45]'
		#'test/test_distributions.py::test_cdf_and_icdf[InverseGamma-<lambda>-params46]'
		#'test/test_distributions.py::test_cdf_and_icdf[InverseGamma-<lambda>-params47]'
		#'test/test_distributions.py::test_cdf_and_icdf[StudentT-<lambda>-params104]'
		#'test/test_distributions.py::test_cdf_and_icdf[StudentT-<lambda>-params105]'
		#'test/test_distributions.py::test_cdf_and_icdf[StudentT-<lambda>-params106]'
		#'test/test_distributions.py::test_gof[GaussianCopulaBeta-None-params30]'
		#'test/test_distributions.py::test_gof[GaussianCopulaBeta-None-params31]'
		#'test/test_distributions.py::test_gof[GaussianCopulaBeta-None-params32]'
		#'test/test_distributions.py::test_independent_shape[GaussianCopulaBeta-None-params32]'
		#'test/test_distributions.py::test_dist_pytree[MultivariateStudentT-_multivariate_t_to_scipy-params89]'
		#'test/test_distributions.py::test_dist_pytree[_TruncatedNormal-_truncnorm_to_scipy-params115]'
	)
	local -x CI=1
	epytest -k "not test_example" --ignore=test/infer/ --ignore=test/contrib/ test || die "Tests failed with ${EPYTHON}"
}
