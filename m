From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 08/28] lkl: system call interface and application API
Date: Sun, 08 Nov 2015 00:24:42 +0100
Message-ID: <4119283.3hnNZZdIi2@wuerfel>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com> <1446582059-17355-9-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:63687 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933124AbbKGXYv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 Nov 2015 18:24:51 -0500
In-Reply-To: <1446582059-17355-9-git-send-email-octavian.purdila@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, thehajime@gmail.com

On Tuesday 03 November 2015 22:20:39 Octavian Purdila wrote:
> +
> +/*
> + * Unsupported system calls due to lack of support in LKL (e.g. related to
> + * virtual memory, signal, user processes). We also only support 64bit version
> + * of system calls where we have two version to keep the same APi across 32 and
> + * 64 bit hosts.
> + */
> +#define __NR_restart_syscall 0
> +#define __NR_exit 0
> +#define __NR_fork 0
> +#define __NR_execve 0
> +#define __NR_ptrace 0
> +#define __NR_alarm 0
> +#define __NR_pause 0

Why are these not #undef?

> diff --git a/arch/lkl/include/uapi/asm/unistd.h b/arch/lkl/include/uapi/asm/unistd.h
> new file mode 100644
> index 0000000..68b5423
> --- /dev/null
> +++ b/arch/lkl/include/uapi/asm/unistd.h
> @@ -0,0 +1,256 @@
> +#ifndef _ASM_UAPI_LKL_UNISTD_H
> +#define _ASM_UAPI_LKL_UNISTD_H
> +
> +#ifdef __KERNEL__
> +#define __NR_ni_syscall		0
> +#define __NR_reboot		1
> +#endif
> +#define __NR_getpid		2
> +#define __NR_write		3
> +#define __NR_close		4
> +#define __NR_unlink		5
> +#define __NR_open		6
> +#define __NR_poll		7

Could you use the standard numbers from include/uapi/asm-generic/unistd.h?
Maybe include that header and then #undef the ones you don't support?
That would avoid having to assign a new number of each future syscall
that gets added.

	Arnd
