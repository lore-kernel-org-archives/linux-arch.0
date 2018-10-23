From: Enke Chen <enkechen@cisco.com>
Subject: Re: [PATCH v2] kernel/signal: Signal-based pre-coredump notification
Date: Tue, 23 Oct 2018 14:40:10 -0700
Message-ID: <a7cd5312-f743-cf57-7945-c2964026f652@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <20181023092348.GA14340@redhat.com>
 <1e68a3ce-32cd-b058-3d1d-36455ceca848@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1e68a3ce-32cd-b058-3d1d-36455ceca848@cisco.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@s>
List-Id: linux-arch.vger.kernel.org

Hi, Oleg:

On 10/23/18 12:43 PM, Enke Chen wrote:

>>
>>> --- a/fs/coredump.c
>>> +++ b/fs/coredump.c
>>> @@ -546,6 +546,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>>  	struct cred *cred;
>>>  	int retval = 0;
>>>  	int ispipe;
>>> +	bool notify;
>>>  	struct files_struct *displaced;
>>>  	/* require nonrelative corefile path and be extra careful */
>>>  	bool need_suid_safe = false;
>>> @@ -590,6 +591,15 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>>  	if (retval < 0)
>>>  		goto fail_creds;
>>>
>>> +	/*
>>> +	 * Send the pre-coredump signal to the parent if requested.
>>> +	 */
>>> +	read_lock(&tasklist_lock);
>>> +	notify = do_notify_parent_predump(current);
>>> +	read_unlock(&tasklist_lock);
>>> +	if (notify)
>>> +		cond_resched();
>>
>> Hmm. I do not understand why do we need cond_resched(). And even if we need it,
>> why we can't call it unconditionally?
> 
> Remember the goal is to allow the parent (e.g., a process manager) to take early
> action. The "yield" before doing coredump will help.
> 
> The yield is made conditional because the notification is conditional.
> Is that ok?

Given this is in do_coredump(), it is ok to make it unconditional for simplicity.

>>
>>> +bool do_notify_parent_predump(struct task_struct *tsk)
>>> +{
>>> +	struct sighand_struct *sighand;
>>> +	struct kernel_siginfo info;
>>> +	struct task_struct *parent;
>>> +	unsigned long flags;
>>> +	pid_t pid;
>>> +	int sig;
>>> +
>>> +	parent = tsk->parent;
>>> +	sighand = parent->sighand;
>>> +	pid = task_tgid_vnr(tsk);
>>> +
>>> +	spin_lock_irqsave(&sighand->siglock, flags);
>>> +	sig = parent->signal->predump_signal;
>>> +	if (!valid_predump_signal(sig)) {
>>> +		spin_unlock_irqrestore(&sighand->siglock, flags);
>>> +		return false;
>>> +	}
>>
>> Why do we need to check parent->signal->predump_signal under ->siglock?
>> This complicates the code for no reason, afaics.

Will simplify.

Thanks.  -- Enke
