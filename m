Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:41839 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933838AbeFVRqO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jun 2018 13:46:14 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20180420120605.1612248-1-arnd@arndb.de>
        <20180420120605.1612248-2-arnd@arndb.de>
        <20180621154915.GA31947@gmail.com>
        <CAK8P3a1QYTfRNQt2+a29BpvgYM_pnSFrO=NBvVo=BdUa2q9ngQ@mail.gmail.com>
        <20180621161121.GB7222@gmail.com>
        <CAK8P3a1mx16S+DhEMQA6WBJ7efdhN5YaKKVHU6n+E6kfifM-Qg@mail.gmail.com>
        <20180622021636.GA11266@gmail.com>
Date: Fri, 22 Jun 2018 12:45:50 -0500
In-Reply-To: <20180622021636.GA11266@gmail.com> (Ingo Molnar's message of
        "Fri, 22 Jun 2018 04:16:36 +0200")
Message-ID: <87a7rm3eb5.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v2 2/2] rusage: allow 64-bit times ru_utime/ru_stime
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Paul Eggert <eggert@cs.ucla.edu>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Dominik Brodowski <linux@dominikbrodowski.net>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-alpha@vger.kernel.org, Deepa Dinamani <deepa.kernel@gmail.com>
Message-ID: <20180622174550.fYK7r-Lp2uMTAF-SYldXkknCrgtTdDy_wOrqFNC-RYA@z>

Ingo Molnar <mingo@kernel.org> writes:

> * Arnd Bergmann <arnd@arndb.de> wrote:
>
>> However, the other question that has to be asked then is whether
>> there is anything wrong with wait4()/waitid() and getrusuage() that
>> we want to change beyond the time value passing. We have
>> answered a similar question with 'yes' for stat(), which has led
>> to the introduction of statx(),
>
> So we are thinking about adding wait5() in essence, right?

> One thing we might want to look into whether the wait4() and waitid() ABIs could 
> be 'merged', by making wait4() essentially a natural special case of
> waitid().

Essentially waitid(2) not waitid(3) has already seen this merger.
In that there is nothing to wait for that you can not already
expression with waitid.  status vs siginfo is a little different
but the information is encoded in both.

And waitid(2) optionally returns a struct rusage.

> This would mean that the only new system call we'd have to add is waitid2() in 
> essence, which would solve both the rusage layout problem and would offer a 
> unified ABI.
>
> If that makes sense (it might not!!), then I'd also modernize waitid2() by making 
> it attribute structure based, have a length field and make the ABI extensible from 
> now on going forward without having to introduce a new syscall variant every time 
> we come up with something new...

The only part where something is not parameterized in waitid is with the
return of rusage.

What to wait for takes an explicit type parameter.
What is being returned in siginfo returns an si_code to describe how
to decode it.

If it weren't for the zombie being gone after waitid returns I don't
think it would make any sense to combine getrusage and waitid together
at all.

> I.e. how the perf syscall does ABI extensions: we've had dozens of ABI extensions, 
> some of them pretty complex, and not a single time did we have to modify glibc and 
> tooling was able to adapt quickly yet in a both backwards and forwards compatible 
> fashion.
>
> Another, simpler example is the new sys_sched_setattr() syscall, that too is using 
> the perf_copy_attr() ABI method, via sched_copy_attr(). (With a minor 
> compatibility quirk of SCHED_ATTR_SIZE_VER0 that a new wait ABI wouldn't have to 
> do - i.e. it could be made even simpler.)
>
> This way we only have:
>
> SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr, unsigned int, flags)
>
> But even 'pid' and 'flags' could have been part of the attribute, i.e. one we pick 
> up an attribute structure from user-space we can have really low argument count 
> system calls. This also concentrates all the compat concerns into handling the 
> attribute structure properly - no weird per-arch artifacts and quirks with 4-5-6 
> system call arguments.

The trouble with attributes is that means you can't filter your system
call arguments with seccomp.  Which most of the time is a pretty big
downside.
