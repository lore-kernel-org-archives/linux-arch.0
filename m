Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA91A3AE183
	for <linux-arch@vger.kernel.org>; Mon,  1 Jun 2026 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329494; cv=none; b=mgYhrZrOWfz6N8meJY4gDRoZTz4Fnoh96YB9W+KLQSjCT/ZktpAnVK+1GLcI7Q8eR3kEM4/fv8P/x+ZRsdWnzkUt6FxlDzKazi4gZQ94JAGvGJ68LKAI+X3IQQaES2HaMrgyELllHcZQqYGidvyXxBZCgw8L4ey9dBUiRey6cZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329494; c=relaxed/simple;
	bh=wfFGpa4hd8MriFRaj1C27iappjFj/ZUW6x4WeHYHXDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fV4I1LUasrN3mH2wlTiXfk6t2bEPMOeF5kd/EYMGiC3fDfncarAbxuqU3ZrUSTgP0QjlGowGKMkMKMXTW/7snILqYo53HzWz2nT+zfEuyfEPwigHmZbItrsq1aPS8yg0P+eZAw/QgJjKZWY4FlKY4giLFOzqUkdnNC9LpHNgizM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E9UpFtjY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dKUn2my4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OwvWznOn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/ukgfTtP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E9UpFtjY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dKUn2my4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OwvWznOn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/ukgfTtP"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED3F167ACB;
	Mon,  1 Jun 2026 15:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780329491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=558HwviRqQQ7RjjiJ/cce6YAyjTcOG6jdw14ixD5Wug=;
	b=E9UpFtjYof29VTrn+k0FzAi7f1TMoQDoqsc1/by5B1fbCdp2T6PvqsQmir4MIkeR2DEfhn
	lyJF5hc3JSqD1MIiFZDLlCBIVaTB/ifIX9vt5Tl7C7ck8YJFLu5A4ahzG6cWQYPTJdbBpn
	xhxsijwcwmQG9z4yQu7dbQlrFAv9MGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780329491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=558HwviRqQQ7RjjiJ/cce6YAyjTcOG6jdw14ixD5Wug=;
	b=dKUn2my4qemsQRg99uoLnfG/mLKXIrxrwXZv9je1Bdodcx+Y0ap5xz+H4+RQOfVEk/143J
	JSqo6LfIWaOl54Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780329490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=558HwviRqQQ7RjjiJ/cce6YAyjTcOG6jdw14ixD5Wug=;
	b=OwvWznOn2dDN0ZkcEXwuL26IhLKSlu64T3PgIUsjzgumRYkrWzLhBvxwvBej5UBOGKeLLZ
	DRKZZU2keNjx5syYaQl7A4b1eg8MHQhLWOrFYOz/4ou3D9rKM5gf7aBMqJk2ujw+Gq7M6v
	wNMgEIchhqGzA9bty/YshNpbbs1s/Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780329490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=558HwviRqQQ7RjjiJ/cce6YAyjTcOG6jdw14ixD5Wug=;
	b=/ukgfTtPXPnrrAL7uR/ZwwErxUHs5fVgJvyJxirAfFtkh3GYN3PaWnfxTpFfKmPLuOd09i
	gg0p/4n2cZt+q5Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDB63779A7;
	Mon,  1 Jun 2026 15:58:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GD0bNhKsHWpQXQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Jun 2026 15:58:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7A8EBA0EC0; Mon, 01 Jun 2026 17:58:10 +0200 (CEST)
Date: Mon, 1 Jun 2026 17:58:10 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arnd Bergmann <arnd@arndb.de>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] vfs: missing inode operation should return a consistent
 error code
Message-ID: <xdknvjlda7wxwo35toe357nnyaydsllv5g65ogzsomxqgm7jfu@qwtugpoy2rcw>
References: <20260531104947.6142-1-jkoolstra@xs4all.nl>
 <c5e32b78aeaa833d18d9b7a566358a6f71d09f23.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5e32b78aeaa833d18d9b7a566358a6f71d09f23.camel@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[xs4all.nl,zeniv.linux.org.uk,kernel.org,suse.cz,arndb.de,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[opengroup.org:url,suse.com:email,xs4all.nl:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Sun 31-05-26 10:08:47, Jeff Layton wrote:
> On Sun, 2026-05-31 at 12:49 +0200, Jori Koolstra wrote:
> > Currently several different error codes are used in the VFS for
> > situations where the underlying filesystem does not support the
> > requested inode operation (such as mkdir, tmpfile, create, etc.)
> > Examples: create returns EACCES, mkdir EPERM, tmpfile EOPNOTSUPP,
> > fileattr_get ENOIOCTLCMD.
> > 
> > We should provide a sensible unified error code for these situations.
> > EOPNOTSUPP is already used for this both in the kernel (when lacking
> > tmpfile support) and in userland (e.g. glibc).[1] Restricting EOPNOTSUPP
> > to socket operations as POSIX suggests is not the current reality and
> > this was recently changed in the man page as well.[2]
> > 
> > vfs_fileattr_get|set return ENOIOCTLCMD, but this cannot be changed
> > since EOPNOTSUPP is already used to by underlying filesystems to indicate
> > that a flag is not supported. The change to EOPNOTSUPP was reverted by
> > 4dd5b5ac089b ("Revert "fs: make vfs_fileattr_[get|set] return
> > -EOPNOTSUPP"")
> > 
> > [1]: https://lore.kernel.org/all/20260528-abnimmt-befreien-perspektive-a7930659fb40@brauner/
> > [2]: https://lore.kernel.org/linux-fsdevel/ahd3SmZZqnzP0-O2@devuan/T/#t
> > 
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > ---
> >  fs/namei.c                       | 18 +++++++++---------
> >  include/uapi/asm-generic/errno.h |  2 +-
> >  2 files changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index c7fac83c9a85..813419c340ad 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4192,7 +4192,7 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode,
> >  		return error;
> >  
> >  	if (!dir->i_op->create)
> > -		return -EACCES;	/* shouldn't it be ENOSYS? */
> > +		return -EOPNOTSUPP;
> >  
> >  	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
> >  	error = security_inode_create(dir, dentry, mode);
> > @@ -4504,7 +4504,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> >  		file->f_mode |= FMODE_CREATED;
> >  		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> >  		if (!dir_inode->i_op->create) {
> > -			error = -EACCES;
> > +			error = -EOPNOTSUPP;
> >  			goto out_dput;
> >  		}
> >  
> > @@ -5102,7 +5102,7 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
> >  		return -EPERM;
> >  
> >  	if (!dir->i_op->mknod)
> > -		return -EPERM;
> > +		return -EOPNOTSUPP;
> >  
> >  	mode = vfs_prepare_mode(idmap, dir, mode, mode, mode);
> >  	error = devcgroup_inode_mknod(mode, dev);
> > @@ -5241,7 +5241,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> >  	if (error)
> >  		goto err;
> >  
> > -	error = -EPERM;
> > +	error = -EOPNOTSUPP;
> >  	if (!dir->i_op->mkdir)
> >  		goto err;
> >  
> > @@ -5345,7 +5345,7 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
> >  		return error;
> >  
> >  	if (!dir->i_op->rmdir)
> > -		return -EPERM;
> > +		return -EOPNOTSUPP;
> >  
> >  	dget(dentry);
> >  	inode_lock(dentry->d_inode);
> > @@ -5479,7 +5479,7 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
> >  		return error;
> >  
> >  	if (!dir->i_op->unlink)
> > -		return -EPERM;
> > +		return -EOPNOTSUPP;
> >  
> >  	inode_lock(target);
> >  	if (IS_SWAPFILE(target))
> > @@ -5630,7 +5630,7 @@ int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
> >  		return error;
> >  
> >  	if (!dir->i_op->symlink)
> > -		return -EPERM;
> > +		return -EOPNOTSUPP;
> >  
> >  	error = security_inode_symlink(dir, dentry, oldname);
> >  	if (error)
> > @@ -5752,7 +5752,7 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
> >  	if (HAS_UNMAPPED_ID(idmap, inode))
> >  		return -EPERM;
> >  	if (!dir->i_op->link)
> > -		return -EPERM;
> > +		return -EOPNOTSUPP;
> >  	if (S_ISDIR(inode->i_mode))
> >  		return -EPERM;
> >  
> > @@ -5961,7 +5961,7 @@ int vfs_rename(struct renamedata *rd)
> >  		return error;
> >  
> >  	if (!old_dir->i_op->rename)
> > -		return -EPERM;
> > +		return -EOPNOTSUPP;
> >  
> >  	/*
> >  	 * If we are going to change the parent - check write permissions,
> > diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
> > index 92e7ae493ee3..7b5b71ae1b12 100644
> > --- a/include/uapi/asm-generic/errno.h
> > +++ b/include/uapi/asm-generic/errno.h
> > @@ -76,7 +76,7 @@
> >  #define	ENOPROTOOPT	92	/* Protocol not available */
> >  #define	EPROTONOSUPPORT	93	/* Protocol not supported */
> >  #define	ESOCKTNOSUPPORT	94	/* Socket type not supported */
> > -#define	EOPNOTSUPP	95	/* Operation not supported on transport endpoint */
> > +#define	EOPNOTSUPP	95	/* Operation not supported */
> >  #define	EPFNOSUPPORT	96	/* Protocol family not supported */
> >  #define	EAFNOSUPPORT	97	/* Address family not supported by protocol */
> >  #define	EADDRINUSE	98	/* Address already in use */
> > 
> > base-commit: 670b77dfebe7257adc0defbc48a4c43cfdf6c8f6
> 
> This seems ill-advised. The problem is that most of this behavior has
> been well established for years, and not all userland software (and
> even some internal callers like nfsd), will react well when you go
> changing behavior like this.
> 
> As a case in point, the POSIX spec doesn't list EOPNOTSUPP as a valid
> error return for open():
> 
>    https://pubs.opengroup.org/onlinepubs/9690949399/functions/open.html
> 
> The manpage for open() says only:
> 
>        EOPNOTSUPP
>               The filesystem containing pathname does not support O_TMPFILE.
> 
> What is the poor userland developer to make of this when open() starts
> returning EOPNOTSUPP without O_TMPFILE being specified?

So I wouldn't care as much about POSIX, we largely ignore it anyway in the
kernel. But I tend to agree that changing the error code we returned for
several decades just for the sake of "cleanliness" isn't IMHO a good enough
reason to risk breaking userspace or causing confusion.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
