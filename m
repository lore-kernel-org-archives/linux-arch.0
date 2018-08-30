From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Date: Thu, 30 Aug 2018 20:31:59 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B090EA4@us01wembx1.internal.synopsys.com>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com> <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
 <20180830142354.GB13005@arm.com>
 <20180830142920.GO24082@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 08/30/2018 07:29 AM, Peter Zijlstra wrote:=0A=
> On Thu, Aug 30, 2018 at 03:23:55PM +0100, Will Deacon wrote:=0A=
>=0A=
>> Yes, that would be worth trying. However, I also just noticed that the=
=0A=
>> fetch-ops (which are now used to implement test_and_set_bit_lock()) seem=
=0A=
>> to be missing the backwards branch in the LL/SC case. Yet another diff=
=0A=
>> below.=0A=
>>=0A=
>> Will=0A=
>>=0A=
>> --->8=0A=
>>=0A=
>> diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic=
.h=0A=
>> index 4e0072730241..f06c5ed672b3 100644=0A=
>> --- a/arch/arc/include/asm/atomic.h=0A=
>> +++ b/arch/arc/include/asm/atomic.h=0A=
>> @@ -84,7 +84,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v=
)			\=0A=
>>  	"1:	llock   %[orig], [%[ctr]]		\n"		\=0A=
>>  	"	" #asm_op " %[val], %[orig], %[i]	\n"		\=0A=
>>  	"	scond   %[val], [%[ctr]]		\n"		\=0A=
>> -	"						\n"		\=0A=
>> +	"	bnz	1b				\n"		\=0A=
>>  	: [val]	"=3D&r"	(val),						\=0A=
>>  	  [orig] "=3D&r" (orig)						\=0A=
>>  	: [ctr]	"r"	(&v->counter),					\=0A=
> ACK!! sorry about that, no idea how I messed that up.=0A=
>=0A=
> Also, once it all works, they should look at switching to _relaxed=0A=
> atomics for LL/SC.=0A=
=0A=
Indeed this is the mother of all issues, I tried and system is clearly hose=
d with=0A=
and works after.=0A=
What's amazing is the commit 4aef66c8ae9 which introduced it is from 2016 ;=
-)=0A=
Back then we had a retry branch with backoff stuff which I'd reverted for n=
ew=0A=
cores and the merge conflict somehow missed it.=0A=
=0A=
@PeterZ I'll create a patch with you as author ? do I need any formal sign =
offs,=0A=
acks etc ?=0A=
=0A=
So after this there are 2 other things to be addresses / looked at still wh=
ile we=0A=
are still here.=0A=
=0A=
1. After 84c6591103db __clear_bit_lock() implementation will be broken (or =
atleast=0A=
not consistent with what we had after), do we need to reinstate it.=0A=
2. Will's proposed change to remove the underlying issue, but the issue in =
#1=0A=
remains ?=0A=
=0A=
-Vineet=0A=
