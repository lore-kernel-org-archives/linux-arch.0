Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DF0446839;
	Tue, 21 Jul 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655934; cv=none; b=mFltk9SDfXxUeSpwI4r+sPIOU7dJqwqtU80dtxjIvHH80V6fHzDpngiGSfVqpqn70mNOw3F7NNLUvPbA7MJ38odv3X7p3Ts3lXDS8lwX+F+vrPnt6S9bB3lQdfyWcXplBtOX7pNLqVYc64n1bx6YwzdOKcnTGWOlogu1nNyxlSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655934; c=relaxed/simple;
	bh=hrYivZRwvgo4Jln4t+vd90e0saYnNKOsQL0oUJ6U/zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFXcj5FseyKjibD5GbSei3SmDveV8umTN3/vz5yQ8FxotUxgtkCItWovZgjTiQ3V2V6MXGP+RgBdaTckoGsk/reC4xrttA75Siyk5TdTPsjoixJMuM+M3mgVpLpFRaAYq5mAaCm2awE9rsyP6vbvTPXA9Ud7i1gFdVO6ayLvb8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YcdJ0SMk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YcdJ0SMk"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD47A1AC1;
	Tue, 21 Jul 2026 10:45:27 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 873643F58B;
	Tue, 21 Jul 2026 10:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784655931; bh=hrYivZRwvgo4Jln4t+vd90e0saYnNKOsQL0oUJ6U/zA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcdJ0SMkJGlBA6zcU5v7DCrlzSEWCTP6ZWedBSSkSSjm8uzBucCY02WFFlppbTou0
	 7Vtk7Wne8hYcoyIusG8mtsWATS11C/0DiJBcsPsfedbFHDz9wkKju5sMGuQL/9I8hl
	 uF20WzjU/fp1spnK9FfiincvEjVknHZCmFNVhFQs=
Date: Tue, 21 Jul 2026 18:45:17 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Yeoreum Yun <yeoreum.yun@arm.com>,
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
Message-ID: <al-wLXp0tAv7hNv-@e129823.arm.com>
References: <ac365196-8ccc-4d8b-83d7-28fec763e75c@kernel.org>
 <710b7eb0-8e0c-4f07-991c-2285c77e1beb@intel.com>
 <6007625e-c3f9-4ad6-99a8-61396bccbcec@kernel.org>
 <32d459d1-ad19-4baf-bbb1-0565458001d2@intel.com>
 <3ea30f8a-bb29-4bf5-8400-1c4840d46a88@kernel.org>
 <7e84b200-25eb-43a6-b5e2-5f27f2d82a77@intel.com>
 <31988089-095a-4eed-b5e2-c677c70f79f6@kernel.org>
 <14e250db-1641-4085-8d13-02f819657d5f@intel.com>
 <d83c76b3-ea4d-4c41-b4c5-f5ae558ace55@kernel.org>
 <alYgMxKqRnF6_X0A@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alYgMxKqRnF6_X0A@e129823.arm.com>

Hi,

> > On 7/13/26 23:40, Dave Hansen wrote:
> > > On 7/13/26 14:17, David Hildenbrand (Arm) wrote:
> > >>> To me, the double READ_ONCE() is a non-issue.
> > >> To other arch maintainers, it is!
> > > 
> > > Ahh, so it seems like Christophe in ppc32 land was looking at this more
> > > like a regression that needed to get fixed.
> > 
> > Yes, exactly. :)
> > 
> > And I agree that it is something we should be optimizing.
> > 
> > > 
> > > Christophe, just out of curiosity, was this something that was causing
> > > you practical problems like measurable performance regressions, or was
> > > it really just insane code generation that seems unacceptably suboptimal?
> > 
> > I'd be curious about that as well. I mean, looking at the generated code
> > it's clear that it is suboptimal.
> > 
> > 
> > The solution space I see:
> > 
> > 
> > (1) Pass the result from e.g., pgdp_get() into p4d_get(), so it can just return 
> >     the value with folded p4ds.
> > 
> > That requires extreme amounts of churn in core-mm AFAIKS, so I don't see that as feasible.
> > 
> > 
> > (2) Rewrite folding code to make p4d_present() be a dummy instead of 
> >     pgd_present(), and make p4dp_get() return a dummy value.
> > 
> > ... a lot of churn across architectures. I'm sure we'll learn soon why it was done 
> > ike the way it is today in the first place. Something interesting to look at,
> > certainly, but a bit of a stretch just to optimize reads.
> > 
> > 
> > (3) Make folded pgdp_get() use an ordinary read instead of a READ_ONCE / dummy.
> > 
> > I don't like that, because we couldn't catch easily if the value is then
> > actually used some old/new code.
> > 
> > If pgd_present() etc are supposed to ignore the value, I'd rather have a mechanism
> > that enforces that the values are actually ignore in pgd_offset() etc as well.
> > 
> > 
> > (4) What we do in this series, but instead of forbidding set_pgd(), make it only 
> >     complain when we are passing in a dummy value.
> > 
> > The expectation is that it would avoid touching most architecture code in patch
> > 12 -> 27 and still prevent mistakes in the future.
> > 
> > @Yeoreum can you play with that and see what the end result would be?

If there's no comment anymore for (4), Could I post next version on tomorrow?

Thanks.

[...]

-- 
Sincerely,
Yeoreum Yun
