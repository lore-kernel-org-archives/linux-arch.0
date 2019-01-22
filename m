From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH] RISC-V: Add _TIF_NEED_RESCHED check for kernel thread when CONFIG_PREEMPT=y
Date: Tue, 22 Jan 2019 10:58:51 -0800 (PST)
Message-ID: <mhng-fd3c9beb-34ce-40c5-92ce-0a7d76d877aa@palmer-si-x1c4>
References: <20190103054555.GA30904@roeck-us.net>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103054555.GA30904@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@roeck-us.net
Cc: vincentc@andestech.com, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 02 Jan 2019 21:45:55 PST (-0800), linux@roeck-us.net wrote:
> On Thu, Jan 03, 2019 at 11:32:33AM +0800, Vincent Chen wrote:
>> The cond_resched() can be used to yield the CPU resource if
>> CONFIG_PREEMPT is not defined. Otherwise, cond_resched() is a dummy
>> function. In order to avoid kernel thread occupying entire CPU,
>> when CONFIG_PREEMPT=y, the kernel thread needs to follow the
>> rescheduling mechanism like a user thread.
>>
>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>
> This patch seems to do the trick. I no longer see a problem with
> CONFIG_PREEMPT=y and the various lock torture tests enabled, as
> previously reported.
>
> Nice catch and fix.
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
>
> Guenter
>
>> ---
>>  arch/riscv/kernel/asm-offsets.c |    1 +
>>  arch/riscv/kernel/entry.S       |   18 +++++++++++++++++-
>>  2 files changed, 18 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
>> index 6a92a2f..dac9834 100644
>> --- a/arch/riscv/kernel/asm-offsets.c
>> +++ b/arch/riscv/kernel/asm-offsets.c
>> @@ -39,6 +39,7 @@ void asm_offsets(void)
>>  	OFFSET(TASK_STACK, task_struct, stack);
>>  	OFFSET(TASK_TI, task_struct, thread_info);
>>  	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
>> +	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
>>  	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
>>  	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
>>  	OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> index 13d4826..728b72d 100644
>> --- a/arch/riscv/kernel/entry.S
>> +++ b/arch/riscv/kernel/entry.S
>> @@ -144,6 +144,10 @@ _save_context:
>>  	REG_L x2,  PT_SP(sp)
>>  	.endm
>>
>> +#if !IS_ENABLED(CONFIG_PREEMPT)
>> +#define resume_kernel restore_all
>> +#endif
>> +

I don't like preprocessor stuff if we can avoid it, are you OK if I squash in 
the following diff:

    diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
    index cfbad2f689c3..fd9b57c8b4ce 100644
    --- a/arch/riscv/kernel/entry.S
    +++ b/arch/riscv/kernel/entry.S
    @@ -145,7 +145,7 @@ _save_context:
     	.endm
    
     #if !IS_ENABLED(CONFIG_PREEMPT)
    -#define resume_kernel restore_all
    +.set resume_kernel, restore_all
     #endif
    
     ENTRY(handle_exception)

I think that should do the same thing, but at link time instead of in the 
preprocessor -- that makes it a bit less likely to bit us in the future.

>>  ENTRY(handle_exception)
>>  	SAVE_ALL
>>
>> @@ -228,7 +232,7 @@ ret_from_exception:
>>  	REG_L s0, PT_SSTATUS(sp)
>>  	csrc sstatus, SR_SIE
>>  	andi s0, s0, SR_SPP
>> -	bnez s0, restore_all
>> +	bnez s0, resume_kernel
>>
>>  resume_userspace:
>>  	/* Interrupts must be disabled here so flags are checked atomically */
>> @@ -250,6 +254,18 @@ restore_all:
>>  	RESTORE_ALL
>>  	sret
>>
>> +#if IS_ENABLED(CONFIG_PREEMPT)
>> +resume_kernel:
>> +	REG_L s0, TASK_TI_PREEMPT_COUNT(tp)
>> +	bnez s0, restore_all
>> +need_resched:
>> +	REG_L s0, TASK_TI_FLAGS(tp)
>> +	andi s0, s0, _TIF_NEED_RESCHED
>> +	beqz s0, restore_all
>> +	call preempt_schedule_irq
>> +	j need_resched
>> +#endif
>> +
>>  work_pending:
>>  	/* Enter slow path for supplementary processing */
>>  	la ra, ret_from_exception

I'm just going to assume you're OK with the squash and drop this into my plans 
for the next RC, let me know if that's not OK.

Thanks for fixing this!
