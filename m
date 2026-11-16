Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850886;
	b=qsTOTLHQyy3+2ZRC5cix5I8hzCDet1kAct47VMsbihPGvkUDbKeYLK9Ud6aSowN6yC+H
	 5zByQMw80xHqxg09KQHBkrAiOLDDgVYVj7Y/tea+y1bzftxwxNpQ2CGkvDJWJinC361n6
	 +QaCsGjsmYqOAw6eDjin0bhbjGGR/UC4TylJKT8hAFu9/l/PWqsnGV2MitGmbKcSenaK2
	 CdN0FZ6bHwtmjfOBisqX5UcdFMjGtnQJMrSH61ubrS6A+XJ5hup79Imm9lN+KIfgcQKIM
	 p9wgHR9q4AwmRXEUO0gPw7zzYSSyyHzbnvdY9fQ8HZkXTmxduaOt1s13wgn8OmbDqRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850886;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ch/BM/lENfR/J2/TnwIZqowCLj2KAkaLmppsgvcuwmY=;
	b=xx+UB30e6nZBgPxeHzgIzYvTqDgkd4czVQWglkB+qUvPZyXrj3zbCv764R+ZQzj0+sNW
	 660s3uBkuwSI6N9D79Y6ZETod7pQJ4QY+GM3DHhekLr7wUWoJl5XwJYsaw9RtMBoVlTsJ
	 B3GjmjJwx6ZcKBEp3ARfT92+GsmvEskpF8znd+nTT4SFQmREwl5SJ+nW+0QVCHWQY3vHJ
	 W0ZqIX6KiZvkcTsaO4ScgkH4z2PF3LT5fjdqO9sYvWqi11KDRki97JKjVcqYsWJiyXXTJ
	 2ayFmi1CjOz00E+Y95UkwqaUq/GgRvnDS/JlHVhT6/nY66evhIlB2pq4nhMl3ixcP+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="VG/Kk1/H";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33339606A31C;
	Mon, 16 Nov 2026 17:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33339606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VG/Kk1/H
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3260A1684;
	Mon, 16 Nov 2026 09:41:22 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1ECB73F632;
	Mon, 16 Nov 2026 09:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794850885; bh=DJXLQoLiGRbRJ+1smSfQs3/6Lkrk8ODrlYWu8BnlA00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VG/Kk1/Hm7a1RCkojQzH3TfEGbFCMCdZBSdIQjb7FeNVmUGMUZy58kcZMku6lOZsS
	 y169/1y6JoIbmOKKanzJyn1ciIo6W3230WeN1uCk/y3+S7HCx6aFqY1VgaSiWKEaZ8
	 XMtniXb6xIQr4QvploJN+iUys049C/iJsVz38he8=
Date: Mon, 16 Nov 2026 17:41:20 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Zi Yan <ziy@nvidia.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] mm: distinguish HW PTE pointers from SW PTE value
 pointers
Message-ID: <avtAQCkvRr1xkxMF@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-pte0-v3-0-5670b8cb9059@arm.com>

Hi Usama,

(trimmed the Cc list, some lists reject it as too many recipients)

On Tue, Sep 22, 2026 at 06:12:28PM +0100, Muhammad Usama Anjum wrote:
> pte_t currently describes both a software PTE value and an element stored
> in a PTE table. Consequently, pte_t * can point either to a software PTE
> value, often a stack copy, or to a PTE-table slot. The compiler cannot
> distinguish these cases. A value pointer can therefore be passed to an
> interface that expects table storage, while table storage can be read by
> direct dereference instead of the architecture accessor.
> 
> This series begins a staged conversion at the PTE level. It introduces
> hw_pte_t as the element type for PTE-table storage and converts generic
> MM to use hw_pte_t *. Software PTE values remain pte_t. Interfaces that
> intentionally return a value through pte_t *, such as install_pte,
> remain value interfaces; the relevant parameters are named ptentp to
> make that distinction explicit.

[...]

> PMD, PUD, P4D and PGD storage are deliberately out of scope. They can be
> converted in later series after the PTE boundary is agreed, avoiding the
> PMD-specific cases that made an all-level conversion difficult to
> review.

I looked at this (and the arm64 counterpart) and I'm not fully convinced
it's worth the effort (but I won't oppose it if the mm folk decide to go
this route).

First, I'd like to see all such on-stack p*d pointers addressed as a
prerequisite (e.g. fix pmd_populate() in __split_huge_zero_page_pmd()).
If for some reason we deem pmd not fixable, I don't like half (or
quarter) baked solutions just addressing the pte.

Second, we could add a run-time page table check, at least for pmd/pte.
Something like below, gated by CONFIG_PAGE_TABLE_CHECK or
CONFIG_DEBUG_VM (untested and not entirely sure about using
PageTable()):

static inline void pgtable_ptr_check(struct mm_struct *mm, const void *p)
{
	if (object_is_on_stack(p)) {
		WARN_ON_ONCE(1);
		return;
	}
	if (mm != &init_mm && virt_addr_valid(p))
		WARN_ON_ONCE(!PageTable(virt_to_page(p)));
}

You already have some coccinelle patches to make the conversion. Could
we turn them into a coccicheck to detect new uses? With LLM reviews like
Sashiko, we can probably catch new uses violating the requirement (we
need to document it).

LLMs and coccicheck won't catch all abuses nor does this series prevent
one from declaring hw_pte_t on the stack.

Once the above are in place, I'd look again at these patches and see
whether they improve code clarity and are worth the churn.

Maybe an argument in favour of these patchsets is future dynamic support
for FEAT_D128, we'd need to separate the software representation of a
pte from the hardware one but we've done this before (arm32 non-LPAE has
different representations).

That said, patch 2 (naming the software PTE value pointers ptentp) could
go in independently. Same for David's suggestion on patch 5 to replace
the huge_ptep_clear_flush() stub with a plain declaration.

Thanks.

-- 
Catalin
