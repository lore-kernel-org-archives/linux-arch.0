From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/2] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Wed, 23 Nov 2016 00:41:07 +0000
Message-ID: <20161123004106.GA14217@n2100.armlinux.org.uk>
References: <20161122110557.1533467-1-arnd@arndb.de>
 <alpine.LFD.2.20.1611221106410.1814@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1611221106410.1814@knanqh.ubzr>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>, viro@zeniv.linux.org.uk
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, regressions@leemhuis.info, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 22, 2016 at 11:34:48AM -0500, Nicolas Pitre wrote:
> On Tue, 22 Nov 2016, Arnd Bergmann wrote:
> > This adds an asm/asm-prototypes.h header for ARM to fix the broken symbol
> > versioning for symbols exported from assembler files.
> > 
> > I couldn't find the correct prototypes for the compiler builtins,
> > so I went with the fake 'void f(void)' prototypes that we had
> > before, restoring the state before they were moved.
> > 
> > Originally I assumed that the problem was just a harmless warning
> > in unusual configurations, but as Uwe found, we actually need this
> > to load most modules when symbol versioning is enabled, as it is
> > in many distro kernels.
> > 
> > Cc: Uwe Kleine-König <uwe@kleine-koenig.org>
> > Fixes: 4dd1837d7589 ("arm: move exports to definitions")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Compared to the earlier version, I dropped the changes to the
> > csumpartial files, which now get handled correctly by Kbuild
> > even when the export comes from a macro, and I also dropped the
> > changes to the bitops files, which were already fixed in a
> > patch from Nico.
> > 
> > The patch applies cleanly on top of the rmk/fixes tree but has
> > no effect there, as it also needs 4efca4ed05cb ("kbuild: modversions
> > for EXPORT_SYMBOL() for asm") and cc6acc11cad1 ("kbuild: be more
> > careful about matching preprocessed asm ___EXPORT_SYMBOL").
> > 
> > With the combination of rmk/fixes, torvalds/master and these two
> > patches, symbol versioning works again on ARM. As it is still
> > broken on almost all other architectures (powerpc is fixed,
> > x86 has a patch), I wonder if we should make CONFIG_MODVERSIONS
> > as broken for everything else.
> 
> I'm not sure I like this at all.
> 
> The goal for moving EXPORT_SYMBOL() to assembly code where symbols were 
> defined is to make things close together and avoid those centralized 
> list of symbols that you can easily miss when modifying the actual code.
> 
> This series is therefore bringing back a centralized list of symbols in 
> a slightly different form, nullifying the advantages from having moved 
> EXPORT_SYMBOL() to asm code.  To me this looks like a big step backward.
> 
> Why not simply extending the original idea of keeping exports close to 
> the actual code by _also_ having a macro that provides the function 
> prototype alongside the EXPORT_SYMBOL() instance?  That could even be 
> expressed with some EXPORT_SYMBOL_PROTO(ret, sym, arg...) macro that 
> does it all.

What you're saying is that you don't like the solution that's taken
weeks to get merged up to this point, so where do we go from here
now?  This crap has been broken since 4.9-rc1, and is a regression.

I think at this point, we just declare that modversions are broken
on ARM, and those who created this mess get to explain to people
why the fsck they broke the kernel.

4.9 is the next LTS kernel?  ROTFL!

I agree with Nicolas - it seems that the whole EXPORT_SYMBOL() crap
has just been a pointless exercise in churn, resulting only in
something "different" because it looks "cool" to do it some other
way.  There's no real benefit here at all, only harm.

Just revert the damned patches that created this breakage in the
first place please.  It's now way too late to be trying to fix it
any other way.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
