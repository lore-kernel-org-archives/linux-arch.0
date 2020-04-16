From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Date: Thu, 16 Apr 2020 12:38:00 +1000
Message-ID: <1587003993.x84ylh11b2.astroid@bobo.none>
References: <20200413125303.423864-1-npiggin@gmail.com>
        <20200413125303.423864-5-npiggin@gmail.com>
        <20200415104755.GD12621@willie-the-truck>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732153AbgDPCik (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 22:38:40 -0400
In-Reply-To: <20200415104755.GD12621@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org

Excerpts from Will Deacon's message of April 15, 2020 8:47 pm:
> Hi Nick,
>=20
> On Mon, Apr 13, 2020 at 10:53:03PM +1000, Nicholas Piggin wrote:
>> For platforms that define HAVE_ARCH_HUGE_VMAP and support PMD vmap mappi=
ngs,
>> have vmalloc attempt to allocate PMD-sized pages first, before falling b=
ack
>> to small pages. Allocations which use something other than PAGE_KERNEL
>> protections are not permitted to use huge pages yet, not all callers exp=
ect
>> this (e.g., module allocations vs strict module rwx).
>>=20
>> This gives a 6x reduction in dTLB misses for a `git diff` (of linux), fr=
om
>> 45600 to 6500 and a 2.2% reduction in cycles on a 2-node POWER9.
>=20
> I wonder if it's worth extending vmap() to handle higher order pages in
> a similar way? That might be helpful for tracing PMUs such as Arm SPE,
> where the CPU streams tracing data out to a virtually addressed buffer
> (see rb_alloc_aux_page()).

Yeah it becomes pretty trivial to do that with VM_HUGE_PAGES after
this patch, I have something to do it but no callers ready yet, if
you have an easy one we can add it.

>> This can result in more internal fragmentation and memory overhead for a
>> given allocation. It can also cause greater NUMA unbalance on hashdist
>> allocations.
>>=20
>> There may be other callers that expect small pages under vmalloc but use
>> PAGE_KERNEL, I'm not sure if it's feasible to catch them all. An
>> alternative would be a new function or flag which enables large mappings=
,
>> and use that in callers.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  include/linux/vmalloc.h |   2 +
>>  mm/vmalloc.c            | 135 +++++++++++++++++++++++++++++-----------
>>  2 files changed, 102 insertions(+), 35 deletions(-)
>>=20
>> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
>> index 291313a7e663..853b82eac192 100644
>> --- a/include/linux/vmalloc.h
>> +++ b/include/linux/vmalloc.h
>> @@ -24,6 +24,7 @@ struct notifier_block;		/* in notifier.h */
>>  #define VM_UNINITIALIZED	0x00000020	/* vm_struct is not fully initializ=
ed */
>>  #define VM_NO_GUARD		0x00000040      /* don't add guard page */
>>  #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory =
*/
>> +#define VM_HUGE_PAGES		0x00000100	/* may use huge pages */
>=20
> Please can you add a check for this in the arm64 change_memory_common()
> code? Other architectures might need something similar, but we need to
> forbid changing memory attributes for portions of the huge page.

Yeah good idea, I can look about adding some more checks.

>=20
> In general, I'm a bit wary of software table walkers tripping over this.
> For example, I don't think apply_to_existing_page_range() can handle
> huge mappings at all, but the one user (KASAN) only ever uses page mappin=
gs
> so it's ok there.

Right, I have something to warn for apply to page range (and looking
at adding support for bigger pages). It doesn't even have a test and
warn at the moment which isn't good practice IMO so we should add one
even without huge vmap.

>=20
>> @@ -2325,9 +2356,11 @@ static struct vm_struct *__get_vm_area_node(unsig=
ned long size,
>>  	if (unlikely(!size))
>>  		return NULL;
>> =20
>> -	if (flags & VM_IOREMAP)
>> -		align =3D 1ul << clamp_t(int, get_count_order_long(size),
>> -				       PAGE_SHIFT, IOREMAP_MAX_ORDER);
>> +	if (flags & VM_IOREMAP) {
>> +		align =3D max(align,
>> +			    1ul << clamp_t(int, get_count_order_long(size),
>> +					   PAGE_SHIFT, IOREMAP_MAX_ORDER));
>> +	}
>=20
>=20
> I don't follow this part. Please could you explain why you're potentially
> aligning above IOREMAP_MAX_ORDER? It doesn't seem to follow from the rest
> of the patch.

Trying to remember. If the caller asks for a particular alignment we=20
shouldn't reduce it. Should put it in another patch.

Thanks,
Nick
