From: Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date: Fri, 31 Jul 2020 12:11:52 -0400
Message-ID: <9ba26063-0098-e796-9431-8c1d0c076ffc@oracle.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <20200730152250.GG23808@casper.infradead.org>
 <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
 <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
 <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
 <20200731152736.GP23808@casper.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:39164 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGaQOs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 12:14:48 -0400
In-Reply-To: <20200731152736.GP23808@casper.infradead.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com

On 7/31/2020 11:27 AM, Matthew Wilcox wrote:
> On Fri, Jul 31, 2020 at 10:57:44AM -0400, Steven Sistare wrote:
>> Matthews sileby/mshare proposal has the same issue.  If a process opts-in
>> and mmap's an address in the shared region, then content becomes mapped at
>> a VA that was known to the pre-fork or pre-exec process.  Trust must still
>> be established.
> 
> It's up to the recipient whether they try to map it at the same address
> or at a fresh address.  The intended use case is a "semi-shared" address
> space between two processes (ie partway between a threaded, fully-shared
> address space and a forked un-shared address space), in which case
> there's a certain amount of trust and cooperation between the processes.

Understood, but if the recipient does map at any of the same, which is the whole
point because you want to share the page table.  The trust relationship is no
different than for the live update case.  
 
> Your preservation-across-exec use-case might or might not need the
> VMA to be mapped at the same address.  

It does.  qemu registers memory with vfio which remembers the va's in kernel
metadata for the device.

> I don't know whether qemu stores
> pointers in this VMA which are absolute within the qemu address space.
> If it's just the emulated process's address space, then everything will
> be absolute within its own address space and everything will be opaque
> to qemu.  If qemu is storing its own pointers in it, then it has to be
> mapped at the same address.

qemu does not do the latter but that could be a nice way for apps to use
preserved memory.

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
>> and incrementally tearing down state will be prone to bugs.  Getting a
>> clean slate from a kernel exec is a much more reliable design.  The use
>> case is creating long-lived apps that never go down, and the simplest
>> implementation will have the fewest bugs and is the best.  MADV_DOEXEC is
>> simple, and does not even require a new system call, and the kernel already
>> knows how to exec without bugs.
> 
> It's a net increase of 200 lines of kernel code.  If 4 lines of userspace
> code removes 200 lines of kernel code, I think I know which I prefer ...

It will be *far* more than 4 lines.
Much of the 200 lines is mostly for the elf opt in, and much of the elf code is from
anthony reviving an earlier patch that use MAP_FIXED_NOREPLACE during segment setup.

- Steve
