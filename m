Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38554 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387802AbfIMS13 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Sep 2019 14:27:29 -0400
Date: Fri, 13 Sep 2019 19:27:13 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH v2 00/12] Unify SMP stop generic logic to common code
Message-ID: <20190913182713.GB13294@shell.armlinux.org.uk>
References: <20190913181953.45748-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913181953.45748-1-cristian.marussi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mark.rutland@arm.com, peterz@infradead.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, will@kernel.org, dave.martin@arm.com, linux-arm-kernel@lists.infradead.org, mingo@redhat.com, x86@kernel.org, dzickus@redhat.com, ehabkost@redhat.com, davem@davemloft.net, sparclinux@vger.kernel.org, hch@infradead.org
Message-ID: <20190913182713.0vfANnwvxmHmTXs7PT1K4P7IG_4UNFuKFE7-2QnKpBs@z>

On Fri, Sep 13, 2019 at 07:19:41PM +0100, Cristian Marussi wrote:
> Tested as follows:
> 
> - arm:
> 1. boot

So this basically means the code paths you're touching are untested on
ARM... given that, and the variety of systems we have out there, why
should the patches touching ARM be taken?

Given that you're an ARM Ltd employee, I'm sure you can find 32-bit
systems to test - or have ARM Ltd got rid of everything that isn't
64-bit? ;)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
