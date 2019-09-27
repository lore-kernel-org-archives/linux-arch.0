From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Date: Fri, 27 Sep 2019 15:38:44 -0700
Message-ID: <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
 <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de> <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Will Deacon <will@kernel.org>, Stefan Wahren <wahrenst@gmx.net>, Kees Cook <keescook@google.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 27, 2019 at 3:08 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> So get_user() was passed a bad value/pointer from userspace? Do you
> know which of the tree calls to get_user() from sock_setsockopt() is
> failing?  (It's not immediately clear to me how this patch is at
> fault, vs there just being a bug in the source somewhere).

Based on the error messages, the SO_PASSCRED ones are almost certainly
from the get_user() in net/core/sock.c: sock_setsockopt(), which just
does

        if (optlen < sizeof(int))
                return -EINVAL;

        if (get_user(val, (int __user *)optval))
                return -EFAULT;

        valbool = val ? 1 : 0;

but it's the other messages imply that a lot of other cases are
failing too (ie the "Failed to bind netlink socket" is, according to
google, a bind() that fails with the same EFAULT error).

There are probably even more failures that happen elsewhere and just
don't even syslog the fact. I'd guess that all get_user() calls just
fail, and those are the ones that happen to get printed out.

Now, _why_ it would fail, I have ni idea. There are several inlines in
the arm uaccess.h file, and it depends on other headers like
<asm/domain.h> with more inlines still - eg get/set_domain() etc.

Soem of that code is pretty subtle. They have fixed register usage
(but the asm macros actually check them). And the inline asms clobber
the link register, but they do seem to clearly _state_ that they
clobber it, so who knows.

Just based on the EFAULT, I'd _guess_ that it's some interaction with
the domain access control register (so that get/set_domain() thing).
But I'm not even sure that code is enabled for the Rpi2, so who
knows..

               Linus
