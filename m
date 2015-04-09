From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH] qrwlock: Fix bug in interrupt handling code
Date: Thu, 09 Apr 2015 18:09:55 -0400
Message-ID: <5526F8B3.3060903@hp.com>
References: <1428610075-38957-1-git-send-email-Waiman.Long@hp.com> <20150409201405.GU21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g1t5424.austin.hp.com ([15.216.225.54]:52794 "EHLO
	g1t5424.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbbDIWKA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2015 18:10:00 -0400
In-Reply-To: <20150409201405.GU21418@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On 04/09/2015 04:14 PM, Peter Zijlstra wrote:
> On Thu, Apr 09, 2015 at 04:07:55PM -0400, Waiman Long wrote:
>> The qrwlock is fair in the process context, but becoming unfair when
>> in the interrupt context to support use cases like the tasklist_lock.
>> However, the unfair code in the interrupt context has problem that
>> may cause deadlock.
>>
>> The fast path increments the reader count. In the interrupt context,
>> the reader in the slowpath will wait until the writer release the
>> lock. However, if other readers have the lock and the writer is just
>> in the waiting mode. It will never get the write lock because the
>> that interrupt context reader has increment the count. This will
>> cause deadlock.
>>
>> This patch fixes this problem by checking the state of the
>> reader/writer count retrieved at the fast path. If the writer
>> is in waiting mode, the reader will get the lock immediately and
>> return. Otherwise, it will wait until the writer release the lock
>> like before.
> A little word on how you found this issue would be nice.

It is not found by testing. I didn't see any problem with a running 
Linux kernel so far.

I am in the process of trying to make the qrwlock lock unfair in virt. 
When I inspect the code, I found out that the interrupt code didn't look 
right. That is why I send out a patch to fix that.

Regards,
Longman
