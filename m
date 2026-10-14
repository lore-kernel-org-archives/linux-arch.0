Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CD14EE868;
	Wed, 14 Oct 2026 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970871; cv=none; b=AWo/pYh2hMCDb8qjlRXdwTdvAUXtof3228tniVqFwE2Auu5m26MfmCeiLWkJj7SbyFp79C9Y9lkjTIpjBuevx8ciExTyq2flm9OVBwErpSTGBYQC/jSn2QP0gbcSgzQvYe3UAG3Q1e/lf7aFU7MaDAByPgraywFud5+Qmf0hlNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970871; c=relaxed/simple;
	bh=IZ8rfk5wxLDPpZ+dPdITJwhlPRFAwVPL9jnNAGRlXks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBdI4ATm9l/O8vSZbY+zE1Qj9dl4YCuCpckLgcP+OxPWHPUbukNG7ZH3yU5LeK/iGLc0ypQgVVpZjoOWQzVNKMbcCoP5ji7YPN/MsouQLIBDEB93L3GNPj9J1M0dUugamBm0gGA1I9E9t44BNu9/5ljHLwDFZ7dp/8YtvUGalGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=V92y/KLn; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="V92y/KLn"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87B1E1476;
	Wed, 14 Oct 2026 02:41:05 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AF293F7B4;
	Wed, 14 Oct 2026 02:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791970868; bh=IZ8rfk5wxLDPpZ+dPdITJwhlPRFAwVPL9jnNAGRlXks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V92y/KLn+QFs1dHeT5iQbY8pAfel4csa8XC0I/lkv0KHx1K2TT47ezllvr0uhly/0
	 015KPOYKeVKGO+UgOwsPrd/6b/fuoIlM6ngOfqHLEiWFVMzudL5X5ZAHOlmapDgTxZ
	 T0WIJMCN2wo4aeW9rp9i0FoWrlPYfah9XjcOeeQM=
Date: Wed, 14 Oct 2026 10:40:58 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
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
	linux-openrisc@vger.kernel.org,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: [PATCH 00/21] mm: change behavior of pXdp_get()/pXd_page() in
 compile-time folded pgtable
Message-ID: <as9OKt7pg-vkJDz9@e129823.arm.com>
References: <20260921-dummy_ptxp3-v1-0-cd40cf68242e@arm.com>
 <as36bbrMVHOESsLd@e129823.arm.com>
 <ef5b6275-d15b-4192-a278-ab23235956a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef5b6275-d15b-4192-a278-ab23235956a0@kernel.org>

> On 10/13/26 11:31, Yeoreum Yun wrote:
> > Hi all,
> > 
> > May I ask there are any further comments on this series?
> 
> Let's resend after -rc1.
> 
> I think most arch changes are reasonably simple and uncontroversial.

Acked.

> 
> But I'd prefer if riscv maintainers could have a look at
> 
>   [PATCH 11/21] riscv: mm: use proper set_pXd() for generic compile-time folded
>   patable in vmalloc_fault()
> 
> You are working on some general vmalloc_fault() cleanups, but until we have them
> I would hope to get an ACK from riscv maintainers that this temporary solution
> is good to go in.

Hopefully. Thanks!

-- 
Sincerely,
Yeoreum Yun
