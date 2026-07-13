Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321CC30F92D;
	Mon, 13 Jul 2026 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954908; cv=none; b=uZTC6orhQwQVhrtE1xGU+gXJz3adppi8NizLbcUZ6RpQiy4IC9ugHgrDf1kGTYpKI1eBPFxnx7f84waLe/QWpSgZS7xn4JLPFhYdNO5BbJF4nppdenNy6aabeK7RlKdsghx+pB4B5J9kfp4BK9iP3dTN/Xp2lu4VlI+HlR2Ckok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954908; c=relaxed/simple;
	bh=9w80m56EnZdV2ckCQq9WOh+dgxbLKrdljH3QH/Zl0XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPtxUR88zYySxVR3Si+ZIMGXA2Bi6tTbOsYHfvyGof8/5NMDN5WY+X3ZCnQDh14ByWea43Jjy/mPgw3nyBFPTCQi0HVkB9bIttlUiaxKpVd/Mp7OAlJZTWneD1PP/WInsiUin0fk0A/leB3GYyNbmU0+V1CtAmCq/QbDpWunft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W5eOVh/z; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="W5eOVh/z"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A67B1576;
	Mon, 13 Jul 2026 08:01:42 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 161493F7B4;
	Mon, 13 Jul 2026 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783954906; bh=9w80m56EnZdV2ckCQq9WOh+dgxbLKrdljH3QH/Zl0XA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5eOVh/zOqm17OUoBLtYwVfeD63WSFSCtTMrWpLtRFIn78Q4rc+1NKCnG4FVAdhdB
	 /ca8if0c03QwXj0RcqJO2zYZXUUTyt5Zzn3asCiVnRZHfwC3awBIneOdO0AiWLfqtf
	 i8rHL6kn8R+poGRr0mrVPUMuZFgH8TTvhOQBLcCk=
Date: Mon, 13 Jul 2026 16:01:31 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	x86@kernel.org, linux-mm@kvack.org, kasan-dev@googlegroups.com,
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org, david@kernel.org,
	linux@armlinux.org.uk, akpm@linux-foundation.org,
	ankur.a.arora@oracle.com, rppt@kernel.org, linmag7@gmail.com,
	chleroy@kernel.org, klarasmodin@gmail.com, chenhuacai@kernel.org,
	kernel@xen0n.name, kas@kernel.org, zhangtianyang@loongson.cn,
	wangyuli@aosc.io, tsbogend@alpha.franken.de, ljs@kernel.org,
	jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
	arnd@arndb.de, ryan.roberts@arm.com, pasha.tatashin@soleen.com,
	rmclure@linux.ibm.com, baolin.wang@linux.alibaba.com, tj@kernel.org,
	kevin.brodsky@arm.com, anup@brainfault.org, atish.patra@linux.dev,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, dave.hansen@linux.intel.com, luto@kernel.org,
	peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, hannes@cmpxchg.org, mhocko@kernel.org,
	qi.zheng@linux.dev, shakeel.butt@linux.dev, kasong@tencent.com,
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, ryabinin.a.a@gmail.com, glider@google.com,
	andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	anshuman.khandual@arm.com, yang@os.amperecomputing.com,
	chaitanyas.prakash@arm.com, ardb@kernel.org, guoren@kernel.org,
	yang.li85200@gmail.com, viro@zeniv.linux.org.uk,
	dinguyen@kernel.org, schuster.simon@siemens-energy.com,
	wangruikang@iscas.ac.cn, junhui.liu@pigmoral.tech,
	muchun.song@linux.dev, vishal.moola@gmail.com, namcao@linutronix.de,
	pavel@kernel.org, djbw@kernel.org, yu-cheng.yu@intel.com,
	baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
	coxu@redhat.com, andreas@gaisler.com, liam@infradead.org,
	vbabka@kernel.org, surenb@google.com, mhocko@suse.com,
	geert@linux-m68k.org, shorne@gmail.com, jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi
Subject: Re: [RFC PATCH 19/34] x86: power: use proper set_pXd() for generic
 compile-time folded patable in resume_one_md_table_init()
Message-ID: <alT9y_JRznnBq8sQ@e129823.arm.com>
References: <20260713135614.1618183-1-yeoreum.yun@arm.com>
 <20260713135614.1618183-20-yeoreum.yun@arm.com>
 <595e5ba5-0bc4-4630-b8f0-8637298076ce@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <595e5ba5-0bc4-4630-b8f0-8637298076ce@intel.com>

> On 7/13/26 06:55, Yeoreum Yun wrote:
> > @@ -134,11 +129,12 @@ static inline void resume_init_first_level_page_table(pgd_t *pg_dir)
> >  {
> >  #ifdef CONFIG_X86_PAE
> >  	int i;
> > +	pud_t *pud = pud_offset(p4d_offset(pg_dir, 0), 0);
> >  
> >  	/* Init entries of the first-level page table to the zero page */
> >  	for (i = 0; i < PTRS_PER_PGD; i++)
> > -		set_pgd(pg_dir + i,
> > -			__pgd(__pa(empty_zero_page) | _PAGE_PRESENT));
> > +		set_pud(pud + i,
> > +			__pud(__pa(empty_zero_page) | _PAGE_PRESENT));
> >  #endif
> >  }
> 
> If this is the way forward, it's going to require the retraining of some
> awfully old brain cells.
> 
> It also doesn't really read correctly. Loop over each PGD entry:
> 
> 	for (i = 0; i < PTRS_PER_PGD; i++)
> 
> ... and set a pud?
> 
> 		set_pud(...)
> 
> I'm not sure how I'd ever learn the rules to write this code from
> scratch. Right now, the code says: "The pgd_t is the top level of the
> page tables. I know there are PTRS_PER_PGD of those top level entries
> entries I need to 'zero'."
> 
> You don't have to know what is folded, just that you're dealing with the
> top level.
> 
> But *this* code says:
> 
> 1. The pgd_t is the top level of the page tables. Start there.
> 2. "Walk" down *two* (folded) levels
> 3. Set the third-level (pud) entries to 'zero'
> 
> So the code now *has* to know how the folding occurs.
> 
> This seems really hard to work with to me.

Actually, This is what the patch series want.
IOW, the "code" need to consider the folded pgtable level and
use a proper APIs.

Might for the clarification, change a PTRS_PER_PGD to PTRS_PER_PUD
seems better. but the using set_pgd() seems much more worse since
second argument type is p4d_t which doesn't exist in the p4d folded case.

IOW, this patch wants to use proper API for the real first page table
level. for example, X86_PAE's pgtable level is 3 so not use pgd friends function
but use a pud to setup first page table entries.

-- 
Sincerely,
Yeoreum Yun
