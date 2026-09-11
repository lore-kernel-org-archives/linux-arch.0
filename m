Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A09C2F3632;
	Fri, 11 Sep 2026 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131253; cv=none; b=EohAHzRfjtdHWOY/U9TfjlftK5dncV1JU+B4njPVRoIv9TOcP2NRRB96ctxW9AConFIOwUT++5V/OC++Pqa2rSYSTLRMLl/aWPi/FHJ3xVaQnSCHnwpowIwwSJL0KBla+yrjdWi0lKevxmbiyomrxj/Ii8Pw2Kf8jHQw1cFY4LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131253; c=relaxed/simple;
	bh=vmU9Dno4g9w5n0bGOE1W0Dp7oYJdxcLp+RMsbZV0yKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMNV649TYiGxwhr+8fpQ1cRt7aaIJX0//Hj7ci9/5vfKD/mZdZFbzeeiSANhBTvZ+yN76wHz2E5cCaAsgtyaSv0l7ny8j2BnfKHBKINIiHPMgbkIHqxmWRLXetk5555jbC4AeGSU8pgwFQJsuAJ5NoApZBROpwm4hZJx0DExRjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX9r7CT/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX9r7CT/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3361B1F00893;
	Fri, 11 Sep 2026 12:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131251;
	bh=Y12PtyNHuLG4wZ4glSRJ8LTvqHRVQ8wgV9JCM2xUR5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iX9r7CT/1y8Q0LOcrodYBYyxXyv8NUTTNIFjXvcD2IBGfP/r53ijoKwzqXPuMM7Pt
	 nHCtxeDYzzT9Ne2jeATiIvCv9pIrLHLf3FqDTOWyVTbLYAhC8fSA+TNQJqUBV121Ad
	 T/VcoRtCYgwP7T3KBzfj1eFCCIXhNVyWqEqGW4Qgy5f+GfRwlxUbOXrJZ6fXSwvcyb
	 0yI5u72cS/E02IX4R83bdDd4rXt+pps6y/W01uAnkGvkGZgjzRqGxsROp8mGMruP8y
	 Ypz/wA1hhNw7M3QRXNvaq+EV6vmg7XgQpTKmtbVztr3tIS/86w2ckPQSJGuhQOe6Tb
	 37Hmq3O+H0/CA==
Date: Fri, 11 Sep 2026 14:54:08 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-man@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, astian <astian@memeware.net>, 
	Andreas Jaeger <aj@suse.de>, Linux-Arch <linux-arch@vger.kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v1] man/man2/outb.2: Remove obsolete note about optimizations
Message-ID: <049db2a23b976fcef7fe1a667848724fa2067f07.1789131131.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
References: <b6258140-1ece-4113-bcb4-025302ef59cc@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cdkydfbvltlv2dhm"
Content-Disposition: inline
In-Reply-To: <b6258140-1ece-4113-bcb4-025302ef59cc@app.fastmail.com>


--cdkydfbvltlv2dhm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-man@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, astian <astian@memeware.net>, 
	Andreas Jaeger <aj@suse.de>, Linux-Arch <linux-arch@vger.kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v1] man/man2/outb.2: Remove obsolete note about optimizations
Message-ID: <049db2a23b976fcef7fe1a667848724fa2067f07.1789131131.git.alx@kernel.org>
References: <b6258140-1ece-4113-bcb4-025302ef59cc@app.fastmail.com>
MIME-Version: 1.0
In-Reply-To: <b6258140-1ece-4113-bcb4-025302ef59cc@app.fastmail.com>

It seems this was necessary due to an old glibc bug, fixed in glibc.git
994cc0ea88ce (2000-08-23; "(_EXTERN_INLINE): Remove. Use static __inline
instead of _EXTERN_INLINE.").

Link: <https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommitdiff;h=3D994cc0e=
a88ce7a33d532b735c0723705742b1a7e>
Reported-by: astian <astian@memeware.net>
Reported-by: Alejandro Colomar <alx@kernel.org>
Cc: Andreas Jaeger <aj@suse.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Message-ID: <b6258140-1ece-4113-bcb4-025302ef59cc@app.fastmail.com>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---

Hi Arnd,

Thanks for confirming!  I've taken that as an 'Acked-by'.

I'll also prepare a commit for mentioning the non-portability, and the
archs that support this.  Thanks for that suggestion!


Have a lovely day!
Alex

 man/man2/outb.2 | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/man/man2/outb.2 b/man/man2/outb.2
index 98bd6bab4ffa..ba87455b121f 100644
--- a/man/man2/outb.2
+++ b/man/man2/outb.2
@@ -62,15 +62,6 @@ .SH DESCRIPTION
 .\" in addition to that given in
 .\" .BR outb (9).
 .P
-You must compile with
-.B \-O
-or
-.B \-O2
-or similar.
-The functions
-are defined as inline macros, and will not be substituted in without
-optimization enabled, causing unresolved references at link time.
-.P
 You use
 .BR ioperm (2)
 or alternatively

base-commit: bd51589ffe65f720d9618bffef5da00938e9842e
--=20
2.55.0


--cdkydfbvltlv2dhm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmqj+fAACgkQ64mZXMKQ
wqmR8A//RBm+MrVT9DrkbExfgyUqwuWYzyh4UpTAQbxhRJMC13l3TV+p2oENgfrF
BzaVQnEr/X6G1TCLqTsqa+sJJ99XI6t7+rGT0VbpBpHvWaFGTR+hSMm6m9nqQ+w+
+weCcZkkk5fGm8qiZciJNE4aGM66m26thQoqTg6PQowBnIfhe+j8bMzrq9EnkIPo
a3uEWMZgTxlvIIKPfO56Pny+xGcvEcQy0LSSREU0Bq3x2bwPY4gYkSJnpcrx1SZ3
yIDTkXApAB6WCkLZYr7RjkL0pHk2MeII2tTunZafZ1GG6WvF3cRS1BGn5XuH/+Uo
PKp4d4IK3zku43wEAumH9zyZMRTgi5R+r7GuqwNIWacV6xLp16BxZddwzH8yDW4q
mmKsS605tyjYZSX/Ro1xFFcJHYejclrR0DI9xYh6SLWm4F3NxWh/0WgUUzIak0YQ
drgMpf/ATAbNmtPDQ4dEpaSX9FMlQbdNZq/0gPOTdF0blCRXCTOD+n3OUH5iEZ8M
DjZi9vlizYE5a89oQEBEM1bveSzwh9IQE1pahurvDr+M9cSlztv3HVX6UCJe8zJF
5m+EXhQQ4tLtGhgdsITKVJyVmKY3W2Jinmw93w/hhd5TIfbJ9g5kTRKije3Z1ezu
phGeLPCCnVN/rivRrb59FeIm5XpKwkyfl994HBedHpFA4IBkXfg=
=uO01
-----END PGP SIGNATURE-----

--cdkydfbvltlv2dhm--
