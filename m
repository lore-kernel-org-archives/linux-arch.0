Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:46270 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467AbXIDNHt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Sep 2007 09:07:49 -0400
Date: Tue, 4 Sep 2007 07:07:47 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Removal of dma_cache_* functions?
Message-ID: <20070904130747.GS14130@parisc-linux.org>
References: <20070904115615.GA14986@linux-mips.org> <20070904124212.GR14130@parisc-linux.org> <1188910630.3435.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1188910630.3435.2.camel@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Sep 04, 2007 at 01:57:10PM +0100, James Bottomley wrote:
> On Tue, 2007-09-04 at 06:42 -0600, Matthew Wilcox wrote:
> > On Tue, Sep 04, 2007 at 12:56:16PM +0100, Ralf Baechle wrote:
> > > Most architectures implement the dma_cache_wback, dma_cache_wback_inv
> > > and dma_cache_wback_inv functions even though there is the more modern
> > > and much better designed DMA API and only two MIPS-specific users (one of
> > > which I just fixed) do remain.  So should we finally start removing it?
> > 
> > There's still some users in arch/, but yes, let's remove it from the
> > arches that don't use it internally.
> 
> There's the updated dma_cache_sync() API, which you need to keep because
> the parisc lasi scsi and network drivers rely on it for our fully
> incoherent boxes.

Sure -- I was just talking about the three functions Ralf mentioned.
BTW, Ralf, I found six MIPS users:

./arch/mips/au1000/common/dbdma.c:      dma_cache_wback_inv((unsigned long)buf, nbytes);
./arch/mips/jazz/jazzdma.c: dma_cache_wback_inv(vdma_pagetable_start, VDMA_PGTBL_SIZE);
./arch/mips/mm/dma-default.c: dma_cache_wback_inv((unsigned long) ret, size);
./drivers/net/sgiseeq.c:        dma_cache_wback_inv((unsigned long)&sp->srings->rxvector,
./drivers/scsi/dec_esp.c:       dma_cache_wback_inv((unsigned long) phys_to_virt(vaddress), length);
./include/asm-mips/floppy.h:    dma_cache_wback_inv((unsigned long)addr,size);

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
