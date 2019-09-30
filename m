From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Date: Tue, 1 Oct 2019 00:08:07 +0200
Message-ID: <CANiq72kbZVB4vdyQonMQzuRHdh=BnD6F=sv5NQsFey5_xAB-Zg@mail.gmail.com>
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
 <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de> <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
 <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
 <20190930112636.vx2qxo4hdysvxibl@willie-the-truck> <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Will Deacon <will@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Stefan Wahren <wahrenst@gmx.net>, Kees Cook <keescook@google.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 30, 2019 at 11:50 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> So __attribute__((always_inline)) doesn't guarantee that code will be
> inlined.  [...] inline and __attribute__((always_inline))
> are a heuristic laden mess and should not be relied upon.

Small note: in GCC, __attribute__((always_inline)) is documented as
actually guaranteeing to either inline or error otherwise (although
see the remark for indirect calls):

    "Failure to inline such a function is diagnosed as an error. Note
that if such a function is called indirectly the compiler may or may
not inline it depending on optimization level and a failure to inline
an indirect call may or may not be diagnosed."

As for LLVM/Clang, no idea, since it does not say anything about it in
the docs -- but from what you say, it is a weaker guarantee.

Cheers,
Miguel
