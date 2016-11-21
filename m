From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] kbuild: provide include/asm/asm-prototypes.h for
 ARM
Date: Mon, 21 Nov 2016 17:10:57 +1100
Message-ID: <20161121171057.3ae027a6@roar.ozlabs.ibm.com>
References: <20161017065131.GA27863@angband.pl>
        <20161020150814.42951f61@roar.ozlabs.ibm.com>
        <3446653.W8FbGAKSeQ@wuerfel>
        <14534456.e6dv16VA3R@wuerfel>
        <20161025193200.1f4d9e24@roar.ozlabs.ibm.com>
        <20161120132127.GU1041@n2100.armlinux.org.uk>
        <CA+55aFxh=F77vDAG0Ta9p7Fxf8-b4nCSv1ewfY6ikx3X42zwkA@mail.gmail.com>
        <20161120191257.GX1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161120191257.GX1041@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Alexey Dobriyan <adobriyan@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro <viro@zeniv.linux.org.uk>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sun, 20 Nov 2016 19:12:57 +0000
Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Sun, Nov 20, 2016 at 10:32:50AM -0800, Linus Torvalds wrote:
> > On Sun, Nov 20, 2016 at 5:21 AM, Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:  
> > > On Tue, Oct 25, 2016 at 07:32:00PM +1100, Nicholas Piggin wrote:  
> > >>
> > >> Michal, what's your thoughts? If you merge my patch 2/2 and skip 1/2, it
> > >> should not give any new build warnings or errors, so then arch patches can
> > >> go via arch trees. 1/2 could go in after everyone is up to date.  
> > >
> > > So what's the conclusion on this?  I've just had a failure due to
> > > CONFIG_TRIM_UNUSED_KSYMS reported on ARM, and it looks like (at
> > > least some of) patch 1 could resolve it.  
> > 
> > Hmm. I've got
> > 
> >   cc6acc11cad1 kbuild: be more careful about matching preprocessed asm
> > ___EXPORT_SYMBOL
> >   4efca4ed05cb kbuild: modversions for EXPORT_SYMBOL() for asm
> > 
> > in my tree. Is that sufficient, or do we still have issues?  
> 
> Hmm, those seem to have gone in during the last week, so I haven't
> tested it yet (build running, but it'll take a while).  However, I
> don't think they'll solve _this_ problem.
> 
> Some of the issue here is that we use a mixture of assembly macros
> and preprocessor for the ARM bitops - the ARM bitops are created
> with an assembly macro which contains some pre-processor expanded
> macros (eg, EXPORT_SYMBOL()).
> 
> This means that the actual symbol being exported is not known to
> the preprocessor, so doing the "__is_defined(__KSYM_##sym)" inside
> "EXPORT_SYMBOL(\name)" becomes "__is_defined(__KSYM_\name)" to the
> preprocessor.  As "__KSYM_\name" is never defined, it always comes
> out as zero, hence we always use __cond_export_sym_0, which omits
> the symbol export from the assembly macro definition:
> 
>  .macro bitop, name, instr
> .globl \name ; .align 0 ; \name:
> 
> ...
> 
> .type \name, %function; .size \name, .-\name
> 
>  .endm
> 
> In other words, using preprocessor macros inside an assembly macro
> may not work as expected, and now leads to config-specific failures.
> 

Yes, that's a limitation. cpp expansion we can handle, but not gas macros.
You will need Arnd's patches for ARM.

http://marc.info/?l=linux-kbuild&m=147732160529499&w=2

If that doesn't fix it for you, send me your .config offline and I'll set
up a cross compile to work on it.

Again, any arch always has the option of going back to doing asm exports
in the old style of putting them into a .c file, but hopefully you'll find
Arnd's reworked patches to be something you're willing to merge.

Thanks,
Nick
