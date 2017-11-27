Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33213 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752750AbdK0Ul4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 15:41:56 -0500
MIME-Version: 1.0
In-Reply-To: <87o9nnlfpq.fsf@xmission.com>
References: <20171127170121.634826-1-arnd@arndb.de> <20171127170121.634826-3-arnd@arndb.de>
 <34369a6e-e0ce-fe7b-65e3-9c4a33e4789a@cs.ucla.edu> <87o9nnlfpq.fsf@xmission.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 27 Nov 2017 21:41:54 +0100
Message-ID: <CAK8P3a1asMLnJtea=JkduiYzr0dF0BTKQzcx5aQVv1zU5dK2FA@mail.gmail.com>
Subject: Re: [PATCH 3/3] y2038: rusage: use __kernel_old_timeval for process times
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Paul Eggert <eggert@cs.ucla.edu>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, y2038 Mailman List <y2038@lists.linaro.org>, GNU C Library <libc-alpha@sourceware.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Albert ARIBAUD <albert.aribaud@3adev.fr>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Kirill Tkhai <ktkhai@virtuozzo.com>, linux-alpha@vger.kernel.org
Message-ID: <20171127204154.9_IHyZBgFZx8acuSFk3eM0eGCVK2c-Q2KG8FwnAXLOY@z>

On Mon, Nov 27, 2017 at 7:49 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Paul Eggert <eggert@cs.ucla.edu> writes:
>
>> On 11/27/2017 09:00 AM, Arnd Bergmann wrote:
>>> b) Extend the approach taken by the x32 ABI, and use the 64-bit
>>>     native structure layout for rusage on all architectures with new
>>>     system calls that is otherwise compatible. A possible problem here
>>>     is that we end up with incompatible definitions of rusage between
>>>     /usr/include/linux/resource.h and /usr/include/bits/resource.h
>>>
>>> c) Change the definition of struct rusage to be independent of
>>>     time_t. This is the easiest change, as it does not involve new system
>>>     call entry points, but it has the risk of introducing compile-time
>>>     incompatibilities with user space sources that rely on the type
>>>     of ru_utime and ru_stime.
>>>
>>> I'm picking approch c) for its simplicity, but I'd like to hear from
>>> others whether they would prefer a different approach.
>>
>> (c) would break programs like GNU Emacs, which copy ru_utime and ru_stime
>> members into struct timeval variables.

Right. I think I originally had the workaround to have glibc convert
between its own structure and the kernel structure in mind, but then
ended up not including that in the text above. I was going back and
forth on whether it would be needed or not.

>> All in all, (b) sounds like it would be better for programs using glibc, as it's
>> more compatible with what POSIX apps expect. Though I'm not sure what problems
>> are meant by "possible ... incompatible definitions"; perhaps you could
>> elaborate.

I meant that you might have an application that includes
linux/resource.h instead of sys/resource.h but calls the glibc
function, or one that includes sys/resource.h and invokes the
system call directly.

> getrusage is posix and I believe the use of struct timeval is posix as
> well.
>
> So getrusage(3) the libc definition and that defintion must struct
> timeval or the implementation will be non-conforming and it won't be
> just emacs we need to worry about.
>
> The practical question is what do we provide to userspace so that it can
> implement a conforming getrusage?
>
> A 32bit time_t based struct timeval is good for durations up to 136 years
> or so.  Which strongly suggests the range is large enough, except for
> some crazy massively multi-threaded application.  And anything off the
> charts cpu hungry at this point I expect will be 64bit.
>
> It is possible to get a 128 way system with one thread on each core and
> consume 100% of the core for a bit over a year to max out getrusage.  So
> I do think in the long run we care about increasing the size of time_t
> here.  Last I checked applications doing things like that were 64bit in
> the year 2000.

Agreed, this was also a calculation I did.

> Given that userspace is going to be seeing the larger struct rusage in
> any event my inclination for long term maintainability would be to
> introduce the new syscall and have the current one called oldgetrusage
> on 32bit architectures.  Then we won't have to worry about what weird
> things glibc will do when translating the data, and we can handle
> applications with crazy (but possible) runtimes.  Which inclines me to
> (b) as well.

This would actually be the same thing we do for most other syscalls,
regarding the naming, it would become compat_sys_getrusage()
and share the implementation between native 32-bit mode and
compat mode on 64-bit architectures, while sys_getrusage becomes
the function that deals with the 64-bit layout, and would have the
same binary format on both 32-bit and 64-bit native ABIs.

Unfortunately, this opens a new question, as the structure is currently
defined by glibc as:

/* Structure which says how much of each resource has been used.  */

/* The purpose of all the unions is to have the kernel-compatible layout
   while keeping the API type as 'long int', and among machines where
   __syscall_slong_t is not 'long int', this only does the right thing
   for little-endian ones, like x32.  */
struct rusage
  {
    /* Total amount of user time used.  */
    struct timeval ru_utime;
    /* Total amount of system time used.  */
    struct timeval ru_stime;
    /* Maximum resident set size (in kilobytes).  */
    __extension__ union
      {
        long int ru_maxrss;
        __syscall_slong_t __ru_maxrss_word;
      };
    /* Amount of sharing of text segment memory
       with other processes (kilobyte-seconds).  */
    /* Maximum resident set size (in kilobytes).  */
    __extension__ union
      {
        long int ru_ixrss;
        __syscall_slong_t __ru_ixrss_word;
      };
   ...
};

Here, I guess we have to replace __syscall_slong_t with an 'rusage'
specific type that has the same length as time_t, but is independent
of __syscall_slong_t, which is still 32-bit for most 32-bit architectures.

How would we do the big-endian version of that though?

One argument for using c) plus the emulation in glibc is that glibc
has to do emulation anyway, to allow running user space with 64-bit
time_t on older kernels that don't have the new getrusage system
call.

> As for (a) does anyone have a need for process acounting at nsec
> granularity?  Unless we can get that for free that just seems like
> overpromising and a waist to have so much fine granularity.

The kernel does everything in nanoseconds, so we always spend
a few cycles (a lot of cycles on some of the very low-end architectures)
on dividing it by 1000. Moving the division operation to user space
is essentially free, and using the nanoseconds instead of microseconds
might be slightly cheaper. I don't think anyone really needs it though.

      Arnd
