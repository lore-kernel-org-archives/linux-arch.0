Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16892.7218.458371.340859@cargo.ozlabs.ibm.com>
Date: Sun, 30 Jan 2005 10:28:50 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: TASK_SIZE is variable.
In-Reply-To: <20050129122321.0cac707c.akpm@osdl.org>
References: <1106692012.6480.158.camel@localhost.localdomain>
	<20050129122321.0cac707c.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andrew Morton writes:

> Guys, could I get a bit of clarity on how we want to proceed with all of
> this?
> 
> I have the below two patches queued.  Speak now or forever stfu!

In both cases (free_pgtables and exit_mmap) we want to do something to
the whole of an address space which may not be ours.  With these
patches we use MM_VM_SIZE(mm) to tell us how big the address space is
rather than TASK_SIZE, which is a good start.  However, the default
MM_VM_SIZE is still (based on) TASK_SIZE, and each 64-bit arch that
has TASK_SIZE as a per-task property then has to override it (except
that parisc doesn't seem to).  Also, having the mm as an argument to
MM_VM_SIZE is currently useless because there is nothing in the mm
that is helpful.

Thus the two patches you included will fix the problems, at the
expense of having to scan the whole pgd at exit time, even though we
really only need to look at the first 2 entries on ppc64 for the
very common case where the mm was used by a 32-bit process.

IMHO it would be cleaner and more efficient to have a way to tell how
much of an address space has actually been used, just from the mm,
without having to know what task(s) used the mm and whether they were
32-bit or 64-bit tasks.  That is what my mm->max_addr patch was aiming
at.  Having mm->max_addr should also work correctly across all
architectures, even the ones that have mappings above the 4GB point
for 32-bit processes, as long as they create vma's for those mappings.

Thus I would like to see the mm->max_addr patch go in.  If
architectures still want to control MM_VM_SIZE, we could have the
default definition of MM_VM_SIZE(mm) be mm->max_addr + 1 (or
alternatively make mm->max_addr be the address space size rather than
the max address - I made it the max address because I was concerned
that there might be 32-bit architectures that allowed mappings up to
and including 0xffffffff).

I am happy to make a combined patch if people agree on the approach.

Paul.
