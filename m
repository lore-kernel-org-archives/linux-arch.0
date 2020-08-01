From: Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v5 32/36] x86/boot/compressed: Reorganize zero-size
 section asserts
Date: Sat, 1 Aug 2020 13:12:25 -0400
Message-ID: <20200801171225.GB3249534@rani.riverdale.lan>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-33-keescook@chromium.org>
 <20200801014755.GA2700342@rani.riverdale.lan>
 <20200801025325.GA2800311@rani.riverdale.lan>
 <202007312235.4A48157938@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgHARM3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Aug 2020 13:12:29 -0400
Content-Disposition: inline
In-Reply-To: <202007312235.4A48157938@keescook>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Arvind Sankar <nivedita@alum.mit.edu>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 10:36:00PM -0700, Kees Cook wrote:
> On Fri, Jul 31, 2020 at 10:53:25PM -0400, Arvind Sankar wrote:
> > On Fri, Jul 31, 2020 at 09:47:55PM -0400, Arvind Sankar wrote:
> > > On Fri, Jul 31, 2020 at 04:08:16PM -0700, Kees Cook wrote:
> > > > For readability, move the zero-sized sections to the end after DISCARDS
> > > > and mark them NOLOAD for good measure.
> > > > 
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >  arch/x86/boot/compressed/vmlinux.lds.S | 42 +++++++++++++++-----------
> > > >  1 file changed, 25 insertions(+), 17 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > > > index 3c2ee9a5bf43..42dea70a5091 100644
> > > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > > > @@ -42,18 +42,16 @@ SECTIONS
> > > >  		*(.rodata.*)
> > > >  		_erodata = . ;
> > > >  	}
> > > > -	.rel.dyn : {
> > > > -		*(.rel.*)
> > > > -	}
> > > > -	.rela.dyn : {
> > > > -		*(.rela.*)
> > > > -	}
> > > > -	.got : {
> > > > -		*(.got)
> > > > -	}
> > > >  	.got.plt : {
> > > >  		*(.got.plt)
> > > >  	}
> > > > +	ASSERT(SIZEOF(.got.plt) == 0 ||
> > > > +#ifdef CONFIG_X86_64
> > > > +	       SIZEOF(.got.plt) == 0x18,
> > > > +#else
> > > > +	       SIZEOF(.got.plt) == 0xc,
> > > > +#endif
> > > > +	       "Unexpected GOT/PLT entries detected!")
> > > >  
> > > >  	.data :	{
> > > >  		_data = . ;
> > > > @@ -85,13 +83,23 @@ SECTIONS
> > > >  	ELF_DETAILS
> > > >  
> > > >  	DISCARDS
> > > > -}
> > > >  
> > > > -ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
> > > > -#ifdef CONFIG_X86_64
> > > > -ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
> > > > -#else
> > > > -ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
> > > > -#endif
> > > > +	/*
> > > > +	 * Sections that should stay zero sized, which is safer to
> > > > +	 * explicitly check instead of blindly discarding.
> > > > +	 */
> > > > +	.got (NOLOAD) : {
> > > > +		*(.got)
> > > > +	}
> > > > +	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
> > > >  
> > > > -ASSERT(SIZEOF(.rel.dyn) == 0 && SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations detected!")
> > > > +	/* ld.lld does not like .rel* sections being made "NOLOAD". */
> > > > +	.rel.dyn : {
> > > > +		*(.rel.*)
> > > > +	}
> > > > +	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
> > > > +	.rela.dyn : {
> > > > +		*(.rela.*)
> > > > +	}
> > > > +	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
> > > > +}
> > > > -- 
> > > > 2.25.1
> > > > 
> > > 
> > > There's no point in marking zero-size sections NOLOAD -- if the ASSERT's
> > > passed, they won't be present in the file at all anyway.
> > > 
> > > The only section for which there might be a point is .got.plt, which is
> > > non-empty on 32-bit, and only if it is first moved to the end. That
> > > saves a few bytes.
> > 
> > Btw, you should move .got.plt also to the end anyway for readability,
> > it's unused even if non-empty. And with the ASSERT being placed
> > immediately after it, it's even more distracting from the actual section
> > layout.
> 
> ld.bfd (if I'm remembering correctly) was extraordinarily upset about it
> being at the end. I will retest and report back.
> 
> -- 
> Kees Cook

Actually, moving it to the end also requires marking it INFO or
stripping it out when creating the bzImage. Otherwise we get back to
that old problem of materializing .bss/.pgtable in the bzImage.
