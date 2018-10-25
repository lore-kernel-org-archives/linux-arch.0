From: Enke Chen <enkechen@cisco.com>
Subject: Re: [PATCH v2] kernel/signal: Signal-based pre-coredump notification
Date: Thu, 25 Oct 2018 14:24:19 -0700
Message-ID: <3da93f7c-972d-14e0-dae2-f0217ba03dc1@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <87sh0vpj5q.fsf@xmission.com>
 <df08c74f-1027-c635-fb99-a12d23f60947@cisco.com>
 <87zhv2md04.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87zhv2md04.fsf@xmission.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, "Kirill A. Shutemov" <kirill.shu>
List-Id: linux-arch.vger.kernel.org

Hi, Eric:

I have a couple comments inlined.

>> On Wed, Oct 24, 2018 at 3:30 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>> Enke Chen <enkechen@cisco.com> writes:
>>>> For simplicity and consistency, this patch provides an implementation
>>>> for signal-based fault notification prior to the coredump of a child
>>>> process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
>>>> be used by an application to express its interest and to specify the
>>>> signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
>>>> signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.
>>>>
>>>> Changes to prctl(2):
>>>>
>>>>    PR_SET_PREDUMP_SIG (since Linux 4.20.x)
>>>>           Set the child pre-coredump signal of the calling process to
>>>>           arg2 (either SIGUSR1, or SIUSR2, or SIGCHLD, or 0 to clear).
>>>>           This is the signal that the calling process will get prior to
>>>>           the coredump of a child process. This value is cleared across
>>>>           execve(2), or for the child of a fork(2).
>>>>
>>>>           When SIGCHLD is specified, the signal code will be set to
>>>>           CLD_PREDUMP in such an SIGCHLD signal.
>> [...]
>>> Ugh.  Your test case is even using signalfd.  So you don't even want
>>> this signal to be delivered as a signal.
>>
>> Just to make sure everyone's on the same page: You're suggesting that
>> it might make sense to deliver the pre-dump notification via a new
>> type of file instead (along the lines of signalfd, timerfd, eventfd
>> and so on)?
> 
> My real complaint was that the API was not being tested in the way it
> is expected to be used.  Which makes a test pretty much useless as some
> aspect userspace could regress and the test would not notice because it
> is testing something different.
> 
> 

As I stated in a prior email, I have test code for both sigaction/waipid(),
and signefd(). As the sigaction/waitpid is more widely used and that is
what you prefer, I will change the selftest code to reflect that in the
next version.  Actually I should separate out the selftest code.

> 
> I do think that a file descriptor based API might be a good alternative
> to a signal based API.  The proc connector and signals are not the only
> API solution.
> 
> The common solution to this problem is that distributions defailt the
> rlimit core file size to 0.

We do need coredumps in order to have the bugs fixed.

Thanks.  -- Enke
