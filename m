From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Date: Fri, 03 Jul 2020 10:15:34 +1000
Message-ID: <1593735251.svr5r5cxle.astroid@bobo.none>
References: <20200413125303.423864-1-npiggin@gmail.com>
        <20200413125303.423864-5-npiggin@gmail.com>
        <d148f86c-b27b-63fb-31d2-35b8f52ec540@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGCAPm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 20:15:42 -0400
In-Reply-To: <d148f86c-b27b-63fb-31d2-35b8f52ec540@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org, Zefan Li <lizefan@huawei.com>
Cc: =?iso-8859-1?q?Borislav=0A?= Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, =?iso-8859-1?q?Thomas=0A?= Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, x86@kernel.org

Excerpts from Zefan Li's message of July 1, 2020 5:10 pm:
>>  static void *__vmalloc_node(unsigned long size, unsigned long align,
>> -			    gfp_t gfp_mask, pgprot_t prot,
>> -			    int node, const void *caller);
>> +			gfp_t gfp_mask, pgprot_t prot, unsigned long vm_flags,
>> +			int node, const void *caller);
>>  static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask=
,
>> -				 pgprot_t prot, int node)
>> +				 pgprot_t prot, unsigned int page_shift,
>> +				 int node)
>>  {
>>  	struct page **pages;
>> +	unsigned long addr =3D (unsigned long)area->addr;
>> +	unsigned long size =3D get_vm_area_size(area);
>> +	unsigned int page_order =3D page_shift - PAGE_SHIFT;
>>  	unsigned int nr_pages, array_size, i;
>>  	const gfp_t nested_gfp =3D (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
>>  	const gfp_t alloc_mask =3D gfp_mask | __GFP_NOWARN;
>>  	const gfp_t highmem_mask =3D (gfp_mask & (GFP_DMA | GFP_DMA32)) ?
>> -					0 :
>> -					__GFP_HIGHMEM;
>> +					0 : __GFP_HIGHMEM;
>> =20
>> -	nr_pages =3D get_vm_area_size(area) >> PAGE_SHIFT;
>> +	nr_pages =3D size >> page_shift;
>=20
> while try out this patchset, we encountered a BUG_ON in account_kernel_st=
ack()
> in kernel/fork.c.
>=20
> BUG_ON(vm->nr_pages !=3D THREAD_SIZE / PAGE_SIZE);
>=20
> which obviously should be updated accordingly.

Thanks for finding that. We may have to change this around a bit so=20
nr_pages still appears to be in PAGE_SIZE units for anybody looking.

Thanks,
Nick
