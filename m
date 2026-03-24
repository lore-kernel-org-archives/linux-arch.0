Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2F83F8E11;
	Tue, 24 Mar 2026 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355481; cv=none; b=J2Qx/U+NOSkcuCPtkhXiARPTqEEWeQ/mzAtDCm17Sd9VziFZFIa0TKOdQ0c/kU+66GrIYc08l/GS5jGCf++AC/WivOjD4x7vizSggOjQDJt2vt5mj9hloy2GixA227AojbqvQtH3J/IoegWxPmugLLtGKorSTXAGshIbL8KJN3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355481; c=relaxed/simple;
	bh=Z63/zjcHqfFV5Qn4B9BpNQIoOK6HDNDi+XQVR+t8PjI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NmN9pSq343ikm34qVHfhll+P6d0jm49ldf5TaBZrHhYfNOxTMMemsKnJbmkK0R6xXswmm7QU/OrbBIhfk/rEShqHDV6V9Af9vK5qUCt5Lrgn/a52fDi2rzXr39j7ze9Zd3en+fQcEExERXFxMhtV4UfhTW5RXZTnSFpTlYDVfBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9VEy6yd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9VEy6yd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58838C19424;
	Tue, 24 Mar 2026 12:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774355480;
	bh=Z63/zjcHqfFV5Qn4B9BpNQIoOK6HDNDi+XQVR+t8PjI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=X9VEy6ydihgcVFTq1LZcft7aQ6mXSCotcDWGosw+P4bUq5yI8iqsYI6iPz0tudSAM
	 FIpzDNOzrKGbKBVQ8ab5EBi+y6VhNbqfiOJsacsLc+bwELmEDj/okZ/q4eE2ipysCn
	 VUGo1CX4hHqwsDcq7nysyCcFOULs+QMLVEJIt9IlKWBOSuJyC+jnE1c3VtQtDPriYs
	 DdTe8D6z1HWwxWhZb08E0EbSB74l5Ksup82R/KRmmrqVLiqwUbmg2xeH7LUWY7RnPi
	 DVlyesXSMrTrN7ie9J7FP+OQ/ZdwXLO7NOeEz+DNnO2EPn1Yo/r+JGIW0AfvIqaZVn
	 r1ZueWgELVYOw==
Message-ID: <1f9db20a9701e3d79805c75ebee5a5129a72ead0.camel@kernel.org>
Subject: Re: [RFC PATCH 0/1] vfs: transitive upgrade restrictions for fds
From: Jeff Layton <jlayton@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>, Alexander Viro	
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	 <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, Alexander Aring	
 <alex.aring@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	gregkh@linuxfoundation.org
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett"	
 <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, David
 Hildenbrand	 <david@redhat.com>, Lorenzo Stoakes <ljs@kernel.org>, zhang
 jiao	 <zhangjiao2@cmss.chinamobile.com>, Kees Cook <kees@kernel.org>,
 Penglei Jiang	 <superman.xpt@gmail.com>, Ethan Tidmore
 <ethantidmore06@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Suren
 Baghdasaryan <surenb@google.com>, Vlastimil Babka	 <vbabka@kernel.org>,
 wangzijie <wangzijie1@honor.com>, NeilBrown <neil@brown.name>,  Amir
 Goldstein <amir73il@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>,
 linux-fsdevel@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org
Date: Tue, 24 Mar 2026 08:31:16 -0400
In-Reply-To: <20260323220029.765874-1-jkoolstra@xs4all.nl>
References: <20260323220029.765874-1-jkoolstra@xs4all.nl>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-23 at 23:00 +0100, Jori Koolstra wrote:
> Add upgrade restrictions to openat2(). Extend struct open_how to allow
> setting transitive restrictions on using file descriptors to open other
> files. A use case for this feature is to block services or containers
> from re-opening/upgrading an O_PATH file descriptor through e.g.
> /proc/<pid>/fd/<nr> or OPENAT2_EMPTY_PATH (if upstreamed) as O_WRONLY.
>=20
> The implementation idea is this: magic paths like /proc/<pid>/fd/<nr>
> (currently the only one of its sort AFAIK) go through nd_jump_link() to
> hard set current->nameidata. To include information about the fd
> yielding the magic link, we add a new struct jump_how as a parameter.
> This struct may include restictions or other metadata attached to the
> magic link jump other than the struct path to jump to. So far it has
> only one unsigned int field: allowed_upgrades. This is a flag int that
> (for now) may be either READ_UPGRADABLE, WRITE_UPGRADABLE, or
> DENY_UPGRADES.
>=20
> The idea is that you can restrict what kind of open flags may be used
> to open files in any way using this fd as a starting point
> (transitively). The check is enforced in may_open_upgrade(), which is
> just the old may_open() with an extra test. To keep this state attached
> to the fds, we add a field f_allowed_upgrades to struct file. Then
> in do_open(), after success, we compute:
>=20
> 	file->f_allowed_upgrades =3D
> 		op->allowed_upgrades & nd->allowed_upgrades;
>=20
> where op is the struct open_flags that is build from open_how in
> build_open_flags(), and nd->allowed_upgrades is set during path
> traversal either in path_init() or nd_jump_link().
>=20
> The implementation and the idea are a bit rough; it is the first bit of
> less trivial work I have done on the kernel, hence the RFC status. I did
> create some self tests already which this patch passes, and nothing
> seems to break on a fresh vng kernel. But obviously there may be MANY
> things I am overlooking.
>=20
> The original idea for this features comes form the UAPI group kernel
> feature idea list [1].
>=20
> [1] https://github.com/uapi-group/kernel-features?tab=3Dreadme-ov-file#up=
grade-masks-in-openat2
>=20
> Jori Koolstra (1):
>   vfs: transitive upgrade restrictions for fds
>=20
>  fs/file_table.c                  |  2 ++
>  fs/internal.h                    |  1 +
>  fs/namei.c                       | 38 ++++++++++++++++++++++++++++----
>  fs/open.c                        |  9 ++++++++
>  fs/proc/base.c                   | 24 ++++++++++++++------
>  fs/proc/fd.c                     |  6 ++++-
>  fs/proc/internal.h               |  4 +++-
>  include/linux/fcntl.h            |  6 ++++-
>  include/linux/fs.h               |  1 +
>  include/linux/namei.h            | 15 ++++++++++++-
>  include/uapi/asm-generic/fcntl.h |  4 ++++
>  include/uapi/linux/openat2.h     |  1 +
>  12 files changed, 96 insertions(+), 15 deletions(-)


It's an interesting idea, but I could see it being difficult to track
the result of this across a large chain of open fd's.

If you are going to do this, then at the very least you should add a
mechanism (fcntl() command?) to query the current f_allowed_upgrade
mask, so that this can be debugged in some fashion.
--=20
Jeff Layton <jlayton@kernel.org>
