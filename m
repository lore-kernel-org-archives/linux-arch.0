Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DD2365A0F;
	Fri, 11 Sep 2026 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139223; cv=none; b=HIa+7KjN5jf/KL9xnaAjLyHjrMVEeth8/OdJ3w/fhq/YNansOTp7fI6LWWiZeinN5Hp0YZr8zKx/ANA6ivxQyHVSY8ry1p/h6C8npxwnSx6YSMHtei+5/8KiuZUyhVeoIndP0Wga0TOMZsxatMzz1pR/AgHJQ/f25jnEs2inP0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139223; c=relaxed/simple;
	bh=QN05eFoGOE6Mj05kEDJFXnD+mS8HvLu9j7+4owhkroQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dUqFVrgXEDuokfawkFxPC6gzexBh8+aGMhNabkU5OczNMTCdi26M/l+yYDuuCcJn8p8VO4x99vo585p0oYHC8MtnIOpDmyQjlnnRem64YlOOgD3Mh95teAOuyOarTKV6HHftGhmPf3FBhj5CWmC3Mb/PF3pYKWGEkNwM4F+nFJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbJC64Zb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbJC64Zb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88621F000FF;
	Fri, 11 Sep 2026 15:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789139222;
	bh=dumtvvNlzHdMjdEmvI1ZvztP2C/VFwH4zITPO8Dd78E=;
	h=Date:From:To:Cc:Subject;
	b=EbJC64ZbRqbYTVaYMNp4IXgNT9cF6jaB5piLED0IUOvs1onrwd1XAS7IWchprzO47
	 CZ8nd73qy28vmRkkyZ9UQw3TQ57FN2HM/4SltWKTtXvmfbDfHYS50VCDglOI7Xwvi5
	 0MBf/pg6kX5zrc8joQcsCiB2Na4pKUjBJYepuvO+3tQ4RRhi1tgdGHvrISjQQcctos
	 a+iAl9N+ST+XvK9tsB2n3Uqca8Ut/N9HtQfItggq5tvQmspjiwv60CVUutG/Lq2DqZ
	 iO7XKNRRdkiyGgGP75xmZNW3RE7IwY8EWZVJcl5L7GUVzWQonD4bx+irCC6FTQyfay
	 sFa31IMcleIeg==
Date: Fri, 11 Sep 2026 17:06:58 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-man@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	astian <astian@memeware.net>, Andreas Jaeger <aj@suse.de>, 
	Linux-Arch <linux-arch@vger.kernel.org>
Subject: [PATCH v1] man/man2/outb.2: STANDARDS: Document that this is
 Linux-only, and specifically, x86- and alpha-only.
Message-ID: <ceea4a6d8238e5bf6090586cafdf60de8dd247b9.1789139207.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5qjbnvrp2q5nal4j"
Content-Disposition: inline


--5qjbnvrp2q5nal4j
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-man@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	astian <astian@memeware.net>, Andreas Jaeger <aj@suse.de>, 
	Linux-Arch <linux-arch@vger.kernel.org>
Subject: [PATCH v1] man/man2/outb.2: STANDARDS: Document that this is
 Linux-only, and specifically, x86- and alpha-only.
Message-ID: <ceea4a6d8238e5bf6090586cafdf60de8dd247b9.1789139207.git.alx@kernel.org>
MIME-Version: 1.0

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Message-Id: <b6258140-1ece-4113-bcb4-025302ef59cc@app.fastmail.com>
Cc: astian <astian@memeware.net>
Cc: Andreas Jaeger <aj@suse.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 man/man2/outb.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man2/outb.2 b/man/man2/outb.2
index ba87455b121f..3a01bae1f2e5 100644
--- a/man/man2/outb.2
+++ b/man/man2/outb.2
@@ -73,14 +73,14 @@ .SH DESCRIPTION
 .SH VERSIONS
 .BR outb ()
 and friends are hardware-specific.
 The
 .I value
 argument is passed first and the
 .I port
 argument is passed second,
 which is the opposite order from most DOS implementations.
 .SH STANDARDS
-None.
+Linux (x86, alpha).
 .SH SEE ALSO
 .BR ioperm (2),
 .BR iopl (2)

base-commit: c949d123cd0c00bdd027fac3179d7ef35af132ba
--=20
2.55.0


--5qjbnvrp2q5nal4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmqkGRIACgkQ64mZXMKQ
wqka6w//VJs58d70kS02Jii8T8ZTNQ3Ek9AOY98cHB02zJkmbQn1FklOq6D7X+JJ
v2GmguGjPW3cWHlCcaH6Nfiu+VbQeTTRnCveBqS3rpI1xQKJlPcuzk1sUKfrkZMd
q5QvlWOT3U6Gei9o98cfNXkNVVXuvVCjsAF5QxICLd+Egi4yd6o/RZ765smtvZD6
EFegGkD1l9vp1Hu6VogAHZcvdLJ5em4P2FQVqz20jkN+SHDn6cjfbwMBgoKDvqhO
/NGPTcK1Zirc0YHLKC4JysO7SnDAZSiKrpUQQKo9nwDdMiKjzbA1OVHNOh2D0RAm
g7O21eprxcvEipodVkB7dQ1OVxRcndhZ9xXAVgs79T3Y7Bz6HqXjQ9rpacMX0dWx
62hFjD5Jio9MAayIM+rWZ3UZR+qXNnbRqhD7Ws+NxWt/8zvK5MC/FWwy/jZOOphj
JLJCHpkKyZyOlejICwAhHGEJUGk9X9W8bJuCeo0qIMpdl0HnvJEK+daY/RymYCzV
wSnNVXauy78McRCIy5qdgoT3L0IHQUeBykTHq0WLbsHuaI0rnD8+cdyPZN6DzYMV
su9jNoO+pP+CnlyfncKoWrj19v/BUrnoTWR6fV2N7kytQc4Mm0jgmKsO+tERugCu
qnu/EoVax9DF8ljbum4zcbePmBkSCnyedMJTX/cUE5mYPV9wzoE=
=4ixk
-----END PGP SIGNATURE-----

--5qjbnvrp2q5nal4j--
