From: Enke Chen <enkechen@cisco.com>
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
Date: Mon, 15 Oct 2018 17:54:43 -0700
Message-ID: <6211eeaa-ce07-a909-e4c2-172618ddfb95@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <87va62lri4.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87va62lri4.fsf@xmission.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, Kirill A. Shute
List-Id: linux-arch.vger.kernel.org

Hi, Eric:

On 10/15/18 4:28 PM, Eric W. Biederman wrote:
> Enke Chen <enkechen@cisco.com> writes:
> 
>> For simplicity and consistency, this patch provides an implementation
>> for signal-based fault notification prior to the coredump of a child
>> process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
>> be used by an application to express its interest and to specify the
>> signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
>> signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.
>>
>> Background:
>>
>> As the coredump of a process may take time, in certain time-sensitive
>> applications it is necessary for a parent process (e.g., a process
>> manager) to be notified of a child's imminent death before the coredump
>> so that the parent process can act sooner, such as re-spawning an
>> application process, or initiating a control-plane fail-over.
> 
> You talk about time senstive and then you talk about bash scripts.
> I don't think your definition of time-sensitive and my definition match.

It's certainly not my preference to have a process manager (or one for each
application) written in bash scripts. But they do work, and are deployed.

> 
> With that said I think the best solution would be to figure out how to
> allow the coredump to run in parallel with the usual exit signal, and
> exit code reaping of the process> 
> That would solve the problem for everyone, and would not introduce any
> new complicated APIs.

That would certainly help. But given the huge deployment of Linux, I don't
think it would be feasible to change this fundamental behavior (signal post
coredump).

> 
> Short of that having the prctl in the process that receives the signals
> they you are doing is the right way to go.

Thanks for for the encouragement.

> 
> You are however calling do_notify_parent_predump from the wrong
> function, and frankly with the wrong locking.  There are multiple paths
> to the do_coredump function so you really want this notification from
> do_coredump.

This makes two - Oleg also suggested doing it in do_coredump().
I will look into it, perhaps also relocated proc_coredump_connector().

> 
> But I still think it would be better to solve the root cause problem and
> change the coredump logic to be able to run in parallel with the normal
> exit notification and zombie reaping logic.  Then the problem you are
> trying to solve goes away and everyone's code gets simpler.
> 
> Eric
> 

Thanks.  -- Enke
