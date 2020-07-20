From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Date: Mon, 20 Jul 2020 12:49:02 +1000
Message-ID: <1595213278.m30kayfsvu.astroid@bobo.none>
References: <20200413125303.423864-1-npiggin@gmail.com>
        <20200413125303.423864-5-npiggin@gmail.com>
        <0e43e743-7c78-fb86-6c36-f42e6184d32c@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgGTCtI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Jul 2020 22:49:08 -0400
In-Reply-To: <0e43e743-7c78-fb86-6c36-f42e6184d32c@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org, Zefan Li <lizefan@huawei.com>
Cc: =?iso-8859-1?q?Borislav=0A?= Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, =?iso-8859-1?q?Thomas=0A?= Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, x86@kernel.org

Excerpts from Zefan Li's message of July 20, 2020 12:02 pm:
>> +static int vmap_pages_range_noflush(unsigned long start, unsigned long =
end,
>> +				    pgprot_t prot, struct page **pages,
>> +				    unsigned int page_shift)
>> +{
>> +	if (page_shift =3D=3D PAGE_SIZE) {
>=20
> Is this a typo of PAGE_SHIFT?

Oh good catch, yeah that'll always be going via the one-at-a-time route=20
and slow down the small page vmaps. Will fix.

Thanks,
Nick

>=20
>> +		return vmap_small_pages_range_noflush(start, end, prot, pages);
>> +	} else {
>> +		unsigned long addr =3D start;
>> +		unsigned int i, nr =3D (end - start) >> page_shift;
>> +
>> +		for (i =3D 0; i < nr; i++) {
>> +			int err;
>> +
>> +			err =3D vmap_range_noflush(addr,
>> +					addr + (1UL << page_shift),
>> +					__pa(page_address(pages[i])), prot,
>> +					page_shift);
>> +			if (err)
>> +				return err;
>> +
>> +			addr +=3D 1UL << page_shift;
>> +		}
>> +
>> +		return 0;
>> +	}
>> +}
>> +
>=20
