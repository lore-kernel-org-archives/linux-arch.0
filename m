From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 0/4] Generalize fncpy availability
Date: Tue, 20 Jun 2017 10:10:25 +0100
Message-ID: <20170620091025.GA26846@red-moon>
References: <20170617000744.22158-1-f.fainelli@gmail.com>
 <20170619122444.GJ10246@leverpostej>
 <c8b7789c-38fb-6793-050f-7c60ccb8ca17@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c8b7789c-38fb-6793-050f-7c60ccb8ca17@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-arm-kernel@lists.infradead.org, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Keerthy J <j-keerthy@ti.com>, sudeep.holla@arm.com
List-Id: linux-arch.vger.kernel.org

[+Sudeep]

On Mon, Jun 19, 2017 at 10:32:38AM -0700, Florian Fainelli wrote:
> On 06/19/2017 05:24 AM, Mark Rutland wrote:
> > On Fri, Jun 16, 2017 at 05:07:40PM -0700, Florian Fainelli wrote:
> >> Hi all,
> > 
> > Hi Florian,
> > 
> >> This patch series makes ARM's fncpy() implementation more generic (dropping the
> >> Thumb-specifics) and available in an asm-generic header file.
> >>
> >> Tested on a Broadcom ARM64 STB platform with code that is written to SRAM.
> >>
> >> Changes in v3 (thanks Doug!):
> >> - correct include guard names in asm-generic/fncpy.h to __ASM_FNCPY_H
> >> - utilize Kbuild to provide the fncpy.h header on ARM64
> >>
> >> Changes in v2:
> >> - leave the ARM implementation where it is
> >> - make the generic truly generic (no)
> >>
> >> This is helpful in making SoC-specific power management code become true drivers
> >> that can be shared between different architectures.
> > > Could you elaborate on what this is needed for?
> 
> Several uses cases come to mind:
> 
> - it could be used as a trampoline code prior to entering S2 for systems
> that do not support PSCI 1.0

I think S2 here means PM_SUSPEND_MEM. It is very wrong to manage power
states through platform specific hooks on PSCI based systems, consider
upgrading to PSCI 1.0 please (or implement PSCI CPU_SUSPEND power
states that allow to achieve same power savings as PM_SUSPEND_MEM
by just entering suspend-to-idle).

> - any code that has a specific need to relocate a performance, security
> sensitive code into SRAM and use it as another pool of memory.
> 
> > 
> > My understanding was that on 32-bit, this was to handle idle / suspend
> > cases, whereas for arm64 that should be handled by PSCI.
> 
> For systems that support PSCI 1.0, I agree, but it may not be possible
> to update those systems easily, still use case 2 is completely valid.

Just to be clear, thinking of using platform specific suspend hooks
on PSCI systems is not a viable solution, I will let other people
comment on option 2.

> > what exactly do you intend to use this for?
> 
> At the moment we use it to enter S2 on ARM64 systems (ARCH_BRCMSTB)

"At the moment", where ?

> which are PSCI 0.2 only. And yes, we do have a plan to evaluate
> upgrading to PSCI 1.0, but in general, any SoC which as an addressable
> SRAM could use it for whatever purpose it sees fit.

Not to implement suspend hooks on PSCI 0.2 systems.

Thanks,
Lorenzo
