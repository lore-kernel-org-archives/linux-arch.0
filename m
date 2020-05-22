From: Patrick Daly <pdaly@codeaurora.org>
Subject: Re: [PATCH v4 24/26] arm64: mte: Introduce early param to disable
 MTE support
Date: Thu, 21 May 2020 22:57:10 -0700
Message-ID: <20200522055710.GA25791@pdaly-linux.qualcomm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-25-catalin.marinas@arm.com>
 <a2ad6cbf-2632-3cda-eb49-74ddfbed2cec@arm.com>
 <20200518113103.GA32394@willie-the-truck>
 <20200518172054.GL9862@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail27.static.mailgun.info ([104.130.122.27]:27416 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbgEVF5T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 May 2020 01:57:19 -0400
Content-Disposition: inline
In-Reply-To: <20200518172054.GL9862@gaia>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, Vincenzo Frascino <vincenzo.frascino@arm.com>, Peter Collingbourne <pcc@google.com>, Dave P Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org

On Mon, May 18, 2020 at 06:20:55PM +0100, Catalin Marinas wrote:
> On Mon, May 18, 2020 at 12:31:03PM +0100, Will Deacon wrote:
> > On Mon, May 18, 2020 at 12:26:30PM +0100, Vladimir Murzin wrote:
> > > On 5/15/20 6:16 PM, Catalin Marinas wrote:
> > > > For performance analysis it may be desirable to disable MTE altogether
> > > > via an early param. Introduce arm64.mte_disable and, if true, filter out
> > > > the sanitised ID_AA64PFR1_EL1.MTE field to avoid exposing the HWCAP to
> > > > user.
> > > > 
> > > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > ---
> > > > 
> > > > Notes:
> > > >     New in v4.
> > > > 
> > > >  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
> > > >  arch/arm64/kernel/cpufeature.c                  | 11 +++++++++++
> > > >  2 files changed, 15 insertions(+)
> > > > 
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > index f2a93c8679e8..7436e7462b85 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -373,6 +373,10 @@
> > > >  	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
> > > >  			Format: <io>,<irq>,<nodeID>
> > > >  
> > > > +	arm64.mte_disable=
> > > > +			[ARM64] Disable Linux support for the Memory
> > > > +			Tagging Extension (both user and in-kernel).
> > > > +
> > > 
> > > Should it really to take parameter (on/off/true/false)? It may lead to expectation
> > > that arm64.mte_disable=false should enable MT and, yes, double negatives make it
> > > look ugly, so if we do need parameter, can it be arm64.mte=on/off/true/false?
> > 
> > I don't think "performance analysis" is a good justification for this
> > parameter tbh. We don't tend to add these options for other architectural
> > features, and I don't see why MTE is any different in this regard.
> 
> There is an expectation of performance impact with MTE enabled,
> especially if it's running in synchronous mode. For the in-kernel MTE,
> we could add a parameter which sets sync vs async at boot time rather
> than a big disable knob. It won't affect user space however.
> 
> The other 'justification' is if your hardware has weird unexpected
> behaviour but I'd like this handled via errata workarounds.
> 
> I'll let the people who asked for this to chip in ;). I agree with you
> that we rarely add these (and I rejected a similar option a few weeks
> ago on the AMU patchset).

We've been looking into other ways this on/off behavior could be achieved.
The "arm,armv8.5-memtag" DT flag already provides what we want - meaning
that this flag could be removed if the system did not support MTE.

I did see your remark on "arm64: mte: Check the DT memory nodes for MTE support"
questioning whether it was the right approach - is this still the case?
--Patrick

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
