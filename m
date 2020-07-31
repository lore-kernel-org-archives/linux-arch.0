From: Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date: Fri, 31 Jul 2020 10:57:44 -0400
Message-ID: <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <20200730152250.GG23808@casper.infradead.org>
 <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
 <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:35438 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbgGaO6s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 10:58:48 -0400
In-Reply-To: <87y2n03brx.fsf@x220.int.ebiederm.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Matthew Wilcox <willy@infradead.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com

On 7/30/2020 5:58 PM, ebiederm@xmission.com wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
>> On 7/30/2020 1:49 PM, Matthew Wilcox wrote:
>>> On Thu, Jul 30, 2020 at 01:35:51PM -0400, Steven Sistare wrote:
>>>> mshare + VA reservation is another possible solution.
>>>>
>>>> Or MADV_DOEXEC alone, which is ready now.  I hope we can get back to reviewing that.
>>>
>>> We are.  This is the part of the review process where we explore other
>>> solutions to the problem.
>>>
>>>>>> Also, we need to support updating legacy processes that already created anon segments.
>>>>>> We inject code that calls MADV_DOEXEC for such segments.
>>>>>
>>>>> Yes, I was assuming you'd inject code that called mshare().
>>>>
>>>> OK, mshare works on existing memory and builds a new vma.
>>>
>>> Actually, reparents an existing VMA, and reuses the existing page tables.
>>>
>>>>> Actually, since you're injecting code, why do you need the kernel to
>>>>> be involved?  You can mmap the new executable and any libraries it depends
>>>>> upon, set up a new stack and jump to the main() entry point, all without
>>>>> calling exec().  I appreciate it'd be a fair amount of code, but it'd all
>>>>> be in userspace and you can probably steal / reuse code from ld.so (I'm
>>>>> not familiar with the details of how setting up an executable is done).
>>>>
>>>> Duplicating all the work that the kernel and loader do to exec a process would
>>>> be error prone, require ongoing maintenance, and be redundant.  Better to define 
>>>> a small kernel extension and leave exec to the kernel.
>>>
>>> Either this is a one-off kind of thing, in which case it doesn't need
>>> ongoing maintenance, or it's something with broad applicability, in
>>> which case it can live as its own userspace project.  It could even
>>> start off life as part of qemu and then fork into its own project.
>>
>> exec will be enhanced over time in the kernel.  A separate user space implementation
>> would need to track that.
>>
>> Reimplementing exec in userland would be a big gross mess.  Not a good solution when
>> we have simple and concise ways of solving the problem.
> 
> The interesting work is not done in exec.  The interesting work of
> loading an executable is done in ld.so, and ld.so lives in userspace.

And yet a smart guy named Eric said:
  "There is just enough complexity in exec currently that our implementation of exec is 
  already teetering."
which suggests that a user-space re-implementation will also be complex.
In complexity lies bugs.

>>> The idea of tagging an ELF executable to say "I can cope with having
>>> chunks of my address space provided to me by my executor" is ... odd.
>>
>> I don't disagree.  But it is useful.  We already pass a block of data containing
>> environment variables and arguments from one process to the next.  Preserving 
>> additional segments is not a big leap from there.
> 
> But we randomize where that block lives.
> 
> It has been found to be very useful to have randomization by default and
> you are arguing against that kind of randomization.

In the normal use case the addresses of the preserved anon segments were
already randomized during allocation in the pre-exec process.  Preservation
across exec does not make the process less safe from an external attack.

Now, if the attacker injects content at known addresses by preserving and
exec'ing, then the post-exec process must decide whether to trust the
pre-exec process.  Let's prevent preservation when exec'ing setuid binaries.
That is not part of this patch series, but is a good idea.  So, uid does not
change across exec.  Do I trust myself?  Yes I do.  If the uid is trusted,
as it must be in the qemu use case which accesses system resources, then
that is sufficient.  If the exec raises caps, and the uid is not trusted,
then the post-exec process must do additional work to verify the pre-exec
credentials.  The method is left to the app.  We defined the ELF opt-in so
that processes that do not use preserved memory will never receive any and
will never need to deal with such verification.

Matthews sileby/mshare proposal has the same issue.  If a process opts-in
and mmap's an address in the shared region, then content becomes mapped at
a VA that was known to the pre-fork or pre-exec process.  Trust must still
be established.

> Here is another suggestion.
> 
> Have a very simple program that does:
> 
> 	for (;;) {
> 		handle = dlopen("/my/real/program");
> 		real_main = dlsym(handle, "main");
> 		real_main(argc, argv, envp);
> 		dlclose(handle);
> 	}
> 
> With whatever obvious adjustments are needed to fit your usecase.
> 
> That should give the same level of functionality, be portable to all
> unices, and not require you to duplicate code.  It belive it limits you
> to not upgrading libc, or librt but that is a comparatively small
> limitation.
> 
> 
> Given that in general the interesting work is done in userspace and that
> userspace has provided an interface for reusing that work already.
> I don't see the justification for adding anything to exec at this point. 

Thanks for the suggestion.  That is clever, and would make a fun project,
but I would not trust it for production.  These few lines are just
the first of many that it would take to reset the environment to the
well-defined post-exec initial conditions that all executables expect,
and incrementally tearing down state will be prone to bugs.  Getting a
clean slate from a kernel exec is a much more reliable design.  The use
case is creating long-lived apps that never go down, and the simplest
implementation will have the fewest bugs and is the best.  MADV_DOEXEC is
simple, and does not even require a new system call, and the kernel already
knows how to exec without bugs.

- Steve
