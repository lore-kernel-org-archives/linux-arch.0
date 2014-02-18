From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v4 0/3] qspinlock: Introducing a 4-byte queue spinlock
Date: Tue, 18 Feb 2014 14:27:30 -0500
Message-ID: <5303B422.2010304@hp.com>
References: <1392669684-4807-1-git-send-email-Waiman.Long@hp.com> <53029167.4060109@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:54154 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbaBRT15 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 Feb 2014 14:27:57 -0500
In-Reply-To: <53029167.4060109@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Daniel J Blueman <daniel@numascale.com>, Alexander Fyodorov <halcy@yandex.ru>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>

On 02/17/2014 05:47 PM, H. Peter Anvin wrote:
> On 02/17/2014 12:41 PM, Waiman Long wrote:
>> v3->v4:
>>   - Remove debugging code and fix a configuration error
>>   - Simplify the qspinlock structure and streamline the code to make it
>>     perform a bit better
>>   - Add an x86 version of asm/qspinlock.h for holding x86 specific
>>     optimization.
>>   - Add an optimized x86 code path for 2 contending tasks to improve
>>     low contention performance.
>>
>> v2->v3:
>>   - Simplify the code by using numerous mode only without an unfair option.
>>   - Use the latest smp_load_acquire()/smp_store_release() barriers.
>>   - Move the queue spinlock code to kernel/locking.
>>   - Make the use of queue spinlock the default for x86-64 without user
>>     configuration.
>>   - Additional performance tuning.
>>
>> v1->v2:
>>   - Add some more comments to document what the code does.
>>   - Add a numerous CPU mode to support>= 16K CPUs
>>   - Add a configuration option to allow lock stealing which can further
>>     improve performance in many cases.
>>   - Enable wakeup of queue head CPU at unlock time for non-numerous
>>     CPU mode.
>>
>> This patch set introduces a queue-based spinlock implementation that
>> can replace the default ticket spinlock without increasing the size
>> of the spinlock data structure. As a result, critical kernel data
>> structures that embed spinlock won't increase in size and breaking
>> data alignments.
>>
> This is starting to look good, so I have pulled it into
> tip:x86/spinlocks to start give it some testing mileage.
>
> 	-hpa
>
>

Thank for the additional testing. Please let me know if you find 
anything wrong.

-Longman
