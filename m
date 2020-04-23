From: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 3/4] arm64: mte: Enable swap of tagged pages
Date: Thu, 23 Apr 2020 14:51:11 +0100
Message-ID: <74ec349c-454a-363f-1ae0-131934e0af26@arm.com>
References: <20200422142530.32619-1-steven.price@arm.com>
 <20200422142530.32619-4-steven.price@arm.com>
 <6ebff138-a6ad-75c9-bfe5-b7174098e878@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:40286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgDWNvU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Apr 2020 09:51:20 -0400
In-Reply-To: <6ebff138-a6ad-75c9-bfe5-b7174098e878@intel.com>
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Hugh Dickins <hughd@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>

On 22/04/2020 19:34, Dave Hansen wrote:
> On 4/22/20 7:25 AM, Steven Price wrote:
>> Because shmem can swap pages back in without restoring
>> the userspace PTE it is also necessary to add a hook for shmem.
> 
> I think the swap readahead code does this as well.  It pulls the page
> into the swap cache, but doesn't map it in.

The swap cache isn't a problem because the swap entry is still valid - 
so the parallel tag cache is still associated with the page. shmem has 
it's own cache so the tag data has to be transferred between the caches 
(in this case stored back in the physical tag memory).

> ...
>> +static DEFINE_XARRAY(mte_pages);
>> +
>> +void *mte_allocate_tag_storage(void)
>> +{
>> +	/* tags granule is 16 bytes, 2 tags stored per byte */
>> +	return kmalloc(PAGE_SIZE / 16 / 2, GFP_KERNEL);
>> +}
> 
> Yikes, so this eats 2k of unmovable kernel memory per 64k of swap?  This
> is *probably* worth having its own slab just so the memory that's used
> for it is less opaque.  It could be pretty large.  But, I guess if
> you're worried about how much kernel memory this can eat, there's always
> the swap cgroup controller to enforce limits.

Yes, this is probably something that will need tuning in the future. At 
the moment we don't have much of an idea how much memory will have tags. 
It's 'only' 2k per 64k of memory which has been mapped with PROT_MTE. 
Obvious avenues for potential improvement are:

  * A dedicated slab (as you suggest)
  * Enabling swapping of the tags themselves
  * Compressing the tags (there might be large runs of duplicated tag 
values)

> This also *increases* the footprint of a page while it's in the swap
> cache.  That's at least temporarily a _bit_ counterproductive.

Indeed. It *may* be possible to store the tags back in the physical tag 
memory while the page is in the swap cache, but this would require 
hooking into the path where the swap cache is freed without write-back 
of the page data.

> I guess there aren't any nice alternatives, though.  I would imagine
> that it would be substantially more complicated to rig the swap code up
> to write the tag along with the data.  Or, to store the tag data
> somewhere *it* can be reclaimed, like in a kernel-internal shmem file or
> something.

Yes, I'm attempting a simple (hopefully 'obviously right') 
implementation. When we actually have some real applications making use 
of this then we can look at optimisations - that will also allow 
meaningful benchmarking of the optimisations.

>> +void mte_free_tag_storage(char *storage)
>> +{
>> +	kfree(storage);
>> +}
>> +
>> +int mte_save_tags(struct page *page)
>> +{
>> +	void *tag_storage, *ret;
>> +
>> +	if (!test_bit(PG_mte_tagged, &page->flags))
>> +		return 0;
>> +
>> +	tag_storage = mte_allocate_tag_storage();
>> +	if (!tag_storage)
>> +		return -ENOMEM;
>> +
>> +	mte_save_page_tags(page_address(page), tag_storage);
>> +
>> +	ret = xa_store(&mte_pages, page_private(page), tag_storage, GFP_KERNEL);
> 
> This is indexing into the xarray with the swap entry.val established in
> do_swap_page()?  Might be nice to make a note where it came from.

Good point, I'll put a comment in

>> +	if (WARN(xa_is_err(ret), "Failed to store MTE tags")) {
>> +		mte_free_tag_storage(tag_storage);
>> +		return xa_err(ret);
>> +	} else if (ret) {
>> +		mte_free_tag_storage(ret);
> 
> Is there a missing "return ret;" here?  Otherwise, it seems like this
> might silently fail to save the page's tags.  I'm not sure what
> non-xa_is_err() codes get returned, but if there is one, it could end up
> here.

No, perhaps a comment is needed! xa_store() will return the value that 
used to be at that index (or NULL if there wasn't an entry). So if the 
swap index is being reused ret != NULL (and !xa_is_err(ret)) and in this 
case we need to free the old storage to prevent a memory leak. So in 
this path the tags have been successfully saved.

>> +	}
>> +
>> +	return 0;
>> +}
> ...
> 
>> +void mte_sync_tags(pte_t *ptep, pte_t pte)
>> +{
>> +	struct page *page = pte_page(pte);
>> +	pte_t old_pte = READ_ONCE(*ptep);
>> +	swp_entry_t entry;
>> +
>> +	set_bit(PG_mte_tagged, &page->flags);
>> +
>> +	if (!is_swap_pte(old_pte))
>> +		return;
>> +
>> +	entry = pte_to_swp_entry(old_pte);
>> +	if (non_swap_entry(entry))
>> +		return;
>> +
>> +	mte_restore_tags(entry, page);
>> +}
> 
> Oh, here it is!  This gets called when replacing a swap PTE with a
> present PTE and restores the tags on swap-in.
> 
> Does this work for swap PTEs which were copied at fork()?  I *think*
> those might end up in here twice, once for the parent and another for
> the child.  If both read the page, both will fault and both will do a
> set_pte() and end up in here.  I don't think it will do any harm since
> it will just set_bit(PG_mte_tagged) twice and restore the same tags
> twice.  But, it might be nice to call that out.

Yes, that's what should happen. Beyond adding another page flag (to 
track whether the tags have been restored or not) I couldn't think of a 
neat way of preventing this. And I believe it should be harmless 
restoring it twice.

> This function is a bit light on comments.  It might make sense, for
> instance to note that 'pte' is always a tagged PTE at this point.

Yes, I'll add some more comments here too.

Thanks for the review!

Steve
