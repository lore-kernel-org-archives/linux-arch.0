From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/3] ARM: Generalize fncpy implementation
Date: Fri, 16 Jun 2017 12:58:34 +0100
Message-ID: <20170616115834.GZ23750@n2100.armlinux.org.uk>
References: <20170615232117.29727-1-f.fainelli@gmail.com>
 <20170615232117.29727-2-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:48822 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbdFPL64 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jun 2017 07:58:56 -0400
Content-Disposition: inline
In-Reply-To: <20170615232117.29727-2-f.fainelli@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Keerthy J <j-keerthy@ti.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>

On Thu, Jun 15, 2017 at 04:21:15PM -0700, Florian Fainelli wrote:
> ARM's fncpy implementation is actually suitable for a large number of
> platforms since the only assumption it makes is just the function's
> alignment (8 bytes) which also happens to fulfil other architectures,
> including but not limited to ARM64.

NAK.  This is really not "generic" because the whole point of this is
that it encapsulates architecture specific knowledge - in the case of
ARM, the fact that bit 1 is used to indicate whether the code is to be
run in Thumb mode or ARM mode.

That clearly does not belong in an asm-generic version of this.

I'm not saying "don't provide an asm-generic" version, I'm saying don't
use the ARM version as an asm-generic implementation, because it is
nothing of the sort.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
