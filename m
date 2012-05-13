From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: Do we use runtime patching of function calls somewhere?
Date: Sun, 13 May 2012 13:44:54 -0400
Message-ID: <201205131344.55427.vapier@gentoo.org>
References: <20120513121600.GA15708@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2093959.FvS9GWZnLq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:35412 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865Ab2EMRo3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 13 May 2012 13:44:29 -0400
In-Reply-To: <20120513121600.GA15708@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux arch <linux-arch@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

--nextPart2093959.FvS9GWZnLq
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sunday 13 May 2012 08:16:00 Sam Ravnborg wrote:
> Do we have any archs that does runtime patching of function calls?

Matthew already mentioned the x86 altinstruction support (which helps with=
=20
building smp kernels which run well on UP setups), but in case it helps,=20
there's the ftrace stuff that runtime patches calls to mcount.  there's=20
HAVE_FTRACE_MCOUNT_RECORD and HAVE_DYNAMIC_FTRACE which=20
Documentation/trace/ftrace-design.txt covers.
=2Dmike

--nextPart2093959.FvS9GWZnLq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPr/MXAAoJEEFjO5/oN/WBGooP/2iSzN9AcPrxh/BqA+YuVEMT
F0VHV+fR20yAHVsPRMKZlIwVz+zzE+9r+zDsZuZ5oBZP++gHMUCklR/bJWRqzhRK
v1af2CpsZ5RqMScBAoQwggSY10j6vIJ62RxKnqLVNO1N45/+/q16c0hwnMPoCbh1
1VxjG2R+lVd4QGIdfoXvDChMcR7uuVsa7tiv5U57UkaEDPjGyQIQemG4WlWZUcDk
tHGCfxTGauK2prMr3PA6cinqk1sQqUcsbcjvKFKFz8dsoytWxayLM2JibdEsHvTT
TOZSf7cykJe+Lk8GN7ikLIsNmSs2L/pLcti7kBs96x3f2OndjeIqc2n37eFxcamJ
/fWynAuNyBVa2jCGohOHS+JTvUQZSmYlXCxChDQaxZz7Q4RuwtlCKfe3v6SVp/Oz
9+tx5RlS8sefHGEX3lMLMso2T67MIsgNXBnHvfVFwL6VoW6VRUdbGwcbFMn7DtYi
2bzuzZcArZIJtQgFLyvQJZaGXhGBNfeZAt75fuPJqnnKIsziC7BtQhLktup9imSu
P9kJ7ZQPMGS1igblILlKx/zpKNhXpnsT2+RsTHlVt3gdlzozYIDuHIoDLCsekKiZ
l8fg83Oc0LNDdyH6axNdu4WrLvR+lXwpWq8y+Q/qQegH7fiIUmj4LZkFBzy2rpJK
AgubywG2f+hNzBvMs2LY
=rXxN
-----END PGP SIGNATURE-----

--nextPart2093959.FvS9GWZnLq--
