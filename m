Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1276A318BB8;
	Sun, 31 May 2026 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780236531; cv=none; b=RPDaOvi6sZ9cTbD5ZwT5+ZzlcOCYfVK99HQjQMPgU8c36LUZzZwFAOw8uK5tg2uIgtiomsY9c1rnZH8u7FUbOf4WhEZp5wowHBKWdyFDqoGgDBa+P/BalT8C0U6zhe57ZTL5PsVehsuMt1kBl0zjO6XEibkTQvIkBa7pOe/g/nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780236531; c=relaxed/simple;
	bh=jyVPKZ0/cmUu98r1EWJCouBj7DMt2S6yi2wrVOlOqxc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eTx5k5siKx50TUlPzYrIZgqu2pY9qaKEpbjxAmxUyVMRn9tHJ38mp1xjOxWwfUFSxXd4srxpK6zSRdnTVUz7NbPMBSTknrJ0CDgbY3uw6ozatSW6azV308faF6bKPQ0oy+KOiWkpoL12yOnXsKtablHMd0/Fnl5UDaZYOt8lVK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dL5LJs3w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dL5LJs3w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AEB1F0089A;
	Sun, 31 May 2026 14:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780236529;
	bh=INFoxaNJI2f4ewr1YrT0YJcK+/YNafUWsGD89A8ln2A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dL5LJs3w/ON5xLUnEVICW76EXbA1u/PyGoanlYw2ohdTe1D1ckIcWw1KIBhyFheNX
	 5TK4pDWjqWPdMs7qQGC3wuLbcaWXXsxR3kkLcoeuE4GHA6eFVrVbf2ks3gVcIa1VMF
	 4S/G3FLc1WAjqSKhkF2XSvnSGHsQvVlRQ3y9fYGRSkRt6QvVGE+9BOLllQVmJStYjH
	 gPPg/BiC+v12n3RggfZmbVkYkmaBjmCBKQgNr+9i7FS1CAPqd6PieCLvjL2+8AgeDz
	 EdwxZTJPAdHx+8Kjhh8dS9J7DDm+XmnPXbElULIyVUbnii2dtj+fP5RGaalHJZmGEQ
	 aE43Pcs769Okw==
Message-ID: <c5e32b78aeaa833d18d9b7a566358a6f71d09f23.camel@kernel.org>
Subject: Re: [PATCH] vfs: missing inode operation should return a consistent
 error code
From: Jeff Layton <jlayton@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>, Alexander Viro	
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	 <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>
Cc: "open list:FILESYSTEMS (VFS and infrastructure)"	
 <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
 "open list:GENERIC INCLUDE/ASM HEADER FILES"	 <linux-arch@vger.kernel.org>
Date: Sun, 31 May 2026 10:08:47 -0400
In-Reply-To: <20260531104947.6142-1-jkoolstra@xs4all.nl>
References: <20260531104947.6142-1-jkoolstra@xs4all.nl>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-05-31 at 12:49 +0200, Jori Koolstra wrote:
> Currently several different error codes are used in the VFS for
> situations where the underlying filesystem does not support the
> requested inode operation (such as mkdir, tmpfile, create, etc.)
> Examples: create returns EACCES, mkdir EPERM, tmpfile EOPNOTSUPP,
> fileattr_get ENOIOCTLCMD.
>=20
> We should provide a sensible unified error code for these situations.
> EOPNOTSUPP is already used for this both in the kernel (when lacking
> tmpfile support) and in userland (e.g. glibc).[1] Restricting EOPNOTSUPP
> to socket operations as POSIX suggests is not the current reality and
> this was recently changed in the man page as well.[2]
>=20
> vfs_fileattr_get|set return ENOIOCTLCMD, but this cannot be changed
> since EOPNOTSUPP is already used to by underlying filesystems to indicate
> that a flag is not supported. The change to EOPNOTSUPP was reverted by
> 4dd5b5ac089b ("Revert "fs: make vfs_fileattr_[get|set] return
> -EOPNOTSUPP"")
>=20
> [1]: https://lore.kernel.org/all/20260528-abnimmt-befreien-perspektive-a7=
930659fb40@brauner/
> [2]: https://lore.kernel.org/linux-fsdevel/ahd3SmZZqnzP0-O2@devuan/T/#t
>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c                       | 18 +++++++++---------
>  include/uapi/asm-generic/errno.h |  2 +-
>  2 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index c7fac83c9a85..813419c340ad 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4192,7 +4192,7 @@ int vfs_create(struct mnt_idmap *idmap, struct dent=
ry *dentry, umode_t mode,
>  		return error;
> =20
>  	if (!dir->i_op->create)
> -		return -EACCES;	/* shouldn't it be ENOSYS? */
> +		return -EOPNOTSUPP;
> =20
>  	mode =3D vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
>  	error =3D security_inode_create(dir, dentry, mode);
> @@ -4504,7 +4504,7 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
>  		file->f_mode |=3D FMODE_CREATED;
>  		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
>  		if (!dir_inode->i_op->create) {
> -			error =3D -EACCES;
> +			error =3D -EOPNOTSUPP;
>  			goto out_dput;
>  		}
> =20
> @@ -5102,7 +5102,7 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode=
 *dir,
>  		return -EPERM;
> =20
>  	if (!dir->i_op->mknod)
> -		return -EPERM;
> +		return -EOPNOTSUPP;
> =20
>  	mode =3D vfs_prepare_mode(idmap, dir, mode, mode, mode);
>  	error =3D devcgroup_inode_mknod(mode, dev);
> @@ -5241,7 +5241,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, s=
truct inode *dir,
>  	if (error)
>  		goto err;
> =20
> -	error =3D -EPERM;
> +	error =3D -EOPNOTSUPP;
>  	if (!dir->i_op->mkdir)
>  		goto err;
> =20
> @@ -5345,7 +5345,7 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode=
 *dir,
>  		return error;
> =20
>  	if (!dir->i_op->rmdir)
> -		return -EPERM;
> +		return -EOPNOTSUPP;
> =20
>  	dget(dentry);
>  	inode_lock(dentry->d_inode);
> @@ -5479,7 +5479,7 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inod=
e *dir,
>  		return error;
> =20
>  	if (!dir->i_op->unlink)
> -		return -EPERM;
> +		return -EOPNOTSUPP;
> =20
>  	inode_lock(target);
>  	if (IS_SWAPFILE(target))
> @@ -5630,7 +5630,7 @@ int vfs_symlink(struct mnt_idmap *idmap, struct ino=
de *dir,
>  		return error;
> =20
>  	if (!dir->i_op->symlink)
> -		return -EPERM;
> +		return -EOPNOTSUPP;
> =20
>  	error =3D security_inode_symlink(dir, dentry, oldname);
>  	if (error)
> @@ -5752,7 +5752,7 @@ int vfs_link(struct dentry *old_dentry, struct mnt_=
idmap *idmap,
>  	if (HAS_UNMAPPED_ID(idmap, inode))
>  		return -EPERM;
>  	if (!dir->i_op->link)
> -		return -EPERM;
> +		return -EOPNOTSUPP;
>  	if (S_ISDIR(inode->i_mode))
>  		return -EPERM;
> =20
> @@ -5961,7 +5961,7 @@ int vfs_rename(struct renamedata *rd)
>  		return error;
> =20
>  	if (!old_dir->i_op->rename)
> -		return -EPERM;
> +		return -EOPNOTSUPP;
> =20
>  	/*
>  	 * If we are going to change the parent - check write permissions,
> diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/=
errno.h
> index 92e7ae493ee3..7b5b71ae1b12 100644
> --- a/include/uapi/asm-generic/errno.h
> +++ b/include/uapi/asm-generic/errno.h
> @@ -76,7 +76,7 @@
>  #define	ENOPROTOOPT	92	/* Protocol not available */
>  #define	EPROTONOSUPPORT	93	/* Protocol not supported */
>  #define	ESOCKTNOSUPPORT	94	/* Socket type not supported */
> -#define	EOPNOTSUPP	95	/* Operation not supported on transport endpoint *=
/
> +#define	EOPNOTSUPP	95	/* Operation not supported */
>  #define	EPFNOSUPPORT	96	/* Protocol family not supported */
>  #define	EAFNOSUPPORT	97	/* Address family not supported by protocol */
>  #define	EADDRINUSE	98	/* Address already in use */
>=20
> base-commit: 670b77dfebe7257adc0defbc48a4c43cfdf6c8f6

This seems ill-advised. The problem is that most of this behavior has
been well established for years, and not all userland software (and
even some internal callers like nfsd), will react well when you go
changing behavior like this.

As a case in point, the POSIX spec doesn't list EOPNOTSUPP as a valid
error return for open():

   https://pubs.opengroup.org/onlinepubs/9690949399/functions/open.html

The manpage for open() says only:

       EOPNOTSUPP
              The filesystem containing pathname does not support O_TMPFILE=
.

What is the poor userland developer to make of this when open() starts
returning EOPNOTSUPP without O_TMPFILE being specified?
--=20
Jeff Layton <jlayton@kernel.org>
