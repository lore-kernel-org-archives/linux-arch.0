From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] kbuild: provide include/asm/asm-prototypes.h for
 ARM
Date: Wed, 23 Nov 2016 12:40:17 +1100
Message-ID: <20161123124017.648c44d9@roar.ozlabs.ibm.com>
References: <20161122110557.1533467-1-arnd@arndb.de>
        <alpine.LFD.2.20.1611221106410.1814@knanqh.ubzr>
        <20161123004106.GA14217@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35709 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755262AbcKWBkc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2016 20:40:32 -0500
In-Reply-To: <20161123004106.GA14217@n2100.armlinux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Arnd Bergmann <arnd@arndb.de>, viro@zeniv.linux.org.uk, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <uwe@kleine-koenig.org>, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, regressions@leemhuis.info, linux-kernel@vger.kernel.org

On Wed, 23 Nov 2016 00:41:07 +0000
Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Tue, Nov 22, 2016 at 11:34:48AM -0500, Nicolas Pitre wrote:
> > On Tue, 22 Nov 2016, Arnd Bergmann wrote:  
> > > This adds an asm/asm-prototypes.h header for ARM to fix the broken symbol
> > > versioning for symbols exported from assembler files.
> > > 
> > > I couldn't find the correct prototypes for the compiler builtins,
> > > so I went with the fake 'void f(void)' prototypes that we had
> > > before, restoring the state before they were moved.
> > > 
> > > Originally I assumed that the problem was just a harmless warning
> > > in unusual configurations, but as Uwe found, we actually need this
> > > to load most modules when symbol versioning is enabled, as it is
> > > in many distro kernels.
> > > 
> > > Cc: Uwe Kleine-König <uwe@kleine-koenig.org>
> > > Fixes: 4dd1837d7589 ("arm: move exports to definitions")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > Compared to the earlier version, I dropped the changes to the
> > > csumpartial files, which now get handled correctly by Kbuild
> > > even when the export comes from a macro, and I also dropped the
> > > changes to the bitops files, which were already fixed in a
> > > patch from Nico.
> > > 
> > > The patch applies cleanly on top of the rmk/fixes tree but has
> > > no effect there, as it also needs 4efca4ed05cb ("kbuild: modversions
> > > for EXPORT_SYMBOL() for asm") and cc6acc11cad1 ("kbuild: be more
> > > careful about matching preprocessed asm ___EXPORT_SYMBOL").
> > > 
> > > With the combination of rmk/fixes, torvalds/master and these two
> > > patches, symbol versioning works again on ARM. As it is still
> > > broken on almost all other architectures (powerpc is fixed,
> > > x86 has a patch), I wonder if we should make CONFIG_MODVERSIONS
> > > as broken for everything else.  
> > 
> > I'm not sure I like this at all.
> > 
> > The goal for moving EXPORT_SYMBOL() to assembly code where symbols were 
> > defined is to make things close together and avoid those centralized 
> > list of symbols that you can easily miss when modifying the actual code.
> > 
> > This series is therefore bringing back a centralized list of symbols in 
> > a slightly different form, nullifying the advantages from having moved 
> > EXPORT_SYMBOL() to asm code.  To me this looks like a big step backward.
> > 
> > Why not simply extending the original idea of keeping exports close to 
> > the actual code by _also_ having a macro that provides the function 
> > prototype alongside the EXPORT_SYMBOL() instance?  That could even be 
> > expressed with some EXPORT_SYMBOL_PROTO(ret, sym, arg...) macro that 
> > does it all.  
> 
> What you're saying is that you don't like the solution that's taken
> weeks to get merged up to this point, so where do we go from here
> now?  This crap has been broken since 4.9-rc1, and is a regression.
> 
> I think at this point, we just declare that modversions are broken
> on ARM, and those who created this mess get to explain to people
> why the fsck they broke the kernel.

Let's fix it instead :)

Why not merge Arnd's 2 patches? I think he mostly addressed your concerns
of them. Or...

> 
> 4.9 is the next LTS kernel?  ROTFL!
> 
> I agree with Nicolas - it seems that the whole EXPORT_SYMBOL() crap
> has just been a pointless exercise in churn, resulting only in
> something "different" because it looks "cool" to do it some other
> way.  There's no real benefit here at all, only harm.
> 
> Just revert the damned patches that created this breakage in the
> first place please.  It's now way too late to be trying to fix it
> any other way.
> 

4dd1837d7589 diffstat is entirely in arch/arm. I think reverting that
would fix it (I haven't tested it myself so I would advise testing
before committing). So the ball is in your court.

As for process concerns, you have made valid points. Sometimes a mistake
is made or we make an incorrect assumption about how another person works
or what mailing lists they have read, or do not anticipate the fallout
from some change.

Everyone does it sometimes, so it's never a bad time to reflect on how
we work with others and try to do better.

Thanks,
Nick
