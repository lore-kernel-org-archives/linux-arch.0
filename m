Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42552 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfJAVGc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 17:06:32 -0400
MIME-Version: 1.0
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAK8P3a0eKOyJRjp1P8HWfSLWO=d6Y3befy3kQBgTPVX+g_2q4A@mail.gmail.com>
In-Reply-To: <CAK8P3a0eKOyJRjp1P8HWfSLWO=d6Y3befy3kQBgTPVX+g_2q4A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Oct 2019 23:06:18 +0200
Message-ID: <CANiq72nZRc5TXxhXSQnMhaeQaP2RuDpHf+1CvC8kDV8_m14WeQ@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Stefan Wahren <wahrenst@gmx.net>, Kees Cook <keescook@google.com>, clang-built-linux <clang-built-linux@googlegroups.com>
Message-ID: <20191001210618.3oyAqCfXaWzI4fOkTuRcIKhakjuDbfSkMP-JQ-7qcQs@z>

On Tue, Oct 1, 2019 at 10:53 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> 1. is clearly the most common case, but there is also
>
> 4. Some compiler version (possibly long gone, possibly still current)
> makes bad inlining decisions that result in horrible but functionally
> correct object code for a particular function, and forcing a function to
> be inlined results in what we had expected the compiler to do already.

There is also 5. code that does not even compile without it, e.g.
_static_cpu_has() in x86_64 which requires
__attribute__((always_inline)), at least on GCC 9.2.

For x64_64 it is the only one case I found, though. If you disable
__always_inline everything else compiles and links (in a defconfig).

Cheers,
Miguel
