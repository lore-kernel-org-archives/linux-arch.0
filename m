Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:50269 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbXIDNdi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Sep 2007 09:33:38 -0400
Received: from localhost.localdomain ([127.0.0.1]:15530 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024746AbXIDNdh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 4 Sep 2007 14:33:37 +0100
Date: Tue, 4 Sep 2007 14:33:35 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Removal of dma_cache_* functions?
Message-ID: <20070904133335.GC16556@linux-mips.org>
References: <20070904115615.GA14986@linux-mips.org> <20070904124212.GR14130@parisc-linux.org> <1188910630.3435.2.camel@localhost.localdomain> <20070904130747.GS14130@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070904130747.GS14130@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: James Bottomley <James.Bottomley@steeleye.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Sep 04, 2007 at 07:07:47AM -0600, Matthew Wilcox wrote:

> BTW, Ralf, I found six MIPS users:
> 
> ./arch/mips/au1000/common/dbdma.c:      dma_cache_wback_inv((unsigned long)buf, nbytes);
> ./arch/mips/jazz/jazzdma.c: dma_cache_wback_inv(vdma_pagetable_start, VDMA_PGTBL_SIZE);
> ./arch/mips/mm/dma-default.c: dma_cache_wback_inv((unsigned long) ret, size);
> ./drivers/net/sgiseeq.c:        dma_cache_wback_inv((unsigned long)&sp->srings->rxvector,
> ./drivers/scsi/dec_esp.c:       dma_cache_wback_inv((unsigned long) phys_to_virt(vaddress), length);
> ./include/asm-mips/floppy.h:    dma_cache_wback_inv((unsigned long)addr,size);

arch/mips/mm/dma-default.c is the implementation of the DMA API as
documented in the kernel; it needs to bang on the caches for non-coherent
I/O so will have to continue using the old functions though I may change
the function names.  sgiseeq I already fixed, the rest is being fixed
once as I'm writing this.

  Ralf
