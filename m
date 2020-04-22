From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 3/4] arm64: mte: Enable swap of tagged pages
Date: Wed, 22 Apr 2020 11:34:22 -0700
Message-ID: <6ebff138-a6ad-75c9-bfe5-b7174098e878@intel.com>
References: <20200422142530.32619-1-steven.price@arm.com>
 <20200422142530.32619-4-steven.price@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200422142530.32619-4-steven.price@arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Steven Price <steven.price@arm.com>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

On 4/22/20 7:25 AM, Steven Price wrote:
> Because shmem can swap pages back in without restoring
> the userspace PTE it is also necessary to add a hook for shmem.

I think the swap readahead code does this as well.  It pulls the page
into the swap cache, but doesn't map it in.

...
> +static DEFINE_XARRAY(mte_pages);
> +
> +void *mte_allocate_tag_storage(void)
> +{
> +	/* tags granule is 16 bytes, 2 tags stored per byte */
> +	return kmalloc(PAGE_SIZE / 16 / 2, GFP_KERNEL);
> +}

Yikes, so this eats 2k of unmovable kernel memory per 64k of swap?  This
is *probably* worth having its own slab just so the memory that's used
for it is less opaque.  It could be pretty large.  But, I guess if
you're worried about how much kernel memory this can eat, there's always
the swap cgroup controller to enforce limits.

This also *increases* the footprint of a page while it's in the swap
cache.  That's at least temporarily a _bit_ counterproductive.

I guess there aren't any nice alternatives, though.  I would imagine
that it would be substantially more complicated to rig the swap code up
to write the tag along with the data.  Or, to store the tag data
somewhere *it* can be reclaimed, like in a kernel-internal shmem file or
something.

> +void mte_free_tag_storage(char *storage)
> +{
> +	kfree(storage);
> +}
> +
> +int mte_save_tags(struct page *page)
> +{
> +	void *tag_storage, *ret;
> +
> +	if (!test_bit(PG_mte_tagged, &page->flags))
> +		return 0;
> +
> +	tag_storage = mte_allocate_tag_storage();
> +	if (!tag_storage)
> +		return -ENOMEM;
> +
> +	mte_save_page_tags(page_address(page), tag_storage);
> +
> +	ret = xa_store(&mte_pages, page_private(page), tag_storage, GFP_KERNEL);

This is indexing into the xarray with the swap entry.val established in
do_swap_page()?  Might be nice to make a note where it came from.

> +	if (WARN(xa_is_err(ret), "Failed to store MTE tags")) {
> +		mte_free_tag_storage(tag_storage);
> +		return xa_err(ret);
> +	} else if (ret) {
> +		mte_free_tag_storage(ret);

Is there a missing "return ret;" here?  Otherwise, it seems like this
might silently fail to save the page's tags.  I'm not sure what
non-xa_is_err() codes get returned, but if there is one, it could end up
here.

> +	}
> +
> +	return 0;
> +}
...

> +void mte_sync_tags(pte_t *ptep, pte_t pte)
> +{
> +	struct page *page = pte_page(pte);
> +	pte_t old_pte = READ_ONCE(*ptep);
> +	swp_entry_t entry;
> +
> +	set_bit(PG_mte_tagged, &page->flags);
> +
> +	if (!is_swap_pte(old_pte))
> +		return;
> +
> +	entry = pte_to_swp_entry(old_pte);
> +	if (non_swap_entry(entry))
> +		return;
> +
> +	mte_restore_tags(entry, page);
> +}

Oh, here it is!  This gets called when replacing a swap PTE with a
present PTE and restores the tags on swap-in.

Does this work for swap PTEs which were copied at fork()?  I *think*
those might end up in here twice, once for the parent and another for
the child.  If both read the page, both will fault and both will do a
set_pte() and end up in here.  I don't think it will do any harm since
it will just set_bit(PG_mte_tagged) twice and restore the same tags
twice.  But, it might be nice to call that out.

This function is a bit light on comments.  It might make sense, for
instance to note that 'pte' is always a tagged PTE at this point.
