From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Date: Fri, 31 Aug 2018 00:30:50 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B090FF3@us01wembx1.internal.synopsys.com>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com> <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
 <20180830142354.GB13005@arm.com>
 <20180830142920.GO24082@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075012B090EA4@us01wembx1.internal.synopsys.com>
 <20180830204515.GC24124@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 08/30/2018 01:45 PM, Peter Zijlstra wrote:=0A=
>>=0A=
>> Indeed this is the mother of all issues, I tried and system is clearly h=
osed with=0A=
>> and works after.=0A=
>> What's amazing is the commit 4aef66c8ae9 which introduced it is from 201=
6 ;-)=0A=
>> Back then we had a retry branch with backoff stuff which I'd reverted fo=
r new=0A=
>> cores and the merge conflict somehow missed it.=0A=
>>=0A=
>> @PeterZ I'll create a patch with you as author ? do I need any formal si=
gn offs,=0A=
>> acks etc ?=0A=
> Well, Will spotted it, give authorship to him, you have my ack per the=0A=
> above.=0A=
=0A=
Oops, sorry for the mixup. I have him as author now and pushed to ARC for-c=
urr=0A=
(will trickle into linux-next eventually).=0A=
=0A=
> FWIW, also ACK on Will's patch to switch you over to asm-generic bitops=
=0A=
> entirely.=0A=
=0A=
Yeah I'll get it to that and your's after the clear_bit_lock stuff - sorry =
for=0A=
hijacking this thread to that topic now=0A=
=0A=
-Vineet=0A=
