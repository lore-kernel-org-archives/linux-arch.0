From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH tip/core/rcu 1/3] membarrier: Provide register expedited
 private command
Date: Thu, 5 Oct 2017 15:54:38 +0000 (UTC)
Message-ID: <1765353553.31703.1507218878562.JavaMail.zimbra@efficios.com>
References: <20171004213734.GA11463@linux.vnet.ibm.com> <1507153075-12345-1-git-send-email-paulmck@linux.vnet.ibm.com> <20171005142325.5a407f18@roar.ozlabs.ibm.com> <64c8984c-7140-ccce-513f-6b3f601257a7@scylladb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.142.141]:51386 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbdJEPxH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Oct 2017 11:53:07 -0400
In-Reply-To: <64c8984c-7140-ccce-513f-6b3f601257a7@scylladb.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Avi Kivity <avi@scylladb.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, dipankar <dipankar@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, rostedt <rostedt@goodmis.org>, David Howells <dhowells@redhat.com>, Eric Dumazet <edumazet@google.com>, fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

----- On Oct 5, 2017, at 8:22 AM, Avi Kivity avi@scylladb.com wrote:

> On 10/05/2017 07:23 AM, Nicholas Piggin wrote:
>> On Wed,  4 Oct 2017 14:37:53 -0700
>> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
>>
>>> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>
>>> Provide a new command allowing processes to register their intent to use
>>> the private expedited command.
>>>
>>> This allows PowerPC to skip the full memory barrier in switch_mm(), and
>>> only issue the barrier when scheduling into a task belonging to a
>>> process that has registered to use expedited private.
>>>
>>> Processes are now required to register before using
>>> MEMBARRIER_CMD_PRIVATE_EXPEDITED, otherwise that command returns EPERM.
>>>
>>> Changes since v1:
>>> - Use test_ti_thread_flag(next, ...) instead of test_thread_flag() in
>>>    powerpc membarrier_arch_sched_in(), given that we want to specifically
>>>    check the next thread state.
>>> - Add missing ARCH_HAS_MEMBARRIER_HOOKS in Kconfig.
>>> - Use task_thread_info() to pass thread_info from task to
>>>    *_ti_thread_flag().
>>>
>>> Changes since v2:
>>> - Move membarrier_arch_sched_in() call to finish_task_switch().
>>> - Check for NULL t->mm in membarrier_arch_fork().
>>> - Use membarrier_sched_in() in generic code, which invokes the
>>>    arch-specific membarrier_arch_sched_in(). This fixes allnoconfig
>>>    build on PowerPC.
>>> - Move asm/membarrier.h include under CONFIG_MEMBARRIER, fixing
>>>    allnoconfig build on PowerPC.
>>> - Build and runtime tested on PowerPC.
>>>
>>> Changes since v3:
>>> - Simply rely on copy_mm() to copy the membarrier_private_expedited mm
>>>    field on fork.
>>> - powerpc: test thread flag instead of reading
>>>    membarrier_private_expedited in membarrier_arch_fork().
>>> - powerpc: skip memory barrier in membarrier_arch_sched_in() if coming
>>>    from kernel thread, since mmdrop() implies a full barrier.
>>> - Set membarrier_private_expedited to 1 only after arch registration
>>>    code, thus eliminating a race where concurrent commands could succeed
>>>    when they should fail if issued concurrently with process
>>>    registration.
>>> - Use READ_ONCE() for membarrier_private_expedited field access in
>>>    membarrier_private_expedited. Matches WRITE_ONCE() performed in
>>>    process registration.
>>>
>>> Changes since v4:
>>> - Move powerpc hook from sched_in() to switch_mm(), based on feedback
>>>    from Nicholas Piggin.
>> For now, the powerpc approach is okay by me. I plan to test
>> others (e.g., taking runqueue locks) on larger systems, but that can
>> be sent as an incremental patch at a later time.
>>
>> The main thing I would like is for people to review the userspace API.
>>
> 
> As a future satisfied user of the expedited private membarrier syscall,
> I am happy with the change.

Thanks Avi for your input on the userspace API.

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
