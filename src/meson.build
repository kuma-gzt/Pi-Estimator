piestimator_sources = [
  'Driver.vala',
  'Window.vala',
  'Utils.vala'
]

piestimator_deps = [
  dependency('glib-2.0'),
  dependency('gobject-2.0'),
  dependency('gtk+-3.0'),
  # dependency('gsl'),
  meson.get_compiler('c').find_library('m', required: false),
]

executable('piestimator', piestimator_sources,
  vala_args: '--target-glib=2.58',  dependencies: piestimator_deps,
  install: true,
)

