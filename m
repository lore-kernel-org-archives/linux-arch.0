Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41812 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfJARzc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 13:55:32 -0400
Date: Tue, 1 Oct 2019 18:55:12 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Message-ID: <20191001175512.GK25745@shell.armlinux.org.uk>
References: <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
 <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
 <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck>
 <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck>
 <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck>
 <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Will Deacon <will@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Stefan Wahren <wahrenst@gmx.net>, Kees Cook <keescook@google.com>
Message-ID: <20191001175512.CK7rxkqX96iCa0wgBI-5x1M4UyODatGqdze_J-8Y_bk@z>

On Tue, Oct 01, 2019 at 10:44:43AM -0700, Nick Desaulniers wrote:
> I apologize; I don't mean to be difficult.  I would just like to avoid
> surprises when code written with the assumption that it will be
> inlined is not.  It sounds like we found one issue in arm32 and one in
> arm64 related to outlining.  If we fix those two cases, I think we're
> close to proceeding with Masahiro's cleanup, which I view as a good
> thing for the health of the Linux kernel codebase.

Except, using the C preprocessor for this turns the arm32 code into
yuck:

1. We'd need to turn get_domain() and set_domain() into multi-line
   preprocessor macro definitions, using the GCC ({ }) extension
   so that get_domain() can return a value.

2. uaccess_save_and_enable() and uaccess_restore() also need to
   become preprocessor macro definitions too.

So, we end up with multiple levels of nested preprocessor macros.
When something goes wrong, the compiler warning/error message is
going to be utterly _horrid_.

Now, as to whether an __attribute__((always_inline)) can or can not
be inlined...

`always_inline'
     Generally, functions are not inlined unless optimization is
     specified.  For functions declared inline, this attribute inlines
     the function even if no optimization level is specified.

Is this another instance of the compiler folk changing the rules of
already documented semantics?  This says nothing about "might not be
inlined if someone passes some random combination of -f flags".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
