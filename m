From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] asm-generic: default BUG_ON(x) to "if(x) BUG()"
Date: Mon, 23 Nov 2015 22:30:56 +0100
Message-ID: <4745584.7EJGtZoN8U@wuerfel>
References: <5868782.RxZY0W5S4d@wuerfel> <4102055.db40h1joXM@wuerfel> <20151123211748.GA30660@x>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151123211748.GA30660@x>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
List-Id: linux-arch.vger.kernel.org

On Monday 23 November 2015 13:17:48 Josh Triplett wrote:
> > not sure where I can find tinyconfig,
> 
> "make tinyconfig" in the standard kernel tree.  It turns on a few
> options that make the kernel even smaller.

I should learn how that works. We have way too many configuration
files on ARM and it would be nice to use Kconfig fragments to
simplify it a little for things like enabling LPAE or big-endian.
The kernelci.org folks do that already, but it's not in mainline.

FWIW, on tinyconfig, the __modver section remains at 1784 with or
without my patch, and the size difference with my patch applied
is down to 5412 bytes mostly in .text, around 0.50% of the total size.

> > this is what I get for ARM allnoconfig
> > (only totals, let me know if you need more details):
> > 
> > original:             961307
> > patched:              969167 (+0.82%)
> > CONFIG_BUG:           994695 (+3.36%)
> 
> "patched" here represents allnoconfig with your patch added, but with
> CONFIG_BUG still turned off?

Correct.

> Doesn't seem too bad.  Rather large, but I think we ought to fix the
> problem by 1) reducing the number of uses of BUG_ON in the kernel, and
> 2) compiling out more bits of the kernel entirely, including their calls
> to BUG_ON.  Eliminating a class of warnings that cause people grief when
> trying to build and contribute to tiny kernels seems worth it, at least
> for now.

Ok

> > > >  #ifndef HAVE_ARCH_BUG_ON
> > > > -#define BUG_ON(condition) do { if (condition) ; } while (0)
> > > > +#define BUG_ON(condition) do { if (condition) BUG(); } while (0)
> > > 
> > > This makes BUG_ON in the !CONFIG_BUG case almost identical to the
> > > CONFIG_BUG=y case, except for the use of unlikely(condition), which this
> > > ought to do as well.
> > > 
> > > Given that, could you pull the definition *out* of the #ifdef/#else for
> > > CONFIG_BUG entirely, and define it the same way in both cases?
> > 
> > Yes, I thought about that already and decided to keep the patch simple
> > instead. I can do that of course once we get consensus on the general
> > approach.
> 
> Looking at the thread, I think you have it at this point.
> 
> And personally I value simplicity of the patched code over simplicity of
> the patch. 

Ok, I'll prepare an updated version with that change.

Thanks,

	Arnd
