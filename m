From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 1/4] locking/qspinlock: Handle > 4 slowpath nesting
 levels
Date: Wed, 23 Jan 2019 15:11:19 -0500
Message-ID: <63131030-bd24-34bf-10dc-b5e7c7c177be@redhat.com>
References: <1548215351-18896-1-git-send-email-longman@redhat.com>
 <1548215351-18896-2-git-send-email-longman@redhat.com>
 <20190123093424.GE15019@brain-police>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190123093424.GE15019@brain-police>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>, James Morse <james.morse@arm.com>, SRINIVAS <srinivas.eeda@oracle.com>
List-Id: linux-arch.vger.kernel.org

On 01/23/2019 04:34 AM, Will Deacon wrote:
> On Tue, Jan 22, 2019 at 10:49:08PM -0500, Waiman Long wrote:
>> Four queue nodes per cpu are allocated to enable up to 4 nesting levels
>> using the per-cpu nodes. Nested NMIs are possible in some architectures.
>> Still it is very unlikely that we will ever hit more than 4 nested
>> levels with contention in the slowpath.
>>
>> When that rare condition happens, however, it is likely that the system
>> will hang or crash shortly after that. It is not good and we need to
>> handle this exception case.
>>
>> This is done by spinning directly on the lock using repeated trylock.
>> This alternative code path should only be used when there is nested
>> NMIs. Assuming that the locks used by those NMI handlers will not be
>> heavily contended, a simple TAS locking should work out.
>>
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  kernel/locking/qspinlock.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>> index 8a8c3c2..0875053 100644
>> --- a/kernel/locking/qspinlock.c
>> +++ b/kernel/locking/qspinlock.c
>> @@ -412,6 +412,21 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>>  	idx = node->count++;
>>  	tail = encode_tail(smp_processor_id(), idx);
> Does the compiler generate better code if we move the tail assignment
> further down, closer to the xchg_tail() call?
>
>> +	/*
>> +	 * 4 nodes are allocated based on the assumption that there will
>> +	 * not be nested NMIs taking spinlocks. That may not be true in
>> +	 * some architectures even though the chance of needing more than
>> +	 * 4 nodes will still be extremely unlikely. When that happens,
>> +	 * we fall back to spinning on the lock directly without using
>> +	 * any MCS node. This is not the most elegant solution, but is
>> +	 * simple enough.
>> +	 */
>> +	if (unlikely(idx >= MAX_NODES)) {
>> +		while (!queued_spin_trylock(lock))
>> +			cpu_relax();
>> +		goto release;
>> +	}
> Acked-by: Will Deacon <will.deacon@arm.com>
>
> Will

Looking at the generated x86 code:

424        if (unlikely(idx >= MAX_NODES)) {
   0x00000000000003ce <+206>:    test   %ecx,%ecx
   0x00000000000003d0 <+208>:    jg     0x4c6
<native_queued_spin_lock_slowpath+454>

425            qstat_inc(qstat_lock_no_node, true);
426            while (!queued_spin_trylock(lock))

   0x00000000000004c2 <+450>:    jne    0x482
<native_queued_spin_lock_slowpath+386>
   0x00000000000004c4 <+452>:    jmp    0x491
<native_queued_spin_lock_slowpath+401>
   0x00000000000004c6 <+454>:    incq   %gs:0x0(%rip)        # 0x4ce
<native_queued_spin_lock_slowpath+462>
   0x00000000000004ce <+462>:    mov    $0x1,%edx
   0x00000000000004d3 <+467>:    jmp    0x4d7
<native_queued_spin_lock_slowpath+471>
   0x00000000000004d5 <+469>:    pause 
   0x00000000000004d7 <+471>:    mov    (%rdi),%eax
   0x00000000000004d9 <+473>:    test   %eax,%eax
   0x00000000000004db <+475>:    jne    0x4d5
<native_queued_spin_lock_slowpath+469>
   0x00000000000004dd <+477>:    lock cmpxchg %edx,(%rdi)
   0x00000000000004e1 <+481>:    jne    0x4d5
<native_queued_spin_lock_slowpath+469>
   0x00000000000004e3 <+483>:    jmp    0x491
<native_queued_spin_lock_slowpath+4

MAX_NODES was modified to 1 in the test kernel.

So the additional code checks the idx value and branch to the end of the
function when the condition is true. There isn't too much overhead here.

Cheers,
Longman
