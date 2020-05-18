From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 24/26] arm64: mte: Introduce early param to disable
 MTE support
Date: Mon, 18 May 2020 12:31:03 +0100
Message-ID: <20200518113103.GA32394@willie-the-truck>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-25-catalin.marinas@arm.com>
 <a2ad6cbf-2632-3cda-eb49-74ddfbed2cec@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgERLbJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 07:31:09 -0400
Content-Disposition: inline
In-Reply-To: <a2ad6cbf-2632-3cda-eb49-74ddfbed2cec@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org, Vincenzo Frascino <vincenzo.frascino@arm.com>, Dave P Martin <Dave.Martin@arm.com>

On Mon, May 18, 2020 at 12:26:30PM +0100, Vladimir Murzin wrote:
> On 5/15/20 6:16 PM, Catalin Marinas wrote:
> > For performance analysis it may be desirable to disable MTE altogether
> > via an early param. Introduce arm64.mte_disable and, if true, filter out
> > the sanitised ID_AA64PFR1_EL1.MTE field to avoid exposing the HWCAP to
> > user.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> > 
> > Notes:
> >     New in v4.
> > 
> >  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
> >  arch/arm64/kernel/cpufeature.c                  | 11 +++++++++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index f2a93c8679e8..7436e7462b85 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -373,6 +373,10 @@
> >  	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
> >  			Format: <io>,<irq>,<nodeID>
> >  
> > +	arm64.mte_disable=
> > +			[ARM64] Disable Linux support for the Memory
> > +			Tagging Extension (both user and in-kernel).
> > +
> 
> Should it really to take parameter (on/off/true/false)? It may lead to expectation
> that arm64.mte_disable=false should enable MT and, yes, double negatives make it
> look ugly, so if we do need parameter, can it be arm64.mte=on/off/true/false?

I don't think "performance analysis" is a good justification for this
parameter tbh. We don't tend to add these options for other architectural
features, and I don't see why MTE is any different in this regard.

Will
