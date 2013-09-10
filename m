From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/7] preempt_count rework -v2
Date: Tue, 10 Sep 2013 14:51:32 -0700
Message-ID: <522F9464.9070806@zytor.com>
References: <20130910130811.507933095@infradead.org> <20130910135152.GD7537@gmail.com> <20130910135636.GA8268@gmail.com> <CA+55aFwmEQeF+PtM7cuaQ8OkuTS=R4JJ61Wwfv8u-Svo-V3KwQ@mail.gmail.com> <20130910164519.GL31370@twins.programming.kicks-ass.net> <CA+55aFz7WtcdkwKEGoqCzmC9HsY0LPK-oVK_oATYhRnbGq=2GA@mail.gmail.com> <20130910212509.GA18147@laptop.programming.kicks-ass.net> <CA+55aFxsEYQPXnoxNXAeSPEkk3uT8iq-_KJVe2M2qZZbtL=cbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:44851 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101Ab3IJVxA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Sep 2013 17:53:00 -0400
In-Reply-To: <CA+55aFxsEYQPXnoxNXAeSPEkk3uT8iq-_KJVe2M2qZZbtL=cbA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Andi Kleen <ak@linux.intel.com>, Mike Galbraith <bitbucket@online.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On 09/10/2013 02:43 PM, Linus Torvalds wrote:
> On Tue, Sep 10, 2013 at 2:25 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> Here's one that builds and boots on kvm until wanting to mount root.
>>
>> I'm not entirely sure on the "ir" vs "er" thing and atomic64_t and
>> local_t are inconsistent wrt that so I'm too.
> 
> "i" is "any constant", while "e" is "32-bit signed constant".
> 
> And I think all of the 64-bit ones should probably be "e", because
> afaik there is no way to add a 64-bit constant directly to memory (you
> have to load it into a register first).
> 
> Of course, in reality, the constant is always just 1 or -1 or
> something like that, so nobody will ever notice the incorrect case...
> 
> And it doesn't matter for the 32-bit cases, obviously, but we could
> just make them all be "e" for simplicity.
> 
> That said, looking at your patch, I get the *very* strong feeling that
> we could make a macro that does all the repetitions for us, and then
> have a
> 
>   GENERATE_RMW(atomic_sub_and_test, LOCK_PREFIX "subl", "e", "")
>   GENERATE_RMW(atomic_dec_and_test, LOCK_PREFIX "decl", "e", "")
>   ..
>   GENERATE_RMW(atomic_add_negative, LOCK_PREFIX "addl", "s", "")
> 
>   GENERATE_RMW(local_sub_and_test, "subl", "e", __percpu_prefix)
>   ...
> 
> etc.
> 
> I'm sure the macro would be nasty as hell (and I bet it needs a few
> more arguments), but then we'd avoid the repetition..
> 

Actually, the right thing here really is "er" (which I think you meant,
but just to make it clear.)  Why?  Even if the value is representable as
a signed immediate, if gcc already happens to have it in a register it
will be better to use the register.

"e" doesn't work on versions of gcc older than the first x86-64 release,
but we don't care about that anymore.

A final good question is if we should encapsulate the add/inc and
sub/dec into a single function; one could easily do somethin glike:

static inline int atomic_sub_and_test(int i, atomic_t *)
{
	if (__builtin_constant_p(i) && i == 1)
		/* Use incl */
	else if (__builtin_constant_p(i) && i == -1)
		/* Use decl */
	else
		/* Use addl */
}

	-hpa
