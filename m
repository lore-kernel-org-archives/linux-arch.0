Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35687 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730446AbfJCR3m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Oct 2019 13:29:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id m7so3692705lji.2
        for <linux-arch@vger.kernel.org>; Thu, 03 Oct 2019 10:29:40 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 81sm681104lje.70.2019.10.03.10.29.38
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 10:29:38 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id v24so3691381ljj.3
        for <linux-arch@vger.kernel.org>; Thu, 03 Oct 2019 10:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com>
 <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com>
 <CAK7LNARM2jVSdgCDJWDbvVxYLiUR_CFgTPg0nxzbCszSKcx+pg@mail.gmail.com>
 <CAHk-=wiMm3rN15WmiAqMHjC-pakL_b8qgWsPPri0+YLFORT-ZA@mail.gmail.com> <CAK7LNATSoOD0g=Aarui6Y26E_YB035NsaPpHxqtBNyw0K0UXVw@mail.gmail.com>
In-Reply-To: <CAK7LNATSoOD0g=Aarui6Y26E_YB035NsaPpHxqtBNyw0K0UXVw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 3 Oct 2019 10:29:21 -0700
Message-ID: <CAHk-=wj9Dbom1x7qDfrXgNbjdFa_84bAUMdGigs4sELQQW28wg@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Nick Desaulniers <ndesaulniers@google.com>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Stefan Wahren <wahrenst@gmx.net>, Kees Cook <keescook@google.com>, Arnd Bergmann <arnd@arndb.de>, clang-built-linux <clang-built-linux@googlegroups.com>
Message-ID: <20191003172921.wW7gntxdT5pO5BrPDk1GJqYFmhdisG4iv5gfHizxTUI@z>

On Thu, Oct 3, 2019 at 10:24 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I just want to annotate __always_inline for the case
> "2. code that if not inlined is somehow not correct."

Oh, I support that entirely - if only for documentation.

But I do *not* support the dismissal of the architecture maintainers
concerns about "does it work?" and apparently known compiler bugs.

> Again, not saying "use a macro".

Other people did, though.

And there seemed to be little balancing of the pain vs the gain. The
gain really isn't that obvious. If the code shrinks by a couple of kB,
is that good or bad? Maybe it is smaller, but is it _better_?

            Linus
