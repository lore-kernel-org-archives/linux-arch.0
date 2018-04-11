From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Q: Do si_time and si_utime need to be 64bit for y2038?
Date: Wed, 11 Apr 2018 22:13:52 +0200
Message-ID: <CAK8P3a2HaYDOnWYb5cagJeHKmeoWAz1MGzGfGwbeymEqDpvWzw@mail.gmail.com>
References: <87d0z6ttxe.fsf@xmission.com> <CALCETrVR1qHCndoaqXWosy8ckMTyT2RequQTgg0MZUw_sMPwwQ@mail.gmail.com>
 <87bmepn2o8.fsf_-_@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87bmepn2o8.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 11, 2018 at 6:11 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Arnd,
>
> I am looking at the siginfo si_utime and si_stime fields of type clock_t
> on 32bit architectures except for x32 these are 32bit fields.  For y2038
> do we want to extend these fields to 64bit like x32 does?  Or is it not
> a problem for these fields to be 32bit?

Short answer: I think we're fine without changing it, at least for y2038.

> I care right now because I am trying to figure out how
> copy_siginfo_to_user32 and copy_siginfo_to_user need to evolve.
>
> If we are going to extend existing architectures with 64bit variations
> of si_utime and si_stime copy_siginfo_to_user and copy_siginfo_to_user32
> needs an additional parameter describing which variant they should be
> copying.
>
> It looks like posix does not define si_stime and and si_utime so we only
> have to be backwards compatible with ourselves for whatever that is
> worth.
>
> I am wondering if perhaps the general solution might be to just add
> two extra fields si_stime64 and si_utime64 and always fill those in.
>
> Arnd do you have any ideas?

There are generally four areas to be aware of with the data structure
changes required for y2038:

1. Stuff that overflows in the next few decades (either 2038 or some other
    year). si_utime/si_stime counts relative times, so there is no overflow
    happening at a particular date that we have to be aware of. However,
    it does overflow when a 32-bit process runs for more than
    (LONG_MAX / USER_HZ) seconds, which is about 248 days.
    When you have a large SMP system with 256 CPUs and run a single
    task across all of them, the overflow happens within one day of runtime.
    This is a rare use case for 32-bit tasks, but it is an actual limitation
    that we may want to fix regardless of the y2038 changes.

2. Types that don't overflow in a particular interface (because they count
    relative times) but do overflow in others. We have a problem in
    wait4()/waidid() and getrusage() here, since those use 'struct timeval'
    to count process times. Those can count up to 68 years of process
    times (97 days on a 256-core machine running one task), so we
    probably don't care about the overflow, but POSIX requires the
    use of timeval [1] and we have to redefine that structure with an
    incompatible layout.
    We do have a choice between either keeping the existing structure
    and letting the libc translate the 32-bit time_t to a 64-bit time_t,
    or adding replacement syscalls for both getrusage() and waitid().
    IIRC we don't need a new wait4(), since that can be implemented
    using waitid.
    clock_t is used in exactly two places: struct siginfo and struct tms,
    so if we change one of the two, we also have to change the other.

3. In some cases, two structures are almost identical between 32-bit
    and 64-bit architectures. Using the exact same layout simplifies the
    compat syscall handling. I think in x32, this was a factor as it means
    that e.g. times() is shared between x32 and x86-64.

4. If we change an interface, we may want to improve it in more than
   one way, like we did with stat()->stat64()->statx() or time()->
   gettimeofday()->clock_gettime()->clock_gettime64().
   If we introduce a larger range for the 32-bit siginfo and tms
   structures, we could also consider extending the resolution to
   nanoseconds. I wouldn't follow rusage's timeval but use
   timespec64 (__kernel_timespec as seen from user space).
   64-bit nanoseconds are another option, but that again
   overflows after 584 CPU-years or 52 days on a 4096-core
   system.

         Arnd

[1] http://pubs.opengroup.org/onlinepubs/009696699/basedefs/sys/resource.h.html
