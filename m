Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBFF4E4C4B;
	Wed, 14 Oct 2026 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970715; cv=none; b=A6JxeiPsz0X9JUby/x4I2WBhHkUqKs5wAfySyGv9DB9FZGTqxCeahPUnwwEt5DVjs8HYq5NLXCS0RUXGQUB8tydOAzj4KKiv1/8DoKyb183xTknR3aaLJsj7UJthIosMtYXK4EwGzhI4PgcamrW1ZhclnM9NITlS8UtakWPZY7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970715; c=relaxed/simple;
	bh=AxKdmJrP0IH3YpfUlw2dNutWImngnRPxoK/25soqHT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OS4d5KNNySyw76rkShDOD1hi+7bzRwXfNHjYZdYpid9YbcYWpXSxdVU3xpBXny3y9iFiyuvYYevfV8BLvn+6WnmG0AWK68e+JLKhUPUVQjgu9Lk6IvVuuo/gMkngIsLeGMLJEUe1d4UTaYk0xuPFrBTlYNuTQXXeWlopho6NWFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eG0jUYG+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eG0jUYG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FDB1F00A08;
	Wed, 14 Oct 2026 09:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791970714;
	bh=KpXJrzBDyvJvMZGQ7sWNVin16ZGNhFmi7scpeRJwY88=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eG0jUYG+FHPC1mIGBXF1XswYvWqsvCRJ5g1WeWMqfBOTk7qeccaNz1bXKpRGDLiWt
	 cl814MgIVDFjDkY4hxw9NYvt+1ChdY6Kn8HS9OwlJkdOiiXm1ldSZ0oSBYupNcL4Kb
	 VMdOWNcagKOW3CvJ5kbtm5qf1Int1kDfIV+OSf1vhkEoWBalH/u2c+tsnjSPqKr3ei
	 zggVoHfRQ2+BPJMcXv5+UwWqjabHz/WNlmQHjgaTe5OnDEDOpCGSWZmh0PbVsiG52t
	 0w8/QCPoUnwTtiB/3rNIJKxqhnGkAnXbnQvNkO3Gdj5lCMMTd0Itd04ZifoMYQMA8v
	 bt7T7IiHlzFOQ==
Message-ID: <e4bbf208-41d3-480f-92c4-231d69a749cd@kernel.org>
Date: Wed, 14 Oct 2026 11:37:48 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] riscv: mm: use proper set_pXd() for generic
 compile-time folded patable in vmalloc_fault()
To: Yeoreum Yun <yeoreum.yun@arm.com>, Russell King <linux@armlinux.org.uk>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-openrisc@vger.kernel.org
References: <20260921-dummy_ptxp3-v1-0-cd40cf68242e@arm.com>
 <20260921-dummy_ptxp3-v1-11-cd40cf68242e@arm.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20260921-dummy_ptxp3-v1-11-cd40cf68242e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/26 12:55, Yeoreum Yun wrote:
> The behaviour of pXdp_get() will change with generic compile-time folded
> page tables, making it invalid to use set_pXd() with the result of
> pXdp_get(). Instead, the appropriate first-level set_pXd() must be paired
> with the corresponding pXdp_get().
> 
> Therefore, call the appropriate set_pXd() for generic compile-time folded
> page tables so that vmalloc_fault() continues to handle folded entries
> correctly when checking pXd_present().
> 
> There should be no functional change.
> 
> Since most architectures use a similar pattern to handle vmalloc fault
> by syncing the faulted entry, it would be worth cleaning this up by
> introducing a common helper in the near future.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---

@ Riscv maintainers, is this good enough until we get some more generic cleanups
in this area?


>  arch/riscv/mm/fault.c | 52 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 33 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 04ed6f8acae4f..b2bcaf10d13f1 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -167,14 +167,16 @@ bad_area(struct pt_regs *regs, struct mm_struct *mm, int code,
>  
>  static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long addr)
>  {
> -	pgd_t *pgd, *pgd_k;
> -	pud_t *pud_k;
> -	p4d_t *p4d_k;
> -	pmd_t *pmd_k;
> -	pte_t *pte_k;
> +	pgd_t *pgdp_k, *pgdp, pgd_k;
> +	p4d_t *p4dp_k, *p4dp;
> +	pud_t *pudp_k, *pudp, pud_k;
> +	pmd_t *pmdp_k, *pmdp, pmd_k;
> +	pte_t *ptep_k;
>  	int index;
>  	unsigned long pfn;
>  
> +	BUILD_BUG_ON(CONFIG_PGTABLE_LEVELS != 5 && CONFIG_PGTABLE_LEVELS != 2);
> +
>  	/* User mode accesses just cause a SIGSEGV */
>  	if (user_mode(regs))
>  		return do_trap(regs, SIGSEGV, code, addr);
> @@ -189,39 +191,51 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
>  	 */
>  	index = pgd_index(addr);
>  	pfn = csr_read(CSR_SATP) & SATP_PPN;
> -	pgd = (pgd_t *)pfn_to_virt(pfn) + index;
> -	pgd_k = init_mm.pgd + index;
>  
> -	if (!pgd_present(pgdp_get(pgd_k))) {
> +	pgdp = (pgd_t *)pfn_to_virt(pfn) + index;
> +	pgdp_k = init_mm.pgd + index;
> +
> +	pgd_k = pgdp_get(pgdp_k);
> +	if (!pgd_present(pgd_k)) {
>  		no_context(regs, addr);
>  		return;
>  	}
> -	set_pgd(pgd, pgdp_get(pgd_k));
> +	if (CONFIG_PGTABLE_LEVELS == 5)
> +		set_pgd(pgdp, pgd_k);
>  
> -	p4d_k = p4d_offset(pgd_k, addr);
> -	if (!p4d_present(p4dp_get(p4d_k))) {
> +	p4dp = p4d_offset(pgdp, addr);
> +	p4dp_k = p4d_offset(pgdp_k, addr);
> +	if (!p4d_present(p4dp_get(p4dp_k))) {
>  		no_context(regs, addr);
>  		return;
>  	}
>  
> -	pud_k = pud_offset(p4d_k, addr);
> -	if (!pud_present(pudp_get(pud_k))) {
> +	pudp = pud_offset(p4dp, addr);
> +	pudp_k = pud_offset(p4dp_k, addr);
> +
> +	pud_k = pudp_get(pudp_k);
> +	if (!pud_present(pud_k)) {
>  		no_context(regs, addr);
>  		return;
>  	}
> -	if (pud_leaf(pudp_get(pud_k)))
> +	if (pud_leaf(pud_k))
>  		goto flush_tlb;
>  
>  	/*
>  	 * Since the vmalloc area is global, it is unnecessary
>  	 * to copy individual PTEs
>  	 */
> -	pmd_k = pmd_offset(pud_k, addr);
> -	if (!pmd_present(pmdp_get(pmd_k))) {
> +	pmdp = pmd_offset(pudp, addr);
> +	pmdp_k = pmd_offset(pudp_k, addr);
> +
> +	pmd_k = pmdp_get(pmdp_k);
> +	if (!pmd_present(pmd_k)) {
>  		no_context(regs, addr);
>  		return;
>  	}
> -	if (pmd_leaf(pmdp_get(pmd_k)))
> +	if (CONFIG_PGTABLE_LEVELS == 2)
> +		set_pmd(pmdp, pmd_k);
> +	if (pmd_leaf(pmd_k))
>  		goto flush_tlb;
>  
>  	/*
> @@ -230,8 +244,8 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
>  	 * addresses. If we don't do this, this will just
>  	 * silently loop forever.
>  	 */
> -	pte_k = pte_offset_kernel(pmd_k, addr);
> -	if (!pte_present(ptep_get(pte_k))) {
> +	ptep_k = pte_offset_kernel(pmdp_k, addr);
> +	if (!pte_present(ptep_get(ptep_k))) {
>  		no_context(regs, addr);
>  		return;
>  	}
> 


-- 
Cheers,

David
