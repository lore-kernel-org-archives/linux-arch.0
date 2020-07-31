From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 3/7] mm: introduce memfd_secret system call to create
 "secret" memory areas
Date: Fri, 31 Jul 2020 15:29:05 +0100
Message-ID: <20200731142905.GA67415@C02TD0UTHF1T.local>
References: <20200727162935.31714-1-rppt@kernel.org>
 <20200727162935.31714-4-rppt@kernel.org>
 <20200730162209.GB3128@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:32900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728697AbgGaO3V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Jul 2020 10:29:21 -0400
Content-Disposition: inline
In-Reply-To: <20200730162209.GB3128@gaia>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Christopher Lameter <cl@linux.com>, Dan Williams <dan.j.williams@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul

On Thu, Jul 30, 2020 at 05:22:10PM +0100, Catalin Marinas wrote:
> On Mon, Jul 27, 2020 at 07:29:31PM +0300, Mike Rapoport wrote:

> > +static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
> > +{
> > +	struct secretmem_ctx *ctx = file->private_data;
> > +	unsigned long mode = ctx->mode;
> > +	unsigned long len = vma->vm_end - vma->vm_start;
> > +
> > +	if (!mode)
> > +		return -EINVAL;
> > +
> > +	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
> > +		return -EINVAL;
> > +
> > +	if (mlock_future_check(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
> > +		return -EAGAIN;
> > +
> > +	switch (mode) {
> > +	case SECRETMEM_UNCACHED:
> > +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > +		fallthrough;
> > +	case SECRETMEM_EXCLUSIVE:
> > +		vma->vm_ops = &secretmem_vm_ops;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	vma->vm_flags |= VM_LOCKED;
> > +
> > +	return 0;
> > +}
> 
> I think the uncached mapping is not the right thing for arm/arm64. First
> of all, pgprot_noncached() gives us Strongly Ordered (Device memory)
> semantics together with not allowing unaligned accesses. I suspect the
> semantics are different on x86.

> The second, more serious problem, is that I can't find any place where
> the caches are flushed for the page mapped on fault. When a page is
> allocated, assuming GFP_ZERO, only the caches are guaranteed to be
> zeroed. Exposing this subsequently to user space as uncached would allow
> the user to read stale data prior to zeroing. The arm64
> set_direct_map_default_noflush() doesn't do any cache maintenance.

It's also worth noting that in a virtual machine this is liable to be
either broken (with a potential loss of coherency if the host has a
cacheable alias as existing KVM hosts have), or pointless (if the host
uses S2FWB to upgrade Stage-1 attribues to cacheable as existing KVM
hosts also have).

I think that trying to avoid the data caches creates many more problems
than it solves, and I don't think there's a strong justification for
trying to support that on arm64 to begin with, so I'd rather entirely
opt-out on supporting SECRETMEM_UNCACHED.

Thanks,
Mark.
