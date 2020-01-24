From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 02/10] netfilter: Avoid assigning 'const' pointer to
 non-const pointer
Date: Fri, 24 Jan 2020 09:36:54 -0800
Message-ID: <CAHk-=wgbAfG6UZYd3PY3fmh5nCE191gY76Fn_g_D8nO64mdx-A@mail.gmail.com>
References: <20200123153341.19947-1-will@kernel.org> <20200123153341.19947-3-will@kernel.org>
 <CAKwvOdm2snorniFunMF=0nDH8-RFwm7wtjYK_Tcwkd+JZinYPg@mail.gmail.com> <20200124082443.GY14914@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200124082443.GY14914@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kernel-team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Fri, Jan 24, 2020 at 12:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Just for curiosity's sake. What does clang actually do in that case?

This shouldn't necessarily be clang-specific. If the variable itself
is 'const', it might go into a read-only section. So trying to modify
it will quite possibly hit a SIGSEGV in user space (and in kernel
space cause an oops).

Note that that is different from a const pointer to something that
wasn't originally const. That's just a "error out at compile time if
somebody tries to write through it", but the const'ness can be cast
away, because all the 'const' really said was that the object can't be
modified through _that_ pointer, not in general.

(That also means that the compiler can't necessarily even optimize
multiple accesses through a const pointer away, because the object
might be modified through another pointer that aliases the const one -
you'd need to also mark it "restrict" to tell the compiler that no
other pointer will alias).

                 Linus
