Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173A343C05E;
	Mon, 21 Sep 2026 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022412; cv=none; b=MhRvGszv3i3YDBEp60SZvMzzkvU00jg8tXlDeCGUIoBbmnW2oXi2niRWYWqNqGp8PaNbKAOz4ONUfc/DbMeBXd4QNtASdj++6p/z53L/2/ln6sn75bBNst6mvFY5a4FlozMc/lqPkVJX9MFPcoB2KhE+VOKFoX9O/uXCgXwTKPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022412; c=relaxed/simple;
	bh=YR8KjfryI7McmdGWbe5RjCYF03qe877YQVcwQ4evUyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTX/QEn1Ji894oyz++0D+vJAcw/0aHMg9iXM6SvlC4IBw98JT9TfIOO8CO2iscVj6uVdGO6JZpOvPljFs0zYSdkQIclV/ft9VyEZ2AKBJOAXcJ1PMlwyCXbZ8UZyNMDs+R0VV3IdY7GqwNs3cv/uBSfyfMAB0XC2yWV+S91vsJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZJQgJ1u3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZJQgJ1u3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E89C5176C;
	Mon, 21 Sep 2026 13:26:45 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19DCC3F632;
	Mon, 21 Sep 2026 13:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790022409; bh=YR8KjfryI7McmdGWbe5RjCYF03qe877YQVcwQ4evUyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZJQgJ1u3+XbrE14CRndMnlfvZodRjo8Owgd4VUfyb4ysv/TCeswI4E1slRGuH0ZC5
	 gEB41b7eQMFvIpiPafng381AyyipSmuL+EUBfZkrewzD7VQyDMaw6gvMc8JJ8U+oLq
	 2RkB+DvgV9b00Ftlc/0AMEXk2kIo1XjoleH7ftTk=
Date: Mon, 21 Sep 2026 21:26:40 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Randy Dunlap <rdunlap@infradead.org>
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
Subject: Re: [PATCH 21/21] Documentation: mm: clarify behaviour of
 compile-time folded page tables
Message-ID: <arGTAMyNaJVjKiuC@e129823.arm.com>
References: <20260921-dummy_ptxp3-v1-0-cd40cf68242e@arm.com>
 <20260921-dummy_ptxp3-v1-21-cd40cf68242e@arm.com>
 <c0c67459-6b75-4bcd-b068-3752e23afbf6@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0c67459-6b75-4bcd-b068-3752e23afbf6@infradead.org>

Hi Randy,

> 
> 
> On 9/21/26 3:55 AM, Yeoreum Yun wrote:
> > From: "David Hildenbrand (Arm)" <david@kernel.org>
> > 
> > Compile-time folded page tables are not necessarily easy to understand, and even
> > people the were once familiar with the concept might need to refresh their memory.
> > 
> > Add proper documentation, including a nice diagram, for the current design.
> > Mention details about dummy functions, including the recently changed pXdp_get()
> > helpers.
> > 
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> Documentation/mm/page_tables.rst:197: WARNING: Bullet list ends without a blank line; unexpected unindent. [docutils]
> 
> See below for a fix.

[...]

> > +Note that the arrows from PGD to NOP4D represent page-table-walker
> > +transitions, not pointers stored in the pgd entries.
> > +
> > +Using p4d as an example, `nop4d`/`p4d folded` translates to the following:
> > +
> > +- p4d is considered folded into pgd; both are operating on the same page
> > + table.
> 
>      table.
> (add one more prefix space to align the indentation)
> 

Thanks! I'll fix it!

[...]
-- 
Sincerely,
Yeoreum Yun
