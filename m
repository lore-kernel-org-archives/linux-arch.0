From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Date: Thu, 12 Dec 2019 12:49:52 -0800
Message-ID: <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au> <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck> <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191212193401.GB19020@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Segher Boessenkool <segher@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 12, 2019 at 11:34 AM Will Deacon <will@kernel.org> wrote:
>
> The root of my concern in all of this, and what started me looking at it in
> the first place, is the interaction with 'typeof()'. Inheriting 'volatile'
> for a pointer means that local variables in macros declared using typeof()
> suddenly start generating *hideous* code, particularly when pointless stack
> spills get stackprotector all excited.

Yeah, removing volatile can be a bit annoying.

For the particular case of the bitops, though, it's not an issue.
Since you know the type there, you can just cast it.

And if we had the rule that READ_ONCE() was an arithmetic type, you could do

    typeof(0+(*p)) __var;

since you might as well get the integer promotion anyway (on the
non-volatile result).

But that doesn't work with structures or unions, of course.

I'm not entirely sure we have READ_ONCE() with a struct. I do know we
have it with 64-bit entities on 32-bit machines, but that's ok with
the "0+" trick.

               Linus
