Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:46244 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbeHVUqE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Aug 2018 16:46:04 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992554AbeHVRUR0yESn (ORCPT
        <rfc822;linux-arch@vger.kernel.org> + 1 other);
        Wed, 22 Aug 2018 19:20:17 +0200
Date: Wed, 22 Aug 2018 18:20:17 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Alpha Avanti broken by
 9ce8654323d69273b4977f76f11c9e2d345ab130
In-Reply-To: <CAK8P3a20xrD3C2uGPm6dawp_02kbbZaocK5nTZLoUyeiaCkRgw@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1808221750570.26277@eddie.linux-mips.org>
References: <alpine.LRH.2.02.1808161556450.13597@file01.intranet.prod.int.rdu2.redhat.com> <28597e7477418ac7cb646e2edb5e6da2@codeaurora.org> <alpine.LRH.2.02.1808201010200.15146@file01.intranet.prod.int.rdu2.redhat.com> <CAK8P3a3ribyvLwXaB=J4dcTwD9aYc64hfw+ORTFtyvOHuS-U0g@mail.gmail.com>
 <alpine.LRH.2.02.1808201740170.2948@file01.intranet.prod.int.rdu2.redhat.com> <CAK8P3a1E2V-zFN5PpJ868L=6CgTykkyjtF6-aTsCCh6QqryUig@mail.gmail.com> <alpine.LRH.2.02.1808210814250.24287@file01.intranet.prod.int.rdu2.redhat.com>
 <CAK8P3a3vJK1caKpDqkEhMG=8n8N3U6ckqe=0f2fjUJwk-9K0XA@mail.gmail.com> <alpine.LRH.2.02.1808220743270.12730@file01.intranet.prod.int.rdu2.redhat.com> <21c0bd37-0ae7-db8f-76b8-6552c30faa4f@codeaurora.org> <alpine.LFD.2.21.1808221609000.26277@eddie.linux-mips.org>
 <alpine.LRH.2.02.1808221136480.18647@file01.intranet.prod.int.rdu2.redhat.com> <CAK8P3a20xrD3C2uGPm6dawp_02kbbZaocK5nTZLoUyeiaCkRgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Sinan Kaya <okaya@codeaurora.org>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, okaya@kernel.org, Will Deacon <will.deacon@arm.com>, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>

On Wed, 22 Aug 2018, Arnd Bergmann wrote:

> > According to the Alpha handbook, non-overlapping accesses may be
> > reordered.

 I have had a notion of this since forever, however I have had troubles 
tracking down the exact reference in the architecture specification.

> > So if someone does
> > writel(REG1);
> > readl(REG2);
> >
> > readl may (according to the spec) reach the device before writel. Although
> > actual experiments suggests that the read flushes the queued writes.

 Individual implementations can surely be more strongly ordered than the 
architecture specification requires.

> > Does ARM have some hardware magic that prevents reordering the write and
> > the read in this case?
> 
> Most architecture have this AFAICT, ARM and x86 definitely do, and
> PCI requires this to be true on the bus:
> 
> All MMIO accesses from a given CPU to a given device (according
> to an architecture-specific definition of "device") are ordered with respect
> to one another.
> 
> If the hardware does not guarantee that, for simple load/store operations
> on uncached device memory, then we need a full barrier after each store
> in addition to the write barrier needed for the DMA synchronization.

 MIPS is architecturally even more weakly ordered and a set of barrier 
instructions has been defined for synchronisation: SYNC for a completion 
barrier, and SYNC_ACQUIRE, SYNC_RELEASE, SYNC_RMB, SYNC_WMB and SYNC_MB 
for various ordering barriers.  Older architecture revisions had this less 
standardised.  Many if not most implementations are more strongly ordered 
though, in which case the relevant SYNC instructions are effectively NOPs.

 I'd expect some other architectures to be similarly weakly ordered.

 FWIW,

  Maciej
