From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 22/28] ARCv2: STAR 9000837815 workaround hardware exclusive
 transactions livelock
Date: Fri, 19 Jun 2015 15:39:22 +0530
Message-ID: <5583EA52.5080701@synopsys.com>
References: <20150610110234.GH3644@twins.programming.kicks-ass.net> <1434707726-32624-1-git-send-email-vgupta@synopsys.com> <20150619095932.GC18017@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:39917 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751120AbbFSKJm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Jun 2015 06:09:42 -0400
In-Reply-To: <20150619095932.GC18017@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, Carlos Basto <Carlos.Basto@synopsys.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

On Friday 19 June 2015 03:29 PM, Will Deacon wrote:
> On Fri, Jun 19, 2015 at 10:55:26AM +0100, Vineet Gupta wrote:
>> > A quad core SMP build could get into hardware livelock with concurrent
>> > LLOCK/SCOND. Workaround that by adding a PREFETCHW which is serialized by
>> > SCU (System Coherency Unit). It brings the cache line in Exclusive state
>> > and makes others invalidate their lines. This gives enough time for
>> > winner to complete the LLOCK/SCOND, before others can get the line back.
>> > 
>> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>> > Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
>> > ---
>> >  arch/arc/include/asm/atomic.h | 14 ++++++++++++--
>> >  1 file changed, 12 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
>> > index 20b7dc17979e..03484cb4d16d 100644
>> > --- a/arch/arc/include/asm/atomic.h
>> > +++ b/arch/arc/include/asm/atomic.h
>> > @@ -23,13 +23,21 @@
>> >  
>> >  #define atomic_set(v, i) (((v)->counter) = (i))
>> >  
>> > +#ifdef CONFIG_ISA_ARCV2
>> > +#define PREFETCHW	"	prefetchw   [%1]	\n"
>> > +#else
>> > +#define PREFETCHW
>> > +#endif
>> > +
>> >  #define ATOMIC_OP(op, c_op, asm_op)					\
>> >  static inline void atomic_##op(int i, atomic_t *v)			\
>> >  {									\
>> >  	unsigned int temp;						\
>> >  									\
>> >  	__asm__ __volatile__(						\
>> > -	"1:	llock   %0, [%1]	\n"				\
>> > +	"1:				\n"				\
>> > +	PREFETCHW							\
>> > +	"	llock   %0, [%1]	\n"				\
>> >  	"	" #asm_op " %0, %0, %2	\n"				\
>> >  	"	scond   %0, [%1]	\n"				\
>> >  	"	bnz     1b		\n"				\
> Curious, but are you *sure* the prefetch should be *inside* the loop?
> On most ll/sc architectures, that's a livelock waiting to happen because
> you ping-pong the cache-line around in exclusive state.

Indeed, the prefetchw inside the loop seems dubious, but this is what broke the
h/w livelock when we were playing with multibench last year and what i was told to
do by h/w folks. Let me go check once again !

-Vineet
