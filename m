From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [GIT PULL] optimize 64-by-32 ddivision for constant divisors on
 32-bit machines
Date: Mon, 23 Nov 2015 09:59:07 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1511230949310.22569@knanqh.ubzr>
References: <alpine.LFD.2.20.1511161710270.5826@knanqh.ubzr> <4206238.8hPtvbUZ9X@wuerfel> <alpine.LFD.2.20.1511221721320.22569@knanqh.ubzr> <4172767.ihrTf0eWtM@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4172767.ihrTf0eWtM@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, 23 Nov 2015, Arnd Bergmann wrote:

> On Sunday 22 November 2015 17:28:33 Nicolas Pitre wrote:
> > On Sun, 22 Nov 2015, Arnd Bergmann wrote:
> > > On Monday 16 November 2015 20:20:38 you wrote:
> > > I'm now getting a build regressing with the attached randconfig configuration,
> > > when compiling drivers/net/wireless/iwlegacy/common.o:
> > > 
> > > drivers/built-in.o: In function `il_send_rxon_timing':
> > > :(.text+0xbbac80): undefined reference to `__aeabi_uldivmod'
> > > :(.text+0xbbac9c): undefined reference to `__aeabi_uldivmod'
> > > :(.text+0xbbacdc): undefined reference to `__aeabi_uldivmod'
> > > :(.text+0xbbadc8): undefined reference to `__aeabi_uldivmod'
> > > :(.text+0xbbadf8): undefined reference to `__aeabi_uldivmod'
> > > :(.text+0xbbae3c): more undefined references to `__aeabi_uldivmod' follow
> > > drivers/built-in.o: In function `il_send_rxon_timing':
> > > :(.text+0xbbb11c): undefined reference to `____ilog2_NaN'
> > 
> > This looks like some gcc bug from a few years ago.
> 
> Yes, I clearly remember debugging something in this area before,
> but I don't remember what we did about it.
> 
> We already have the workaround for OABI (which you kept), and I have
> another workaround to disable the optimized function for ARMv3 as
> well, as newer gcc versions also get that wrong here (internal compiler
> error IIRC).

Although we no longer support ARMv3 targets, the only reason 
-march=armv3 is used is to prevent gcc from using strh/ldrh instructions 
on RiscPC whose memory bus can't accommodate it.  Still, this would be 
worth reporting a bug for it.

> We could add yet another such workaround for CONFIG_PROFILE_ALL_BRANCHES,
> but I don't have a good feeling about doing this unless we understand
> well enough why it breaks.

I'm able to reproduce it, and I am in the process of reintroducing the 
last patch piece by piece to see what breaks.  The presence of 
____ilog2_NaN is particularly intriguing as this would mean 0 is passed 
to ilog2() somewhere.


Nicolas
