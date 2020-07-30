From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date: Thu, 30 Jul 2020 16:58:58 -0500
Message-ID: <87y2n03brx.fsf@x220.int.ebiederm.org>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
        <20200730152250.GG23808@casper.infradead.org>
        <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
        <20200730171251.GI23808@casper.infradead.org>
        <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
        <20200730174956.GK23808@casper.infradead.org>
        <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:41060 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgG3WCX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jul 2020 18:02:23 -0400
In-Reply-To: <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com> (Steven
        Sistare's message of "Thu, 30 Jul 2020 14:27:21 -0400")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com

Steven Sistare <steven.sistare@oracle.com> writes:

> On 7/30/2020 1:49 PM, Matthew Wilcox wrote:
>> On Thu, Jul 30, 2020 at 01:35:51PM -0400, Steven Sistare wrote:
>>> mshare + VA reservation is another possible solution.
>>>
>>> Or MADV_DOEXEC alone, which is ready now.  I hope we can get back to reviewing that.
>> 
>> We are.  This is the part of the review process where we explore other
>> solutions to the problem.
>> 
>>>>> Also, we need to support updating legacy processes that already created anon segments.
>>>>> We inject code that calls MADV_DOEXEC for such segments.
>>>>
>>>> Yes, I was assuming you'd inject code that called mshare().
>>>
>>> OK, mshare works on existing memory and builds a new vma.
>> 
>> Actually, reparents an existing VMA, and reuses the existing page tables.
>> 
>>>> Actually, since you're injecting code, why do you need the kernel to
>>>> be involved?  You can mmap the new executable and any libraries it depends
>>>> upon, set up a new stack and jump to the main() entry point, all without
>>>> calling exec().  I appreciate it'd be a fair amount of code, but it'd all
>>>> be in userspace and you can probably steal / reuse code from ld.so (I'm
>>>> not familiar with the details of how setting up an executable is done).
>>>
>>> Duplicating all the work that the kernel and loader do to exec a process would
>>> be error prone, require ongoing maintenance, and be redundant.  Better to define 
>>> a small kernel extension and leave exec to the kernel.
>> 
>> Either this is a one-off kind of thing, in which case it doesn't need
>> ongoing maintenance, or it's something with broad applicability, in
>> which case it can live as its own userspace project.  It could even
>> start off life as part of qemu and then fork into its own project.
>
> exec will be enhanced over time in the kernel.  A separate user space implementation
> would need to track that.
>
> Reimplementing exec in userland would be a big gross mess.  Not a good solution when
> we have simple and concise ways of solving the problem.

The interesting work is not done in exec.  The interesting work of
loading an executable is done in ld.so, and ld.so lives in userspace.

>> The idea of tagging an ELF executable to say "I can cope with having
>> chunks of my address space provided to me by my executor" is ... odd.
>
> I don't disagree.  But it is useful.  We already pass a block of data containing
> environment variables and arguments from one process to the next.  Preserving 
> additional segments is not a big leap from there.

But we randomize where that block lives.

It has been found to be very useful to have randomization by default and
you are arguing against that kind of randomization.



Here is another suggestion.

Have a very simple program that does:

	for (;;) {
		handle = dlopen("/my/real/program");
		real_main = dlsym(handle, "main");
		real_main(argc, argv, envp);
		dlclose(handle);
	}

With whatever obvious adjustments are needed to fit your usecase.

That should give the same level of functionality, be portable to all
unices, and not require you to duplicate code.  It belive it limits you
to not upgrading libc, or librt but that is a comparatively small
limitation.


Given that in general the interesting work is done in userspace and that
userspace has provided an interface for reusing that work already.
I don't see the justification for adding anything to exec at this point.


Eric
