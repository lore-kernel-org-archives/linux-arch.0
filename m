Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:45356 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeHKWxl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Aug 2018 18:53:41 -0400
Date: Sat, 11 Aug 2018 20:28:04 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 1/6] alpha: Move __IGNORE* entries to non uapi header
Message-ID: <20180811192804.GI6515@ZenIV.linux.org.uk>
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
 <1531736638-15294-2-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531736638-15294-2-git-send-email-firoz.khan@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: linux-alpha@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com
Message-ID: <20180811192804.8sRTr2G9qwDZawQLRIaNXThv-y6lI7Zo1E559UiHQM4@z>

On Mon, Jul 16, 2018 at 03:53:53PM +0530, Firoz Khan wrote:
> It is correct to keep __IGNORE* entry in non uapi header
> asm/unistd.h while uapi/asm/unistd.h must hold information
> only useful for user space applications.

> diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
> index e153ca6..3bb6ac1 100644
> --- a/arch/alpha/include/uapi/asm/unistd.h
> +++ b/arch/alpha/include/uapi/asm/unistd.h
> @@ -481,9 +481,4 @@
>  #define __NR_pwritev2			521
>  #define __NR_statx			522
>  
> -/* Alpha doesn't have protection keys. */
> -#define __IGNORE_pkey_mprotect
> -#define __IGNORE_pkey_alloc
> -#define __IGNORE_pkey_free
> -
>  #endif /* _UAPI_ALPHA_UNISTD_H */

Hmm...  There's also

#define __IGNORE_alarm
#define __IGNORE_creat
#define __IGNORE_getegid
#define __IGNORE_geteuid
#define __IGNORE_getgid
#define __IGNORE_getpid
#define __IGNORE_getppid
#define __IGNORE_getuid
#define __IGNORE_pause
#define __IGNORE_time
#define __IGNORE_utime
#define __IGNORE_umount2

in there...
