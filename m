From: Paul Mackerras <paulus@samba.org>
Subject: Re: + page_align-correctly-handle-64-bit-values-on-32-bit-architectures.patch added to -mm tree
Date: Tue, 1 Jul 2008 10:30:15 +1000
Message-ID: <18537.31383.187229.10301@cargo.ozlabs.ibm.com>
References: <200806302233.m5UMXliA029045@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:50353 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408AbYGAAbb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 30 Jun 2008 20:31:31 -0400
In-Reply-To: <200806302233.m5UMXliA029045@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, righi.andrea@gmail.com, linux-arch@vger.kernel.org

akpm@linux-foundation.org writes:

> diff -puN arch/powerpc/boot/page.h~page_align-correctly-handle-64-bit-values-on-32-bit-architectures arch/powerpc/boot/page.h
> --- a/arch/powerpc/boot/page.h~page_align-correctly-handle-64-bit-values-on-32-bit-architectures
> +++ a/arch/powerpc/boot/page.h
> @@ -28,7 +28,4 @@
>  /* align addr on a size boundary - adjust address up if needed */
>  #define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
>  
> -/* to align the pointer to the (next) page boundary */
> -#define PAGE_ALIGN(addr)	_ALIGN(addr, PAGE_SIZE)
> -
>  #endif				/* _PPC_BOOT_PAGE_H */

NAK to this part, because arch/powerpc/boot is a separate program and
doesn't use headers from include/asm or include/linux, hence this
change will leave the bootwrapper without a definition of PAGE_ALIGN.

Paul.
