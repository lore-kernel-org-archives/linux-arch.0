From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
Date: Mon, 24 Jun 2019 15:49:24 +0100
Message-ID: <20190624144924.GE29120@arrakis.emea.arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906241613280.32342@nanos.tec.linutronix.de>
 <20190624142346.pxljv3m4npatdiyk@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190624142346.pxljv3m4npatdiyk@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andy Lutomirski <luto@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Will Deacon <will.deacon@arm.com>, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, linux-arch@vger.kernel.org, Dmitry Safonov <dima@arista.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andre Przywara <andre.przywara@arm.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Michael Kelley <mikelley@microsoft.com>, Peter Collingbourne <pcc@google.com>, LAK <linux-arm-kernel@lists.infradead.org>, Andrei Vagin <avagin@openvz.org>, Huw Davies <huw@codeweavers.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jun 24, 2019 at 03:23:46PM +0100, Russell King wrote:
> On Mon, Jun 24, 2019 at 04:18:28PM +0200, Thomas Gleixner wrote:
> > Vincenzo,
> > 
> > On Mon, 24 Jun 2019, Thomas Gleixner wrote:
> > 
> > > I did not merge the ARM and MIPS parts as they lack any form of
> > > acknowlegment from their maintainers. Please talk to those folks. If they
> > > ack/review the changes then I can pick them up and they go into 5.3 or they
> > > have to go in a later cycle. Nevertheless it was well worth the trouble to
> > > have those conversions done to confirm that the new common library fits a
> > > bunch of different architectures.
> > 
> > I talked to Russell King and he suggested to file the ARM parts into his
> > patch system and he'll pick them up after 5.3-rc1.
> > 
> >    https://www.arm.linux.org.uk/developer/patches/
> > 
> > I paged out how to deal with it, but you'll surely manage :)
> 
> Easy way: ask git to add the "KernelVersion" tag as a header to the
> email using --add-header to e.g. git format-patch, and just mail them
> to patches@armlinux.org.uk

Although I haven't send patches to Russell in a while, I still have a
git alias in my .gitconfig (only works with one patch at a time IIRC,
sending multiple patches may arrive in a different order):

[alias]
	send-rmk-email = !git send-email --add-header=\"KernelVersion: $(git describe --abbrev=0)\" --no-thread --suppress-cc=all --to="patches@arm.linux.org.uk"

-- 
Catalin
