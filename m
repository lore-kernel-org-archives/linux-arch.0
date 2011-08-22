From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 12/24] C6X: syscalls
Date: Mon, 22 Aug 2011 23:00:04 +0200
Message-ID: <2674360.Vi7D6LZv9Y@wuerfel>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com> <1314043785-2880-13-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55037 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab1HVVAj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2011 17:00:39 -0400
In-Reply-To: <1314043785-2880-13-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 22 August 2011 16:09:33 Mark Salter wrote:
> +asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
> +                        unsigned long prot, unsigned long flags,
> +                        unsigned long fd, off_t offset)
> +{
> +       if (offset & ~PAGE_MASK)
> +               return -EINVAL;
> +       return sys_mmap_pgoff(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
> +}
> +
> +/* Provide the actual syscall number to call mapping. */
> +#undef __SYSCALL
> +#define __SYSCALL(nr, call) [nr] = (call),
> +
> +/*
> + * Use trampolines
> + */
> +#define sys_pread64            sys_pread_c6x
> +#define sys_pwrite64           sys_pwrite_c6x
> +#define sys_truncate64         sys_truncate64_c6x
> +#define sys_ftruncate64                sys_ftruncate64_c6x
> +#define sys_fadvise64          sys_fadvise64_c6x
> +#define sys_fadvise64_64       sys_fadvise64_64_c6x
> +#define sys_fallocate          sys_fallocate_c6x
> +
> +/* Use sys_mmap_pgoff directly */
> +#define sys_mmap2 sys_mmap_pgoff

If you use sys_mmap_pgoff, there should be no need for sys_mmap any more.

	Arnd
