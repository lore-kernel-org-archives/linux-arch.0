From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] io: prevent compiler reordering on the default writeX()
 implementation
Date: Fri, 30 Mar 2018 16:16:17 +0100
Message-ID: <20180330151617.GI16141@n2100.armlinux.org.uk>
References: <1522420199-23548-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1522420199-23548-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 30, 2018 at 10:29:58AM -0400, Sinan Kaya wrote:
> The default implementation of mapping writeX() to __raw_writeX() is wrong.
> writeX() has stronger ordering semantics. Compiler is allowed to reorder
> __raw_writeX().
> 
> In the abscence of a write barrier or when using a strongly ordered
> architecture, writeX() should at least have a compiler barrier in
> it to prevent commpiler from clobbering the execution order.

You want the barrier _before_ the call to __raw_writel() - you need to
ensure that writes to memory are emitted by the compiler _before_ the
write to the hardware - the write to the hardware may start DMA, and it
may be reading data that the program thinks it previously wrote.

Similarly, for readl(), you need the barrier after __raw_readl() to
ensure that other reads in the program aren't scheduled before a
potential DMA status register read.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
