From: Enke Chen <enkechen@cisco.com>
Subject: Re: [PATCH v2] kernel/signal: Signal-based pre-coredump notification
Date: Wed, 24 Oct 2018 16:50:26 -0700
Message-ID: <df08c74f-1027-c635-fb99-a12d23f60947@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <87sh0vpj5q.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87sh0vpj5q.fsf@xmission.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, "Kirill A. Shutemov" <kirill.shu>
List-Id: linux-arch.vger.kernel.org

Hi, Eric:

Thanks for your comments. Please see my replies inline.

On 10/24/18 6:29 AM, Eric W. Biederman wrote:
> Enke Chen <enkechen@cisco.com> writes:
> 
>> For simplicity and consistency, this patch provides an implementation
>> for signal-based fault notification prior to the coredump of a child
>> process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
>> be used by an application to express its interest and to specify the
>> signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
>> signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.
>>
>> Changes to prctl(2):
>>
>>    PR_SET_PREDUMP_SIG (since Linux 4.20.x)
>>           Set the child pre-coredump signal of the calling process to
>>           arg2 (either SIGUSR1, or SIUSR2, or SIGCHLD, or 0 to clear).
>>           This is the signal that the calling process will get prior to
>>           the coredump of a child process. This value is cleared across
>>           execve(2), or for the child of a fork(2).
>>
>>           When SIGCHLD is specified, the signal code will be set to
>>           CLD_PREDUMP in such an SIGCHLD signal.
> 
> Your signal handling is still not right.  Please read and comprehend
> siginfo_layout.
> 
> You have not filled in all of the required fields for the SIGCHLD case.
> For the non SIGCHLD case you are using si_code == 0 == SI_USER which is
> very wrong.  This is not a user generated signal.
> 
> Let me say this slowly.  The pair si_signo si_code determines the union
> member of struct siginfo.  That needs to be handled consistently. You
> aren't.  I just finished fixing this up in the entire kernel and now you
> are trying to add a usage that is worst than most of the bugs I have
> fixed.  I really don't appreciate having to deal with no bugs.
> 

My apologies. I will investigate and make them consistent.

> 
> 
> Further siginfo can be dropped.  Multiple signals with the same signal
> number can be consolidated.  What is your plan for dealing with that?

The primary application for the early notification involves a process
manager which is responsible for re-spawning processes or initiating
the control-plane fail-over. There are two models:

One model is to have 1:1 relationship between a process manager and
application process. There can only be one predump-signal (say, SIGUSR1)
from the child to the parent, and will unlikely be dropped or consolidated.

Another model is to have 1:N where there is only one process manager with
multiple application processes. One of the RT signal can be used to help
make it more reliable.

> Other code paths pair with wait to get the information out.  There
> is no equivalent of wait in your code.

I was not aware of that before.  Let me investigate.

> 
> Signals can be delayed by quite a bit, scheduling delays etc.  They can
> not provide any meaningful kind of real time notification.
> 

The timing requirement is about 50-100 msecs for BFD.  Not sure if that
qualifies as "real time".  This mechanism has worked well in deployment
over the years.

> So between delays and loss of information signals appear to be a very
> poor fit for this usecase.
> 
> I am concerned about code that does not fit the usecase well because
> such code winds up as code that no one cares about that must be
> maintained indefinitely, because somewhere out there there is one use
> that would break if the interface was removed.  This does not feel like
> an interface people will want to use and maintain in proper working
> order forever.
> 
> Ugh.  Your test case is even using signalfd.  So you don't even want
> this signal to be delivered as a signal.

I actually tested sigaction()/waitpid() as well. If there is a preference,
I can check in the sigaction()/waitpid() version instead.

> 
> You add an interface that takes a pointer and you don't add a compat
> interface.  See Oleg's point of just returning the signal number in the
> return code.

This is what Oleg said "but I won't insist, this is subjective and cosmetic".

It is no big deal either way. It just seems less work if we do not keep
adding exceptions to the prctl(2) manpage:
 
prctl(2):

       On success, PR_GET_DUMPABLE,   PR_GET_KEEPCAPS,   PR_GET_NO_NEW_PRIVS,   PR_CAPBSET_READ,    PR_GET_TIMING,    PR_GET_SECUREBITS,
       PR_MCE_KILL_GET,  PR_CAP_AMBIENT+PR_CAP_AMBIENT_IS_SET,  and  (if  it returns) PR_GET_SECCOMP return the nonnegative values described
       above.  All other option values return 0 on success.  On error, -1 is returned, and errno is set appropriately.

> 
> Now I am wondering how well prctl works from a 32bit process on a 64bit
> kernel.  At first glance it looks like it probably does not work.
>

I am not sure which part would be problematic.

> Consistency with PDEATHSIG is not a good argument for anything.
> PDEATHSIG at the present time is unusable in the real world by most
> applications that want something like it.

Agreed, PDEATHSIG seems to have a few issues ...

> 
> So far I see an interface that even you don't want to use as designed,
> that is implemented incorrectly.
> 
> The concern is real and deserves to be addressed.  I don't think signals
> are the right way to handle it, and certainly not this patch as it
> stands.

I will address your concerns on the patch. Regarding the requirement and the
overall solution, if there are specific questions that I have not answered,
please let me know.

Thanks. -- Enke
