From: Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v4 08/17] arm64/mm: Remove needless section quotes
Date: Mon, 29 Jun 2020 17:06:19 -0400
Message-ID: <20200629210619.GA1603907@rani.riverdale.lan>
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-9-keescook@chromium.org>
 <CAKwvOd=r6bsBfSZxVYrnbm1Utq==ApWBDjx+0Fxsm90Aq3Jghw@mail.gmail.com>
 <202006291301.46FEF3B7@keescook>
 <20200629205448.GA1474367@rani.riverdale.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387498AbgF2VGX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 17:06:23 -0400
Content-Disposition: inline
In-Reply-To: <20200629205448.GA1474367@rani.riverdale.lan>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.or>

On Mon, Jun 29, 2020 at 04:54:48PM -0400, Arvind Sankar wrote:
> On Mon, Jun 29, 2020 at 01:04:31PM -0700, Kees Cook wrote:
> > On Mon, Jun 29, 2020 at 12:53:47PM -0700, Nick Desaulniers wrote:
> > > On Sun, Jun 28, 2020 at 11:18 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > Fix a case of needless quotes in __section(), which Clang doesn't like.
> > > >
> > > > Acked-by: Will Deacon <will@kernel.org>
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > 
> > > Yep, I remember bugs from this.  Probably should scan the kernel for
> > > other instances of this.  +Joe for checkpatch.pl validation.
> > 
> > I think the others are safe because they're in macros:
> 
> Why does that make it safe -- the commit msg is a bit sparse, but I
> assume the problem is that it generates
> 	__attribute__((__section__("\".foo\"")))
> from
> 	__section(".foo")
> after preprocessing, and clang keeps the quotes in the section name when
> generating assembly, while gcc appears to strip them off.
> 
> It does that even if nested in another macro, no?

Yep, I can see things like:
[25] ".discard.ksym"   PROGBITS         0000000000000000  0000217c
       0000000000000000  0000000000000000  WA       0     0     4

Doesn't seem to cause a build error, but that can't be good.

> 
> > 
> > $ git grep -4 '__section("'
> > include/linux/compiler.h-# define KENTRY(sym)                                           \
> 
> Am I missing something, or is KENTRY unused in the tree?
> 
> > include/linux/compiler.h-       extern typeof(sym) sym;                                 \
> > include/linux/compiler.h-       static const unsigned long __kentry_##sym               \
> > include/linux/compiler.h-       __used                                                  \
> > include/linux/compiler.h:       __section("___kentry" "+" #sym )                        \
> > include/linux/compiler.h-       = (unsigned long)&sym;
> > --
> > include/linux/export.h-#define __ksym_marker(sym)       \
> > include/linux/export.h: static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
> > --
> > include/linux/srcutree.h-# define __DEFINE_SRCU(name, is_static)                                \
> > include/linux/srcutree.h-       is_static struct srcu_struct name;                              \
> > include/linux/srcutree.h-       struct srcu_struct * const __srcu_struct_##name                 \
> > include/linux/srcutree.h:               __section("___srcu_struct_ptrs") = &name
> > 
> > 
> > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > 
> > Thanks!
> > 
> > -- 
> > Kees Cook
