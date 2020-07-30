From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date: Thu, 30 Jul 2020 18:12:51 +0100
Message-ID: <20200730171251.GI23808@casper.infradead.org>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <20200730152250.GG23808@casper.infradead.org>
 <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3RM4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jul 2020 13:12:56 -0400
Content-Disposition: inline
In-Reply-To: <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com

On Thu, Jul 30, 2020 at 11:59:42AM -0400, Steven Sistare wrote:
> On 7/30/2020 11:22 AM, Matthew Wilcox wrote:
> > On Mon, Jul 27, 2020 at 10:11:22AM -0700, Anthony Yznaga wrote:
> >> This patchset adds support for preserving an anonymous memory range across
> >> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
> >> sharing memory in this manner, as opposed to re-attaching to a named shared
> >> memory segment, is to ensure it is mapped at the same virtual address in
> >> the new process as it was in the old one.  An intended use for this is to
> >> preserve guest memory for guests using vfio while qemu exec's an updated
> >> version of itself.  By ensuring the memory is preserved at a fixed address,
> >> vfio mappings and their associated kernel data structures can remain valid.
> >> In addition, for the qemu use case, qemu instances that back guest RAM with
> >> anonymous memory can be updated.
> > 
> > I just realised that something else I'm working on might be a suitable
> > alternative to this.  Apologies for not realising it sooner.
> > 
> > http://www.wil.cx/~willy/linux/sileby.html
> > 
> > To use this, you'd mshare() the anonymous memory range, essentially
> > detaching the VMA from the current process's mm_struct and reparenting
> > it to this new mm_struct, which has an fd referencing it.
> > 
> > Then you call exec(), and the exec'ed task gets to call mmap() on that
> > new fd to attach the memory range to its own address space.
> > 
> > Presto!
> 
> To be suitable for the qemu use case, we need a guarantee that the same VA range
> is available in the new process, with nothing else mapped there.  From your spec,
> it sounds like the new process could do a series of unrelated mmap's which could
> overlap the desired va range before the silby mmap(fd) is performed??

That could happen.  eg libc might get its text segment mapped there
randomly.  I believe Khalid was working on a solution for reserving
memory ranges.

> Also, we need to support updating legacy processes that already created anon segments.
> We inject code that calls MADV_DOEXEC for such segments.

Yes, I was assuming you'd inject code that called mshare().

Actually, since you're injecting code, why do you need the kernel to
be involved?  You can mmap the new executable and any libraries it depends
upon, set up a new stack and jump to the main() entry point, all without
calling exec().  I appreciate it'd be a fair amount of code, but it'd all
be in userspace and you can probably steal / reuse code from ld.so (I'm
not familiar with the details of how setting up an executable is done).
