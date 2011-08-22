From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 00/24] C6X: New architecture patch set
Date: Tue, 23 Aug 2011 00:25:14 +0200
Message-ID: <3154737.lPJJUbNPhg@wuerfel>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:62083 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab1HVWZq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2011 18:25:46 -0400
In-Reply-To: <1314043785-2880-1-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 22 August 2011 16:09:21 Mark Salter wrote:
> Here is v2 of the C6X architecture patch series.
> 
> Changes from the previous patchset are:
> 
>  * Replaced 64-by-64 divides (two places) with do_div
> 
>  * Parse device tree for base address of some miscellaneous SoC registers.
>    The clkdev code still has a hard-coded address but that will go away when
>    device tree clock bindings are settled.
> 
>  * Tweaked the DTS files to more closely match the actual hardware.
> 
>  * Removed all board-specific files by making better use of device tree.
> 
>  * Removed CONFIG_NR_IRQS and replaced with hard-coded number which is large
>    enough for all supported SoCs with room to spare.
> 
>  * Removed GENERIC_FIND_* references.
> 
>  * Cleaned up Makefiles and Kconfig files.
> 
>  * Removed VMLINUX_SYMBOL usage in linker script (not needed for C6X).
> 
>  * Cleaned up show_cpuinfo.
> 
>  * Added __HEAD to head.S
> 
>  * Use generic asm/dma.h
> 
>  * Added cpu_relax() to busy wait loops in cache code.
> 
>  * Dropped unneeded module support routines (handled in generic code)
> 
>  * Cleaned up DMA support.
> 
>  * Removed deprecated syscalls.
> 
>  * Removed PTRACE_PEEKUSR and PTRACE_POKEUSR.
> 
>  * Cleaned up sparse warnings.

Very nice, good progress!

I've just sent a lenghty reply for the soc abstraction, which is the only
thing that really sticks out to me. I think that as soon as we have a
solution for that, your patches should go into linux-next as prepraration
for inclusion in Linux-3.2.

	Arnd
