From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: Regression in 5.3-rc1 and later
Date: Fri, 23 Aug 2019 11:51:21 +0100
Message-ID: <20190823105121.GA13294@shell.armlinux.org.uk>
References: <faaa3843-09a6-1a21-3448-072eeed1ea00@googlemail.com>
 <20190823103654.GX13294@shell.armlinux.org.uk>
 <8ab59d01-348e-9ac1-2944-5e98acd9b1f8@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8ab59d01-348e-9ac1-2944-5e98acd9b1f8@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Chris Clayton <chris2553@googlemail.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, shuah@kernel.org, sthotton@marvell.com, andre.przywara@arm.com, arnd@arndb.de, salyzyn@android.com, huw@codeweavers.com, catalin.marinas@arm.com, daniel.lezcano@linaro.org, will.deacon@arm.com, linux-mips@vger.kernel.org, ralf@linux-mips.org, 0x7f454c46@gmail.com, paul.burton@mips.com, linux-kselftest@vger.kernel.org, linux@rasmusvillemoes.dk, tglx@linutronix.de, pcc@google.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 23, 2019 at 11:43:32AM +0100, Vincenzo Frascino wrote:
> Hi Russell,
> 
> On 8/23/19 11:36 AM, Russell King - ARM Linux admin wrote:
> > Hi,
> > 
> > To everyone on the long Cc list...
> > 
> > What's happening with this?  I was about to merge the patches for 32-bit
> > ARM, which I don't want to do if doing so will cause this regression on
> > 32-bit ARM as well.
> > 
> 
> The regression is sorted as of yesterday, a new patch is going through tip:
> timers/urgent and will be part of the next -rc.
> 
> If you want to merge them there should be nothing blocking.

I don't have access to the tip tree.

I'll wait a kernel release cycle instead.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
