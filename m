Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44712 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfJAV6t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 17:58:49 -0400
Date: Tue, 1 Oct 2019 22:58:27 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Message-ID: <20191001215827.GP25745@shell.armlinux.org.uk>
References: <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck>
 <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk>
 <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk>
 <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <20191001205938.GM25745@shell.armlinux.org.uk>
 <20191001212608.GN25745@shell.armlinux.org.uk>
 <CAKwvOdmkmdM14BNurK3WwyG3Qc5wOFeajMtQ1D+na9mLfkim+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmkmdM14BNurK3WwyG3Qc5wOFeajMtQ1D+na9mLfkim+w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Will Deacon <will@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Stefan Wahren <wahrenst@gmx.net>, Kees Cook <keescook@google.com>, Arnd Bergmann <arnd@arndb.de>, clang-built-linux <clang-built-linux@googlegroups.com>
Message-ID: <20191001215827.dDRHeCYPQBPmDUjrItIxetflzrqOrDtHmpn_WZUBD38@z>

On Tue, Oct 01, 2019 at 02:32:54PM -0700, Nick Desaulniers wrote:
> On Tue, Oct 1, 2019 at 2:26 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Oct 01, 2019 at 09:59:38PM +0100, Russell King - ARM Linux admin wrote:
> > > On Tue, Oct 01, 2019 at 01:21:44PM -0700, Nick Desaulniers wrote:
> > > > On Tue, Oct 1, 2019 at 11:14 AM Russell King - ARM Linux admin
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > The whole "let's make inline not really mean inline" is nothing more
> > > > > than a band-aid to the overuse (and abuse) of "inline".
> > > >
> > > > Let's triple check the ISO C11 draft spec just to be sure:
> > > > § 6.7.4.6: A function declared with an inline function specifier is an
> > > > inline function. Making a
> > > > function an inline function suggests that calls to the function be as
> > > > fast as possible.
> > > > The extent to which such suggestions are effective is
> > > > implementation-defined. 139)
> > > > 139) For example, an implementation might never perform inline
> > > > substitution, or might only perform inline
> > > > substitutions to calls in the scope of an inline declaration.
> > > > § J.3.8 [Undefined Behavior] Hints: The extent to which suggestions
> > > > made by using the inline function specifier are effective (6.7.4).
> > > >
> > > > My translation:
> > > > "Please don't assume inline means anything."
> > > >
> > > > For the unspecified GNU C extension __attribute__((always_inline)), it
> > > > seems to me like it's meant more for performing inlining (an
> > > > optimization) at -O0.  Whether the compiler warns or not seems like a
> > > > nice side effect, but provides no strong guarantee otherwise.
> > > >
> > > > I'm sorry that so much code may have been written with that
> > > > assumption, and I'm sorry to be the bearer of bad news, but this isn't
> > > > a recent change.  If code was written under false assumptions, it
> > > > should be rewritten. Sorry.
> > >
> > > You may quote C11, but that is not relevent.  The kernel is coded to
> > > gnu89 standard - see the -std=gnu89 flag.
> >
> > There's more to this and why C11 is entirely irrelevant.  The "inline"
> > you see in our headers is not the compiler keyword that you find in
> > various C standards, it is a macro that gets expanded to either:
> >
> > #define inline inline __attribute__((__always_inline__)) __gnu_inline \
> >         __maybe_unused notrace
> >
> > or
> >
> > #define inline inline                                    __gnu_inline \
> >         __maybe_unused notrace
> >
> > __gnu_inline is defined as:
> >
> > #define __gnu_inline                    __attribute__((__gnu_inline__))
> >
> > So this attaches the gnu_inline attribute to the function:
> >
> > `gnu_inline'
> >      This attribute should be used with a function that is also declared
> >      with the `inline' keyword.  It directs GCC to treat the function
> >      as if it were defined in gnu90 mode even when compiling in C99 or
> >      gnu99 mode.
> > ...
> >      Since ISO C99 specifies a different semantics for `inline', this
> >      function attribute is provided as a transition measure and as a
> >      useful feature in its own right.  This attribute is available in
> >      GCC 4.1.3 and later.  It is available if either of the
> >      preprocessor macros `__GNUC_GNU_INLINE__' or
> >      `__GNUC_STDC_INLINE__' are defined.  *Note An Inline Function is
> >      As Fast As a Macro: Inline.
> >
> > which is quite clear that C99 semantics do not apply to _this_ inline.
> > The manual goes on to explain:
> >
> >  GCC implements three different semantics of declaring a function
> > inline.  One is available with `-std=gnu89' or `-fgnu89-inline' or when
> > `gnu_inline' attribute is present on all inline declarations, another
> > when `-std=c99', `-std=c11', `-std=gnu99' or `-std=gnu11' (without
> > `-fgnu89-inline'), and the third is used when compiling C++.
> 
> (I wrote the kernel patch for gnu_inline; it only comes into play when
> `inline` appears on a function *also defined as `extern`*).
