From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 1/2] qspinlock: Introducing a 4-byte queue spinlock
 implementation
Date: Fri, 02 Aug 2013 08:30:32 +0530
Message-ID: <51FB20D0.5070306@linux.vnet.ibm.com>
References: <1375324631-32868-1-git-send-email-Waiman.Long@hp.com> <1375324631-32868-2-git-send-email-Waiman.Long@hp.com> <51FAC3BA.9050705@linux.vnet.ibm.com> <51FACE78.9070901@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:58715 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649Ab3HBCyZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Aug 2013 22:54:25 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <raghavendra.kt@linux.vnet.ibm.com>;
	Fri, 2 Aug 2013 12:43:52 +1000
In-Reply-To: <51FACE78.9070901@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Richard Weinberger <richard@nod.at>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matt Fleming <matt.fleming@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Akinobu Mita <akinobu.mita@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, George Spelvin <linux@horizon.com>Harvey Harrison <har>

On 08/02/2013 02:39 AM, Waiman Long wrote:
> On 08/01/2013 04:23 PM, Raghavendra K T wrote:
>> On 08/01/2013 08:07 AM, Waiman Long wrote:
[..]
>>
>> Though I could see some gains in overcommit, but it hurted undercommit
>> in some workloads :(.
>
> The gcc 4.4.7 compiler that I used in my test machine has the tendency
> of allocating stack space for variables instead of using registers when
> a loop is present. So I try to avoid having loop in the fast path. Also
> the count itself is rather arbitrary. For the first pass, I would like
> to make thing simple. We can always enhance it once it is accepted and
> merged.

Yes. agree.

>>
>> I have not yet tested on bigger machine. I hope that bigger machine will
>> see significant undercommit improvements.
>>
>
> Thank for running the test. I am a bit confused about the terminology.
> What exactly do undercommit and overcommit mean?
>

Undercommit means I meant total #vcpu < #pcpus in virtual env. so
overcommit should not be an issue in baremetal.
