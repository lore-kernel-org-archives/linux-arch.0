From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 04/25] avr32: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 22:19:44 +0200
Message-ID: <20140513201944.GA14023@samfundet.no>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
 <1399971769-4116-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:40711 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbaEMUTt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 May 2014 16:19:49 -0400
Content-Disposition: inline
In-Reply-To: <1399971769-4116-1-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com, Haavard Skinnemoen <hskinnemoen@gmail.com>

Around Tue 13 May 2014 17:02:49 +0800 or thereabout, Ley Foon Tan wrote:
> Override time_t and clock_t in include/uapi/asm-generic.
> 
> Signed-off-by: Ley Foon Tan <lftan@altera.com>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  arch/avr32/include/uapi/asm/posix_types.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/avr32/include/uapi/asm/posix_types.h b/arch/avr32/include/uapi/asm/posix_types.h
> index 5b813a8..47d5146 100644
> --- a/arch/avr32/include/uapi/asm/posix_types.h
> +++ b/arch/avr32/include/uapi/asm/posix_types.h
> @@ -32,6 +32,12 @@ typedef unsigned short  __kernel_old_gid_t;
>  typedef unsigned short  __kernel_old_dev_t;
>  #define __kernel_old_dev_t __kernel_old_dev_t
>  
> +typedef long __kernel_time_t;
> +#define __kernel_time_t __kernel_time_t
> +
> +typedef long __kernel_clock_t;
> +#define __kernel_clock_t __kernel_clock_t
> +
>  #include <asm-generic/posix_types.h>
>  
>  #endif /* _UAPI__ASM_AVR32_POSIX_TYPES_H */

Quickly looked over some of the other patches in the series, and they all
seem to add the same. Could this be generic, with the possibility for arch to
override?

-- 
mvh
Hans-Christian Egtvedt
