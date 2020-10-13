Return-Path: <SRS0=OX6G=DU=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6A4C433DF
	for <linux-arch@archiver.kernel.org>; Tue, 13 Oct 2020 14:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09AA24818
	for <linux-arch@archiver.kernel.org>; Tue, 13 Oct 2020 14:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387608AbgJMOX1 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:23:27 -0400
Received: from foss.arm.com ([217.140.110.172]:60784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387516AbgJMOX1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Oct 2020 10:23:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9839531B;
        Tue, 13 Oct 2020 07:23:26 -0700 (PDT)
Received: from e107158-lin (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 620473F66B;
        Tue, 13 Oct 2020 07:23:25 -0700 (PDT)
Date:   Tue, 13 Oct 2020 15:23:22 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 3/3] arm64: Handle AArch32 tasks running on non
 AArch32 cpu
Message-ID: <20201013142322.kldwvdnr2zjbia6e@e107158-lin>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-4-qais.yousef@arm.com>
 <20201009072943.GD2628@hirez.programming.kicks-ass.net>
 <20201009081312.GA8004@e123083-lin>
 <20201009083146.GA29594@willie-the-truck>
 <20201009093340.GC23638@gaia>
 <20201009113155.to5euj6sekmwt7lg@e107158-lin.cambridge.arm.com>
 <20201009124025.GH23638@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201009124025.GH23638@gaia>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/09/20 13:40, Catalin Marinas wrote:
> On Fri, Oct 09, 2020 at 12:31:56PM +0100, Qais Yousef wrote:
> > On 10/09/20 10:33, Catalin Marinas wrote:
> > > On Fri, Oct 09, 2020 at 09:31:47AM +0100, Will Deacon wrote:
> > > > Honestly, I don't understand why we're trying to hide this asymmetry from
> > > > userspace by playing games with affinity masks in the kernel. Userspace
> > > > is likely to want to move things about _anyway_ because even amongst the
> > > > 32-bit capable cores, you may well have different clock frequencies to
> > > > contend with.
> > > > 
> > > > So I'd be *much* happier to let the schesduler do its thing, and if one
> > > > of these 32-bit tasks ends up on a core that can't deal with it, then
> > > > tough, it gets killed. Give userspace the information it needs to avoid
> > > > that happening in the first place, rather than implicitly limit the mask.
> > > > 
> > > > That way, the kernel support really boils down to two parts:
> > > > 
> > > >   1. Remove the sanity checks we have to prevent 32-bit applications running
> > > >      on asymmetric systems
> > > > 
> > > >   2. Tell userspace about the problem
> > > 
> > > This works for me as well as long as it is default off with a knob to
> > > turn it on. I'd prefer a sysctl (which can be driven from the command
> > > line in recent kernels IIRC) so that one can play with it a run-time.
> > > This way it's also a userspace choice and not an admin or whoever
> > > controls the cmdline (well, that's rather theoretical since the target
> > > is Android).
> > 
> > I like the cmdline option more. It implies a custom bootloader and user space
> > are required to enable this. Which in return implies they can write their own
> > custom driver to manage exporting this info to user-space. Reliefing us from
> > maintaining any ABI in mainline kernel.
> 
> Regardless of whether it's cmdline or sysctl, I'm strongly opposed to
> custom drivers for exposing this information to user. It leads to
> custom incompatible ABIs scattered around.

Yeah I see what you mean.

So for now I'll remove the Kconfig dependency and replace it with a sysctl
instead such that system_supports_asym_32bit_el0() only returns true if the
system is asym AND the sysctl is true.

Thanks

--
Qais Yousef

> Note that user can already check the MIDR_EL1 value if it knows which
> CPU type and revision has 32-bit support.
> 
> -- 
> Catalin
