From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 0/4] Generalize fncpy availability
Date: Mon, 19 Jun 2017 06:53:12 -0700
Message-ID: <20170619135312.GM3730@atomide.com>
References: <20170617000744.22158-1-f.fainelli@gmail.com>
 <20170619122444.GJ10246@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170619122444.GJ10246@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-arm-kernel@lists.infradead.org, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Keerthy J <j-keerthy@ti.com>
List-Id: linux-arch.vger.kernel.org

* Mark Rutland <mark.rutland@arm.com> [170619 05:25]:
> On Fri, Jun 16, 2017 at 05:07:40PM -0700, Florian Fainelli wrote:
> > 
> > This is helpful in making SoC-specific power management code become true drivers
> > that can be shared between different architectures.
> 
> Could you elaborate on what this is needed for?
> 
> My understanding was that on 32-bit, this was to handle idle / suspend
> cases, whereas for arm64 that should be handled by PSCI.
> 
> what exactly do you intend to use this for?

Well idle / suspend can have multiple needs such as running
core while DDR is in self-refresh mode and saving and restoring
of some context registers in that state.

Also clock drivers may need this to reprogram some core clocks.

Regards,

Tony
