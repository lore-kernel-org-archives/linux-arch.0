Return-Path: <arnd@arndb.de>
Received: from natsmtp01.rzone.de ([81.169.145.166]:12446 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S263602AbUCYUeq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 25 Mar 2004 15:34:46 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [CFT] compat_sys_mount
Date: Thu, 25 Mar 2004 21:17:00 +0100
References: <20040324154832.GJ25059@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040324154832.GJ25059@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403252117.00480.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
To: Matthew Wilcox <willy@debian.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wednesday 24 March 2004 16:48, Matthew Wilcox wrote:
> My first thought on seeing DaveM's patch to sys32_mount was "Why doesn't
> he just move it to fs/compat.c".  The answer is "Because it's more than
> trivial to do".  Sigh.  So here's a first stab at the problem.

Looks good. Here are a few comments for stuff that could be improved
further:

>  - low2highuid and gid are only defined on some architectures, so I just
>    deleted them.  I don't think it's valid for -1 to be in any of those
>    fields anyway.

I guess this will cause mounts with "-o uid=65535" to have all files owned
by overflowuid instead of 65535, not sure if this needs to be fixed
either.

> +struct ncp_mount_data32_v4 {
> +	int version;
> +	/* all members below are "long" in ABI */
> +	unsigned int flags;
> +	unsigned int mounted_uid;
> +	int wdog_pid;
> +	unsigned int ncp_fd;
> +	unsigned int time_out;
> +	unsigned int retry_count;
> +	unsigned int uid;
> +	unsigned int gid;
> +	unsigned int file_mode;
> +	unsigned int dir_mode;
> +};

The current convention suggests calling the structure
compat_ncp_mount_data_v4. It would also be clearer to
use compat_ulong_t for emulating unsigned long fields.
The same applies to the other structures.

> +	} else {
> +		return NULL;
> +	}
> +
> +	return raw_data;
> +}
> +

failing do_ncp_super_data_conv for unknown version
probably breaks version 5 parameters, which pass a
string in *data.

> +static int copy_mount_stuff_to_kernel(const void *user, unsigned long *kernel)
> +{
> +	int i;
> +	unsigned long page;
> +	struct vm_area_struct *vma;
> +
> +	*kernel = 0;
> +	if (!user)
> +		return 0;
> +	vma = find_vma(current->mm, (unsigned long)user);
> +	if (!vma || (unsigned long)user < vma->vm_start)
> +		return -EFAULT;
> +	if (!(vma->vm_flags & VM_READ))
> +		return -EFAULT;
> +	i = vma->vm_end - (unsigned long) user;
> +	if (PAGE_SIZE <= (unsigned long) i)
> +		i = PAGE_SIZE - 1;
> +	if (!(page = __get_free_page(GFP_KERNEL)))
> +		return -ENOMEM;
> +	if (copy_from_user((void *) page, user, i)) {
> +		free_page(page);
> +		return -EFAULT;
> +	}
> +	*kernel = page;
> +	return 0;
> +}

This looks like the 2.2.x version of copy_mount_options. It's probably
better to make the real copy_mount_options function global and call
that instead.

> +	err = copy_mount_stuff_to_kernel(dir_name, &dir_page);
> +	if (err)
> +		goto dev_out;

sys_mount uses get_name() here.

Since we now have compat_alloc_user_space, compat_sys_mount could be
implemented somewhat simpler by just converting the data page in
case of smb, ncpv3 and ncpv4  and calling sys_mount.

	Arnd <><
