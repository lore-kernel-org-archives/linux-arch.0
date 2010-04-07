From: David Miller <davem@davemloft.net>
Subject: Re: [patch 1/3] kernel: local_irq_{save,restore}_nmi()
Date: Tue, 06 Apr 2010 18:19:06 -0700 (PDT)
Message-ID: <20100406.181906.89249649.davem@davemloft.net>
References: <20100406132807.698467930@chello.nl>
	<20100406133140.903644813@chello.nl>
	<1270602790.19685.15603.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37222
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932370Ab0DGBTD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2010 21:19:03 -0400
In-Reply-To: <1270602790.19685.15603.camel@gandalf.stny.rr.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rostedt@goodmis.org
Cc: a.p.zijlstra@chello.nl, mingo@elte.hu, acme@redhat.com, paulus@samba.org, efault@gmx.de, fweisbec@gmail.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 06 Apr 2010 21:13:10 -0400

> On Tue, 2010-04-06 at 15:28 +0200, Peter Zijlstra wrote:
> 
>> Index: linux-2.6/kernel/trace/trace_irqsoff.c
>> ===================================================================
>> --- linux-2.6.orig/kernel/trace/trace_irqsoff.c
>> +++ linux-2.6/kernel/trace/trace_irqsoff.c
>> @@ -316,6 +316,14 @@ void trace_hardirqs_off(void)
>>  }
>>  EXPORT_SYMBOL(trace_hardirqs_off);
>>  
>> +void trace_hardirqs_off_no_nmi(void)
>> +{
>> +	WARN_ON_ONCE(in_nmi());
> 
> Should we do this for all archs? I can imagine a lot of warning reports
> coming in the near future. And they will be passing it towards me.

That's the whole point, so that the problem is more easily noticed and
it gets fixed long before I end up accidently testing the code on my
machines :-)

To be honest, the fix is so trivial, you just need to add '_nmi' to
the local_irq_{save,restore}() calls that warn like this.

I'm even willing to have you forward all of those reports to me and
I'll be responsible for fixing them.

How's that? :-)
