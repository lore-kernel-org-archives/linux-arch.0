From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/2] sparc64: Implement local_irq_save_nmi().
Date: Wed, 07 Apr 2010 00:06:25 -0700 (PDT)
Message-ID: <20100407.000625.203083228.davem@davemloft.net>
References: <20100406.163955.28809295.davem@davemloft.net>
	<1270623146.5109.532.camel@twins>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:52574
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757160Ab0DGHGW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2010 03:06:22 -0400
In-Reply-To: <1270623146.5109.532.camel@twins>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: mingo@elte.hu, acme@redhat.com, paulus@samba.org, efault@gmx.de, fweisbec@gmail.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 07 Apr 2010 08:52:26 +0200

> On Tue, 2010-04-06 at 16:39 -0700, David Miller wrote:
>> @@ -49,6 +49,16 @@ static inline void raw_local_irq_disable(void)
>>  	);
>>  }
>>  
>> +static inline void raw_local_irq_disable_nmi(void)
>> +{
>> +	__asm__ __volatile__(
>> +		"wrpr	%0, %%pil"
>> +		: /* no outputs */
>> +		: "i" (PIL_NMI)
>> +		: "memory"
>> +	);
>> +}
>> +
> 
> Isn't this wrong when used from !NMI context?
> 
> Should this thing do something like:
> 
>   if (rdpr() < PIL_NORMAL_MAX)
>     wrpr(PIL_NORMAL_MAX);
> 
> so that it only disables IRQs, but doesn't enable NMIs.

It's immaterial, local_irq_restore() will do the right thing,
and it's ok to disable NMIs in these few cases I think.

I desperately want to avoid that "test and maybe change the
value %pil value we write" business, and honestly that's
the whole point of this exercise.
