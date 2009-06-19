Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:33854 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbZFSDBB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jun 2009 23:01:01 -0400
Date: Fri, 19 Jun 2009 12:00:10 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Message-ID: <20090619030009.GB16806@linux-sh.org>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <BE4622E9-611A-4D56-BB54-3C7786939CF2@kernel.crashing.org> <20090618025125.GA26531@linux-sh.org> <AED49645-009B-45A4-BF7B-EBF60D9C34C8@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AED49645-009B-45A4-BF7B-EBF60D9C34C8@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org
Message-ID: <20090619030010.dFv92Y87c_wK46awYAIHM1n7leoo0z5E9j7aRoQkZMc@z>

On Thu, Jun 18, 2009 at 09:59:20PM -0500, Kumar Gala wrote:
> 
> On Jun 17, 2009, at 9:51 PM, Paul Mundt wrote:
> 
> >On Wed, Jun 17, 2009 at 09:31:48AM -0500, Kumar Gala wrote:
> >>One topic that was partially touched on was dealing with various
> >>memories on embedded systems.  We have several sram based allocators
> >>in the kernel for various different arch's:
> >>
> >>- Blackfin sram allocator arch/blackfin/mm/sram-alloc.c
> >>- Lite5200(b) sram allocator arch/powerpc/sysdev/bestcomm/sram.c
> >>- AVR32 sram allocator arch/avr32/mach-at32ap/at32ap700x.c and arch/
> >>avr32/mach-at32ap/include/mach/sram.h
> >>- Potential davinci sram allocator
> >>
> >>There maybe others.
> >>
> >SH does this through NUMA on SRAM blocks that are anywhere from  
> >128kB to
> >64MB. Some of our SMP configurations have upwards of a dozen of these
> >blocks.
> 
> Do you really have that much on chip memory?
> 
Is this really a serious question? If we didn't, I would not have
mentioned it.
