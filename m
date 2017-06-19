From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 0/4] Generalize fncpy availability
Date: Mon, 19 Jun 2017 13:24:44 +0100
Message-ID: <20170619122444.GJ10246@leverpostej>
References: <20170617000744.22158-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750926AbdFSMZf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Jun 2017 08:25:35 -0400
Content-Disposition: inline
In-Reply-To: <20170617000744.22158-1-f.fainelli@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Keerthy J <j-keerthy@ti.com>

On Fri, Jun 16, 2017 at 05:07:40PM -0700, Florian Fainelli wrote:
> Hi all,

Hi Florian,

> This patch series makes ARM's fncpy() implementation more generic (dropping the
> Thumb-specifics) and available in an asm-generic header file.
> 
> Tested on a Broadcom ARM64 STB platform with code that is written to SRAM.
> 
> Changes in v3 (thanks Doug!):
> - correct include guard names in asm-generic/fncpy.h to __ASM_FNCPY_H
> - utilize Kbuild to provide the fncpy.h header on ARM64
> 
> Changes in v2:
> - leave the ARM implementation where it is
> - make the generic truly generic (no)
> 
> This is helpful in making SoC-specific power management code become true drivers
> that can be shared between different architectures.

Could you elaborate on what this is needed for?

My understanding was that on 32-bit, this was to handle idle / suspend
cases, whereas for arm64 that should be handled by PSCI.

what exactly do you intend to use this for?

Thanks,
Mark.
