Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83]:48087 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfJCCLG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Oct 2019 22:11:06 -0400
MIME-Version: 1.0
References: <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk> <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
 <20191001181438.GL25745@shell.armlinux.org.uk> <CAKwvOdmBnBVU7F-a6DqPU6QM-BRc8LNn6YRmhTsuGLauCWKUOg@mail.gmail.com>
 <CAMuHMdWPhE1nNkmL1nj3vpQhB7fP3uDs2i_ZVi0Gf9qij4W2CA@mail.gmail.com> <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgFODvdFBHzgVf3JjoBz0z6LZhOm8xvMntsvOr66ASmZQ@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 3 Oct 2019 11:10:11 +0900
Message-ID: <CAK7LNARM2jVSdgCDJWDbvVxYLiUR_CFgTPg0nxzbCszSKcx+pg@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Nick Desaulniers <ndesaulniers@google.com>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Stefan Wahren <wahrenst@gmx.net>, Kees Cook <keescook@google.com>, Arnd Bergmann <arnd@arndb.de>, clang-built-linux <clang-built-linux@googlegroups.com>
Message-ID: <20191003021011.nZvNgIUWXNv9Xsl3g2Vz7PgGmFlPP7E2gAYcQuiBnmc@z>

On Thu, Oct 3, 2019 at 5:46 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Oct 2, 2019 at 5:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > >
> > > Then use the C preprocessor to force the inlining.  I'm sorry it's not
> > > as pretty as static inline functions.
> >
> > Which makes us lose the baby^H^H^H^Htype checking performed
> > on function parameters, requiring to add more ugly checks.
>
> I'm 100% agreed on this.
>
> If the inline change is being pushed by people who say "you should
> have used macros instead if you wanted inlining", then I will just
> revert that stupid commit that is causing problems.
>
> No, the preprocessor is not the answer.
>
> That said, code that relies on inlining for _correctness_ should use
> "__always_inline" and possibly even have a comment about why.
>
> But I am considering just undoing commit 9012d011660e ("compiler:
> allow all arches to enable CONFIG_OPTIMIZE_INLINING") entirely.

No, please do not.

Macrofying the 'inline' is a horrid mistake that makes incorrect code work.
It would eternally prevent people from writing portable, correct code.
Please do not encourage to hide problems.


> The
> advantages are questionable, and when the advantages are balanced
> against actual regressions and the arguments are "use macros", that
> just shows how badly thought out this was.
>
>                 Linus



-- 
Best Regards
Masahiro Yamada
