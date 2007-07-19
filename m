Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:46910 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754807AbXGSUB5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Jul 2007 16:01:57 -0400
Date: Thu, 19 Jul 2007 22:02:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [patch 055/209] define new percpu interface for shared data
Message-ID: <20070719200253.GB15186@uranus.ravnborg.org>
References: <200707190848.l6J8mCkl023086@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200707190848.l6J8mCkl023086@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, fenghua.yu@intel.com, ak@suse.de, clameter@sgi.com, linux-arch@vger.kernel.org, rusty@rustcorp.com.au, suresh.b.siddha@intel.com, tony.luck@intel.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, Jul 19, 2007 at 01:48:12AM -0700, akpm@linux-foundation.org wrote:
> 
> Moves the remotely accessed per cpu data (which is currently marked
> as ____cacheline_aligned_in_smp) into a different section, where all the data
> elements are cacheline aligned. And as such, this differentiates the local
> only data and remotely accessed data cleanly.
> 
> --- a/arch/arm/kernel/vmlinux.lds.S~define-new-percpu-interface-for-shared-data-version-4
> +++ a/arch/arm/kernel/vmlinux.lds.S
> @@ -66,6 +66,7 @@ SECTIONS
>  		. = ALIGN(4096);
>  		__per_cpu_start = .;
>  			*(.data.percpu)
> +			*(.data.percpu.shared_aligned)
>  		__per_cpu_end = .;
>  #ifndef CONFIG_XIP_KERNEL
>  		__init_begin = _stext;

Why is PERCPU not suitable for arm?


> diff -puN arch/i386/kernel/vmlinux.lds.S~define-new-percpu-interface-for-shared-data-version-4 arch/i386/kernel/vmlinux.lds.S
> --- a/arch/i386/kernel/vmlinux.lds.S~define-new-percpu-interface-for-shared-data-version-4
> +++ a/arch/i386/kernel/vmlinux.lds.S
> @@ -181,6 +181,7 @@ SECTIONS
>    .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) {
>  	__per_cpu_start = .;
>  	*(.data.percpu)
> +	*(.data.percpu.shared_aligned)
>  	__per_cpu_end = .;
>    }
>    . = ALIGN(4096);
Ditto for i386

> --- a/arch/ia64/kernel/vmlinux.lds.S~define-new-percpu-interface-for-shared-data-version-4
> +++ a/arch/ia64/kernel/vmlinux.lds.S
> @@ -206,6 +206,7 @@ SECTIONS
>  	{
>  		__per_cpu_start = .;
>  		*(.data.percpu)
> +		*(.data.percpu.shared_aligned)
>  		__per_cpu_end = .;
>  	}
>    . = __phys_per_cpu_start + PERCPU_PAGE_SIZE;	/* ensure percpu data fits
Ditto

> diff -puN arch/powerpc/kernel/vmlinux.lds.S~define-new-percpu-interface-for-shared-data-version-4 arch/powerpc/kernel/vmlinux.lds.S
> --- a/arch/powerpc/kernel/vmlinux.lds.S~define-new-percpu-interface-for-shared-data-version-4
> +++ a/arch/powerpc/kernel/vmlinux.lds.S
> @@ -144,6 +144,7 @@ SECTIONS
>  	.data.percpu : {
>  		__per_cpu_start = .;
>  		*(.data.percpu)
> +		*(.data.percpu.shared_aligned)
>  		__per_cpu_end = .;
>  	}
Ditto

	Sam
