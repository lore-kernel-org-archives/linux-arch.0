Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189CC417BEA;
	Tue, 14 Jul 2026 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051957; cv=none; b=DtRMVCpMq9Id/SmpEchUvr8TikKbnWj3p5FSN4Qemo5PDJ9fxlfaRkGM4iiWKRWiMbY4x3bHPqzGtB+Kj4ct4i0rFwBSyAzL9d1kMKG9J8+elMhcVaU1dGlwyjVOBupdmFhumWtum+oRBU902a6Ot2EXIOUure9XMBbleFR9cOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051957; c=relaxed/simple;
	bh=YLSO3cj4uznp59HTo6K3Y3qLIJ+ISsuvzTFqOw8DO8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeQoaLdyCMb5JG3lyYNQI6W2JQG4BPLy1ZexAcE4X+NLl2Wk+hhE5zGSngzNn8BdytCjr2RrUuE1HXgGnEnGaNW+J+yGncxB9s+dqNVeoIluCSDBD5S7Z5O4aYpiHGZKmQXfgcI16TaF1H+oUAHJV23y/oTxSWq9mbjiGGZ1Phk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Sy24kfg6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Sy24kfg6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27E89339;
	Tue, 14 Jul 2026 10:59:06 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13F4F3F915;
	Tue, 14 Jul 2026 10:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784051950; bh=YLSO3cj4uznp59HTo6K3Y3qLIJ+ISsuvzTFqOw8DO8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sy24kfg6zd8pNJNRop/ip6vK3z44QuvSe+ei7yBDMgOJ+AmuCVqSqQsYm6AbuGoqC
	 lZJ+hB5IynonlF0Xd5xFhRT6j05I3fGK7eqV9iwp4S7UfNaW857WlXcvL4lT3vU6jA
	 Qslx6H13Q5aAiK/4ThVrFPZNAc560M7EpnY0APes=
Date: Tue, 14 Jul 2026 18:58:57 +0100
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
Message-ID: <alZ44XdgTEVFX6jU@e129823.arm.com>
References: <3ea30f8a-bb29-4bf5-8400-1c4840d46a88@kernel.org>
 <7e84b200-25eb-43a6-b5e2-5f27f2d82a77@intel.com>
 <31988089-095a-4eed-b5e2-c677c70f79f6@kernel.org>
 <14e250db-1641-4085-8d13-02f819657d5f@intel.com>
 <d83c76b3-ea4d-4c41-b4c5-f5ae558ace55@kernel.org>
 <alYgMxKqRnF6_X0A@e129823.arm.com>
 <6df814c9-405c-48d8-96ea-929c4b28949b@intel.com>
 <alZe-Cu7yQw9qRXU@e129823.arm.com>
 <alZo9feSrSB_StfO@e129823.arm.com>
 <7cff02d6-d3ce-4315-b667-34911fc6f321@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cff02d6-d3ce-4315-b667-34911fc6f321@kernel.org>

On Tue, Jul 14, 2026 at 07:29:38PM +0200, David Hildenbrand (Arm) wrote:
> On 7/14/26 18:51, Yeoreum Yun wrote:
> > On Tue, Jul 14, 2026 at 05:08:24PM +0100, Yeoreum Yun wrote:
> >> On Tue, Jul 14, 2026 at 07:35:19AM -0700, Dave Hansen wrote:
> >>>
> >>> This is indeed an improvement and a step in the right direction! Thanks
> >>> for looking at this.
> >>>
> >>> But one of my test for whether it's good x86 code is whether there's any
> >>> actually x86-specific logic in it. Isn't this basically a translation
> >>> between the integer level number and whether it is folded?
> >>>
> >>> That seems like a common helper that more than one arch could use. Could
> >>> this be stuck in a helper so that all arch/x86 has to do is:
> >>>
> >>> 	if (mm_pt_level_folded(mm, level))
> >>> 		return;
> >>
> >> Yes. at least the level semantic in ptdump (pgd is level 0,
> >> p4d is level 1, ...) is same to all archs where use ptdump.
> >> So It seems reasonable to add this common helper in ptdump.c
> >>
> > 
> > Furthermore, the effective_prot() need to require to identify whether
> > it's the first pgtable to prevent the inheriting from dummy value.
> > So I think it seems to make a ptdump_pt_level_first() like:
> > 
> > diff --git a/mm/ptdump.c b/mm/ptdump.c
> > index 973020000096c..2ec5700e4be5e 100644
> > --- a/mm/ptdump.c
> > +++ b/mm/ptdump.c
> > @@ -190,6 +190,23 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
> >         st->note_page_flush(st);
> >  }
> > 
> > +bool pdtump_pt_level_first(struct mm_struct *mm, int level)
> > +{
> > +       if (!mm || level > CONFIG_PGTABLE_LEVELS)
> > +               return false;
> 
> Do we actually ever get !mm ?

Yes. for the case of s390 use mm anyway for folded check.
> 
> -- 
> Cheers,
> 
> David

-- 
Sincerely,
Yeoreum Yun
