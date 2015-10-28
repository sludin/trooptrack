# TroopTrack perl API

[swagger-codegen](https://github.com/swagger-api/swagger-codegen#modifying-the-client-library-format) generated perl libraries for TroopTrack.

TroopTrack runs on the 1.2 version of the Swagger schema.  All
existing code that I could find for generating code from the schema
and thus having something that is simple to maintain and keep up to
date uses 2.0.  After wrangling with the tools I decided that the
best thing to do would be to generate a 2.0 schema from teh 1.2
schema.

The NPM package [swagger-tools](https://www.npmjs.com/package/swagger-tools) made this reasonably simple.

The tricks are:
- The 1.2 schema references '#/description/String' and
  '#/description/id'.  Neither of these are understood by the
  converter. There is probably a simpler way to do this, but
  I searched and replaced the former with 'type': 'string' and
  the latter with 'type': 'integer'.  This had to happen
  before the conversion would work.

- The 1.2 schema has implicit return values for most 200s.  This
  in interpreted by swagger-codegen as no return.  Currently
  I am using an included script ( add_return_info.pl ) to force
  the return to be a string which is the JSON itself.  This
  then needs to be decoded into perl.

The conversion tool is [swagger-codegen](https://github.com/swagger-api/swagger-codegen#modifying-the-client-library-format)

This is a java library that supports the creation of API libraries in
many languages including perl.  Getting it built and working was
tricky, but it is managable by following the instrictions on the
referenced site.  For reference I am doing it on OS X 10.10.

What is included:

- add_return_info.pl: script to modify the schema for 200 repsonses ( see above )
- example.pl: simple example for using the generated libraries to call the API
- lib: directory that holds the perl libs.  use libs './lib' to include for testing
- swagger1.2: contains the 1.2 schemas ( pulled directly from TroopTrack )
- swagger2.0: contains the 2.0 schema ( converted and modified as per above )

TODO:

- Script the two tricks above to make them more seamless
- add version checking ( is this in there implcicitly already? )
- Add testing
