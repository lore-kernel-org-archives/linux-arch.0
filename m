From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] vmlinux.lds: consider .text.{hot|unlikely}.* part of
 .text too
Date: Mon, 22 Jun 2020 16:04:07 -0700
Message-ID: <CAKwvOdniambW9_nVbDnd4A_+bdDdZMd2V1Q=Xw5EJYDGeh=eyQ@mail.gmail.com>
References: <20200617210613.95432-1-ndesaulniers@google.com> <20200617212705.tq2q6bi446gydymo@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbgFVXEV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 19:04:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DF7C061573
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 16:04:20 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 35so8264651ple.0
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 16:04:20 -0700 (PDT)
In-Reply-To: <20200617212705.tq2q6bi446gydymo@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, clang-built-linux <clang-built-linux@googlegroups.com>, Kees Cook <keescook@chromium.org>, "# 3.4.x" <stable@vger.kernel.org>, Jian Cai <jiancai@google.com>, Luis Lozano <llozano@google.com>, Manoj Gupta <manojgupta@google.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Jun 17, 2020 at 2:27 PM F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@googl=
e.com> wrote:
>
>
> On 2020-06-17, Nick Desaulniers wrote:
> >ld.bfd's internal linker script considers .text.hot AND .text.hot.* to
> >be part of .text, as well as .text.unlikely and .text.unlikely.*.
>
> >ld.lld will produce .text.hot.*/.text.unlikely.* sections.
>
> Correction to this sentence. lld is not relevant here.
>
> -ffunction-sections combined with profile-guided optimization can
> produce .text.hot.* .text.unlikely.* sections.  Newer clang may produce
> .text.hot. .text.unlikely. (without suffix, but with a trailing dot)
> when -fno-unique-section-names is specified, as an optimization to make
> .strtab smaller.

Then why was the bug report reporting https://reviews.llvm.org/D79600
as the result of a bisection, if LLD is not relevant?  Was the
bisection wrong?

The upstream report wasn't initially public, for no good reason.  So I
didn't include it, but if we end up taking v1, this should have

Link: https://bugs.chromium.org/p/chromium/issues/detail?id=3D1084760

The kernel doesn't use -fno-unique-section-names; is that another flag
that's added by CrOS' compiler wrapper?
https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/t=
hird_party/toolchain-utils/compiler_wrapper/config.go;l=3D110
Looks like no.  It doesn't use `-fno-unique-section-names` or
`-ffunction-sections`.


>
> We've already seen that GCC can place main in .text.startup without
> -ffunction-sections. There may be other non -ffunction-sections cases
> for .text.hot.* or .text.unlikely.*. So it is definitely a good idea to
> be more specific even if we don't care about -ffunction-sections for
> now.
>
> >Make sure to group these together.  Otherwise these orphan sections may
> >be placed outside of the the _stext/_etext boundaries.
> >
> >Cc: stable@vger.kernel.org
> >Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommitdiff;h=
=3Dadd44f8d5c5c05e08b11e033127a744d61c26aee
> >Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommitdiff;h=
=3D1de778ed23ce7492c523d5850c6c6dbb34152655
> >Link: https://reviews.llvm.org/D79600
> >Reported-by: Jian Cai <jiancai@google.com>
> >Debugged-by: Luis Lozano <llozano@google.com>
> >Suggested-by: F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@google.com>
> >Tested-by: Luis Lozano <llozano@google.com>
> >Tested-by: Manoj Gupta <manojgupta@google.com>
> >Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >---
> > include/asm-generic/vmlinux.lds.h | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> >diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vml=
inux.lds.h
> >index d7c7c7f36c4a..fe5aaef169e3 100644
> >--- a/include/asm-generic/vmlinux.lds.h
> >+++ b/include/asm-generic/vmlinux.lds.h
> >@@ -560,7 +560,9 @@
> >  */
> > #define TEXT_TEXT                                                     \
> >               ALIGN_FUNCTION();                                       \
> >-              *(.text.hot TEXT_MAIN .text.fixup .text.unlikely)       \
> >+              *(.text.hot .text.hot.*)                                \
> >+              *(TEXT_MAIN .text.fixup)                                \
> >+              *(.text.unlikely .text.unlikely.*)                      \
> >               NOINSTR_TEXT                                            \
> >               *(.text..refcount)                                      \
> >               *(.ref.text)                                            \
> >--
> >2.27.0.290.gba653c62da-goog
> >
