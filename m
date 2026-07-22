Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DD2368D4D;
	Wed, 22 Jul 2026 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741464; cv=none; b=hSRmAh1jkTThGuvTjPNLuTkqbxNG0vttbYTQQ6jBgZZWVtkeEiNSmqaHykuGb5CMTSiZQBmm/N5iHCll6XETkKxQq9pUy2fUqwagHWcz1akIXsHTZ20zdMaiyBbItrpWb9ih2a0V9nbT2L1UoG4VF6NKofebxEKyeELeQqma/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741464; c=relaxed/simple;
	bh=24jF6AcUqs8OWEGAaLR69DLBQjR9hO+Rom+3K8DJQKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrUPZX+HF7WQ9TaRZVwLMaRu5nRTeks742PZ8mdI8Vnq5MboVmAHs6OsjChy6+0eySjxxaPWZbF1wRlC6GbKErhw7OEQJFo4/LB2UmVVFbMUSNg7m8LgxRGijvPguIBL6dlyrjDoysUDiv3crcnDhRRVfQV5UW/kmFF+KkjQALI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=c73DPG7u; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="c73DPG7u"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC1E21595;
	Wed, 22 Jul 2026 10:30:57 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CBCB3F66F;
	Wed, 22 Jul 2026 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784741462; bh=24jF6AcUqs8OWEGAaLR69DLBQjR9hO+Rom+3K8DJQKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c73DPG7uUV5Fqsc83UkY57n5Qs0XXql23cCXWpZ2ZiqQ+ckAvgZYW4H6Qxd7IuEhg
	 UpaREG+sGAYzR3v9TgE4TzXqEnrXG7rfKfeEIP65qzbz/5t2U9GCOzbaaUSYCknPsU
	 WarfMW9lzNf8oKGScXg68Qq+UBElSke/y8/OuBEw=
Date: Wed, 22 Jul 2026 18:30:52 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>, Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-openrisc@vger.kernel.org
Subject: Re: [PATCH RFC v2 00/20] mm: optimize unnecessary loads due to
 ptep_get() and friends out
Message-ID: <amD-TLGWGdMK2ItC@e129823.arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <0143b927-08c5-4e94-ae6e-2a0d7bfe950f@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0143b927-08c5-4e94-ae6e-2a0d7bfe950f@intel.com>

> One of my nits about v1 was that it didn't really frame the series
> precisely. It talks about "optimization" instead of fundamentally
> changing the way that the kernel deals with folded page table levels.
> 
> The optimization that this *wants* to talk about kinda falls out of that
> refactoring. It's not really the core of the series, IMNHO.
> 
> This series effectively changes the rules about where and how folded
> page table levels can be manipulated. In doing that, the door is opened
> to optimizing out the unnecessary loads.

I see. might the title and the cover letter should be reparsed.
Thanks to remind it again :)

-- 
Sincerely,
Yeoreum Yun
