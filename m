Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37140 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbeHVXjE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Aug 2018 19:39:04 -0400
Date: Wed, 22 Aug 2018 21:12:39 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: Alpha Avanti broken by 9ce8654323d69273b4977f76f11c9e2d345ab130
Message-ID: <20180822201235.GA6707@brain-police>
References: <CAK8P3a3vJK1caKpDqkEhMG=8n8N3U6ckqe=0f2fjUJwk-9K0XA@mail.gmail.com>
 <alpine.LRH.2.02.1808220743270.12730@file01.intranet.prod.int.rdu2.redhat.com>
 <21c0bd37-0ae7-db8f-76b8-6552c30faa4f@codeaurora.org>
 <alpine.LFD.2.21.1808221609000.26277@eddie.linux-mips.org>
 <alpine.LRH.2.02.1808221136480.18647@file01.intranet.prod.int.rdu2.redhat.com>
 <CAK8P3a20xrD3C2uGPm6dawp_02kbbZaocK5nTZLoUyeiaCkRgw@mail.gmail.com>
 <alpine.LRH.2.02.1808221336400.12083@file01.intranet.prod.int.rdu2.redhat.com>
 <09c561cf-541c-219a-f19b-4ecfaf9a0f02@codeaurora.org>
 <alpine.LRH.2.02.1808221545230.2965@file01.intranet.prod.int.rdu2.redhat.com>
 <89256c73-d8e5-3e8f-e796-9b2f1d2f9522@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89256c73-d8e5-3e8f-e796-9b2f1d2f9522@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, okaya@kernel.org, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>

[sorry, thought I replied on this thread already but my wifi is flakey]

On Wed, Aug 22, 2018 at 04:06:09PM -0400, Sinan Kaya wrote:
> On 8/22/2018 3:56 PM, Mikulas Patocka wrote:
> >
> >
> >On Wed, 22 Aug 2018, Sinan Kaya wrote:
> >
> >>On 8/22/2018 1:47 PM, Mikulas Patocka wrote:
> >>>If ARM guarantees that the accesses to a given device are not reordered -
> >>>then the barriers in readl and writel are superfluous.
> >>
> >>It is not. ARM only guarantees ordering of read/write transactions targeting
> >>a device not memory.
> >>
> >>example:
> >>
> >>write memory
> >>raw write to device
> >>
> >>or
> >>
> >>raw read from device
> >>read memory
> >>
> >>these can bypass each other on ARM unless a barrier is placed in the right
> >>place either via readl()/writel() or explicitly.
> >
> >Yes - but - why does Linux insert the barriers into readl() and writel()
> >instead of inserting them between accesses to registers and memory?
> >
> >A lot of drivers have long sequences of accesses to memory-mapped
> >registers with no interleaving accesses to coherent memory and these
> >implicit barriers slow them down with no gain at all.
> 
> It is an abstraction issue. Majority of drivers are developed against x86
> and the developers have no idea about the weakly ordered architecture
> implications.

Right, and Torvalds was very clear that readX/writeX must follow the x86
semantics here.

> Now, Will Deacon added new primitives to address your concern. There are
> new APIs as readl_relaxed() and writel_relaxed() as opposed to readl()
> and writel().
> 
> Relaxed version still guarantee of register accesses with respect to each
> other but no guaranteed with respect to memory. Relaxed versions could
> be used in performance critical path.

Yes, and the heavy ordering requirements of plain readX/writeX were exactly
what motivated the addition of the _relaxed forms.

Will
