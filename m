Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:13710 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932287Ab0GTPWL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jul 2010 11:22:11 -0400
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN; charset=US-ASCII
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L5V00B9P40Y3M40@VL-MO-MR003.ip.videotron.ca> for
 linux-arch@vger.kernel.org; Tue, 20 Jul 2010 11:22:10 -0400 (EDT)
Date: Tue, 20 Jul 2010 17:22:10 +0200 (CEST)
From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 0/3] Cache maintenance on VIPT caches
In-reply-to: <1279633178.10002.28.camel@e102109-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.00.1007201718570.25803@xanadu.home>
References: <20100625115826.30030.89790.stgit@e102109-lin.cambridge.arm.com>
 <20100716131908.GA15032@bnru02.bnr.st.com>
 <1279291157.17878.49.camel@e102109-lin.cambridge.arm.com>
 <20100720185611I.fujita.tomonori@lab.ntt.co.jp>
 <1279633178.10002.28.camel@e102109-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-arch@vger.kernel.org, rabin.vincent@stericsson.com, linux-arm-kernel@lists.infradead.org
Message-ID: <20100720152210.eVl2SAvxpiq2R2NvK6E84eznstp2HCKnSw3Mz6TGL-o@z>

On Tue, 20 Jul 2010, Catalin Marinas wrote:

> On Tue, 2010-07-20 at 18:56 +0900, FUJITA Tomonori wrote:
> > On Fri, 16 Jul 2010 15:39:17 +0100
> > Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > I'm not sure why sg_miter doesn't call flush_dcache_page() but
> > > flush_kernel_dcache_page() (I cc'ed Fujita as he seems to have added
> > > this code).
> > 
> > It is intended to handle D aliasing due to kmap. As cachetlb.txt says
> > that it is assumed here that the user has no incoherent cached copies
> > (it was already addressed elsewhere). So flush_dcache_page() does too
> > much there.
> 
> A related question here - does flush_kernel_dcache_page() need to do
> anything for non-highmem pages? For highmem pages, on ARM, we already
> handle the cache flushing in kunmap().

Well, with your proposed patch we wouldn't anymore.  And semantically we 
shouldn't have to.  Even the fact that kunmap_atomic() does flush the 
cache on VIVT system is an implementation issue not a semantic 
definition (incidentally on VIPT it is not flushed).


Nicolas
