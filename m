From: Enke Chen <enkechen@cisco.com>
Subject: Re: [PATCH v3] kernel/signal: Signal-based pre-coredump notification
Date: Wed, 24 Oct 2018 15:02:29 -0700
Message-ID: <b6908962-84e3-3791-e827-2f463bb50eb2@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
 <20181024140214.GG30128@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181024140214.GG30128@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@s>
List-Id: linux-arch.vger.kernel.org

Hi, Oleg:

On 10/24/18 7:02 AM, Oleg Nesterov wrote:
> On 10/23, Enke Chen wrote:
>>
>> --- a/fs/coredump.c
>> +++ b/fs/coredump.c
>> @@ -590,6 +590,12 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>  	if (retval < 0)
>>  		goto fail_creds;
>>
>> +	/*
>> +	 * Send the pre-coredump signal to the parent if requested.
>> +	 */
>> +	do_notify_parent_predump();
>> +	cond_resched();
> 
> I am still not sure cond_resched() makes any sense here...
> 
>> @@ -1553,6 +1553,9 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
>>  	tty_audit_fork(sig);
>>  	sched_autogroup_fork(sig);
>>
>> +	/* Clear the pre-coredump signal for the child */
>> +	sig->predump_signal = 0;
> 
> No need, copy_signal() does zalloc().
> 

Removed.

> 
>> +void do_notify_parent_predump(void)
>> +{
>> +	struct sighand_struct *sighand;
>> +	struct kernel_siginfo info;
>> +	struct task_struct *parent;
>> +	unsigned long flags;
>> +	int sig;
>> +
>> +	read_lock(&tasklist_lock);
>> +	parent = current->parent;
>> +	sig = parent->signal->predump_signal;
>> +	if (sig != 0) {
>> +		clear_siginfo(&info);
>> +		info.si_pid = task_tgid_vnr(current);
>> +		info.si_signo = sig;
>> +		if (sig == SIGCHLD)
>> +			info.si_code = CLD_PREDUMP;
>> +
>> +		sighand = parent->sighand;
>> +		spin_lock_irqsave(&sighand->siglock, flags);
>> +		__group_send_sig_info(sig, &info, parent);
>> +		spin_unlock_irqrestore(&sighand->siglock, flags);
> 
> You can just use do_send_sig_info() and remove sighand/flags/spin_lock_irqsave.

Ok.

> 
> Perhaps the "likely" predump_signal==0 check at the start makes sense to avoid
> read_lock(tasklist).

I am not sure if we should/need to deviate from the convention (locking before
access the parent). In any case it may not matter as the coredump is in the
exceptional code flow.

> 
> And I'd suggest to move it into coredump.c and make it static. It won't have
> another user.

Ok.

Thanks.  -- Enke
