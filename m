Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729426AbeHVTPw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Aug 2018 15:15:52 -0400
Date: Wed, 22 Aug 2018 11:50:23 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: Alpha Avanti broken by
 9ce8654323d69273b4977f76f11c9e2d345ab130
In-Reply-To: <alpine.LFD.2.21.1808221609000.26277@eddie.linux-mips.org>
Message-ID: <alpine.LRH.2.02.1808221136480.18647@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808161556450.13597@file01.intranet.prod.int.rdu2.redhat.com> <CAK8P3a09jqhxYah6SZUjbku3NGiPX2PyhA+jJNG7VzJUnwUZKQ@mail.gmail.com> <alpine.LFD.2.21.1808172254110.26277@eddie.linux-mips.org> <CAK8P3a3kq35zny70Mnzmk9Tzfm2U9DLPNMyBrursPtOHpOyJSw@mail.gmail.com>
 <28597e7477418ac7cb646e2edb5e6da2@codeaurora.org> <alpine.LRH.2.02.1808201010200.15146@file01.intranet.prod.int.rdu2.redhat.com> <CAK8P3a3ribyvLwXaB=J4dcTwD9aYc64hfw+ORTFtyvOHuS-U0g@mail.gmail.com> <alpine.LRH.2.02.1808201740170.2948@file01.intranet.prod.int.rdu2.redhat.com>
 <CAK8P3a1E2V-zFN5PpJ868L=6CgTykkyjtF6-aTsCCh6QqryUig@mail.gmail.com> <alpine.LRH.2.02.1808210814250.24287@file01.intranet.prod.int.rdu2.redhat.com> <CAK8P3a3vJK1caKpDqkEhMG=8n8N3U6ckqe=0f2fjUJwk-9K0XA@mail.gmail.com>
 <alpine.LRH.2.02.1808220743270.12730@file01.intranet.prod.int.rdu2.redhat.com> <21c0bd37-0ae7-db8f-76b8-6552c30faa4f@codeaurora.org> <alpine.LFD.2.21.1808221609000.26277@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, okaya@kernel.org, Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>



On Wed, 22 Aug 2018, Maciej W. Rozycki wrote:

> On Wed, 22 Aug 2018, Sinan Kaya wrote:
> 
> > > It's hard to tell. The Alpha manual says that only overlapping accesses
> > > are ordered.
> > > 
> > > I did some tests on framebuffer and found out that "read+read+write+write"
> > > is faster than "read+write+read+write" - that may suggest that the reads
> > > flush the write queue.
> > 
> > Do you know if the framebuffer BAR you are using is non-prefetchable? (you
> > can find out from lspci)
> > 
> > Ordering rule only applies to non-prefetchable BARs only. Architectures are
> > allowed to do whatever they want for for prefetchable BARs.
> 
>  Well, data accesses have to reach the relevant PCI host bridge first 
> (i.e. leave the CPU and pass through any intermediate bus bridges between 
> the CPU and the PCI bus tree accessed) for any PCI data ordering rules to 
> apply.  Depending on the system architecture this may or may not require 
> OS software intervention.  NB this is a general observation, not specific 
> to Alpha.
> 
>  "Alpha Architecture Handbook" has an extensive discussion on data 
> ordering, concerning both memory and MMIO (termed "memory-like region" and 
> "non-memory-like region" respectively in the said document), and I'll try 
> to get through all of it in the coming days to see if I can get to a 
> conclusion which will let us avoid excessive synchronisation.
> 
>  Meanwhile I'll be happy of course to accept any input backed with 
> suitable references.
> 
>   Maciej

According to the Alpha handbook, non-overlapping accesses may be 
reordered.

So if someone does 
writel(REG1);
readl(REG2);

readl may (according to the spec) reach the device before writel. Although 
actual experiments suggests that the read flushes the queued writes.

I would be quite interested why did Linux developers decide that readl 
should be implemented as "read+barrier" and writel should be implemented 
as "barrier+write". Why is there this assymetry in the barriers?

Does ARM have some hardware magic that prevents reordering the write and 
the read in this case?

Will Deacon made the change to "memory-barriers.txt" to specify this 
requirement - could you please describe why did you specify it this way?

Mikulas
