From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 01/27] smpboot: Provide a generic method to boot	secondary
 processors
Date: Sat, 02 Jun 2012 04:11:28 +0530
Message-ID: <4FC94518.4010908@linux.vnet.ibm.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com> <20120601091008.31979.93586.stgit@srivatsabhat.in.ibm.com> <20120601165322.GB18870@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:41332 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965856Ab2FAWmU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jun 2012 18:42:20 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Sat, 2 Jun 2012 04:12:18 +0530
In-Reply-To: <20120601165322.GB18870@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com, Suresh Siddha <suresh.b.siddha@intel.com>, Venkatesh Pallipadi <venki@google.com>

On 06/01/2012 10:23 PM, Sam Ravnborg wrote:

>> +
>> +
>> +/* Implement the following functions in your architecture, as appropriate. */
>> +
>> +/**
>> + * __cpu_pre_starting()
>> + *
>> + * Implement whatever you need to do before the CPU_STARTING notifiers are
>> + * invoked. Note that the CPU_STARTING callbacks run *on* the cpu that is
>> + * coming up. So that cpu better be prepared! IOW, implement all the early
>> + * boot/init code for the cpu here. And do NOT enable interrupts.
>> + */
>> +#ifndef __cpu_pre_starting
>> +void __weak __cpu_pre_starting(void *arg) {}
>> +#endif
> 
> I miss the prototype for this in a header?


Prototype is not really necessary for this. Hence not added.

> And the comment maybe belong in the header - not in the implementation?
> 


I think having the comment near the implementation itself works better, just
like how it is done at other places in the kernel.

Regards,
Srivatsa S. Bhat
