From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 05/24] C6X: early boot code
Date: Tue, 9 Aug 2011 21:26:47 +0200
Message-ID: <20110809192647.GB18124@merkur.ravnborg.org>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <1312839879-13592-6-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:30236 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab1HIT0s (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2011 15:26:48 -0400
Content-Disposition: inline
In-Reply-To: <1312839879-13592-6-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

> +;
> +#include <linux/linkage.h>
> +#include <linux/of_fdt.h>
> +#include <asm/asm-offsets.h>
> +

I would expect this code to be part of the head section:

Use __HEAD

> +ENTRY(_c_int00)
> +	;; Save magic and pointer
> +	MV	.S1	A4,A10
> +	MV	.S2	B4,B10
> +	MVKL	.S2	__bss_start,B5
> +	MVKH	.S2	__bss_start,B5
> +	MVKL	.S2	__bss_stop,B6
> +	MVKH	.S2	__bss_stop,B6
> +	SUB	.L2	B6,B5,B6 ; bss size
> +
> +	;; Set the stack pointer
> +	MVKL	.S2	current_ksp,B0
> +	MVKH	.S2	current_ksp,B0
> +	LDW	.D2T2	*B0,B15
> +
> +	;; clear bss
> +	SHR	.S2	B6,3,B0	  ; number of dwords to clear
> +	ZERO	.L2	B13
> +	ZERO	.L2	B12
> +bss_loop:
> +	BDEC	.S2	bss_loop,B0
> +	NOP	3
> +	CMPLT	.L2	B0,0,B1
> + [!B1]	STDW	.D2T2	B13:B12,*B5++[1]
> +
> +	NOP	4
> +	AND	.D2	~7,B15,B15
> +
> +	;; Clear GIE and PGIE
> +	MVC	.S2	CSR,B2
> +	CLR	.S2	B2,0,1,B2
> +	MVC	.S2	B2,CSR
> +	MVC	.S2	TSR,B2
> +	CLR	.S2	B2,0,1,B2
> +	MVC	.S2	B2,TSR
> +	MVC	.S2	ITSR,B2
> +	CLR	.S2	B2,0,1,B2
> +	MVC	.S2	B2,ITSR
> +	MVC	.S2	NTSR,B2
> +	CLR	.S2	B2,0,1,B2
> +	MVC	.S2	B2,NTSR
> +
> +	;; pass DTB pointer to machine_init (or zero if none)
> +	MVKL	.S1	OF_DT_HEADER,A0
> +	MVKH	.S1	OF_DT_HEADER,A0
> +	CMPEQ	.L1	A10,A0,A0
> +  [A0]	MV	.S1X	B10,A4
> +  [!A0] MVK	.S1	0,A4
> +
> +#ifdef CONFIG_BIG_KERNEL
> +	MVKL	.S1	machine_init,A0
> +	MVKH	.S1	machine_init,A0
> +	B	.S2X	A0
> +	ADDKPC  .S2     0f,B3,4
> +0:
> +#else
> +	CALLP	.S2	machine_init,B3
> +#endif
> +
> +	;; Jump to Linux init
> +#ifdef CONFIG_BIG_KERNEL
> +	MVKL	.S1	start_kernel,A0
> +	MVKH	.S1	start_kernel,A0
> +	B	.S2X	A0
> +#else
> +	B	.S2	start_kernel
> +#endif
> +	NOP	5
> +L1:	BNOP	.S2	L1,5
> diff --git a/arch/c6x/kernel/setup.c b/arch/c6x/kernel/setup.c
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/fs.h>
> +#include <linux/genhd.h>
> +#include <linux/errno.h>
> +#include <linux/console.h>
> +#include <linux/string.h>
> +#include <linux/delay.h>
> +#include <linux/bootmem.h>
> +#include <linux/seq_file.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/cache.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/memblock.h>

For C files we sometimes use "inverse christmas tree" sort for include lists.
That is:
longest lines first.
And sorted alphabetically within blocks of equal length.

This would also make it obvious had you had two identical include files.

> +#include <asm/setup.h>
> +#include <asm/irq.h>
> +#include <asm/machdep.h>
> +#include <asm/sections.h>
> +#include <asm/soc.h>
> +
> +#ifdef CONFIG_BLK_DEV_INITRD
> +#include <linux/initrd.h>
> +#include <asm/pgtable.h>
> +#endif

Do these include really need to be guarded?


> +
> +#ifdef DEBUG
> +#define DBG(fmt...) printk(KERN_ERR fmt)
> +#else
> +#define DBG(fmt...)
> +#endif

Drop this. It is used in one place - which I think
is not a debug info anyway.

> +	/* What can we do if we didn't find ? */
> +	if (machine_id >= &__machine_desc_end) {
> +		DBG("No suitable machine found !\n");
> +		for (;;)
> +			;
We stop in a never ending loop.
So debug seems not appropriate...

> 
