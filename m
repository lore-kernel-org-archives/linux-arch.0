From: Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [PATCH v4 24/26] arm64: mte: Introduce early param to disable
 MTE support
Date: Wed, 27 May 2020 11:37:42 +0100
Message-ID: <20200527103741.GB24512@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-25-catalin.marinas@arm.com>
 <a2ad6cbf-2632-3cda-eb49-74ddfbed2cec@arm.com>
 <20200518113103.GA32394@willie-the-truck>
 <20200518172054.GL9862@gaia>
 <20200522055710.GA25791@pdaly-linux.qualcomm.com>
 <20200522103714.GA26492@gaia>
 <20200527021153.GA24439@pdaly-linux.qualcomm.com>
 <20200527095504.GB11111@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:23425
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729876AbgE0KiA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 May 2020 06:38:00 -0400
Content-Disposition: inline
In-Reply-To: <20200527095504.GB11111@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Patrick Daly <pdaly@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org, Vincenzo Frascino <vincenzo.frascino@arm.com>, Dave P Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, nd@arm.com

The 05/27/2020 10:55, Will Deacon wrote:
> On Tue, May 26, 2020 at 07:11:53PM -0700, Patrick Daly wrote:
> > On Fri, May 22, 2020 at 11:37:15AM +0100, Catalin Marinas wrote:
> > > The actual question here is what the on/off behaviour is needed for. We
> > > can figure out the best mechanism for this once we know what we want to
> > > achieve. My wild guess above was performance analysis but that can be
> > > toggled by either kernel boot parameter or run-time sysctl (or just the
> > > Kconfig option).
> > > 
> > > If it is about forcing user space not to use MTE, we may look into some
> > > other sysctl controls (we already have one for the tagged address ABI).
> > 
> > We want to allow the end user to be able to easily "opt out" of MTE in favour
> > of better power, perf and battery life.
> 
> Who is "the end user" in this case?
> 
> If MTE is bad enough for power, performance and battery life that we need a
> kill switch, then perhaps we shouldn't enable it by default and the few
> people that want to use it can build a kernel with it enabled. However, then
> I don't really see what MTE buys you over the existing KASAN implementations.
> 
> I thought the general idea was that you could run in the (cheap) "async"
> mode, and then re-run in the more expensive "sync" mode to further diagnose
> any failures. That model seems to work well with these patches, since
> reporting is disabled by default. Are you saying that there is a
> significant penalty incurred even when reporting is not enabled?
> 
> Anyway, we don't offer global runtime/cmdline switches for the vast majority
> of other architectural features -- instead, we choose a sensible default,
> and I think we should do the same here.

i would not expect mte overhead if userspace processes
don't map anything with PROT_MTE and don't enable tag
checking with prctl. (i.e. userspace runtimes can "opt
out" of mte for better power, perf and battery)

is that not the case?
