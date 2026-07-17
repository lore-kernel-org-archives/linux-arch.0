Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1673032B118;
	Fri, 17 Jul 2026 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274951; cv=none; b=XO8RDzq0zLC/KcbwiFnSyV1aRc7teo+MuvQTtmhyPW3MWvACoEVoWFdJH3AnJfTQbtITEBJBGbjLAxIbCeKDbw86Va8gPwTWu2IPPa+cGd+zMqCkP5ID9D8vz6/v67fPw7qe7OqOf79BKSI7KXiMu43RHBzJ591F/4Uxm/MktZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274951; c=relaxed/simple;
	bh=VCEVOs29qy41aLYqLsGVMHFWJos3BWY8pBqqujyqSaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXXGwRAyOJi6Z6fZGwSEReO96Nlb/2g4dLoSmo+KcFydPcO36+A+p6d07Xq32zjo9GnY/z4JgXLn1b1spyAwx4RfMxT1QwJ7jijmcQiJvVqdLQwF/cm8BnvI5LConEK63delyYFdGlJYenTjil/BrT/YSWrjzlDQTJ4ENkqW7ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DU+ugemJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DU+ugemJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E66881477;
	Fri, 17 Jul 2026 00:55:43 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAAC53F7B4;
	Fri, 17 Jul 2026 00:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784274948; bh=VCEVOs29qy41aLYqLsGVMHFWJos3BWY8pBqqujyqSaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DU+ugemJvHBveBuL7dk8dm1kcBJotHvCGONmuQ5C4OeV57RJUzo7ZQjdR10jl5Jx7
	 5L9Qh62wclbS5bjS5wPcNYuj7MV0SVESp9mh+ohyQWIHooRsWMeuoL7g/xSUEC0PGr
	 Xt2Bp1YeFZMziIbvkg6+QSc6bbWvC8xsO7Wptwks=
Date: Fri, 17 Jul 2026 08:55:34 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Pedro Falcato <pfalcato@suse.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	x86@kernel.org, linux-mm@kvack.org, kasan-dev@googlegroups.com,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-m68k@lists.linux-m68k.org,
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Klara Modin <klarasmodin@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	"Kirill A. Shutemov" <kas@kernel.org>, zhangtianyang@loongson.cn,
	wangyuli@aosc.io, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Lorenzo Stoakes <ljs@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rohan McLure <rmclure@linux.ibm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Tejun Heo <tj@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>,
	Anup Patel <anup@brainfault.org>, atish.patra@linux.dev,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, qi.zheng@linux.dev,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>, chaitanyas.prakash@arm.com,
	Ard Biesheuvel <ardb@kernel.org>, guoren <guoren@kernel.org>,
	yang.li85200@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	"schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>, junhui.liu@pigmoral.tech,
	Muchun Song <muchun.song@linux.dev>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Nam Cao <namcao@linutronix.de>, Pavel Machek <pavel@kernel.org>,
	djbw@kernel.org, yu-cheng.yu@intel.com,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Coiby Xu <coxu@redhat.com>, Andreas Larsson <andreas@gaisler.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: Re: [RFC PATCH 02/34] ARM: mm: make 2-level pgd_t a scalar
Message-ID: <alnf9noAVTTpCtaC@e129823.arm.com>
References: <20260713135614.1618183-1-yeoreum.yun@arm.com>
 <20260713135614.1618183-3-yeoreum.yun@arm.com>
 <alYL7B0HAvmLVHGU@pedro-suse>
 <b7dbc476-1477-4004-93b3-c5e667e24df8@app.fastmail.com>
 <alkrWNECXmoxkrUC@e129823.arm.com>
 <4c3067df-20f0-43e8-8e62-354888afac04@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c3067df-20f0-43e8-8e62-354888afac04@app.fastmail.com>

On Fri, Jul 17, 2026 at 08:16:55AM +0200, Arnd Bergmann wrote:
> On Thu, Jul 16, 2026, at 21:04, Yeoreum Yun wrote:
> >>
> >> > Ugh. This isn't correct C code. It only works because the kernel passes
> >> > -fno-strict-aliasing.
> >> 
> >> I think the bigger problem is the code dereferencing the pgd
> >> pointer in the first place: Since the pgd pair is written in
> >> 32-bit units in __pmd_populate(), anything reading it would
> >> technically have to operate on both entries.
> >> 
> >> As the kernel relies on -fno-strict-aliasing, the type mismatch
> >> is less of a problem than actually doing the potentially wrong
> >> thing.
> >> 
> >> As far as I can tell, we are however saved by pgd_val()
> >> only ever being used for debug prints, where printing
> >> the first entry is likely all that is needed to analyse
> >> the real bug.
> >> 
> >> > I would recommend either forcing a struct here, or
> >> > using a u64 with bitmasks/shifts.
> >> 
> >> That would require extra complexity for the big-endian
> >> case though.
> >
> > Agree. And since the users of pgd_val() mostly uses with
> > pmd_pfn(), pmd_page() and etc. I think it doesn't matter to return
> > lower pmdval_t or higher one.
> >
> > Therefore, without considering endianess, it's enough with downcast
> > like:
> >
> >    #define pgd_val(x)      ((pmdval_t)x)
> >
> > Could we apply this in next version?
> 
> I would just leave the original version here, at least it
> keeps the current behavior for something that is easy to
> get wrong. Taking the second entry on big-endian sounds
> counterintuitive, especially when you have a hugetlb
> mapping where the two don't just point to the same page.

Thanks. Even my simple tests with GCC versions 8.5.0 through 16.1.0 in [0],
did not spill to the stack. So keeping David's original implementation
seems reasonable.

Link: [0] https://www.kernel.org/pub/tools/crosstool/

-- 
Sincerely,
Yeoreum Yun
