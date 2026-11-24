Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795539957;
	b=PutiI5ctFsxI4aXG/EshvDDO7PGzmXF8K42NDR95Bqq1hJAXDQHMFIYHsot3v7BgZ+/G
	 4X9kR0TGPWJVPERBuPCdTCuYrRw1aDbfIpx8eBMs2wPcvg2G4g4El7UHtt3yeDw9zUAx4
	 2EN4TiO0kkDguu8snSh5EPN+HmHwo1trfpFsHvG6WmI9wG+7UcmArIOhWa1jaI93CS+hd
	 DeghQX7nWq/HWVe+DzObA2BDYuW2v0rZA4e4MyLieOiShHdgpTJeCjwqtfY9RoCGAURX8
	 aOhKbFMDI1jH2E+5bk7h9mfbBdZHMUvHkoIO/t4TNDC4giJ4QaWIFr7vEoTzjBggKGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539957;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cEp/cXDtvYTiH8Vp1GK2CqYt15Bi6PXi0it+ySjQOVc=;
	b=dY4QLchuU6MA147eesKlpdmq1cTsssIUWsZxFAyNh82pi2M6ChFwhv31C5z+URg2hRNX
	 87zuekccpuYbCsnup2cpuWHhjQACF2OQxLTTRIySiOg0b81NjNAFJr1nPzvhntNKmkW8o
	 1NM80Ek7oAwxi99ccrRpV3gQt4iu8P2P1MKCb8o6dg920MtidLrsGH6EufmYRN8g0O7JW
	 /sP7PmzDZDvnLXiRZkbyTlYZenr37h2BG/0PhmlSXcMTn/yzAspGsl2033xRySCB1p+OA
	 P+5ygoZPd/sBx2OUQmgJIYll7tSWTTt7aMcFmnpQ36FsoXWDw958VQDg186LIIlStcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bni2B9pu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC76606A31E;
	Tue, 24 Nov 2026 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bni2B9pu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1346D1F000C0;
	Tue, 24 Nov 2026 17:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795539957;
	bh=cEp/cXDtvYTiH8Vp1GK2CqYt15Bi6PXi0it+ySjQOVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bni2B9puF7kfV9Am5t1Ov8WQVRWkWZkohYhFYaAOCp/DQ8YyK4hiNB/6DDEmutNnx
	 9DItMmeG9wGbsSnTa/2g6Bc+qZD0MoOo2QOCjGO0RuxOqF3Tm1xaa1EZJ9bnO6HeVo
	 aY1UKSh6mwdd27HE+ANXhvMJYuMadmQYUspZ9MtLopcJo2kqu6TZRKLJOQ+VmUeRA8
	 BHSro9BNahirHyqaXlAUVp75XTw4Ei0heRmarVboAGmlnTryJvfEdsallK7L2ZowDl
	 Fuw7NBHUoexrLNsU88p9DA3WymGQjoLqXzSxY/kk/t5a2Ys6NENMpuN8WNAadIMoey
	 tbOkOgbd3/Bhg==
Date: Tue, 24 Nov 2026 19:05:38 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Russell King <linux@armlinux.org.uk>,
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
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-openrisc@vger.kernel.org
Subject: Re: [PATCH RESEND v2 12/21] mm/pgtable: redefine PGTABLE_LEVEL enum
 with ascend order from PGD
Message-ID: <awXD4i47F-VAG1tD@kernel.org>
References: <20261102-dummy_ptxp3-v2-0-78840b2ec73c@arm.com>
 <20261102-dummy_ptxp3-v2-12-78840b2ec73c@arm.com>
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
In-Reply-To: <20261102-dummy_ptxp3-v2-12-78840b2ec73c@arm.com>

On Mon, Nov 02, 2026 at 11:21:25AM +0000, Yeoreum Yun wrote:
> The PGTABLE_LEVEL enum values appear to be ordered in the opposite direction
> from their intended usage.
> 
> Intuitively, higher page table levels should have smaller enum values,
> but PTE is currently assigned 0.

That's not what x86 thinks :)
They even expose it in /proc/vmstat with smaller numbers meaning lower levels

$ grep direct_map /proc/vmstat 
direct_map_level2_splits 152
direct_map_level3_splits 4
direct_map_level2_collapses 0
direct_map_level3_collapses 0

Just an observation, I don't mind either order.
 
> For consistency and cleanup, reverse the enum value ordering.
> 
> Since there is no current user relies on these numbers to be ascending from
> PTE->PGD, so it can be changed to be ascending from PGD->PTE, in the
> direction of the page table walk.
> 
> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  include/linux/pgtable.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 780fe849ff8b7..a032f95943357 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -2288,11 +2288,11 @@ static inline bool arch_has_pfn_modify_check(void)
>  typedef unsigned int pgtbl_mod_mask;
>  
>  enum pgtable_level {
> -	PGTABLE_LEVEL_PTE = 0,
> -	PGTABLE_LEVEL_PMD,
> -	PGTABLE_LEVEL_PUD,
> +	PGTABLE_LEVEL_PGD = 0,
>  	PGTABLE_LEVEL_P4D,
> -	PGTABLE_LEVEL_PGD,
> +	PGTABLE_LEVEL_PUD,
> +	PGTABLE_LEVEL_PMD,
> +	PGTABLE_LEVEL_PTE,
>  };
>  
>  static inline const char *pgtable_level_to_str(enum pgtable_level level)
> 
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
