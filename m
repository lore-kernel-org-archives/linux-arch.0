From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Date: Thu, 12 Dec 2019 09:41:32 -0800
Message-ID: <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au> <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191212104610.GW2827@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Segher Boessenkool <segher@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 12, 2019 at 2:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> +#ifdef GCC_VERSION < 40800

Where does that 4.8 version check come from, and why?

Yeah, I know, but this really wants a comment. Sadly it looks like gcc
bugzilla is down, so

   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145

currently gives an "Internal Server Error" for me.

[ Delete the horrid code we have because of gcc bugs ]

> +#else /* GCC_VERSION < 40800 */
> +
> +#define READ_ONCE_NOCHECK(x)                                           \
> +({                                                                     \
> +       typeof(x) __x = *(volatile typeof(x))&(x);                      \

I think we can/should just do this unconditionally if it helps th eissue.

Maybe add a warning about how gcc < 4.8 might mis-compile the kernel -
those versions are getting close to being unacceptable for kernel
builds anyway.

We could also look at being stricter for the normal READ/WRITE_ONCE(),
and require that they are

 (a) regular integer types

 (b) fit in an atomic word

We actually did (b) for a while, until we noticed that we do it on
loff_t's etc and relaxed the rules. But maybe we could have a
"non-atomic" version of READ/WRITE_ONCE() that is used for the
questionable cases?

              Linus
