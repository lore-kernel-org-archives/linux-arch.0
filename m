From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] compat ABI: use non-compat openat and open_by_handle_at variants
Date: Mon, 28 Dec 2015 12:18:56 +0100
Message-ID: <5945276.2UuG1prsU3@wuerfel>
References: <1451146000-5646-1-git-send-email-ynorov@caviumnetworks.com> <1451146000-5646-2-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:64329 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbbL1LTK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Dec 2015 06:19:10 -0500
In-Reply-To: <1451146000-5646-2-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, klimov.linux@gmail.com, Chris Metcalf <cmetcalf@ezchip.com>

On Saturday 26 December 2015 19:06:39 Yury Norov wrote:
> The only difference is that non-compat version forces O_LARGEFILE,
> and it should be the default behaviour for all architectures, as
> we don't support 32-bit off_t. The only exception is tile32, that
> continues with compat version of syscalls.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

Looks good,

Acked-by: Arnd Bergmann <arnd@arndb.de>

(adding Chris to Cc a well, in case he has further comments)

>  arch/tile/kernel/compat.c         | 3 +++
>  include/uapi/asm-generic/unistd.h | 5 ++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/tile/kernel/compat.c b/arch/tile/kernel/compat.c
> index 4912084..489ae19 100644
> --- a/arch/tile/kernel/compat.c
> +++ b/arch/tile/kernel/compat.c
> @@ -94,6 +94,9 @@ COMPAT_SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned int, offset_high,
>  #define compat_sys_readahead sys32_readahead
>  #define sys_llseek compat_sys_llseek
>  
> +#define sys_openat		compat_sys_openat
> +#define sys_open_by_handle_at	compat_sys_open_by_handle_at
> +
>  /* Call the assembly trampolines where necessary. */
>  #define compat_sys_rt_sigreturn _compat_sys_rt_sigreturn
>  #define sys_clone _sys_clone
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 1324b02..07761e5 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -175,7 +175,7 @@ __SYSCALL(__NR_fchownat, sys_fchownat)
>  #define __NR_fchown 55
>  __SYSCALL(__NR_fchown, sys_fchown)
>  #define __NR_openat 56
> -__SC_COMP(__NR_openat, sys_openat, compat_sys_openat)
> +__SYSCALL(__NR_openat, sys_openat)
>  #define __NR_close 57
>  __SYSCALL(__NR_close, sys_close)
>  #define __NR_vhangup 58
> @@ -673,8 +673,7 @@ __SYSCALL(__NR_fanotify_mark, sys_fanotify_mark)
>  #define __NR_name_to_handle_at         264
>  __SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
>  #define __NR_open_by_handle_at         265
> -__SC_COMP(__NR_open_by_handle_at, sys_open_by_handle_at, \
> -	  compat_sys_open_by_handle_at)
> +__SYSCALL(__NR_open_by_handle_at, sys_open_by_handle_at)
>  #define __NR_clock_adjtime 266
>  __SC_COMP(__NR_clock_adjtime, sys_clock_adjtime, compat_sys_clock_adjtime)
>  #define __NR_syncfs 267
> 
