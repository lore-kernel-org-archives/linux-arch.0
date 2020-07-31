From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date: Fri, 31 Jul 2020 18:23:37 +0100
Message-ID: <20200731172337.GQ23808@casper.infradead.org>
References: <20200730152250.GG23808@casper.infradead.org>
 <db3bdbae-eb0f-1ae3-94dd-045e37bc94ba@oracle.com>
 <20200730171251.GI23808@casper.infradead.org>
 <63a7404c-e4f6-a82e-257b-217585b0277f@oracle.com>
 <20200730174956.GK23808@casper.infradead.org>
 <ab7a25bf-3321-77c8-9bc3-28a223a14032@oracle.com>
 <87y2n03brx.fsf@x220.int.ebiederm.org>
 <689d6348-6029-5396-8de7-a26bc3c017e5@oracle.com>
 <20200731152736.GP23808@casper.infradead.org>
 <9ba26063-0098-e796-9431-8c1d0c076ffc@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732970AbgGaRXr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 13:23:47 -0400
Content-Disposition: inline
In-Reply-To: <9ba26063-0098-e796-9431-8c1d0c076ffc@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com

On Fri, Jul 31, 2020 at 12:11:52PM -0400, Steven Sistare wrote:
> On 7/31/2020 11:27 AM, Matthew Wilcox wrote:
> > On Fri, Jul 31, 2020 at 10:57:44AM -0400, Steven Sistare wrote:
> >> Matthews sileby/mshare proposal has the same issue.  If a process opts-in
> >> and mmap's an address in the shared region, then content becomes mapped at
> >> a VA that was known to the pre-fork or pre-exec process.  Trust must still
> >> be established.
> > 
> > It's up to the recipient whether they try to map it at the same address
> > or at a fresh address.  The intended use case is a "semi-shared" address
> > space between two processes (ie partway between a threaded, fully-shared
> > address space and a forked un-shared address space), in which case
> > there's a certain amount of trust and cooperation between the processes.
> 
> Understood, but if the recipient does map at any of the same, which is the whole
> point because you want to share the page table.  The trust relationship is no
> different than for the live update case.  

You don't have to map at the same address to share the page tables.
For example, on x86 if you share an 8GB region, that must be aligned at
1GB in both the donor and the recipient, but they need not be mapped at
the same address.

> > It's a net increase of 200 lines of kernel code.  If 4 lines of userspace
> > code removes 200 lines of kernel code, I think I know which I prefer ...
> 
> It will be *far* more than 4 lines.
> Much of the 200 lines is mostly for the elf opt in, and much of the elf code is from
> anthony reviving an earlier patch that use MAP_FIXED_NOREPLACE during segment setup.

It doesn't really matter how much of it is for the opt-in and how much
is for the exec path itself.  The MAP_FIXED_NOREPLACE patch is only net
+16 lines, so that's not the problem.
