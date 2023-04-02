interactive_viz_sources = [
  'main.vala',
  'window.vala',
  'numeric_box_row.vala',
  'application.vala',
]

interactive_viz_deps = [
  dependency('libadwaita-1', version: '>= 1.0'),
]

gnome = import('gnome')

interactive_viz_sources += gnome.compile_resources('interactive_viz-resources',
  'interactive_viz.gresource.xml',
  c_name: 'interactive_viz'
)

executable('interactive-viz', interactive_viz_sources,
  vala_args: '--target-glib=2.50',  dependencies: interactive_viz_deps,
  install: true,
)
