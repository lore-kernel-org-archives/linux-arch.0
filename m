From: Mike Rapoport <rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/7] mm: introduce memfd_secret system call to create
 "secret" memory areas
Date: Thu, 30 Jul 2020 23:44:09 +0300
Message-ID: <20200730204409.GB534153@kernel.org>
References: <20200727162935.31714-1-rppt@kernel.org>
 <20200727162935.31714-4-rppt@kernel.org>
 <20200730162209.GB3128@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200730162209.GB3128@gaia>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Christopher Lameter <cl-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Elena Reshetova <elena.reshetova-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Idan Yaniv <idan.yaniv-qyM6JfAXOaQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, James Bottomley <jejb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, "Kirill A. Shutemov" <kirill-oKw7cIdHH8eLwutG50LtGA@public.gmane.org>, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Michael Kerrisk <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Palmer Dabbelt <palmer-96lFi9zoCfxBDgjK7y7TUQ@public.gmane.org>, Paul Walmsley <paul.walmsley-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 30, 2020 at 05:22:10PM +0100, Catalin Marinas wrote:
> Hi Mike,
> 
> On Mon, Jul 27, 2020 at 07:29:31PM +0300, Mike Rapoport wrote:
> > For instance, the following example will create an uncached mapping (error
> > handling is omitted):
> > 
> > 	fd = memfd_secret(SECRETMEM_UNCACHED);
> > 	ftruncate(fd, MAP_SIZE);
> > 	ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> [...]
> > +static struct page *secretmem_alloc_page(gfp_t gfp)
> > +{
> > +	/*
> > +	 * FIXME: use a cache of large pages to reduce the direct map
> > +	 * fragmentation
> > +	 */
> > +	return alloc_page(gfp);
> > +}
> > +
> > +static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> > +{
> > +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> > +	struct inode *inode = file_inode(vmf->vma->vm_file);
> > +	pgoff_t offset = vmf->pgoff;
> > +	unsigned long addr;
> > +	struct page *page;
> > +	int ret = 0;
> > +
> > +	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
> > +		return vmf_error(-EINVAL);
> > +
> > +	page = find_get_entry(mapping, offset);
> > +	if (!page) {
> > +		page = secretmem_alloc_page(vmf->gfp_mask);
> > +		if (!page)
> > +			return vmf_error(-ENOMEM);
> > +
> > +		ret = add_to_page_cache(page, mapping, offset, vmf->gfp_mask);
> > +		if (unlikely(ret))
> > +			goto err_put_page;
> > +
> > +		ret = set_direct_map_invalid_noflush(page);
> > +		if (ret)
> > +			goto err_del_page_cache;
> > +
> > +		addr = (unsigned long)page_address(page);
> > +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> > +
> > +		__SetPageUptodate(page);
> > +
> > +		ret = VM_FAULT_LOCKED;
> > +	}
> > +
> > +	vmf->page = page;
> > +	return ret;
> > +
> > +err_del_page_cache:
> > +	delete_from_page_cache(page);
> > +err_put_page:
> > +	put_page(page);
> > +	return vmf_error(ret);
> > +}
> > +
> > +static const struct vm_operations_struct secretmem_vm_ops = {
> > +	.fault = secretmem_fault,
> > +};
> > +
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
 
Hmm, on x86 it's also Strongly Ordered, but I didn't find any alignment
restrictions. Is there a mode for arm64 that can provide similar
semantics?

Would it make sence to use something like

#define pgprot_uncached(prot) \
	__pgprot_modify(prot, PTE_ATTRINDX_MASK, \
			PTE_ATTRINDX(MT_NORMAL_NC) | PTE_PXN)

or is it too weak?

> The second, more serious problem, is that I can't find any place where
> the caches are flushed for the page mapped on fault. When a page is
> allocated, assuming GFP_ZERO, only the caches are guaranteed to be
> zeroed. Exposing this subsequently to user space as uncached would allow
> the user to read stale data prior to zeroing. The arm64
> set_direct_map_default_noflush() doesn't do any cache maintenance.

Well, the idea of uncached mappings came from Elena [1] to prevent
possibility of side channels that leak user space memory. So I think
even without cache flushing after the allocation, user space is
protected as all its memory accesses bypass cache so even after the page
is freed there won't be stale data in the cache.

I think that it makes sense to limit SECRETMEM_UNCACHED only for
architectures that define an appropriate protection, e.g.
pgprot_uncahced(). For x86 it can be aliased to pgprot_noncached() and
other architecures can define their versions.

[1] https://lore.kernel.org/lkml/2236FBA76BA1254E88B949DDB74E612BA4EEC0CE-kPTMFJFq+rFP9JyJpTNKArfspsVTdybXVpNB7YpNyf8@public.gmane.org/

-- 
Sincerely yours,
Mike.
