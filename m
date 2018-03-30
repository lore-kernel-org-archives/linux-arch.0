Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:55026 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbeC3PQb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Mar 2018 11:16:31 -0400
Date: Fri, 30 Mar 2018 16:16:17 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] io: prevent compiler reordering on the default writeX()
 implementation
Message-ID: <20180330151617.GI16141@n2100.armlinux.org.uk>
References: <1522420199-23548-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522420199-23548-1-git-send-email-okaya@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Message-ID: <20180330151617.5N46PLdR6mOjN8eJVbNZ2X0Kn1l6EpeHoo40LG1eP6s@z>

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
