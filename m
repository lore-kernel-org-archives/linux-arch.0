From: Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v5 32/36] x86/boot/compressed: Reorganize zero-size
 section asserts
Date: Sat, 1 Aug 2020 13:00:49 -0400
Message-ID: <20200801170049.GA3249534@rani.riverdale.lan>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-33-keescook@chromium.org>
 <20200801014755.GA2700342@rani.riverdale.lan>
 <202007312233.1BA0E2EFC@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgHARAy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Aug 2020 13:00:54 -0400
Content-Disposition: inline
In-Reply-To: <202007312233.1BA0E2EFC@keescook>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Arvind Sankar <nivedita@alum.mit.edu>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 10:35:14PM -0700, Kees Cook wrote:
> On Fri, Jul 31, 2020 at 09:47:55PM -0400, Arvind Sankar wrote:
> > On Fri, Jul 31, 2020 at 04:08:16PM -0700, Kees Cook wrote:
> > > For readability, move the zero-sized sections to the end after DISCARDS
> > > and mark them NOLOAD for good measure.
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  arch/x86/boot/compressed/vmlinux.lds.S | 42 +++++++++++++++-----------
> > >  1 file changed, 25 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > > index 3c2ee9a5bf43..42dea70a5091 100644
> > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > > @@ -42,18 +42,16 @@ SECTIONS
> > >  		*(.rodata.*)
> > >  		_erodata = . ;
> > >  	}
> > > -	.rel.dyn : {
> > > -		*(.rel.*)
> > > -	}
> > > -	.rela.dyn : {
> > > -		*(.rela.*)
> > > -	}
> > > -	.got : {
> > > -		*(.got)
> > > -	}
> > >  	.got.plt : {
> > >  		*(.got.plt)
> > >  	}
> > > +	ASSERT(SIZEOF(.got.plt) == 0 ||
> > > +#ifdef CONFIG_X86_64
> > > +	       SIZEOF(.got.plt) == 0x18,
> > > +#else
> > > +	       SIZEOF(.got.plt) == 0xc,
> > > +#endif
> > > +	       "Unexpected GOT/PLT entries detected!")
> > >  
> > >  	.data :	{
> > >  		_data = . ;
> > > @@ -85,13 +83,23 @@ SECTIONS
> > >  	ELF_DETAILS
> > >  
> > >  	DISCARDS
> > > -}
> > >  
> > > -ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
> > > -#ifdef CONFIG_X86_64
> > > -ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
> > > -#else
> > > -ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
> > > -#endif
> > > +	/*
> > > +	 * Sections that should stay zero sized, which is safer to
> > > +	 * explicitly check instead of blindly discarding.
> > > +	 */
> > > +	.got (NOLOAD) : {
> > > +		*(.got)
> > > +	}
> > > +	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
> > >  
> > > -ASSERT(SIZEOF(.rel.dyn) == 0 && SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations detected!")
> > > +	/* ld.lld does not like .rel* sections being made "NOLOAD". */
> > > +	.rel.dyn : {
> > > +		*(.rel.*)
> > > +	}
> > > +	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
> > > +	.rela.dyn : {
> > > +		*(.rela.*)
> > > +	}
> > > +	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
> > > +}
> > > -- 
> > > 2.25.1
> > > 
> > 
> > There's no point in marking zero-size sections NOLOAD -- if the ASSERT's
> > passed, they won't be present in the file at all anyway.
> 
> I did not find that universally true. I found some sections be written
> out with a 0 size. Some I could remove from disk with NOLOAD, others did
> not like that so much.

Neither LLD nor BFD is creating 0-sized .got or .rel sections in my
builds. In any case, if they're 0-sized, NOLOAD shouldn't affect
anything: it doesn't remove them from disk, it stops them being loaded
into memory, which is a nop if it was 0-sized.

> 
> > The only section for which there might be a point is .got.plt, which is
> > non-empty on 32-bit, and only if it is first moved to the end. That
> > saves a few bytes.
> 
> What do you mean about "only if it is first moved to the end"? Would it
> be zero-sized if it was closer to .text?
> 
> -- 
> Kees Cook

Sorry, my sentence is confusingly worded: it's always non-empty on
x86-32. I meant, move .got.plt to the end (after _end), add (INFO) to
it, and it might save a few bytes, or not, depending on alignment
padding. If it's left in the middle, it still pushes the addresses of
the remaining sections out, so it doesn't save anything.

I'd tested that out the last time we talked about this, but left it out
of my series as Fangrui was negative about the idea.

I tested with NOLOAD instead of INFO, and at least ld.bfd actually
errors out if .got.plt is marked NOLOAD, no matter where it's located.

	  LDS     arch/x86/boot/compressed/vmlinux.lds
	  LD      arch/x86/boot/compressed/vmlinux
	ld: final link failed: section has no contents

Side note: I also discovered something peculiar with the gcc/lld combo.
On x86-64, it turns out that this still generates a .got.plt section,
which was unexpected as _GLOBAL_OFFSET_TABLE_ shouldn't be referenced on
64-bit. It turns out that when gcc (or even clang) generates an
out-of-line call to memcpy from a __builtin_memcpy call, it doesn't
declare the memcpy as hidden even with Ard's hidden.h, or even if memcpy
was explicitly declared with hidden visibility. It uses memcpy@PLT
instead of memcpy, and this generates a reference to
_GLOBAL_OFFSET_TABLE_ in the .o file.  The linker later converts this to
a direct call to the function, but LLD leaves .got.plt in the
executable, while BFD strips it out.

It also turns out that clang's integrated assembler, unlike gas, does
not generate a reference to _GLOBAL_OFFSET_TABLE for a foo@PLT call. And
because we redefine KBUILD_CFLAGS in boot/compressed Makefile, we lose
the -no-integrated-as option, and clang is using its integrated
assembler when building the compressed kernel.
