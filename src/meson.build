interactive_viz_sources = [
  'main.vala',
  'window.vala',
  'numeric_box_row.vala',
  'interface_definition.vala',
  'argument_row.vala',
  'application.vala',
  'dbus_service.vala',
]

interactive_viz_deps = [
  dependency('libadwaita-1', version: '>= 1.0'),
  dependency('json-glib-1.0', version: '>= 1.6'),
  dependency('gee-0.8'),
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
