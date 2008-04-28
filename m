Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:41510 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934470AbYD1Ons (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Apr 2008 10:43:48 -0400
Date: Mon, 28 Apr 2008 16:43:32 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] Add fast little-endian switch system call
Message-ID: <20080428144332.GA17109@lst.de>
References: <18453.18943.906693.409245@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18453.18943.906693.409245@cargo.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, mtk.manpages@gmail.com, linux-arch@vger.kernel.org
Message-ID: <20080428144332.bq9agq-LJ4594PA-1ufxW4PUFfG6mhQY3hVcIxBN6yQ@z>

Please see Michael Kerrisk on userspace ABI updates.  A nice little
manpage for this gimmick would be helpful, and maybe help other
platforms that want one aswell to implement the same API.

On Mon, Apr 28, 2008 at 01:52:31PM +1000, Paul Mackerras wrote:
> This adds a system call on 64-bit platforms for switching between
> little-endian and big-endian modes that is much faster than doing a
> prctl call.  This system call is handled as a special case right at
> the start of the system call entry code, and because it is a special
> case, it uses a system call number which is out of the range of
> normal system calls, namely 0x1ebe.
> 
> Measurements with lmbench on a 4.2GHz POWER6 showed no measurable
> change in the speed of normal system calls with this patch.
> 
> Switching endianness with this new system call takes around 60ns on a
> 4.2GHz POWER6, compared with around 300ns to switch endian mode with a
> prctl.  This can provide a significant performance advantage for
> emulators for little-endian architectures that want to switch between
> big-endian and little-endian mode frequently, e.g. because they are
> generating instructions sequences on the fly and they want to run
> those sequences in little-endian mode.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> 
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 215973a..2eb49a7 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -239,6 +239,10 @@ instruction_access_slb_pSeries:
>  	.globl	system_call_pSeries
>  system_call_pSeries:
>  	HMT_MEDIUM
> +BEGIN_FTR_SECTION
> +	cmpdi	r0,0x1ebe
> +	beq-	1f
> +END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)

Am I missing something here or does this add a branch for every normal
syscall?

>  	mr	r9,r13
>  	mfmsr	r10
>  	mfspr	r13,SPRN_SPRG3
> @@ -253,6 +257,13 @@ system_call_pSeries:
>  	rfid
>  	b	.	/* prevent speculative execution */
>  
> +/* Fast LE/BE switch system call */
> +1:	mfspr	r12,SPRN_SRR1
> +	xori	r12,r12,MSR_LE
> +	mtspr	SPRN_SRR1,r12
> +	rfid		/* return to userspace */
> +	b	.
> +
>  	STD_EXCEPTION_PSERIES(0xd00, single_step)
>  	STD_EXCEPTION_PSERIES(0xe00, trap_0e)
>  
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
---end quoted text---
