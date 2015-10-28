Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35464 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932384AbbJ1HSW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Oct 2015 03:18:22 -0400
Date: Wed, 28 Oct 2015 16:18:43 +0900
From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] arch: uapi: asm: mman.h: Let MADV_FREE have same value
 for all architectures
Message-ID: <20151028071843.GH26803@bbox>
References: <5480E715.3020900@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5480E715.3020900@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "rth@twiddle.net" <rth@twiddle.net>, "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>, "mattst88@gmail.com" <mattst88@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, "jejb@parisc-linux.org" <jejb@parisc-linux.org>, "deller@gmx.de" <deller@gmx.de>, "chris@zankel.net" <chris@zankel.net>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20151028071843.MX0mvX7OAO5loSyvyboR8YdRs--nsp83pNq2kGBgD_Q@z>

Hello Chen,

n Fri, Dec 05, 2014 at 06:58:29AM +0800, Chen Gang wrote:
> For uapi, need try to let all macros have same value, and MADV_FREE is
> added into main branch recently, so need redefine MADV_FREE for it.
> 
> At present, '8' can be shared with all architectures, so redefine it to
> '8'.

Recently, I cleaned MADV_FREE patchset up and will send uptodate version
to Andrew to replace old implementation in mmotm tree which is not a
linus's tree so this change shouldn't break anyting.

When I look at status of this patch, it seems Andrew missed it
so I want to include this patch when I respin if you don't mind.

Is it okay for you?

Thanks.

> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/alpha/include/uapi/asm/mman.h     | 2 +-
>  arch/mips/include/uapi/asm/mman.h      | 2 +-
>  arch/parisc/include/uapi/asm/mman.h    | 2 +-
>  arch/xtensa/include/uapi/asm/mman.h    | 2 +-
>  include/uapi/asm-generic/mman-common.h | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
> index 836fbd4..0b8a5de 100644
> --- a/arch/alpha/include/uapi/asm/mman.h
> +++ b/arch/alpha/include/uapi/asm/mman.h
> @@ -44,9 +44,9 @@
>  #define MADV_WILLNEED	3		/* will need these pages */
>  #define	MADV_SPACEAVAIL	5		/* ensure resources are available */
>  #define MADV_DONTNEED	6		/* don't need these pages */
> -#define MADV_FREE	7		/* free pages only if memory pressure */
>  
>  /* common/generic parameters */
> +#define MADV_FREE	8		/* free pages only if memory pressure */
>  #define MADV_REMOVE	9		/* remove these pages & resources */
>  #define MADV_DONTFORK	10		/* don't inherit across fork */
>  #define MADV_DOFORK	11		/* do inherit across fork */
> diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
> index 106e741..d247f54 100644
> --- a/arch/mips/include/uapi/asm/mman.h
> +++ b/arch/mips/include/uapi/asm/mman.h
> @@ -67,9 +67,9 @@
>  #define MADV_SEQUENTIAL 2		/* expect sequential page references */
>  #define MADV_WILLNEED	3		/* will need these pages */
>  #define MADV_DONTNEED	4		/* don't need these pages */
> -#define MADV_FREE	5		/* free pages only if memory pressure */
>  
>  /* common parameters: try to keep these consistent across architectures */
> +#define MADV_FREE	8		/* free pages only if memory pressure */
>  #define MADV_REMOVE	9		/* remove these pages & resources */
>  #define MADV_DONTFORK	10		/* don't inherit across fork */
>  #define MADV_DOFORK	11		/* do inherit across fork */
> diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
> index 6cb8db7..700d83f 100644
> --- a/arch/parisc/include/uapi/asm/mman.h
> +++ b/arch/parisc/include/uapi/asm/mman.h
> @@ -40,9 +40,9 @@
>  #define MADV_SPACEAVAIL 5               /* insure that resources are reserved */
>  #define MADV_VPS_PURGE  6               /* Purge pages from VM page cache */
>  #define MADV_VPS_INHERIT 7              /* Inherit parents page size */
> -#define MADV_FREE	8		/* free pages only if memory pressure */
>  
>  /* common/generic parameters */
> +#define MADV_FREE	8		/* free pages only if memory pressure */
>  #define MADV_REMOVE	9		/* remove these pages & resources */
>  #define MADV_DONTFORK	10		/* don't inherit across fork */
>  #define MADV_DOFORK	11		/* do inherit across fork */
> diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
> index 1b19f25..77eaca4 100644
> --- a/arch/xtensa/include/uapi/asm/mman.h
> +++ b/arch/xtensa/include/uapi/asm/mman.h
> @@ -80,9 +80,9 @@
>  #define MADV_SEQUENTIAL	2		/* expect sequential page references */
>  #define MADV_WILLNEED	3		/* will need these pages */
>  #define MADV_DONTNEED	4		/* don't need these pages */
> -#define MADV_FREE	5		/* free pages only if memory pressure */
>  
>  /* common parameters: try to keep these consistent across architectures */
> +#define MADV_FREE	8		/* free pages only if memory pressure */
>  #define MADV_REMOVE	9		/* remove these pages & resources */
>  #define MADV_DONTFORK	10		/* don't inherit across fork */
>  #define MADV_DOFORK	11		/* do inherit across fork */
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index 7a94102..8695959 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -34,9 +34,9 @@
>  #define MADV_SEQUENTIAL	2		/* expect sequential page references */
>  #define MADV_WILLNEED	3		/* will need these pages */
>  #define MADV_DONTNEED	4		/* don't need these pages */
> -#define MADV_FREE	5		/* free pages only if memory pressure */
>  
>  /* common parameters: try to keep these consistent across architectures */
> +#define MADV_FREE	8		/* free pages only if memory pressure */
>  #define MADV_REMOVE	9		/* remove these pages & resources */
>  #define MADV_DONTFORK	10		/* don't inherit across fork */
>  #define MADV_DOFORK	11		/* do inherit across fork */
> -- 
> 1.9.3
