# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 optfeature

DESCRIPTION="Bayesian Modeling and Probabilistic Programming in Python"
HOMEPAGE="
	https://www.pymc.io/
	https://github.com/pymc-devs/pymc
	https://pypi.org/project/pymc/
"
SRC_URI="
	https://github.com/pymc-devs/pymc/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/arviz[${PYTHON_USEDEP}]
	dev-python/cachetools[${PYTHON_USEDEP}]
	dev-python/cloudpickle[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	>=dev-python/pytensor-2.26.1[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/threadpoolctl[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/graphviz[${PYTHON_USEDEP}]
		dev-python/networkx[${PYTHON_USEDEP}]
	)

"

distutils_enable_tests pytest

python_test() {
	export PYTENSOR_FLAGS="floatX=float64,gcc__cxxflags='-march=native'"
	epytest \
		tests/test_util.py \
		tests/test_pytensorf.py \
		tests/test_math.py \
		tests/backends/test_base.py \
		tests/backends/test_ndarray.py \
		tests/step_methods/hmc/test_hmc.py \
		tests/test_func_utils.py \
		tests/distributions/test_shape_utils.py \
		tests/distributions/test_mixture.py \
		tests/test_testing.py
	epytest \
		tests/distributions/test_continuous.py \
#		tests/distributions/test_multivariate.py \
		tests/distributions/moments/test_means.py
	epytest \
		tests/distributions/test_censored.py \
		tests/distributions/test_custom.py \
		tests/distributions/test_simulator.py \
		tests/sampling/test_deterministic.py \
		tests/sampling/test_forward.py \
		tests/sampling/test_population.py \
		tests/stats/test_convergence.py \
		tests/stats/test_log_density.py \
		tests/distributions/test_distribution.py \
		tests/distributions/test_discrete.py
	epytest \
		tests/tuning/test_scaling.py \
		tests/tuning/test_starting.py \
		tests/distributions/test_dist_math.py \
		tests/distributions/test_transform.py \
		tests/sampling/test_mcmc.py \
		tests/sampling/test_parallel.py \
		tests/test_printing.py
	epytest \
		tests/distributions/test_timeseries.py \
		tests/gp/test_cov.py \
		tests/gp/test_hsgp_approx.py \
		tests/gp/test_gp.py \
		tests/gp/test_mean.py \
		tests/gp/test_util.py \
		tests/model/test_core.py \
		tests/model/test_fgraph.py \
		tests/model/transform/test_basic.py \
		tests/model/transform/test_conditioning.py \
		tests/model/transform/test_optimization.py \
		tests/test_model_graph.py \
		tests/ode/test_ode.py \
		tests/ode/test_utils.py \
		tests/step_methods/hmc/test_quadpotential.py \
		tests/step_methods/test_state.py
	epytest \
		tests/distributions/test_truncated.py \
		tests/logprob/test_abstract.py \
		tests/logprob/test_basic.py \
		tests/logprob/test_binary.py \
		tests/logprob/test_checks.py \
		tests/logprob/test_censoring.py \
		tests/logprob/test_composite_logprob.py \
		tests/logprob/test_cumsum.py \
		tests/logprob/test_linalg.py \
		tests/logprob/test_mixture.py \
		tests/logprob/test_order.py \
		tests/logprob/test_rewriting.py \
		tests/logprob/test_scan.py \
		tests/logprob/test_tensor.py \
		tests/logprob/test_transforms.py \
		tests/logprob/test_utils.py
}

pkg_postinst() {
	optfeature "producing a graphviz Digraph from a PyMC model" dev-python/graphviz
	optfeature "producing a networkx Digraph from a PyMC model" dev-python/networkx
}
