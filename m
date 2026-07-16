Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91897313534;
	Thu, 16 Jul 2026 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188204; cv=none; b=CWmJymyKPiWV5D08X3+L4Yu1GAyblhaIc4nh1rNs0QBU0P3WOY74aX7+5j+qx5cSpHylSFXFGIOxKugYwUSc63WjumRO4sDKkaNaD6IXhJsBs+73iAoBAtVE8Ma6bj/FXap8VldZnFqgP9IJ9EZCVoR3K8XQH0kTJnqyXvavlJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188204; c=relaxed/simple;
	bh=SezQaQ3kr0/h0JyFQ0VLykJSkvx0NJJphcsYvOpsEN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwlxPQbCF0y+/aYEwukNdcLl2NpTRbaShlOwMdBA93dxwx+R0Bs/QyXkMhNrjdX90ZlXhPf/j0lCC3OvgVI3hN+GS6ePLVOVOlRcVq/Hho9N2iP118u3k+x0F6U5rMW7v4zniWr2dcEUS9YYzyOzsamm/3EMpbmDGiHkKkiT3sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gQRl7YUQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gQRl7YUQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7269C168F;
	Thu, 16 Jul 2026 00:49:55 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FEE73F905;
	Thu, 16 Jul 2026 00:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784188199; bh=SezQaQ3kr0/h0JyFQ0VLykJSkvx0NJJphcsYvOpsEN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQRl7YUQCBVoiNIinaXRRJ6iLdSG3Rzd0xV0hEu2lGo5w6z86vYyNhkSIYX9L3nd9
	 q4q4/O6JNDXm4XNPNif4MOp4E6vcDqWFBACswg6z3701KGFgiJeJvUAoj008c2kew8
	 5BJk9bAjoi8xDDesBwIO6jPMcRzOrdrOp8BTmyaQ=
Date: Thu, 16 Jul 2026 08:49:47 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Dave Hansen <dave.hansen@intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
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
	shorne@gmail.com, jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi
Subject: Re: [RFC PATCH 10/34] x86: mm: carve out the generic compile-time
 folded pgtable case in effective_prot()
Message-ID: <aliNG7OGphxzH7Wr@e129823.arm.com>
References: <31988089-095a-4eed-b5e2-c677c70f79f6@kernel.org>
 <14e250db-1641-4085-8d13-02f819657d5f@intel.com>
 <d83c76b3-ea4d-4c41-b4c5-f5ae558ace55@kernel.org>
 <alYgMxKqRnF6_X0A@e129823.arm.com>
 <6df814c9-405c-48d8-96ea-929c4b28949b@intel.com>
 <alZe-Cu7yQw9qRXU@e129823.arm.com>
 <alZo9feSrSB_StfO@e129823.arm.com>
 <CAMuHMdUqL=vJFAzYgcRVNbD_VWWwhehwTuhTfwLt_yRR8c+B0g@mail.gmail.com>
 <aldV23PwIXnFloaN@e129823.arm.com>
 <CAMuHMdVOHm6MmP9QsNVvxLsGp1e0jC9u9RGb6+xee0ZBs4Zwfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVOHm6MmP9QsNVvxLsGp1e0jC9u9RGb6+xee0ZBs4Zwfw@mail.gmail.com>

On Wed, Jul 15, 2026 at 12:34:29PM +0200, Geert Uytterhoeven wrote:
> Hi Yeoreum,
> 
> On Wed, 15 Jul 2026 at 11:42, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> > > On Tue, 14 Jul 2026 at 18:51, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> > > > --- a/mm/ptdump.c
> > > > +++ b/mm/ptdump.c
> > > > @@ -190,6 +190,23 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
> > > >         st->note_page_flush(st);
> > > >  }
> > > >
> > > > +bool pdtump_pt_level_first(struct mm_struct *mm, int level)
> > > > +{
> > > > +       if (!mm || level > CONFIG_PGTABLE_LEVELS)
> > > > +               return false;
> > > > +
> > > > +       if (mm_pmd_folded(mm) && level == 3)
> > > > +               return true;
> > > > +       if (mm_pud_folded(mm) && level == 2)
> > > > +               return true;
> > > > +       if (mm_p4d_folded(mm) && level == 1)
> > > > +               return true;
> > >
> > > Is this order (... && level == ...) the optimal order?
> > > On arm64, mm_pud_folded() and mm_p4d_folded() perform several checks.
> > >
> > > > +       if (level == 0)
> > > > +               return true;
> > > > +
> > > > +       return false;
> > > > +}
> >
> > It is. since the purpose of ptdump_pt_level_first is designed to be used
> > in the *callback* of pXd_entry(). IOW, if we check level 0 first,
> > it always returns wrong return in folded case.
> 
> I meant the order inside the if () conditions.
> E.g.
> "if (mm_pud_folded(mm) && level == 2)" does the expensive check first.
> "if (level == 2 && mm_pud_folded(mm))" does the cheap check first.

Ah. Yeap that would be better. Thanks!

-- 
Sincerely,
Yeoreum Yun
