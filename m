Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbeHVXaQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Aug 2018 19:30:16 -0400
Date: Wed, 22 Aug 2018 21:03:54 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: Alpha Avanti broken by 9ce8654323d69273b4977f76f11c9e2d345ab130
Message-ID: <20180822200346.GA6574@brain-police>
References: <alpine.LRH.2.02.1808210814250.24287@file01.intranet.prod.int.rdu2.redhat.com>
 <CAK8P3a3vJK1caKpDqkEhMG=8n8N3U6ckqe=0f2fjUJwk-9K0XA@mail.gmail.com>
 <alpine.LRH.2.02.1808220743270.12730@file01.intranet.prod.int.rdu2.redhat.com>
 <21c0bd37-0ae7-db8f-76b8-6552c30faa4f@codeaurora.org>
 <alpine.LFD.2.21.1808221609000.26277@eddie.linux-mips.org>
 <alpine.LRH.2.02.1808221136480.18647@file01.intranet.prod.int.rdu2.redhat.com>
 <CAK8P3a20xrD3C2uGPm6dawp_02kbbZaocK5nTZLoUyeiaCkRgw@mail.gmail.com>
 <alpine.LRH.2.02.1808221336400.12083@file01.intranet.prod.int.rdu2.redhat.com>
 <09c561cf-541c-219a-f19b-4ecfaf9a0f02@codeaurora.org>
 <alpine.LRH.2.02.1808221545230.2965@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1808221545230.2965@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, okaya@kernel.org, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Aug 22, 2018 at 03:56:28PM -0400, Mikulas Patocka wrote:
> 
> 
> On Wed, 22 Aug 2018, Sinan Kaya wrote:
> 
> > On 8/22/2018 1:47 PM, Mikulas Patocka wrote:
> > > If ARM guarantees that the accesses to a given device are not reordered -
> > > then the barriers in readl and writel are superfluous.
> > 
> > It is not. ARM only guarantees ordering of read/write transactions targeting
> > a device not memory.
> > 
> > example:
> > 
> > write memory
> > raw write to device
> > 
> > or
> > 
> > raw read from device
> > read memory
> > 
> > these can bypass each other on ARM unless a barrier is placed in the right
> > place either via readl()/writel() or explicitly.
> 
> Yes - but - why does Linux insert the barriers into readl() and writel() 
> instead of inserting them between accesses to registers and memory?
> 
> A lot of drivers have long sequences of accesses to memory-mapped 
> registers with no interleaving accesses to coherent memory and these 
> implicit barriers slow them down with no gain at all.

That's what readX_relaxed and writeX_relaxed are for. There was some
discussion on the lists a way back, and Torvalds was very clear that readX
and writeX should follow the x86 semantics, which have these ordering
guarantees against accesses to memory.

Will
