From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 0/4] Generalize fncpy availability
Date: Tue, 20 Jun 2017 17:46:44 +0100
Message-ID: <20170620164644.GF11351@red-moon>
References: <20170617000744.22158-1-f.fainelli@gmail.com>
 <20170619122444.GJ10246@leverpostej>
 <c8b7789c-38fb-6793-050f-7c60ccb8ca17@broadcom.com>
 <20170620091025.GA26846@red-moon>
 <3834f2fa-5ac0-5b48-7c19-a1b68c1e9c65@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbdFTQpU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Jun 2017 12:45:20 -0400
Content-Disposition: inline
In-Reply-To: <3834f2fa-5ac0-5b48-7c19-a1b68c1e9c65@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Keerthy J <j-keerthy@ti.com>, sudeep.holla@arm.com

On Tue, Jun 20, 2017 at 09:20:34AM -0700, Florian Fainelli wrote:
> On 06/20/2017 02:10 AM, Lorenzo Pieralisi wrote:
> > [+Sudeep]
> > 
> > On Mon, Jun 19, 2017 at 10:32:38AM -0700, Florian Fainelli wrote:
> >> On 06/19/2017 05:24 AM, Mark Rutland wrote:
> >>> On Fri, Jun 16, 2017 at 05:07:40PM -0700, Florian Fainelli wrote:
> >>>> Hi all,
> >>>
> >>> Hi Florian,
> >>>
> >>>> This patch series makes ARM's fncpy() implementation more generic (dropping the
> >>>> Thumb-specifics) and available in an asm-generic header file.
> >>>>
> >>>> Tested on a Broadcom ARM64 STB platform with code that is written to SRAM.
> >>>>
> >>>> Changes in v3 (thanks Doug!):
> >>>> - correct include guard names in asm-generic/fncpy.h to __ASM_FNCPY_H
> >>>> - utilize Kbuild to provide the fncpy.h header on ARM64
> >>>>
> >>>> Changes in v2:
> >>>> - leave the ARM implementation where it is
> >>>> - make the generic truly generic (no)
> >>>>
> >>>> This is helpful in making SoC-specific power management code become true drivers
> >>>> that can be shared between different architectures.
> >>>> Could you elaborate on what this is needed for?
> >>
> >> Several uses cases come to mind:
> >>
> >> - it could be used as a trampoline code prior to entering S2 for systems
> >> that do not support PSCI 1.0
> > 
> > I think S2 here means PM_SUSPEND_MEM. It is very wrong to manage power
> > states through platform specific hooks on PSCI based systems, consider
> > upgrading to PSCI 1.0 please (or implement PSCI CPU_SUSPEND power
> > states that allow to achieve same power savings as PM_SUSPEND_MEM
> > by just entering suspend-to-idle).
> 
> S2 is PM_SUSPEND_STANDBY and S3 is PM_SUSPEND_MEM, at least that how I
> read it. I would rather we update to PSCI 1.0 (at least) to properly
> support SYSTEM_SUSPEND rather than retrofitting a system-wide suspend
> state into CPU_SUSPEND since that seems wrong.

I am not asking to retrofit anything, just implementing CPU_SUSPEND
according to platform capabilities, suspend-to-idle would allow you to
enter a system suspend state where all cores are in the deepest idle
state (which, as far as the core is concerned is identical to the state
reached on S2R). Upgrading to PSCI 1.0 is what has to be done anyway.

> >> - any code that has a specific need to relocate a performance, security
> >> sensitive code into SRAM and use it as another pool of memory.
> >>
> >>>
> >>> My understanding was that on 32-bit, this was to handle idle / suspend
> >>> cases, whereas for arm64 that should be handled by PSCI.
> >>
> >> For systems that support PSCI 1.0, I agree, but it may not be possible
> >> to update those systems easily, still use case 2 is completely valid.
> > 
> > Just to be clear, thinking of using platform specific suspend hooks
> > on PSCI systems is not a viable solution, I will let other people
> > comment on option 2.
> > 
> >>> what exactly do you intend to use this for?
> >>
> >> At the moment we use it to enter S2 on ARM64 systems (ARCH_BRCMSTB)
> > 
> > "At the moment", where ?
> 
> Obviously not in tree, since fncpy() is not available on ARM64, here is
> what it looks like for ARM & MIPS systems though:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/513953.html
> 
> > 
> >> which are PSCI 0.2 only. And yes, we do have a plan to evaluate
> >> upgrading to PSCI 1.0, but in general, any SoC which as an addressable
> >> SRAM could use it for whatever purpose it sees fit.
> > 
> > Not to implement suspend hooks on PSCI 0.2 systems.
> 
> You have made your point and it is very valid, still that does not mean
> fncpy() does not have any usefulness on ARM64 systems, this was one
> although not "ARM approved" use case (system suspend), but use case
> where you have code that should execute from SRAM is something that
> should be possible using the standard facilities offered in
> drives/misc/sram*.c

fncpy() won't be used to implement a suspend ops hook on ARM64, that's
the point I made so that it is clear from the beginning.

Thanks,
Lorenzo
