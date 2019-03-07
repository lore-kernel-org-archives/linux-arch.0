From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] signal: fix building with clang
Date: Thu, 7 Mar 2019 16:37:42 +0100
Message-ID: <CAK8P3a2fuD-UBJET_OBKekCxrTDpnAxb0Bpu2LCCXaVT3pXTMQ@mail.gmail.com>
References: <20190307091218.2343836-1-arnd@arndb.de> <20190307152805.GA25101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307152805.GA25101@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, "Eric W . Biederman" <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Christian Brauner <christian@brauner.io>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-mips@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 7, 2019 at 4:28 PM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 03/07, Arnd Bergmann wrote:
> >
> > clang warns about the sigset_t manipulating functions (sigaddset, sigdelset,
> > sigisemptyset, ...) because it performs semantic analysis before discarding
> > dead code, unlike gcc that does this in the reverse order.
> >
> > The result is a long list of warnings like:
> >
> > In file included from arch/arm64/include/asm/ftrace.h:21:
> > include/linux/compat.h:489:10: error: array index 3 is past the end of the array (which contains 2 elements) [-Werror,-Warray-bounds]
> >         case 2: v.sig[3] = (set->sig[1] >> 32); v.sig[2] = set->sig[1];
>
> stupid question... I have no idea if this can work or not, but may be we can just do
>
>         --- x/Makefile
>         +++ x/Makefile
>         @@ -701,6 +701,7 @@ KBUILD_CPPFLAGS += $(call cc-option,-Qun
>          KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
>          KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
>          KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
>         +KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
>          # Quiet clang warning: comparison of unsigned expression < 0 is always false
>          KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
>          # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
>
> ?

I would definitely not go that far, since the warning is generally
rather useful,
but we could try something more localized

__diag_push();
__diag_ignore(clang, 7, "-Warray-bounds");
...
__diag_pop();

> > I turn the nice switch()/case statements
> > into preprocessor conditionals, and where that is not possible, use the
> > '%' operator
>
> I can't say what looks worse... to me it would be either use ifdef's or %'s
> everywhere in signal.h, with this patch the code doesn't look consistent.
> But I won't insist.

I tried using just #ifdefs, but that did not work inside of macros.
We could use % everywhere, or possible wrap it inside of another
macro.

        Arnd
