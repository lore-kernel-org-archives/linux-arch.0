Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0344328AB0B;
	Thu, 16 Jul 2026 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191685; cv=none; b=ag2P1De5SsZfTnghl9K+7IThsxAjG9PRyROXj3Ptren5LLDfL7TUyHppmAOYTZczz7rMXIZL0rU4alAtOLHbkHTYe9Bm+kvEw1pvvyBtA3kUTRvuyYX8hc2w9Bj1htC9qIExiE3kiR+L9i2kfpjboElDs/EqrhyXoRbjVD7BJ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191685; c=relaxed/simple;
	bh=7QMKKDkHs0y71hejlsCYJzHb+xCedfa9P65PLvvFIKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzznvQkVd1I6z4XL4agVkEv/HPCfnRSKbwp/YdyTVYtW/ncCfe042wJ96qoQWi/IyaZ40VsIj84XFEGuWg9bYJh8lQJpV862S8iNWj/KmC/4OrHlhM80z9L+CC6wzgXhn+Nwnavx6CU10bJMY3QPkB/SrlV3cU9WYIRJCQcQGTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=axdTxfnd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="axdTxfnd"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B9A21477;
	Thu, 16 Jul 2026 01:47:54 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49F693F7B4;
	Thu, 16 Jul 2026 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784191678; bh=7QMKKDkHs0y71hejlsCYJzHb+xCedfa9P65PLvvFIKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axdTxfndxhIm2l9wF115JT8EyHK0aYwwshKm81eWDFzjzgjVJJ7BS+4WpMIvME3P1
	 uIFkxgagimtncp13PjU0JSxgZ0WhcaaecC63vGJVGl7xPiIi3KUjXJnW5Hw9bPiUOw
	 JESTB8MB3ZDJ0nw4fAi/iJ9gtqgqsVDoZ01LWgek=
Date: Thu, 16 Jul 2026 09:47:43 +0100
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
Message-ID: <aliar2eyG2WMFWMz@e129823.arm.com>
References: <31988089-095a-4eed-b5e2-c677c70f79f6@kernel.org>
 <14e250db-1641-4085-8d13-02f819657d5f@intel.com>
 <d83c76b3-ea4d-4c41-b4c5-f5ae558ace55@kernel.org>
 <alYgMxKqRnF6_X0A@e129823.arm.com>
 <6df814c9-405c-48d8-96ea-929c4b28949b@intel.com>
 <alZe-Cu7yQw9qRXU@e129823.arm.com>
 <alZo9feSrSB_StfO@e129823.arm.com>
 <7cff02d6-d3ce-4315-b667-34911fc6f321@kernel.org>
 <alZ44XdgTEVFX6jU@e129823.arm.com>
 <a7e6a281-d1a4-42a6-9672-b1304107f888@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7e6a281-d1a4-42a6-9672-b1304107f888@kernel.org>

On Wed, Jul 15, 2026 at 11:44:51AM +0200, David Hildenbrand (Arm) wrote:
> On 7/14/26 19:58, Yeoreum Yun wrote:
> > On Tue, Jul 14, 2026 at 07:29:38PM +0200, David Hildenbrand (Arm) wrote:
> >> On 7/14/26 18:51, Yeoreum Yun wrote:
> >>>
> >>> Furthermore, the effective_prot() need to require to identify whether
> >>> it's the first pgtable to prevent the inheriting from dummy value.
> >>> So I think it seems to make a ptdump_pt_level_first() like:
> >>>
> >>> diff --git a/mm/ptdump.c b/mm/ptdump.c
> >>> index 973020000096c..2ec5700e4be5e 100644
> >>> --- a/mm/ptdump.c
> >>> +++ b/mm/ptdump.c
> >>> @@ -190,6 +190,23 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
> >>>         st->note_page_flush(st);
> >>>  }
> >>>
> >>> +bool pdtump_pt_level_first(struct mm_struct *mm, int level)
> >>> +{
> >>> +       if (!mm || level > CONFIG_PGTABLE_LEVELS)
> >>> +               return false;
> >>
> >> Do we actually ever get !mm ?
> > 
> > Yes. for the case of s390 use mm anyway for folded check.
> That's not what I meant, let me clarify.
> 
> I think in ptdump_walk_pgd() it is guaranteed that mm != NULL, so I am wondering
> why you are handling mm == NULL.

Agree. I'll remove it.
BTW, this helper is incorrect because it returns true even for folded
upper-level page tables. For example, if p4d is folded,
level 0 would still be treated as the first level.

So, it would better to the following:

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 2afa7a23340e9..4e545988953a0 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -27,6 +27,7 @@
  */
 struct pg_state {
        struct ptdump_state ptdump;
+       int first_level;
        int level;
        pgprotval_t current_prot;
        pgprotval_t effective_prot;
@@ -254,7 +255,7 @@ static void effective_prot(struct ptdump_state *pt_st, int level, u64 val)
        pgprotval_t prot = val & PTE_FLAGS_MASK;
        pgprotval_t effective;

-       if (level > 0) {
+       if (level > st->first_level) {
                pgprotval_t higher_prot = st->prot_levels[level - 1];

                effective = (higher_prot & prot & (_PAGE_USER | _PAGE_RW)) |
@@ -455,6 +456,8 @@ bool ptdump_walk_pgd_level_core(struct seq_file *m,
                .seq            = m
        };

+       st.first_level = ptdump_pt_level_first(mm);
+
        ptdump_walk_pgd(&st.ptdump, mm, pgd);

        if (!checkwx)
diff --git a/include/linux/ptdump.h b/include/linux/ptdump.h
index 240bd3bff18dd..26fa624eac44e 100644
--- a/include/linux/ptdump.h
+++ b/include/linux/ptdump.h
@@ -29,6 +29,7 @@ bool ptdump_walk_pgd_level_core(struct seq_file *m,
                                struct mm_struct *mm, pgd_t *pgd,
                                bool checkwx, bool dmesg);
 void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd);
+int ptdump_pt_level_first(struct mm_struct *mm);
 bool ptdump_check_wx(void);

 static inline void debug_checkwx(void)
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 973020000096c..b1d06ac4c0555 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -190,6 +190,17 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
        st->note_page_flush(st);
 }

+int ptdump_pt_level_first(struct mm_struct *mm)
+{
+       if (mm_pmd_folded(mm))
+               return 3;
+       if (mm_pud_folded(mm))
+               return 2;
+       if (mm_p4d_folded(mm))
+               return 1;
+       return 0;
+}
+

-- 
Sincerely,
Yeoreum Yun
