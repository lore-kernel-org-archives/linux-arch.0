Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58722 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfHWLRX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Aug 2019 07:17:23 -0400
Date: Fri, 23 Aug 2019 12:17:13 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: Regression in 5.3-rc1 and later
Message-ID: <20190823111712.GB13294@shell.armlinux.org.uk>
References: <faaa3843-09a6-1a21-3448-072eeed1ea00@googlemail.com>
 <20190823103654.GX13294@shell.armlinux.org.uk>
 <20190823104050.o6golaa4fmdd7np5@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823104050.o6golaa4fmdd7np5@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>, tglx@linutronix.de
Cc: Chris Clayton <chris2553@googlemail.com>, linux-arch@vger.kernel.org, vincenzo.frascino@arm.com, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, arnd@arndb.de, huw@codeweavers.com, andre.przywara@arm.com, daniel.lezcano@linaro.org, will.deacon@arm.com, LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org, salyzyn@android.com, paul.burton@mips.com, linux@rasmusvillemoes.dk, 0x7f454c46@gmail.com, catalin.marinas@arm.com, pcc@google.com, sthotton@marvell.com, shuah@kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20190823111713.POARTG2CX6D2yW9R__xg4HATzoPsVdamW8FDZzSxoh8@z>

On Fri, Aug 23, 2019 at 11:40:50AM +0100, Will Deacon wrote:
> On Fri, Aug 23, 2019 at 11:36:54AM +0100, Russell King - ARM Linux admin wrote:
> > To everyone on the long Cc list...
> > 
> > What's happening with this?  I was about to merge the patches for 32-bit
> > ARM, which I don't want to do if doing so will cause this regression on
> > 32-bit ARM as well.
> 
> tglx fixed it:
> 
> https://lkml.kernel.org/r/alpine.DEB.2.21.1908221257580.1983@nanos.tec.linutronix.de
> 
> which I assume is getting routed as a fix via -tip.

Right, so Chris reported the issue to everyone involved.  Tglx's
reply severely trimmed the Cc list so folk like me had no idea what
was going on, removing even the mailing lists.  On the face of it,
it looks like an intentional attempt to cut people out of the loop
who really should've been kept in the loop.  Yea, that's just great.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
