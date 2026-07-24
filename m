Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1C53F3277;
	Fri, 24 Jul 2026 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893808; cv=none; b=MslVczY+4KM3zt9llfr7AoC0PTWpxlIfUYc0tnAG0W16OuvNwhhL08sOL4AT1oIIxCbY6Ra8iC9pq4fx20atRY4Xc3M+BZh498IBAXzKT2n4TlPNzXlJn/4+v+P960rQXPHezXfwRRa+HWolGtXMudA3Ku/vT1O3NcBu3Ab5yC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893808; c=relaxed/simple;
	bh=lSGi/T62Qz3zkTtfJoxDSfari9OyrmBQakjPywG4Wwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCYlX3jhN2tXei4LOb9g58TxuMs4F/4UptLpIxXsGuIqYW/fpdiePygVNfbtKONTT+WVTEHA8aaMz9Oa7IsPwYARnpGelN6Dq22QqPeIumZHYxC8JMgx0pWs5VrDKCBxs21JqLoL4jZ0srQ49SqEwUtFxrvTgJCESsGxISa947s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=onlJqJS2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="onlJqJS2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA1941477;
	Fri, 24 Jul 2026 04:49:55 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F2463F59E;
	Fri, 24 Jul 2026 04:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784893799; bh=lSGi/T62Qz3zkTtfJoxDSfari9OyrmBQakjPywG4Wwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=onlJqJS22YoDsKaG6SiKSkuKsNv+WmGR0K4ecfdNyqZf1u/+3JEGvSxKfGGrvm5nJ
	 MXCh4HNavE1AO8qDTOoQLnL6W10waJKQJvwWm9dJxKiy7ypA0biilE7i0COMFUcgAZ
	 cBx7VbhxE8imKHXZsbg7suIUPJzdyNKYFStD+n4k=
Date: Fri, 24 Jul 2026 12:49:45 +0100
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
	Stafford Horne <shorne@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-openrisc@vger.kernel.org
Subject: Re: [PATCH RFC v2 14/20] x86: mm: skip pud setup when using generic
 compile-time folded pagetable
Message-ID: <amNRWR-8BCBNU0sR@e129823.arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <20260722-dummy_ptxp3-v2-14-d9e4bad31e0a@arm.com>
 <0ea931f1-4801-4d32-b6ce-4787a8d3daa9@intel.com>
 <amD7ab_KuJPdBQBh@e129823.arm.com>
 <6f5060a7-0a64-49fc-81a3-ae88729ef794@intel.com>
 <amElnEbvRTjv2hyU@e129823.arm.com>
 <3620750c-54d7-45a0-b067-bc813dd3cd9b@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3620750c-54d7-45a0-b067-bc813dd3cd9b@intel.com>

On Wed, Jul 22, 2026 at 01:22:04PM -0700, Dave Hansen wrote:
> On 7/22/26 13:18, Yeoreum Yun wrote:
> > Sorry. But do you mean check with cpu_feature_enabled() not with
> > boot_cpu_has()?
> > IIRC, the boot_cpu_has() doesn't use the DISABLE_MASK_BIT_SET() but
> > uses REQUIRED_MASK_BIT_SET() and I don't expect it wouldn't make
> > an optimisation to constant check which is contrast to DISABLE_MASK_BIT_SET().
> 
> Ahh, yes. I forgot about that nuance! Moving to cpu_feature_enabled()
> would be great!

When I see again, using cpu_feature_enabled(), this would give a chance
to optimisation when the feature disabled and there would be no harm for
when feature enabled since cpu_feature_enabbled() also fallback to
boot_cpu_has().

So, it might be good to change with cpu_feature_enabled() as we
discussed.

@Dave, Should I send above change separately or include it in this patch?

-- 
Sincerely,
Yeoreum Yun
