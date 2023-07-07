piestimator_sources = [
  'main.vala',
]

piestimator_deps = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
]

executable('piestimator', piestimator_sources,
  vala_args: '--target-glib=2.58',  dependencies: piestimator_deps,
  install: true,
)

