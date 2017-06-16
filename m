Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:53922 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752139AbdFPIf3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Jun 2017 04:35:29 -0400
Date: Fri, 16 Jun 2017 01:35:24 -0700
From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: Generalize fncpy implementation
Message-ID: <20170616083524.GJ3730@atomide.com>
References: <20170615232117.29727-1-f.fainelli@gmail.com>
 <20170615232117.29727-2-f.fainelli@gmail.com>
 <577f22f3-ff16-05a0-8204-39e86d47dd9f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <577f22f3-ff16-05a0-8204-39e86d47dd9f@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Message-ID: <20170616083524.s8FYprjIwD2endZHatfZEiPX3AuNFXytnpqqOf881Hg@z>

* Florian Fainelli <f.fainelli@gmail.com> [170615 16:27]:
> On 06/15/2017 04:21 PM, Florian Fainelli wrote:
> > ARM's fncpy implementation is actually suitable for a large number of
> > platforms since the only assumption it makes is just the function's
> > alignment (8 bytes) which also happens to fulfil other architectures,
> > including but not limited to ARM64.

Yeah I'm all for it. Maybe mention in the next version that this helps
with making SoC specific PM code into just regular Linux device drivers.

Regards,

Tony
