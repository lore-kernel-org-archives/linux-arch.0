Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47096 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfJAVPA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 17:15:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so8981499pfg.13
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2019 14:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAK8P3a0eKOyJRjp1P8HWfSLWO=d6Y3befy3kQBgTPVX+g_2q4A@mail.gmail.com> <CANiq72nZRc5TXxhXSQnMhaeQaP2RuDpHf+1CvC8kDV8_m14WeQ@mail.gmail.com>
In-Reply-To: <CANiq72nZRc5TXxhXSQnMhaeQaP2RuDpHf+1CvC8kDV8_m14WeQ@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 1 Oct 2019 14:14:46 -0700
Message-ID: <CAKwvOdm1=9Gbia=9k1f=Vgu_QUSnmM8eKr0KkKOH6zifqtk+qA@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Stefan Wahren <wahrenst@gmx.net>, Kees Cook <keescook@google.com>, clang-built-linux <clang-built-linux@googlegroups.com>
Message-ID: <20191001211446.etwU2uL_tqtoNup6mDDCX3gHlwVUbM7alGXAXqfuO2s@z>

On Tue, Oct 1, 2019 at 2:06 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Oct 1, 2019 at 10:53 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > 1. is clearly the most common case, but there is also
> >
> > 4. Some compiler version (possibly long gone, possibly still current)
> > makes bad inlining decisions that result in horrible but functionally
> > correct object code for a particular function, and forcing a function to
> > be inlined results in what we had expected the compiler to do already.
>
> There is also 5. code that does not even compile without it, e.g.
> _static_cpu_has() in x86_64 which requires
> __attribute__((always_inline)), at least on GCC 9.2.

I assert that's just another case of 2, and should be investigated. (I
think I remember that from when I had to teach LLVM how to inline asm
goto; since the compiler can reject inlining if it doesn't know how to
do such a transform).

>
> For x64_64 it is the only one case I found, though. If you disable
> __always_inline everything else compiles and links (in a defconfig).

Cool, so one bug in arm32, one bug in arm64, one bug in x86_64.
Doesn't sound like too much work to fix.
-- 
Thanks,
~Nick Desaulniers
