From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH] asm-generic: Use raw_local_irq_save/restore instead
	local_irq_save/restore
Date: Tue, 27 Jul 2010 19:54:04 -0400
Message-ID: <AANLkTim3Po8XD3UFB-h6UH4HWtSZP9MA+V63TE5tQgku@mail.gmail.com>
References: <1274863724-14906-1-git-send-email-monstr@monstr.eu>
	<1274863724-14906-2-git-send-email-monstr@monstr.eu> <1274884963.22648.245.camel@gandalf.stny.rr.com>
	<20100526100805.171b3c48.akpm@linux-foundation.org> <4C4D4C2E.8010103@monstr.eu>
	<20100727161819.cf6feab1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100727161819.cf6feab1.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: monstr@monstr.eu, rostedt@goodmis.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 27, 2010 at 19:18, Andrew Morton wrote:
> On Mon, 26 Jul 2010 10:49:50 +0200 Michal Simek wrote:
>> start/stop_critical_timing function for preemptirqsoff, preemptoff
>> and irqsoff tracers contains atomic_inc and atomic_dec operations.
>>
>> Atomic operations used local_irq_save/restore macros to ensure
>> atomic access but they are traced by the same function which is caus=
ing
>> recursion problem.
>>
>> The reason is when these tracers are turn ON then local_irq_save/res=
tore
>> macros are changed in include/linux/irqflags.h to call trace_hardirq=
s_on/off
>> which call start/stop_critical_timing.
>>
>> Microblaze was affected because use generic atomic implementation.
>
> Seems that this will also affect blackfin, mn10300 and score. =C2=A0I=
 guess
> they aren't supporting tracing yet?

do you mean TRACE_IRQFLAGS_SUPPORT ?  Blackfin should ... my
understanding was that arches just needed to implement asm/irqflags.h
for it.
-mike
