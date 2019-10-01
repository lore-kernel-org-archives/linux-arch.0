Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37888 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfJASAY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 14:00:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id x10so10197509pgi.5
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2019 11:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
 <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
 <20190930112636.vx2qxo4hdysvxibl@willie-the-truck> <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck> <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
 <20191001175512.GK25745@shell.armlinux.org.uk>
In-Reply-To: <20191001175512.GK25745@shell.armlinux.org.uk>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 1 Oct 2019 11:00:11 -0700
Message-ID: <CAKwvOdmw_xmTGZLeK8-+Q4nUpjs-UypJjHWks-3jHA670Dxa1A@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Stefan Wahren <wahrenst@gmx.net>, Kees Cook <keescook@google.com>
Message-ID: <20191001180011.t3I6O75rnVsr0m0PVRdxhtxpu1GFESCUc_0faNoqEWY@z>

On Tue, Oct 1, 2019 at 10:55 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Oct 01, 2019 at 10:44:43AM -0700, Nick Desaulniers wrote:
> > I apologize; I don't mean to be difficult.  I would just like to avoid
> > surprises when code written with the assumption that it will be
> > inlined is not.  It sounds like we found one issue in arm32 and one in
> > arm64 related to outlining.  If we fix those two cases, I think we're
> > close to proceeding with Masahiro's cleanup, which I view as a good
> > thing for the health of the Linux kernel codebase.
>
> Except, using the C preprocessor for this turns the arm32 code into
> yuck:
>
> 1. We'd need to turn get_domain() and set_domain() into multi-line
>    preprocessor macro definitions, using the GCC ({ }) extension
>    so that get_domain() can return a value.
>
> 2. uaccess_save_and_enable() and uaccess_restore() also need to
>    become preprocessor macro definitions too.
>
> So, we end up with multiple levels of nested preprocessor macros.
> When something goes wrong, the compiler warning/error message is
> going to be utterly _horrid_.

That's why I preferred V1 of Masahiro's patch, that fixed the inline
asm not to make use of caller saved registers before calling a
function that might not be inlined.
-- 
Thanks,
~Nick Desaulniers
