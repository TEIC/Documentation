<?xml version="1.0" encoding="UTF-8"?>

<!--
   This is a temporary storage buffer for work on the Schematron test
   for a relative URI reference. After work here is done or near done,
   the code will be incorporated into tcw32, and this file can then be
   deleted. —Syd, 2021-11-20
-->

<!--
  Designed to be run on itself. E.g., on my desktop:
  $ saxon.bash /home/syd/Downloads/schxslt-1.8.4/2.0/pipeline-for-svrl.xsl eg58.sch > eg58.xslt && saxon.bash eg58.xslt eg58.sch | xmlstarlet sel -N svrl="http://purl.oclc.org/dsdl/svrl" -t -m "//svrl:text" -v "normalize-space(.)" -n | egrep -v '^$' | perl -pe 's,&amp;,&,g;'

  Note: Validating this file against itself did not work well (for me)
        in oXygen because several of the test values of @icon are invalid
        against some internal schema oXygen is using.
-->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">

  <!-- ********* start test data ********* -->
  <sch:p icon="filesansext"/>
  <sch:p icon="file.xml"/>
  <sch:p icon="path/to/file.xml"/>
  <sch:p icon="/path/to/file.xml"/>
  <sch:p icon="//path/to/file.xml"/>
  <sch:p icon="./path/to/file.xml"/>
  <sch:p icon="file.xml#short"/>
  <sch:p icon="path/to/file.xml#short"/>
  <sch:p icon="/path/to/file.xml#short"/>
  <sch:p icon="//path/to/file.xml#short"/>
  <sch:p icon="./path/to/file.xml#short"/>
  <sch:p icon="file.xml?query"/>
  <sch:p icon="path/to/file.xml?query"/>
  <sch:p icon="/path/to/file.xml?query"/>
  <sch:p icon="//path/to/file.xml?query"/>
  <sch:p icon="./path/to/file.xml?query"/>
  <sch:p icon="file.xml?query#short"/>
  <sch:p icon="path/to/file.xml?query#short"/>
  <sch:p icon="/path/to/file.xml?query#short"/>
  <sch:p icon="//path/to/file.xml?query#short"/>
  <sch:p icon="./path/to/file.xml?query#short"/>
  <sch:p icon="file.xml#short?query"/>
  <sch:p icon="path/to/file.xml#short?query"/>
  <sch:p icon="/path/to/file.xml#short?query"/>
  <sch:p icon="//path/to/file.xml#short?query"/>
  <sch:p icon="./path/to/file.xml#short?query"/>
  <sch:p icon="fi:le.xml"/>
  <sch:p icon="path/to/fi:le.xml"/>
  <sch:p icon="/path/to/fi:le.xml"/>
  <sch:p icon="//path/to/fi:le.xml"/>
  <sch:p icon="./path/to/fi:le.xml"/>
  <sch:p icon="pa:th/to/fi:le.xml"/>
  <sch:p icon="/pa:th/to/fi:le.xml"/>
  <sch:p icon="//pa:th/to/fi:le.xml"/>
  <sch:p icon="./pa:th/to/fi:le.xml"/>
  <sch:p icon="file:file.xml"/>
  <sch:p icon="file:path/to/file.xml"/>
  <sch:p icon="file:/path/to/file.xml"/>
  <sch:p icon="file://path/to/file.xml"/>
  <sch:p icon="file:./path/to/file.xml"/>
  <sch:p icon="file:/file.xml"/>
  <sch:p icon="file:/path/to/file.xml"/>
  <sch:p icon="file://path/to/file.xml"/>
  <sch:p icon="file:///path/to/file.xml"/>
  <sch:p icon="file:/./path/to/file.xml"/>
  <sch:p icon="what:file.xml"/>
  <sch:p icon="what:path/to/file.xml"/>
  <sch:p icon="what:/path/to/file.xml"/>
  <sch:p icon="what://path/to/file.xml"/>
  <sch:p icon="what:./path/to/file.xml"/>
  <sch:p icon="what:/file.xml"/>
  <sch:p icon="what:/path/to/file.xml"/>
  <sch:p icon="what://path/to/file.xml"/>
  <sch:p icon="what:///path/to/file.xml"/>
  <sch:p icon="what:/./path/to/file.xml"/>
  <sch:p icon="#short"/>
  <sch:p icon="?query"/>
  <sch:p icon="?query#short"/>
  <sch:p icon="this://is.not.valid"/>
  <sch:p icon="urn:duck"/>
  <sch:p icon="one#two#three#four"/>
  <sch:p icon="one#two?three?four"/>
  <sch:p icon="one#two/three#four"/>
  <sch:p icon="./0%2Dduck"/>
  <sch:p icon="./¢ent"/>
  <sch:p icon="./%A2ent"/>
  <!-- ********* end test data ********* -->

  <!-- ********* start constraint ********* -->
  <sch:pattern id="eg58">
    <sch:rule context="@icon">
      <sch:let name="pct-encoded" value="'%[0-9A-Fa-f][0-9A-Fa-f]'"/>
      <!--
          “unencoded” is a combination of unreserved, sub-delims,
          COMMERCIAL AT, and COLON; “unencodednc” is the same without
          COLON.
      -->
      <sch:let name="unencoded"   value='"[A-Za-z0-9._~!$&amp;&apos;()*+,;=@:-]"'/>
      <sch:let name="unencodednc" value='"[A-Za-z0-9._~!$&amp;&apos;()*+,;=@-]"' />
      
      <sch:let name="pchar"   value="concat( $unencoded,   '|', $pct-encoded )"/>
      <sch:let name="ncpchar" value="concat( $unencodednc, '|', $pct-encoded )"/>
      
      <sch:let name="segment"       value="concat( '(', $pchar,   ')*')"/>
      <sch:let name="segment-nz"    value="concat( '(', $pchar,   ')+')"/>
      <sch:let name="segment-nz-nc" value="concat( '(', $ncpchar, ')+')"/>
      
      <sch:let name="path-absolute" value="concat('/(', $segment-nz, '(/', $segment, ')*)?')"/>
      <sch:let name="path-noscheme" value="concat( $segment-nz-nc, '(/', $segment, ')*' )"/>
      <sch:let name="path-empty"    value="'[empty]{0}'"/>
      
      <sch:let name="query"    value="concat( '(', $pchar, '|/|\?)*')"/>
      <sch:let name="fragment" value="concat( '(', $pchar, '|/|\?)*')"/>
      
      <sch:let name="relative-ref"
               value="concat('(', $path-absolute,
                             '|', $path-noscheme,
                             '|', $path-empty,
                             ')(\?', $query, ')?(#', $fragment, ')?'
                            )"/>
      <!--
          Note on preceding: We do not consider, and thus do not permit, the specification
          of an authority. (A relative URI reference with an authority section might look
          like “//vswann@localhost:80/kryptonian/vocab.xml”.) The unintended, but probably
          utterly unimportant, side effect is that this constraint incorrectly considers
          “//” an invalid reference.
      -->
      
      <sch:let name="auth-path" value="concat( '(localhost)?', $path-absolute )"/>
      <!--
          Note on preceding: We do not consider, and thus do not permit, the possibility that the
          host is specified as something other than nil or “localhost”, even though
          any host name, including an IPv4 or IPv6 address, is actually allowed.
      -->
      
      <sch:let name="fileURI"
        value="concat('file:((//', $auth-path, ')|(', $path-absolute, '))' )"/>
      <sch:assert test="../preceding-sibling::*/@icon">
        The regular expression is: <sch:value-of select="concat('(',$relative-ref,'|',$fileURI,')')"/>.
      </sch:assert>
      <sch:report test="true()">
        <!-- The question is matches( <sch:value-of select="."/>, <sch:value-of select="$relative-ref"/> )? -->
        The answer for <sch:value-of select="."/> is:
        <sch:value-of select="
          matches( ., concat('^',concat('(',$relative-ref,'|',$fileURI,')'),'$') )
          "/>
      </sch:report>
    </sch:rule>
  </sch:pattern>
  <!-- ********* end constraint ********* -->

  <!-- ********* start ABNF of relative URI reference and "file:" scheme URI ********* -->
  <!--
      excerpted from https://datatracker.ietf.org/doc/html/rfc3986, 2021-11-15
      ========= ==== ============================================== ==========

   relative-ref  = relative-part [ "?" query ] [ "#" fragment ]

   query         = *( pchar / "/" / "?" )

   fragment      = *( pchar / "/" / "?" )

   relative-part = "//" authority-NOT! path-abempty
                   / path-absolute
                   / path-noscheme
                   / path-empty

   path-abempty  = *( "/" segment )
   path-absolute = "/" [ segment-nz *( "/" segment ) ]
   path-noscheme = segment-nz-nc *( "/" segment )
   path-empty    = 0<pchar>

   segment       = *pchar
   segment-nz    = 1*pchar
   segment-nz-nc = 1*( unreserved / pct-encoded / sub-delims / "@" )
                   ; non-zero-length segment without any colon ":"

   pchar         = unreserved / pct-encoded / sub-delims / ":" / "@"

   pct-encoded   = "%" HEXDIG HEXDIG

   unreserved    = ALPHA / DIGIT / "-" / "." / "_" / "~"
   sub-delims    = "!" / "$" / "&" / "'" / "(" / ")" / "*" / "+" / "," / ";" / "="


      excerpted from https://datatracker.ietf.org/doc/html/rfc8089, 2021-11-17
      ========= ==== ============================================== ==========

   file-URI       = file-scheme ":" file-hier-part

   file-scheme    = "file"

   file-hier-part = ( "//" auth-path )
                  / local-path

   auth-path      = [ file-auth ] path-absolute

   local-path     = path-absolute

   file-auth      = "localhost"
                  / host
  -->
  <!-- ********* end ABNF for reference ********* -->
  <!-- (Cool how the above comment is ambiguous.) -->

</sch:schema>
