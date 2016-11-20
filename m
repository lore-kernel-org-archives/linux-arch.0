From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/2] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Sun, 20 Nov 2016 19:12:57 +0000
Message-ID: <20161120191257.GX1041@n2100.armlinux.org.uk>
References: <20161017065131.GA27863@angband.pl>
 <20161020150814.42951f61@roar.ozlabs.ibm.com>
 <3446653.W8FbGAKSeQ@wuerfel>
 <14534456.e6dv16VA3R@wuerfel>
 <20161025193200.1f4d9e24@roar.ozlabs.ibm.com>
 <20161120132127.GU1041@n2100.armlinux.org.uk>
 <CA+55aFxh=F77vDAG0Ta9p7Fxf8-b4nCSv1ewfY6ikx3X42zwkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFxh=F77vDAG0Ta9p7Fxf8-b4nCSv1ewfY6ikx3X42zwkA@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Alexey Dobriyan <adobriyan@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro <viro@zeniv.linux.org.uk>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sun, Nov 20, 2016 at 10:32:50AM -0800, Linus Torvalds wrote:
> On Sun, Nov 20, 2016 at 5:21 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Tue, Oct 25, 2016 at 07:32:00PM +1100, Nicholas Piggin wrote:
> >>
> >> Michal, what's your thoughts? If you merge my patch 2/2 and skip 1/2, it
> >> should not give any new build warnings or errors, so then arch patches can
> >> go via arch trees. 1/2 could go in after everyone is up to date.
> >
> > So what's the conclusion on this?  I've just had a failure due to
> > CONFIG_TRIM_UNUSED_KSYMS reported on ARM, and it looks like (at
> > least some of) patch 1 could resolve it.
> 
> Hmm. I've got
> 
>   cc6acc11cad1 kbuild: be more careful about matching preprocessed asm
> ___EXPORT_SYMBOL
>   4efca4ed05cb kbuild: modversions for EXPORT_SYMBOL() for asm
> 
> in my tree. Is that sufficient, or do we still have issues?

Hmm, those seem to have gone in during the last week, so I haven't
tested it yet (build running, but it'll take a while).  However, I
don't think they'll solve _this_ problem.

Some of the issue here is that we use a mixture of assembly macros
and preprocessor for the ARM bitops - the ARM bitops are created
with an assembly macro which contains some pre-processor expanded
macros (eg, EXPORT_SYMBOL()).

This means that the actual symbol being exported is not known to
the preprocessor, so doing the "__is_defined(__KSYM_##sym)" inside
"EXPORT_SYMBOL(\name)" becomes "__is_defined(__KSYM_\name)" to the
preprocessor.  As "__KSYM_\name" is never defined, it always comes
out as zero, hence we always use __cond_export_sym_0, which omits
the symbol export from the assembly macro definition:

 .macro bitop, name, instr
.globl \name ; .align 0 ; \name:

...

.type \name, %function; .size \name, .-\name

 .endm

In other words, using preprocessor macros inside an assembly macro
may not work as expected, and now leads to config-specific failures.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
