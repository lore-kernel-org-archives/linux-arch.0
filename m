From: Greg Ungerer <gerg@uclinux.org>
Subject: Re: [PATCH] include: asm-generic: page.h: Remove useless
 get_user_page and free_user_page
Date: Fri, 20 Nov 2015 22:15:09 +1000
Message-ID: <564F0ECD.2050109@uclinux.org>
References: <COL130-W7B5F0BB94C76AF6B12EA7B91C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <COL130-W7B5F0BB94C76AF6B12EA7B91C0@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Gang <xili_gchen_5257@hotmail.com>, "vgupta@synopsys.com" <vgupta@synopsys.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "jonas@southpole.se" <jonas@southpole.se>, Arnd Bergmann <arnd@arndb.de>, "abrodkin@synopsys.com" <abrodkin@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, kernel mailing list <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux@lists.openrisc.net
List-Id: linux-arch.vger.kernel.org

Hi Chen,

On 19/11/15 05:40, Chen Gang wrote:
>>From ba7c00c4cb976109b6a35812ce9649aaeda81e2d Mon Sep 17 00:00:00 2001
> From: Chen Gang <gang.chen.5i5j@gmail.com>
> Date: Thu, 19 Nov 2015 03:24:42 +0800
> Subject: [PATCH] include: asm-generic: page.h: Remove useless get_user_page and free_user_page
>
> They are not symmetric with each other, neither are used in real world
> (can not be found by grep command in source code root directory), so
> remove them.
>
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>

Compile and run tested on m68k (MMU and noMMU) targets.
No problems found. So for those parts:

Acked-by: Greg Ungerer <gerg@uclinux.org>

Regards
Greg


> ---
>   arch/arc/include/asm/page.h       | 3 ---
>   arch/arm/include/asm/page-nommu.h | 3 ---
>   arch/frv/include/asm/page.h       | 3 ---
>   arch/m68k/include/asm/page_mm.h   | 3 ---
>   arch/m68k/include/asm/page_no.h   | 3 ---
>   arch/openrisc/include/asm/page.h  | 3 ---
>   include/asm-generic/page.h        | 3 ---
>   7 files changed, 21 deletions(-)
>
> diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
> index 429957f..adf5cbb 100644
> --- a/arch/arc/include/asm/page.h
> +++ b/arch/arc/include/asm/page.h
> @@ -13,9 +13,6 @@
>
>   #ifndef __ASSEMBLY__
>
> -#define get_user_page(vaddr)		__get_free_page(GFP_KERNEL)
> -#define free_user_page(page, addr)	free_page(addr)
> -
>   #define clear_page(paddr)		memset((paddr), 0, PAGE_SIZE)
>   #define copy_page(to, from)		memcpy((to), (from), PAGE_SIZE)
>
> diff --git a/arch/arm/include/asm/page-nommu.h b/arch/arm/include/asm/page-nommu.h
> index d1b162a..503f488 100644
> --- a/arch/arm/include/asm/page-nommu.h
> +++ b/arch/arm/include/asm/page-nommu.h
> @@ -17,9 +17,6 @@
>   #define KTHREAD_SIZE PAGE_SIZE
>   #endif
>
> -#define get_user_page(vaddr)		__get_free_page(GFP_KERNEL)
> -#define free_user_page(page, addr)	free_page(addr)
> -
>   #define clear_page(page)	memset((page), 0, PAGE_SIZE)
>   #define copy_page(to,from)	memcpy((to), (from), PAGE_SIZE)
>
> diff --git a/arch/frv/include/asm/page.h b/arch/frv/include/asm/page.h
> index 8c97068..52ace96 100644
> --- a/arch/frv/include/asm/page.h
> +++ b/arch/frv/include/asm/page.h
> @@ -8,9 +8,6 @@
>
>   #ifndef __ASSEMBLY__
>
> -#define get_user_page(vaddr)			__get_free_page(GFP_KERNEL)
> -#define free_user_page(page, addr)		free_page(addr)
> -
>   #define clear_page(pgaddr)			memset((pgaddr), 0, PAGE_SIZE)
>   #define copy_page(to,from)			memcpy((to), (from), PAGE_SIZE)
>
> diff --git a/arch/m68k/include/asm/page_mm.h b/arch/m68k/include/asm/page_mm.h
> index 5029f73..e7a1946 100644
> --- a/arch/m68k/include/asm/page_mm.h
> +++ b/arch/m68k/include/asm/page_mm.h
> @@ -6,9 +6,6 @@
>   #include <linux/compiler.h>
>   #include <asm/module.h>
>
> -#define get_user_page(vaddr)		__get_free_page(GFP_KERNEL)
> -#define free_user_page(page, addr)	free_page(addr)
> -
>   /*
>    * We don't need to check for alignment etc.
>    */
> diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_no.h
> index ef20916..fa7f32d 100644
> --- a/arch/m68k/include/asm/page_no.h
> +++ b/arch/m68k/include/asm/page_no.h
> @@ -6,9 +6,6 @@
>   extern unsigned long memory_start;
>   extern unsigned long memory_end;
>
> -#define get_user_page(vaddr)		__get_free_page(GFP_KERNEL)
> -#define free_user_page(page, addr)	free_page(addr)
> -
>   #define clear_page(page)	memset((page), 0, PAGE_SIZE)
>   #define copy_page(to,from)	memcpy((to), (from), PAGE_SIZE)
>
> diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
> index 108906f..e613d36 100644
> --- a/arch/openrisc/include/asm/page.h
> +++ b/arch/openrisc/include/asm/page.h
> @@ -40,9 +40,6 @@
>
>   #ifndef __ASSEMBLY__
>
> -#define get_user_page(vaddr)            __get_free_page(GFP_KERNEL)
> -#define free_user_page(page, addr)      free_page(addr)
> -
>   #define clear_page(page)	memset((page), 0, PAGE_SIZE)
>   #define copy_page(to, from)	memcpy((to), (from), PAGE_SIZE)
>
> diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
> index 37d1fe2..67cfb7d 100644
> --- a/include/asm-generic/page.h
> +++ b/include/asm-generic/page.h
> @@ -24,9 +24,6 @@
>
>   #ifndef __ASSEMBLY__
>
> -#define get_user_page(vaddr)		__get_free_page(GFP_KERNEL)
> -#define free_user_page(page, addr)	free_page(addr)
> -
>   #define clear_page(page)	memset((page), 0, PAGE_SIZE)
>   #define copy_page(to,from)	memcpy((to), (from), PAGE_SIZE)
>
> --
> 1.9.3
>
>   		 	   		
>
