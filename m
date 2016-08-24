From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] arm: add an option for erratum 657417
Date: Wed, 24 Aug 2016 14:00:44 +1000
Message-ID: <20160824140044.266d045d@roar.ozlabs.ibm.com>
References: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
        <2466265.8og15RQ8jv@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <2466265.8og15RQ8jv@wuerfel>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>, linux-kbuild@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Julian Brown <julian@codesourcery.com>, Alan Modra <amodra@gmail.com>, Segher Boessenkool <segher@kernel.crashing.org>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Tue, 23 Aug 2016 14:01:29 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday, August 12, 2016 6:19:17 PM CEST Nicholas Piggin wrote:
> > Erratum 657417 is worked around by the linker by inserting additional
> > branch trampolines to avoid problematic branch target locations. This
> > results in much higher linking time and presumably slower and larger
> > generated code. The workaround also seems to only be required when
> > linking thumb2 code, but the linker applies it for non-thumb2 code as
> > well.
> > 
> > The workaround today is left to the linker to apply, which is overly
> > conservative.
> > 
> > https://sourceware.org/ml/binutils/2009-05/msg00297.html
> > 
> > This patch adds an option which defaults to "y" in cases where we
> > could possibly be running Cortex A8 and using Thumb2 instructions.
> > In reality the workaround might not be required at all for the kernel
> > if virtual instruction memory is linear in physical memory. However it
> > is more conservative to keep the workaround, and it may be the case
> > that the TLB lookup would be required in order to catch branches to
> > unmapped or no-execute pages.
> > 
> > In an allyesconfig build, this workaround causes a large load on
> > the linker's branch stub hash and slows down the final link by a
> > factor of 5.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >   
> 
> Thanks a lot for finding this issue. I can confirm that your patch
> helps noticeably in all configurations, reducing time for a relink
> from 18 minutes to 9 minutes on my machine in the best case, but
> the factor 10 slowdown of the final link with your thin archives
> and gc-sections patches remains.
> 
> I suspect there is still something else going on besides the 657417
> slowing things down, but it's also possible that I'm doing something
> wrong here.

Okay, I was only testing thin archives. gc-sections I didn't look at.
With thin archives, one final arm allyesconfig link with this patch is
not showing a regression. gc-sections must be causing something else
ARM specific, because powerpc seems to link fast with gc-sections.

Can you send your latest ARM patch to enable this and I'll have a look
at it?


> Aside from that, I notice that for the purpose of speeding up
> "allyesconfig", we don't actually need to make this user
> configurable, it's sufficient to disable the workaround when
> CONFIG_THUMB2_KERNEL is disabled, which is what allyesconfig
> and all the defconfig files (but not randconfig) use. I also found
> that using THUMB2_KERNEL itself causes a 50% slowdown. I have
> patches on my "randconfig" test tree that have the side-effect
> of enabling THUMB2_KERNEL for allyesconfig, which is one reason
> I have been getting worse results than others.
> 
> I could also try to revive an older patch I started, to annotate
> the specific CPU core on each ARMv7 platform. I think I have all the
> information we need for that, and there are other advantages in
> doing it: we could be more selective with all the ARMv7 errata,
> and automatically determine whether some optional CPU features
> (LPAE, virtualization, integer divide) are available on all
> of the selected CPU cores.

Yeah I was just trying to follow existing pattern and be conservative
with the workaround. From my brief look, it does seem like there is
room to optimize build options by having more fine grained selection
of target CPU/platform.

Thanks,
Nick
