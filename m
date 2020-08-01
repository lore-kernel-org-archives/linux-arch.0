From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 32/36] x86/boot/compressed: Reorganize zero-size
 section asserts
Date: Fri, 31 Jul 2020 22:35:14 -0700
Message-ID: <202007312233.1BA0E2EFC@keescook>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-33-keescook@chromium.org>
 <20200801014755.GA2700342@rani.riverdale.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200801014755.GA2700342@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 31, 2020 at 09:47:55PM -0400, Arvind Sankar wrote:
> On Fri, Jul 31, 2020 at 04:08:16PM -0700, Kees Cook wrote:
> > For readability, move the zero-sized sections to the end after DISCARDS
> > and mark them NOLOAD for good measure.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/x86/boot/compressed/vmlinux.lds.S | 42 +++++++++++++++-----------
> >  1 file changed, 25 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > index 3c2ee9a5bf43..42dea70a5091 100644
> > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > @@ -42,18 +42,16 @@ SECTIONS
> >  		*(.rodata.*)
> >  		_erodata = . ;
> >  	}
> > -	.rel.dyn : {
> > -		*(.rel.*)
> > -	}
> > -	.rela.dyn : {
> > -		*(.rela.*)
> > -	}
> > -	.got : {
> > -		*(.got)
> > -	}
> >  	.got.plt : {
> >  		*(.got.plt)
> >  	}
> > +	ASSERT(SIZEOF(.got.plt) == 0 ||
> > +#ifdef CONFIG_X86_64
> > +	       SIZEOF(.got.plt) == 0x18,
> > +#else
> > +	       SIZEOF(.got.plt) == 0xc,
> > +#endif
> > +	       "Unexpected GOT/PLT entries detected!")
> >  
> >  	.data :	{
> >  		_data = . ;
> > @@ -85,13 +83,23 @@ SECTIONS
> >  	ELF_DETAILS
> >  
> >  	DISCARDS
> > -}
> >  
> > -ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
> > -#ifdef CONFIG_X86_64
> > -ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
> > -#else
> > -ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
> > -#endif
> > +	/*
> > +	 * Sections that should stay zero sized, which is safer to
> > +	 * explicitly check instead of blindly discarding.
> > +	 */
> > +	.got (NOLOAD) : {
> > +		*(.got)
> > +	}
> > +	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
> >  
> > -ASSERT(SIZEOF(.rel.dyn) == 0 && SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations detected!")
> > +	/* ld.lld does not like .rel* sections being made "NOLOAD". */
> > +	.rel.dyn : {
> > +		*(.rel.*)
> > +	}
> > +	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
> > +	.rela.dyn : {
> > +		*(.rela.*)
> > +	}
> > +	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
> > +}
> > -- 
> > 2.25.1
> > 
> 
> There's no point in marking zero-size sections NOLOAD -- if the ASSERT's
> passed, they won't be present in the file at all anyway.

I did not find that universally true. I found some sections be written
out with a 0 size. Some I could remove from disk with NOLOAD, others did
not like that so much.

> The only section for which there might be a point is .got.plt, which is
> non-empty on 32-bit, and only if it is first moved to the end. That
> saves a few bytes.

What do you mean about "only if it is first moved to the end"? Would it
be zero-sized if it was closer to .text?

-- 
Kees Cook
