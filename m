Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54034 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385AbaKFX0g (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 6 Nov 2014 18:26:36 -0500
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v5 2/7] vfs: Define new syscalls preadv2,pwritev2
References: <cover.1415220890.git.milosz@adfin.com>
	<cover.1415220890.git.milosz@adfin.com>
	<dcc7d998033bbd999bbd92ef9c2041bce0255a3e.1415220890.git.milosz@adfin.com>
Date: Thu, 06 Nov 2014 18:25:50 -0500
In-Reply-To: <dcc7d998033bbd999bbd92ef9c2041bce0255a3e.1415220890.git.milosz@adfin.com>
	(Milosz Tanski's message of "Wed, 5 Nov 2014 16:14:48 -0500")
Message-ID: <x49y4rn29oh.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20141106232550.8rsMwWi3fLqDLcz_8WdM-f3iEBhrq7MmohfktgRBBnc@z>

Milosz Tanski <milosz@adfin.com> writes:

> New syscalls that take an flag argument. This change does not add any specific
> flags.
>
> Signed-off-by: Milosz Tanski <milosz@adfin.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/read_write.c                   | 176 ++++++++++++++++++++++++++++++--------
>  include/linux/compat.h            |   6 ++
>  include/linux/syscalls.h          |   6 ++
>  include/uapi/asm-generic/unistd.h |   6 +-
>  mm/filemap.c                      |   5 +-
>  5 files changed, 158 insertions(+), 41 deletions(-)
>
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 94b2d34..907735c 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -866,6 +866,8 @@ ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
>  		return -EBADF;
>  	if (!(file->f_mode & FMODE_CAN_READ))
>  		return -EINVAL;
> +	if (flags & ~0)
> +		return -EINVAL;
>  
>  	return do_readv_writev(READ, file, vec, vlen, pos, flags);
>  }
> @@ -879,21 +881,23 @@ ssize_t vfs_writev(struct file *file, const struct iovec __user *vec,
>  		return -EBADF;
>  	if (!(file->f_mode & FMODE_CAN_WRITE))
>  		return -EINVAL;
> +	if (flags & ~0)
> +		return -EINVAL;
>  
>  	return do_readv_writev(WRITE, file, vec, vlen, pos, flags);
>  }

Hi, Milosz,

You've checked for invalid flags for the normal system calls, but not
for the compat variants.  Can you add that in, please?

Thanks!
Jeff
