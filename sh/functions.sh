#!/bin/bash

# Pass a .pls (playlist) file to this function and it'll copy the contents
# out of multiple dirs, add the files here and prepend numbers to the names
function mover() {
  # Print only lines with "File" and remove any
  # special chars and bits we don't need...
  # NOTE: This is a list of Url encoded conversions,
  # I missed some out that broke sed (like | and \ etc)
  MOVER_SONGPATHS=$(awk '/File/ { print $0 }' $1 \
    | sed 's/^File[^/]*=file:\/\///' \
    | sed 's/%20/ /g' \
    | sed 's/%21/!/g' \
    | sed 's/%22/"/g' \
    | sed 's/%23/#/g' \
    | sed 's/%24/$/g' \
    | sed 's/%25/%/g' \
    | sed 's/%26/&/g' \
    | sed "s/%27/'/g" \
    | sed 's/%28/(/g' \
    | sed 's/%29/)/g' \
    | sed 's/%2C/,/g' \
    | sed 's/%3A/:/g' \
    | sed 's/%3B/;/g' \
    | sed 's/%3C/</g' \
    | sed 's/%3D/=/g' \
    | sed 's/%3E/>/g' \
    | sed 's/%3F/?/g' \
    | sed 's/%40/@/g' \
    | sed 's/%5B/[/g' \
    | sed 's/%5D/]/g' \
    | sed 's/%5E/^/g' \
    | sed 's/%5F/_/g' \
    | sed 's/%7B/{/g' \
    | sed 's/%7D/}/g' \
    | sed 's/%7E/~/g' \
    | sed 's/%E2%82%AC/€/g' \
    | sed 's/%81//g' \
    | sed 's/%E2%80%9A/‚/g' \
    | sed 's/%C6%92/ƒ/g' \
    | sed 's/%E2%80%9E/„/g' \
    | sed 's/%E2%80%A6/…/g' \
    | sed 's/%E2%80%A0/†/g' \
    | sed 's/%E2%80%A1/‡/g' \
    | sed 's/%CB%86/ˆ/g' \
    | sed 's/%E2%80%B0/‰/g' \
    | sed 's/%C5%A0/Š/g' \
    | sed 's/%E2%80%B9/‹/g' \
    | sed 's/%C5%92/Œ/g' \
    | sed 's/%C5%8D//g' \
    | sed 's/%C5%BD/Ž/g' \
    | sed 's/%8F//g' \
    | sed 's/%C2%90//g' \
    | sed 's/%E2%80%98/‘/g' \
    | sed 's/%E2%80%99/’/g' \
    | sed 's/%E2%80%9C/“/g' \
    | sed 's/%E2%80%9D/”/g' \
    | sed 's/%E2%80%A2/•/g' \
    | sed 's/%E2%80%93/–/g' \
    | sed 's/%E2%80%94/—/g' \
    | sed 's/%CB%9C/˜/g' \
    | sed 's/%E2%84/™/g' \
    | sed 's/%C5%A1/š/g' \
    | sed 's/%E2%80/›/g' \
    | sed 's/%C5%93/œ/g' \
    | sed 's/%9D//g' \
    | sed 's/%C5%BE/ž/g' \
    | sed 's/%C5%B8/Ÿ/g' \
    | sed 's/%C2%A1/¡/g' \
    | sed 's/%C2%A2/¢/g' \
    | sed 's/%C2%A3/£/g' \
    | sed 's/%C2%A4/¤/g' \
    | sed 's/%C2%A5/¥/g' \
    | sed 's/%C2%A6/¦/g' \
    | sed 's/%C2%A7/§/g' \
    | sed 's/%C2%A8/¨/g' \
    | sed 's/%C2%A9/©/g' \
    | sed 's/%C2%AA/ª/g' \
    | sed 's/%C2%AB/«/g' \
    | sed 's/%C2%AC/¬/g' \
    | sed 's/%C2%AD/­/g' \
    | sed 's/%C2%AE/®/g' \
    | sed 's/%C2%AF/¯/g' \
    | sed 's/%C2%B0/°/g' \
    | sed 's/%C2%B1/±/g' \
    | sed 's/%C2%B2/²/g' \
    | sed 's/%C2%B3/³/g' \
    | sed 's/%C2%B4/´/g' \
    | sed 's/%C2%B5/µ/g' \
    | sed 's/%C2%B6/¶/g' \
    | sed 's/%C2%B7/·/g' \
    | sed 's/%C2%B8/¸/g' \
    | sed 's/%C2%B9/¹/g' \
    | sed 's/%C2%BA/º/g' \
    | sed 's/%C2%BB/»/g' \
    | sed 's/%C2%BC/¼/g' \
    | sed 's/%C2%BD/½/g' \
    | sed 's/%C2%BE/¾/g' \
    | sed 's/%C2%BF/¿/g' \
    | sed 's/%C3%80/À/g' \
    | sed 's/%C3%81/Á/g' \
    | sed 's/%C3%82/Â/g' \
    | sed 's/%C3%83/Ã/g' \
    | sed 's/%C3%84/Ä/g' \
    | sed 's/%C3%85/Å/g' \
    | sed 's/%C3%86/Æ/g' \
    | sed 's/%C3%87/Ç/g' \
    | sed 's/%C3%88/È/g' \
    | sed 's/%C3%89/É/g' \
    | sed 's/%C3%8A/Ê/g' \
    | sed 's/%C3%8B/Ë/g' \
    | sed 's/%C3%8C/Ì/g' \
    | sed 's/%C3%8D/Í/g' \
    | sed 's/%C3%8E/Î/g' \
    | sed 's/%C3%8F/Ï/g' \
    | sed 's/%C3%90/Ð/g' \
    | sed 's/%C3%91/Ñ/g' \
    | sed 's/%C3%92/Ò/g' \
    | sed 's/%C3%93/Ó/g' \
    | sed 's/%C3%94/Ô/g' \
    | sed 's/%C3%95/Õ/g' \
    | sed 's/%C3%96/Ö/g' \
    | sed 's/%C3%97/×/g' \
    | sed 's/%C3%98/Ø/g' \
    | sed 's/%C3%99/Ù/g' \
    | sed 's/%C3%9A/Ú/g' \
    | sed 's/%C3%9B/Û/g' \
    | sed 's/%C3%9C/Ü/g' \
    | sed 's/%C3%9D/Ý/g' \
    | sed 's/%C3%9E/Þ/g' \
    | sed 's/%C3%9F/ß/g' \
    | sed 's/%C3%A0/à/g' \
    | sed 's/%C3%A1/á/g' \
    | sed 's/%C3%A2/â/g' \
    | sed 's/%C3%A3/ã/g' \
    | sed 's/%C3%A4/ä/g' \
    | sed 's/%C3%A5/å/g' \
    | sed 's/%C3%A6/æ/g' \
    | sed 's/%C3%A7/ç/g' \
    | sed 's/%C3%A8/è/g' \
    | sed 's/%C3%A9/é/g' \
    | sed 's/%C3%AA/ê/g' \
    | sed 's/%C3%AB/ë/g' \
    | sed 's/%C3%AC/ì/g' \
    | sed 's/%C3%AD/í/g' \
    | sed 's/%C3%AE/î/g' \
    | sed 's/%C3%AF/ï/g' \
    | sed 's/%C3%B0/ð/g' \
    | sed 's/%C3%B1/ñ/g' \
    | sed 's/%C3%B2/ò/g' \
    | sed 's/%C3%B3/ó/g' \
    | sed 's/%C3%B4/ô/g' \
    | sed 's/%C3%B5/õ/g' \
    | sed 's/%C3%B6/ö/g' \
    | sed 's/%C3%B7/÷/g' \
    | sed 's/%C3%B8/ø/g' \
    | sed 's/%C3%B9/ù/g' \
    | sed 's/%C3%BA/ú/g' \
    | sed 's/%C3%BB/û/g' \
    | sed 's/%C3%BC/ü/g' \
    | sed 's/%C3%BD/ý/g' \
    | sed 's/%C3%BE/þ/g' \
    | sed 's/%C3%BF/ÿ/g'
  )

  # Create a string of commands that look like:
  # 'cp "<full-path>" "<number> - <file-name>"; cp "<full-path>" "<number> - <file-name>"; [...]'
  MOVER_CP_COMMAND=$(echo "$MOVER_SONGPATHS" | awk '{FS = "/"; print "cp \"" $0 "\" \"" NR " - " $NF "\";"}')

  # Then evaluate the output using `bash -c "{}"`
  bash -c "$MOVER_CP_COMMAND"
}
