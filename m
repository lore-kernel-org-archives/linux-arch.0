Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B26335AC38;
	Wed, 22 Apr 2026 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776898106; cv=none; b=sUEpzzdl088dgET2+Cx/6RvPZcf+qSjQJWtSCfdiLjnvhpw77LPR+6AjyPv0eOx0LCWNiaQLISxwf/lOLFS0898j5+iA+Dg8LXO3jJFBPpgUmogtTcw6CEnv7do0AX/nt3NbCuHFmL4dbCte14qxUPHD6jNqbPEs4muTL0+D8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776898106; c=relaxed/simple;
	bh=LFIU/T5U/PR06CRpKO50PK8cgzNijD6HxlVIv3Oaq4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szSPBdRPX1T9x39iHhv1uFDhBWKZ8+bFlfnojHrIgeX0mj1qRf4u/CENTFCZWLQOuNurr5wIuyocyFtCy8OKy2vJQx3K1ajbnJ7xgQ4RcULr3mGAt7tEryAyyjhHSh0Y8CqVHSIxS7JkBIBWeWHDQaTN61S0AvziFz7eXSr6iCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=fn27O568; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="fn27O568"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4g1DsJ62bWz9v14;
	Thu, 23 Apr 2026 00:48:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1776898100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CshAdHIdOhegAGZ/ibJiR0j5quQNmPDAP31FwRxDM0w=;
	b=fn27O568TzvlQeUqybJAnanyvL6VTQyudgz8GGS0tTvXA0fnHeA6ZfvoRWsmVHyIOeL5uI
	qqkR3Fz2rekK3F9znrulAvkkPX7IsozumvQkojE8KkqXjTfSuxH/D23h39/8YYevsX9WGl
	JI0oQ0ybE09VV7MyNjUMoUu9gYFuEojgQ6UFXyqRdSQw2zgOqZwa9cS2Oj//SKlj2JeRy5
	kOv7gj5iVZ25Scfe/dTzYfVwzROU/LZ4np5BoCVG/krDoEMwPovZoip+7QJ2YecYajvhLS
	baMIAjkDYhCgL8tH7sCf8tAiSxe2XWrM127Rcffs21xGD3DxUpX/N/U8ETyTWA==
Date: Thu, 23 Apr 2026 08:48:09 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: cmirabil@redhat.com, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arnd Bergmann <arnd@arndb.de>, 
	"open list:FILE LOCKING (flock() and fcntl()/lockf())" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] vfs: add O_EMPTYPATH to openat(2)/openat2(2)
Message-ID: <2026-04-22-thirsty-saggy-stat-spouts-6ywYYB@cyphar.com>
References: <20260419131800.486788-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="micvknu33javk6a5"
Content-Disposition: inline
In-Reply-To: <20260419131800.486788-1-jkoolstra@xs4all.nl>


--micvknu33javk6a5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/2] vfs: add O_EMPTYPATH to openat(2)/openat2(2)
MIME-Version: 1.0

On 2026-04-19, Jori Koolstra <jkoolstra@xs4all.nl> wrote:
> To get an operable version of an O_PATH file descriptor, it is possible
> to use openat(fd, ".", O_DIRECTORY) for directories, but other files
> currently require going through open("/proc/<pid>/fd/<nr>"), which
> depends on a functioning procfs.
>=20
> This patch adds the O_EMPTYPATH flag to openat(2)/openat2(2). If passed,
> LOOKUP_EMPTY is set at path resolution time.
>=20
> Note: This implies that you cannot rely anymore on disabling procfs from
> being mounted (e.g. inside a container without procfs mounted and with
> CAP_SYS_ADMIN dropped) to prevent O_PATH fds from being re-opened
> read-write.

Well, you could just block O_EMPTYPATH with seccomp (yes, it'll give you
an unexpected error but people using strict sandboxes are usually fine
with that). You can't block it with openat2(2) but most people block
openat2(2) precisely because you cannot block individual flags with
seccomp (*yet* -- it's on my TODO list!)

I also suspect very few people are actually blocking this correctly in
general. Sadly, most programs don't work without access to /proc (even
glibc implicitly requires it for a lot of compatibility shims).

> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/fcntl.c                       | 2 +-
>  fs/open.c                        | 6 ++++--
>  include/linux/fcntl.h            | 2 +-
>  include/uapi/asm-generic/fcntl.h | 4 ++++
>  4 files changed, 10 insertions(+), 4 deletions(-)

> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/=
fcntl.h
> index 613475285643..db144851f57b 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -88,6 +88,10 @@
>  #define __O_TMPFILE	020000000
>  #endif
> =20
> +#ifndef O_EMPTYPATH
> +#define O_EMPTYPATH	040000000	/* allow empty path */
> +#endif
> +

This value clashes with values on alpha (O_PATH), sparc (__O_TMPFILE),
and parisc (O_SYNC) so you will need to add per-arch definitions for
those as well. You should eventually get a mail because of compilation
errors (thanks to the BUILD_BUG_ON in fs/fcntl.c that was added
specifically to detect this unfortunate quirk of O_* flags).

Actually, it might be nice to try to do what we did with syscall numbers
and just pick 1<<26 as the next bit, but we're getting quite close to
running out of bits. :/

--=20
Aleksa Sarai
https://www.cyphar.com/

--micvknu33javk6a5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaelQKRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG+bFAEA6ptJs6AGW7xWwpsvZF2w
Ykv4i2GzCRA0ujEdI83TfDsBAMhfv5dhefcFSoEJF/ck0anNl520XCeY9JNo9ZG4
nrMO
=no7M
-----END PGP SIGNATURE-----

--micvknu33javk6a5--
