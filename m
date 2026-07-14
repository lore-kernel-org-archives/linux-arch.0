Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47132DB79F;
	Tue, 14 Jul 2026 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053751; cv=none; b=Z79FbCgLCneGN+T6qt1sWY2YgbPGnwM9kQvPPLdDzPCnFYeV8AIhy8Eno80+TvqkYd9fsm5mAkr5XeAYIyljrJXUIXDnlXyvWCaHiAsUWQlv0ieFAXVe1T872jrwjaQP0hwfqRjY1nNQdE+xjRVTV4zAttksjxuqKKoDl/jidAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053751; c=relaxed/simple;
	bh=Q1RaqZFJWDyzCpzM1YydwuIkdx6+prWZv8uRlRqjdPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zdz+GkH3ONs/ics7G0RP/NrhsM3l7m7B4A6IwD+sw04brI6m8Cp2KLcYJVHE3Wr4FnPo7i0oSbz3GJe0y8f5yhoDhCnIhfUlBGiAuQT/L3uDvunxec0bxzcnIL5QzoEnGFAPLQ/bMx+DqPjmIsDqGTsdsmwWFpZSxyv6jDT9S+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qQBkYOYv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qQBkYOYv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CECC5339;
	Tue, 14 Jul 2026 11:29:04 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B86773F7D8;
	Tue, 14 Jul 2026 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784053749; bh=Q1RaqZFJWDyzCpzM1YydwuIkdx6+prWZv8uRlRqjdPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qQBkYOYvll6kV7ChEqyEs9q4KbHl0/kv64+7ai5nhYymyDIN8BvOvG1HzfhI1sCcI
	 qnEtCqga3FrW8+7FXBrXN5emMU1ez24iSDr20rEKRSLvtMZ9oCz/5VlGhBuCnHlKFi
	 ME8BD+bOTZVCgK3PWVNAk87A3Vsa2vT+e5mfIs0s=
Date: Tue, 14 Jul 2026 19:28:56 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Dave Hansen <dave.hansen@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-arch@vger.kernel.org, kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org, x86@kernel.org, linux-mm@kvack.org,
	kasan-dev@googlegroups.com, linux-csky@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
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
Subject: Re: [RFC PATCH 10/34] x86: mm: carve out the generic compile-time
 folded pgtable case in effective_prot()
Message-ID: <alZ_6HFc56zC7tt0@e129823.arm.com>
References: <32d459d1-ad19-4baf-bbb1-0565458001d2@intel.com>
 <3ea30f8a-bb29-4bf5-8400-1c4840d46a88@kernel.org>
 <7e84b200-25eb-43a6-b5e2-5f27f2d82a77@intel.com>
 <31988089-095a-4eed-b5e2-c677c70f79f6@kernel.org>
 <14e250db-1641-4085-8d13-02f819657d5f@intel.com>
 <d83c76b3-ea4d-4c41-b4c5-f5ae558ace55@kernel.org>
 <alYgMxKqRnF6_X0A@e129823.arm.com>
 <6df814c9-405c-48d8-96ea-929c4b28949b@intel.com>
 <alZe-Cu7yQw9qRXU@e129823.arm.com>
 <2d51a1ad-85be-46bf-ac36-18eca199b449@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d51a1ad-85be-46bf-ac36-18eca199b449@kernel.org>

On Tue, Jul 14, 2026 at 06:31:22PM +0200, David Hildenbrand (Arm) wrote:
> 
> >> This makes a *ton* of sense in effective_prot() especially. Its entire
> >> job is mirroring the hardware's job of inheriting permissions from
> >> higher levels of the page tables and enforcing them on lower level leaf
> >> entries. If a higher level is folded, there's nothing to inherit.
> >>
> >> I also think it's worth taking a brief pause on the coding to think
> >> about what kind of design would actually be nice here. If the design
> >> really is that the pgd is folded, the 'struct mm_walk_ops' code would
> >> ideally not even call ->pgd_entry(). It would just (for example) *start*
> >> at ->pud_entry() for a 3-level hardware page table.
> >>
> >> If there are no pgds, why bother calling ->pgd_entry()? It couldn't be
> >> done transparently to mm_walk users of course but it could be done
> >> incrementally where users move one at a time over to a new scheme.
> > 
> > Agree. Calling a pXd_entry() about folded one seems meaningless.
> > But seems enough to check mm_pXd_folded() before calling pXd_entry()
> > in each walk_pXd_range().
> 
> Needs some double-checking that callers can handle it (like effective_prot()
> would currently not), but certainly something to look into!

Most of mm_walk_ops *implicitly* handles the folded pgtable case
(e.x) pXd_none() / pXd_present() and other can handle explicitly in
its own handler.

But, IMHO, It would be better to skip calling pXd_entry() in the
walk_pXd_range() by checking the folded and this is clearer conceptually.

For this, it  requires the rewrite the walk_mm() where use only *p4d_entry()*
to gather the leaf/non-leaf information for MGLRU.

-- 
Sincerely,
Yeoreum Yun
