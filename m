Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FFF472784;
	Mon, 11 May 2026 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524200; cv=none; b=LGbHGyuxuRQXU0A4dnzohwQDWBmMYF3JUXiy/fjyPNH39qnk7OZrf5Wim8q6a02ZzTh8Fr34bC6KAjomODck198MGILf5GhQ8cwG3izKIOm97mCCjYtMgKmZgesYT0G4SY55zjM3JRMmJ9OPruSAAB5/gqD00N7Ka82uPgnNCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524200; c=relaxed/simple;
	bh=mOnRIt5cw4cH/R7V3vuuDDccJ8YG6ocMhdme456Cuvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjJHYDP1zJGokUyhTwuvVdSk8vSBhZPNnvQG8GrCZ3YZadwSMYcMcwe0PomG5bRRHTsHwa3kR75UrIgzhMOa43p/5qBl2CWxt66Yf3aSUX69kP12POgphBmAPB3vzayWCjz1tkDlKCw7MW4YygxnmYKOkdnqjydPAO+ktjPJ3sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=OOCcbXm1; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="OOCcbXm1"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gDpDD33Pxz9tJC;
	Mon, 11 May 2026 20:29:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1778524188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TOM7dgV0LWr8FAq80PjCN0sPeuuxJ48ErXxXpU+rYJg=;
	b=OOCcbXm1NPoSnniKZ+SU3coN0xN7AbJGjrIs7sXInnevGxgtaAlUbOrCb96KNCLW5/8NZK
	W8GPbWtWVjCZDDfwN0T4WF4YhKMNHV0KrPgWnTrson6Cm+rf1qK9kt9naVY3ziUZrAc1eA
	BkAG+ZsbUUJUtUNrhmArerwAS4vC4U3MbBu9ivtG46yu1ekIbqa6OsJ2FNrnv9ZdYe9qbk
	b8nTyKmxZPgoL54aZU/6p6j3u9xZ0Ab63pFgIz9L5GPPxi/ysFr2mbJNBRZALgWuC9Ztqh
	KQTgmq12KKAjx4X88KW04tHu0ZrKXSkLiktWEJBWCgEl1hOapvwsDutrgoi3kw==
Date: Tue, 12 May 2026 04:29:32 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] vfs: add O_EMPTYPATH to openat(2)/openat2(2)
Message-ID: <2026-05-11-robotic-unseen-reversal-talisman-5w0bQM@cyphar.com>
References: <20260424114611.1678641-1-jkoolstra@xs4all.nl>
 <20260424114611.1678641-2-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eoc2fy2uc2uxjcgx"
Content-Disposition: inline
In-Reply-To: <20260424114611.1678641-2-jkoolstra@xs4all.nl>


--eoc2fy2uc2uxjcgx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 1/2] vfs: add O_EMPTYPATH to openat(2)/openat2(2)
MIME-Version: 1.0

On 2026-04-24, Jori Koolstra <jkoolstra@xs4all.nl> wrote:
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
>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Thanks!

Reviewed-by: Aleksa Sarai <aleksa@amutable.com>

> ---
>  fs/fcntl.c                       | 2 +-
>  fs/open.c                        | 6 ++++--
>  include/linux/fcntl.h            | 2 +-
>  include/uapi/asm-generic/fcntl.h | 4 ++++
>  4 files changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index beab8080badf..7d2165855a9c 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -1169,7 +1169,7 @@ static int __init fcntl_init(void)
>  	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
>  	 * is defined as O_NONBLOCK on some platforms and not on others.
>  	 */
> -	BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=3D
> +	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
>  		HWEIGHT32(
>  			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
>  			__FMODE_EXEC));
> diff --git a/fs/open.c b/fs/open.c
> index 681d405bc61e..9e0164a8c1fb 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1158,7 +1158,7 @@ struct file *kernel_file_open(const struct path *pa=
th, int flags,
>  EXPORT_SYMBOL_GPL(kernel_file_open);
> =20
>  #define WILL_CREATE(flags)	(flags & (O_CREAT | __O_TMPFILE))
> -#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
> +#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC | O=
_EMPTYPATH)
> =20
>  inline struct open_how build_open_how(int flags, umode_t mode)
>  {
> @@ -1279,6 +1279,8 @@ inline int build_open_flags(const struct open_how *=
how, struct open_flags *op)
>  		lookup_flags |=3D LOOKUP_DIRECTORY;
>  	if (!(flags & O_NOFOLLOW))
>  		lookup_flags |=3D LOOKUP_FOLLOW;
> +	if (flags & O_EMPTYPATH)
> +		lookup_flags |=3D LOOKUP_EMPTY;
> =20
>  	if (how->resolve & RESOLVE_NO_XDEV)
>  		lookup_flags |=3D LOOKUP_NO_XDEV;
> @@ -1360,7 +1362,7 @@ static int do_sys_openat2(int dfd, const char __use=
r *filename,
>  	if (unlikely(err))
>  		return err;
> =20
> -	CLASS(filename, name)(filename);
> +	CLASS(filename_flags, name)(filename, op.lookup_flags);
>  	return FD_ADD(how->flags, do_file_open(dfd, name, &op));
>  }
> =20
> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index a332e79b3207..c65c5c73d362 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -10,7 +10,7 @@
>  	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC |=
 \
>  	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
>  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
> -	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> +	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_EMPTYPATH)
> =20
>  /* List of all valid flags for the how->resolve argument: */
>  #define VALID_RESOLVE_FLAGS \
> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/=
fcntl.h
> index 613475285643..bfc68156b45a 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -88,6 +88,10 @@
>  #define __O_TMPFILE	020000000
>  #endif
> =20
> +#ifndef O_EMPTYPATH
> +#define O_EMPTYPATH	(1 << 26)	/* allow empty path */
> +#endif
> +
>  /* a horrid kludge trying to make sure that this will fail on old kernel=
s */
>  #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
> =20
> --=20
> 2.54.0
>=20

--=20
Aleksa Sarai
https://www.cyphar.com/

--eoc2fy2uc2uxjcgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCagIgCBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG8FIAD/RN5/VJyZB+aNtgs8bTC8
wVFbPqqaFinpfNgQpu4CVoYBAPNFSLxNhiZbPud5qCUVIN4fzb+JemBJIxZh85nK
QI0E
=IBxS
-----END PGP SIGNATURE-----

--eoc2fy2uc2uxjcgx--
