Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853104;
	b=G0JtEyGd2Chyh9bjLH9oz6eCkcbAn1CMcI+Vsao+f7wH46sxnoqJfrlfRzEJxyKWLAz8
	 5aH44itj/aHd3X0ME9UYlygQIFVmtGiLupJ5WX20Dg17sqOlnH2G7wsESTAoAWv2+lGyp
	 DECY69988WezWmfAtABGy4hb++gU9K4bvDziNZeaQ0Fn5m5v5srWFfyzAsFgcX4dL6qQK
	 tRqnFlxE+8OiC3HirqdrkBrneAZoyNF2yoD2Ub40xYPSbZR3zGDX4t4u3w/23qUY3UJYF
	 POT1eXgEqdqBssaI47RBG4bHfQvG6kiboXQjjbcU4CbY4nPMxjzQznLmawDhcROth+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853104;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=qL4/l55pGUGWSAIO6OSncYUCy29jhWmdy2ivz63FHbE=;
	b=dERYE3wLvpIQJTaTz2dITdFPKniq/kbcWv1K8gX7aVDcKKXTm2usZOrdQmNjogkR9RL/
	 X/1A3bWrqYXbbHkCATsSNQZb/wkkVkIJ50o50XhCBpjuoest4+yU8kS1coW+CFUg05Hmi
	 zvZUg6p0HvFgSarf+J947/ut29Gb2FhhmXdTjGQKOOBKd69H6h9eae/qgb5dwv2uqXQhs
	 PymH9tFXi5CsxPw5ld9XzMgX83DuhvE53j7AxkMHZcxpS98QAkUKyqWzf76UZkl+ANwtE
	 ltNdkv6dk1t8JxNeQ5VKGhg6/zc4jEOEcNIeAcGLnfA5ChNnEth1mp7KFxhAPWk1xJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z4iyAAAY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089D8606A31C;
	Mon, 16 Nov 2026 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z4iyAAAY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FB21F000C4;
	Mon, 16 Nov 2026 18:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853103;
	bh=qL4/l55pGUGWSAIO6OSncYUCy29jhWmdy2ivz63FHbE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Z4iyAAAYQPwaam7VtqCSBShg65aWzrs7n36xuSqQuhpOVVhCoBskBPpBq8JTPnrnp
	 vE1+zDLFyUf51S6/serw8Pgy08eyljZmk4MhuhDD+4z+wAeTpx6l/T6RCvYyV4tz7i
	 ZlJ0eO8SBsLKCFxEUm1eZ9c/UAuEszmwn4bxMSl+1g82oFy+9QXMHCRueJrIutl7Em
	 L+MraKa6fbG+FMPGQv99w4g6jH1mKq8T1cE3MCvpmAL0D5SVPLgcyqKziSeI4G6hVE
	 btde7eAe3tCWEh8Mjo/taGe2xImjB+E1Uo1qi5+B9Y3uiaAMCva1Mi6/eTZDuUyK0q
	 0hKjJPY9yEtiQ==
Message-ID: <5a6f351e-0a68-4bbf-a9fc-5bb39d8439a4@kernel.org>
Date: Mon, 16 Nov 2026 19:18:16 +0100
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] mm: distinguish HW PTE pointers from SW PTE value
 pointers
To: Catalin Marinas <catalin.marinas@arm.com>,
 Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Zi Yan <ziy@nvidia.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Samuel Holland <samuel.holland@sifive.com>, Peter Xu <peterx@redhat.com>,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <avtAQCkvRr1xkxMF@arm.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <avtAQCkvRr1xkxMF@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/26 18:41, Catalin Marinas wrote:
> Hi Usama,
> 
Hi,

David here :)

> (trimmed the Cc list, some lists reject it as too many recipients)
> 
> On Tue, Sep 22, 2026 at 06:12:28PM +0100, Muhammad Usama Anjum wrote:
>> pte_t currently describes both a software PTE value and an element stored
>> in a PTE table. Consequently, pte_t * can point either to a software PTE
>> value, often a stack copy, or to a PTE-table slot. The compiler cannot
>> distinguish these cases. A value pointer can therefore be passed to an
>> interface that expects table storage, while table storage can be read by
>> direct dereference instead of the architecture accessor.
>>
>> This series begins a staged conversion at the PTE level. It introduces
>> hw_pte_t as the element type for PTE-table storage and converts generic
>> MM to use hw_pte_t *. Software PTE values remain pte_t. Interfaces that
>> intentionally return a value through pte_t *, such as install_pte,
>> remain value interfaces; the relevant parameters are named ptentp to
>> make that distinction explicit.
> 
> [...]
> 
>> PMD, PUD, P4D and PGD storage are deliberately out of scope. They can be
>> converted in later series after the PTE boundary is agreed, avoiding the
>> PMD-specific cases that made an all-level conversion difficult to
>> review.
> 
> I looked at this (and the arm64 counterpart) and I'm not fully convinced
> it's worth the effort (but I won't oppose it if the mm folk decide to go
> this route).

I think this is the right thing to do to get type safety.

> 
> First, I'd like to see all such on-stack p*d pointers addressed as a
> prerequisite (e.g. fix pmd_populate() in __split_huge_zero_page_pmd()).
> If for some reason we deem pmd not fixable, I don't like half (or
> quarter) baked solutions just addressing the pte.

IIRC doing the full PxD conversion is quite big; doens't make sense to post
these on the list and instead move stepwise.

Agreed that it would be nice to get rid of all stack usage first.

> 
> Second, we could add a run-time page table check, at least for pmd/pte.
> Something like below, gated by CONFIG_PAGE_TABLE_CHECK or
> CONFIG_DEBUG_VM (untested and not entirely sure about using
> PageTable()):
> 
> static inline void pgtable_ptr_check(struct mm_struct *mm, const void *p)
> {
> 	if (object_is_on_stack(p)) {
> 		WARN_ON_ONCE(1);
> 		return;
> 	}
> 	if (mm != &init_mm && virt_addr_valid(p))
> 		WARN_ON_ONCE(!PageTable(virt_to_page(p)));
> }
> 
> You already have some coccinelle patches to make the conversion. Could
> we turn them into a coccicheck to detect new uses? With LLM reviews like
> Sashiko, we can probably catch new uses violating the requirement (we
> need to document it).
> 
> LLMs and coccicheck won't catch all abuses nor does this series prevent
> one from declaring hw_pte_t on the stack.
> 
> Once the above are in place, I'd look again at these patches and see
> whether they improve code clarity and are worth the churn.
> 
> Maybe an argument in favour of these patchsets is future dynamic support
> for FEAT_D128, we'd need to separate the software representation of a
> pte from the hardware one but we've done this before (arm32 non-LPAE has
> different representations).

Exactly; we'll need this and go one step further and disallow any ptep++ to
instead route this through helpers.

-- 
Cheers,

David
