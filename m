Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252EC480DC9;
	Thu,  6 Aug 2026 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036362; cv=none; b=k3hNH6uozU3WXLcvJCvIgfCTQZbTU4GfFZ9ksBfYoBIP77I/b4m/5T5hcacN/FSb45XDqkuaaNAQisZfS9bbHdXXUFAlfbLGMLL7Kfl41z2I3NPHSbIQBgE5sxDO6CPQHyg2bsFHZmYkfSavXh32KthmT/9e3VeCOD0YGC9LjX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036362; c=relaxed/simple;
	bh=0CVtiwf8Rea49LMoUx7r0FaUR1c1SczGdyIe/liq/ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSHeGfzwUKXjUCWMgNJtBp2TqrjSZCORBSoqkbNJhuUhzZXm/Wq/3RqfBG4aBUkuZg/7uPYdmnjjPZfVB59/naMc83YCtUCYa8sp2fw3gBwPMSf1Dge9egcQIdo0bC8aQcPcZK7ybc0Y9ONzUTGGGbZDjyTR5InyyFXfZd4JAwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8OYpXn/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8OYpXn/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BA71F000E9;
	Thu,  6 Aug 2026 17:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036361;
	bh=i2yjrrVc+H/dOZF8X/JCAszDBzatuRJpY6enVbVkXDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c8OYpXn/lbymZWYNNGPbBk8+3HfighE8u/aLjR6Id3SpcMlVswuIxuoFT6i8+sJVG
	 33bgpDZK07lgJdRnLMQQM5x5OHdfGvrUlwrg07n1Vrb5Uhrfcf7XF85qEDFGTpmbzJ
	 qifqGwAx2bDkh0NXTIgleM+IkLM3PHw2BFHX6yZMbeRqljFQbSRqJcqKkhvmOKwx4y
	 8hBZqfwDXrrUJpo3Surfw1/jC6G5IUWLTS95IreVfJCJJxrzmp1dOhdDQ+kcloC6rE
	 eCHWu6iyOrudRbovBNdMtzXkfpZdjrLsc4CWBTA/u9nkgylUVc+I/jIl/BOLL8csMs
	 892czlr7RY3TA==
From: Will Deacon <will@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-openrisc@vger.kernel.org
Subject: Re: [PATCH RFC v2 00/20] mm: optimize unnecessary loads due to ptep_get() and friends out
Date: Thu,  6 Aug 2026 18:11:50 +0100
Message-ID: <178601690203.388302.5785771709606318463.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 22 Jul 2026 16:30:08 +0100, Yeoreum Yun wrote:
> Using ptep_get() and its counterparts in common code is suboptimal on
> kernel configurations with generic compile-time folded page tables.
> By default, ptep_get() and its friends expands to READ_ONCE(),
> forcing the compiler to emit a load even when the value is not used afterwards.
> 
> This issue was recently reported by Christophe Leroy [1] for ppc32
> preventing futher code conversion to ptep_get()/pmdp_get()/... helper
> and the same behavior can also be observed on arm64 when built with
> 2- or 3-level page tables
> 
> [...]

Applied the arm64 patch on the end to arm64 (for-next/mm), thanks!

[20/20] arm64: pgtable: convert pte_present() from macro to static inline
        https://git.kernel.org/arm64/c/3b56ebafecc4

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
