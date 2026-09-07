Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D1F431A50;
	Mon,  7 Sep 2026 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768396; cv=none; b=dHGG+VHNIornYVeP76dZCuMsrlfOJZDvEF+Bt7jcAIqgZAcz7YTdzk560sGbs9KUSOkoUd4ZgmiV4/JU0Nj69p6j3K/cXop7O44sUoczqdjZCN5NpnAke8Y/d3QvSA7oXJRtvW2CalFbXzfAqHUtGH9IOXerDFx0eooZJH/Wr0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768396; c=relaxed/simple;
	bh=M02Zz7duqtLH9w5WcLt9dmTeIbG6UdWlqLh0VhnRN2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V07BUIOu0YwokM7WGJLCk63sdt2LOAiz1A7VaaF3l3OIall834L5kpklt3OFD2G91BtEUDYN2kkMW/rOfzKZ/mMp9z+dhjGhjCwcnVFI6QN980td4IWWBvajrtHHce5jFeX7zZcriJwS9UqL7T43xODRMgkir4F/rksvWeS+BF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vX9YEFxm; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vX9YEFxm"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB1BC1477;
	Mon,  7 Sep 2026 01:06:29 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18C753F7D8;
	Mon,  7 Sep 2026 01:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788768393; bh=M02Zz7duqtLH9w5WcLt9dmTeIbG6UdWlqLh0VhnRN2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vX9YEFxmN++GHfkO2xxc2HRCAVQZnfcF+y1vVz4p+I67mwn/6aHZjc3V5wQk92028
	 QjFA4Ff9sydSH7mdW6Ml8i/iDQuE/cqvG/ChPtrzIxW16rDWLljleu6TZ5iGFYY1Y2
	 dWFeU1IDBLwdUjSKvUI2sIAZ7djSAJVGofJYXeo8=
Date: Mon, 7 Sep 2026 09:06:24 +0100
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
Subject: Re: [PATCH RFC v3 13/21] x86: mm: use pgtable_level enum in
 effective_prot_pXd()
Message-ID: <ap5wgC-J6Byt7nPS@e129823.arm.com>
References: <20260902-dummy_ptxp3-v3-0-5d8f5b17c25c@arm.com>
 <20260902-dummy_ptxp3-v3-13-5d8f5b17c25c@arm.com>
 <8f3979a9-238a-4d7d-a040-6aa526fedec5@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f3979a9-238a-4d7d-a040-6aa526fedec5@intel.com>

On Wed, Sep 02, 2026 at 01:48:03PM -0700, Dave Hansen wrote:
> On 9/2/26 04:56, Yeoreum Yun wrote:
> > Instead of using hard-coded integer in effective_prot_pXd(), use
> > pgtable level enum.
> 
> Does this actually *do* anything? ;)
> 
> I guess it's nice to have a wee bit of type safety from the enum and it
> means that you don't have to *know* which level number a PUD is, for
> example.
> 
> Either way:
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks!

-- 
Sincerely,
Yeoreum Yun
