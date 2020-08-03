From: Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date: Mon, 3 Aug 2020 15:29:26 -0400
Message-ID: <eeec47c5-232d-fe8e-c19d-70c50c49020c@oracle.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <20200730152250.GG23808@casper.infradead.org>
 <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
 <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
 <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
 <877dufvje9.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:53168 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCTai (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Aug 2020 15:30:38 -0400
In-Reply-To: <877dufvje9.fsf@x220.int.ebiederm.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Matthew Wilcox <willy@infradead.org>, Anthony Yznaga <anthony.yznaga@oracle.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com

On 8/3/2020 11:28 AM, ebiederm@xmission.com wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
>> On 7/30/2020 5:58 PM, ebiederm@xmission.com wrote:
>>> Here is another suggestion.
>>>
>>> Have a very simple program that does:
>>>
>>> 	for (;;) {
>>> 		handle = dlopen("/my/real/program");
>>> 		real_main = dlsym(handle, "main");
>>> 		real_main(argc, argv, envp);
>>> 		dlclose(handle);
>>> 	}
>>>
>>> With whatever obvious adjustments are needed to fit your usecase.
>>>
>>> That should give the same level of functionality, be portable to all
>>> unices, and not require you to duplicate code.  It belive it limits you
>>> to not upgrading libc, or librt but that is a comparatively small
>>> limitation.
>>>
>>>
>>> Given that in general the interesting work is done in userspace and that
>>> userspace has provided an interface for reusing that work already.
>>> I don't see the justification for adding anything to exec at this point. 
>>
>> Thanks for the suggestion.  That is clever, and would make a fun project,
>> but I would not trust it for production.  These few lines are just
>> the first of many that it would take to reset the environment to the
>> well-defined post-exec initial conditions that all executables expect,
>> and incrementally tearing down state will be prone to bugs.
> 
> Agreed.
> 
>> Getting a clean slate from a kernel exec is a much more reliable
>> design.
> 
> Except you are explicitly throwing that out the window, by preserving
> VMAs.  You very much need to have a clean bug free shutdown to pass VMAs
> reliably.

Sure.  The whole community relies on you and others to provide a bug free exec.

>> The use case is creating long-lived apps that never go down, and the
>> simplest implementation will have the fewest bugs and is the best.
>> MADV_DOEXEC is simple, and does not even require a new system call,
>> and the kernel already knows how to exec without bugs.
> 
> *ROFL*  I wish the kernel knew how to exec things without bugs.

Essentially you are saying you would argue against any enhancement to exec.
Surely that is too high a bar.  We must continue to evolve an innovate and
balance risk against reward.  This use case matters to our business a lot,
and to others as well, see below.  That is the reward.  I feel you are 
overstating the risk.  Surely there is some early point in the development
cycle of some release where this can be integrated and get enough test
time and soak time to be proven reliable.

> The bugs are hard to hit but the ones I am aware of are not straight
> forward to fix.
> 
> MADV_DOEXEC is not conceptually simple.  It completely violates the
> guarantees that exec is known to make about the contents of the memory
> of the new process.  This makes it very difficult to reason about.  

I have having trouble see the difficulty.  Perhaps I am too familar with
it, but the semantics are few and easy to explain, and it does not introduce
new concepts: the post-exec process is born with a few more mappings than
previously, and non-fixed further mmaps choose addresses in the holes.

> Nor
> will MADV_DOEXEC be tested very much as it has only one or two users.
> Which means in the fullness of time it is likely someone will change
> something that will break the implementation subtlely and the bug report
> probably won't come in for 3 years, or maybe a decade.  At which point
> it won't be clear if the bug even can be fixed as something else might
> rely on it.

That's on us; we need to provide kernel tests and be diligent about testing
new releases.  This matters to our business and we will do so. 
> What is wrong with live migration between one qemu process and another
> qemu process on the same machine not work for this use case?
> 
> Just reusing live migration would seem to be the simplest path of all,
> as the code is already implemented.  Further if something goes wrong
> with the live migration you can fallback to the existing process.  With
> exec there is no fallback if the new version does not properly support
> the handoff protocol of the old version.

This is less resource intensive than live migration.  The latter ties up two
hosts, consumes lots of memory and network bandwidth, may take a long time
to converge on a busy system, and is unfeasible for guests with a huge amount
of local storeage (which we call dense I/O shapes).  Live update takes less than
1 second total, and the guest pause time is 100 - 200 msecs.  It is a very
attractive solution that other cloud vendors have implemented as well, with
their own private modifications to exec and and fork.  We have been independently
working in this area, and we are offering our implementation to the community.

- Steve
