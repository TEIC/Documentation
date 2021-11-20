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
  <sch:p icon="/"/>
  <sch:p icon="//"/>
  <sch:p icon="///"/>
  <sch:p icon="////"/>
  <sch:p icon="/////"/>
  <!-- ********* end test data ********* -->

  <!-- ********* start constraint ********* -->
  <sch:pattern id="eg58">
    <sch:rule context="@icon">
      <sch:let name="HEXDIG"      value="'[0-9A-Fa-f]'"/>
      <sch:let name="pct-encoded" value="concat('%', $HEXDIG, $HEXDIG )"/>
      <!--
          Since unrserved and sub-delims are never used independently
          we simply use a combined form here:
            ursdsh = unreserved and sub-delims sans hyphen
      -->
      <sch:let name="unressubdel" value='"A-Za-z0-9\-._~!$&amp;&apos;()*+,;="'/>
      <!--
          “unencoded” is a combination of unreserved, sub-delims, COMMERCIAL AT, and COLON;
          “unencodednc” is the same without COLON.
      -->
      <sch:let name="unencoded"   value="concat('[', $unressubdel, '@', ':', ']')"/>
      <sch:let name="unencodednc" value="concat('[', $unressubdel, '@',      ']')"/>
      
      <sch:let name="pchar"   value="concat( $unencoded,   '|', $pct-encoded )"/>
      <sch:let name="ncpchar" value="concat( $unencodednc, '|', $pct-encoded )"/>
      
      <sch:let name="segment"       value="concat('(', $pchar,   ')*')"/>
      <sch:let name="segment-nz"    value="concat('(', $pchar,   ')+')"/>
      <sch:let name="segment-nz-nc" value="concat('(', $ncpchar, ')+')"/>
      
      <sch:let name="path-abempty"  value="concat('(/', $segment, ')*')"/>
      <sch:let name="path-absolute" value="concat('/(', $segment-nz, '(/', $segment, ')*)?')"/>
      <sch:let name="path-noscheme" value="concat( $segment-nz-nc, '(/', $segment, ')*' )"/>
      <sch:let name="path-empty"    value="'[empty]{0}'"/>
      
      <sch:let name="query"    value="concat('(', $pchar, '|/|\?)*')"/>
      <sch:let name="fragment" value="concat('(', $pchar, '|/|\?)*')"/>

      <!-- The following are only used in the host pattern -->
      <sch:let name="dec-octet"
               value="'((1?[1-9])?[0-9]|2([0-4][0-9]|5[0-5]))'"/>
      <sch:let name="IPv4address"
               value="concat( $dec-octet, '.', $dec-octet, '.', $dec-octet, '.', $dec-octet )"/>
      <sch:let name="h16" value="'[0-9A-Fa-f]{1,4}'"/>
      <sch:let name="h16c" value="concat('(', $h16, ':',')')"/>
      <sch:let name="ls32" value="concat('((', $h16, ':', $h16, ')|(', $IPv4address, '))')"/>
      <sch:let name="IPv6addr_a" value="concat(                                   $h16c, '{6}', $ls32 )"/>
      <sch:let name="IPv6addr_b" value="concat(                             '::', $h16c, '{5}', $ls32 )"/>
      <sch:let name="IPv6addr_c" value="concat('(', $h16c, '{0,0}', $h16, ')?::', $h16c, '{4}', $ls32 )"/>
      <sch:let name="IPv6addr_d" value="concat('(', $h16c, '{0,1}', $h16, ')?::', $h16c, '{3}', $ls32 )"/>
      <sch:let name="IPv6addr_e" value="concat('(', $h16c, '{0,2}', $h16, ')?::', $h16c, '{2}', $ls32 )"/>
      <sch:let name="IPv6addr_f" value="concat('(', $h16c, '{0,3}', $h16, ')?::', $h16c, '{1}', $ls32 )"/>
      <sch:let name="IPv6addr_g" value="concat('(', $h16c, '{0,4}', $h16, ')?::',               $ls32 )"/>
      <sch:let name="IPv6addr_h" value="concat('(', $h16c, '{0,5}', $h16, ')?::',               $ls32 )"/>
      <sch:let name="IPv6addr_i" value="concat('(', $h16c, '{0,6}', $h16, ')?::',               $ls32 )"/>
      <sch:let name="IPv6address"
               value="concat('(',
                             '|', $IPv6addr_a,
                             '|', $IPv6addr_b,
                             '|', $IPv6addr_c,
                             '|', $IPv6addr_d,
                             '|', $IPv6addr_e,
                             '|', $IPv6addr_f,
                             '|', $IPv6addr_g,
                             '|', $IPv6addr_h,
                             '|', $IPv6addr_i,
                             ')')"/>
      <sch:let name="IPvFuture" value="concat('v', $HEXDIG, '+\.[', $unressubdel, ':', ']*')"/>
      <sch:let name="IP-literal"
               value="concat('\[(', $IPv6address, '|', $IPvFuture, ')\]')"/>
      <sch:let name="reg-name" value="concat('([', $unressubdel, ']|', $pct-encoded, ')*')"/>
      <!-- end host-pattern only portion -->

      <sch:let name="userinfo" value="concat('([', $unressubdel, ':]|', $pct-encoded, ')*')"/>
      <sch:let name="host" value="concat('(', $IP-literal, '|', $IPv4address, '|', $reg-name, ')')"/>
      <sch:let name="port" value="'[0-9]*'"/>
      <sch:let name="authority"
               value="concat('(', $userinfo, '@)?', $host, '(:', $port, ')?')"/>

      <sch:let name="relative-ref"
               value="concat('(', '//', $authority, $path-abempty,
                             '|', $path-absolute,
                             '|', $path-noscheme,
                             '|', $path-empty,
                             ')(\?', $query, ')?(#', $fragment, ')?'
                            )"/>
      
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

   relative-part = "//" authority path-abempty
                 / path-absolute
                 / path-noscheme
                 / path-empty

   scheme        = ALPHA *( ALPHA / DIGIT / "+" / "-" / "." )

   authority     = [ userinfo "@" ] host [ ":" port ]
   userinfo      = *( unreserved / pct-encoded / sub-delims / ":" )
   host          = IP-literal / IPv4address / reg-name
   port          = *DIGIT

   IP-literal    = "[" ( IPv6address / IPvFuture  ) "]"

   IPvFuture     = "v" 1*HEXDIG "." 1*( unreserved / sub-delims / ":" )

   IPv6address   =                            6( h16 ":" ) ls32
                 /                       "::" 5( h16 ":" ) ls32
                 / [               h16 ] "::" 4( h16 ":" ) ls32
                 / [ *1( h16 ":" ) h16 ] "::" 3( h16 ":" ) ls32
                 / [ *2( h16 ":" ) h16 ] "::" 2( h16 ":" ) ls32
                 / [ *3( h16 ":" ) h16 ] "::"    h16 ":"   ls32
                 / [ *4( h16 ":" ) h16 ] "::"              ls32
                 / [ *5( h16 ":" ) h16 ] "::"              h16
                 / [ *6( h16 ":" ) h16 ] "::"

   h16           = 1*4HEXDIG
   ls32          = ( h16 ":" h16 ) / IPv4address
   IPv4address   = dec-octet "." dec-octet "." dec-octet "." dec-octet

   dec-octet     = DIGIT                 ; 0-9
                 / %x31-39 DIGIT         ; 10-99
                 / "1" 2DIGIT            ; 100-199
                 / "2" %x30-34 DIGIT     ; 200-249
                 / "25" %x30-35          ; 250-255

   reg-name      = *( unreserved / pct-encoded / sub-delims )

   path          = path-abempty    ; begins with "/" or is empty
                 / path-absolute   ; begins with "/" but not "//"
                 / path-noscheme   ; begins with a non-colon segment
                 / path-rootless   ; begins with a segment
                 / path-empty      ; zero characters

   path-abempty  = *( "/" segment )
   path-absolute = "/" [ segment-nz *( "/" segment ) ]
   path-noscheme = segment-nz-nc *( "/" segment )
   path-rootless = segment-nz *( "/" segment )
   path-empty    = 0<pchar>

   segment       = *pchar
   segment-nz    = 1*pchar
   segment-nz-nc = 1*( unreserved / pct-encoded / sub-delims / "@" )
                 ; non-zero-length segment without any colon ":"

   pchar         = unreserved / pct-encoded / sub-delims / ":" / "@"

   query         = *( pchar / "/" / "?" )

   fragment      = *( pchar / "/" / "?" )

   pct-encoded   = "%" HEXDIG HEXDIG

   unreserved    = ALPHA / DIGIT / "-" / "." / "_" / "~"
   reserved      = gen-delims / sub-delims
   gen-delims    = ":" / "/" / "?" / "#" / "[" / "]" / "@"
   sub-delims    = "!" / "$" / "&" / "'" / "(" / ")"
                 / "*" / "+" / "," / ";" / "="


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
