From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 02/10] netfilter: Avoid assigning 'const' pointer to
 non-const pointer
Date: Fri, 24 Jan 2020 23:00:08 +0100
Message-ID: <20200124220008.GS11457@worktop.programming.kicks-ass.net>
References: <20200123153341.19947-1-will@kernel.org>
 <20200123153341.19947-3-will@kernel.org>
 <CAKwvOdm2snorniFunMF=0nDH8-RFwm7wtjYK_Tcwkd+JZinYPg@mail.gmail.com>
 <20200124082443.GY14914@hirez.programming.kicks-ass.net>
 <CAHk-=wgbAfG6UZYd3PY3fmh5nCE191gY76Fn_g_D8nO64mdx-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wgbAfG6UZYd3PY3fmh5nCE191gY76Fn_g_D8nO64mdx-A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kernel-team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Fri, Jan 24, 2020 at 09:36:54AM -0800, Linus Torvalds wrote:
> On Fri, Jan 24, 2020 at 12:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Just for curiosity's sake. What does clang actually do in that case?
> 
> This shouldn't necessarily be clang-specific. If the variable itself
> is 'const', it might go into a read-only section. So trying to modify
> it will quite possibly hit a SIGSEGV in user space (and in kernel
> space cause an oops).

Quite; but I worried clang would use the UB to omit the access entirely,
and therefore rob us of the well deserved crash or something.

Let me go read Nick's email tho, see what it actually does.
