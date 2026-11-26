Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795716663;
	b=mfHQ4ZYHxtXbH5ESMB7UoHLXOlTu6rBUcgNuAEKYY7m2F5HAR1lBoOcx8LfDk2xmn8YD
	 Xewx2vGlrDswogjyHIq+dEoTmt5KqXe3hNpteNFCTwbqi30+efTKiIhzv7fkbfzjaoTA0
	 vCJ5btKA1aBfaXWCpsIGl+wJLf44Y8A+zeatGLo/mdVR8RAMKlA1yEPfTuWMTPWDjSbip
	 lUVLS0nnMpNSdkUFmaeDCf8lPdusRlYF3odoeActfWyQow+BqezzE6QPzzwLgKnySqr8U
	 GFtP/VjOdtwa3FQR3n4/65pZ87It9RkMB5Ji3JVXWkjgzqvrlikr1VfsM8hPcACCCNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795716663;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=u9v575CLn7pmoDOzWOn9peb7SoijlK+LbrKGpES9aRg=;
	b=zCRBOXk6piKOkjLeYJ25xMi4+S1hRDFTDabLsGrs7ecsDmCjUB0pnRBRIoopF15PKsgl
	 xLrWzlsgqkxRNosRbNeqFkU2OU25bOCfU/83eejxIV2D/O7xdBq/+JZVNDZeVkqQy1Ysq
	 4b9Th2KxfZRiwuxivc77n+mKKtnguJ3qe1YEjpUp8DKHK/85Ytdz6WSAau+v2BlL68til
	 13Gfh7VjzT12cmZW1/5NcLW5I8n0b8DhzzAcQ5F6K15S/2OkeWJHKGl/P7y0l3lssCZgT
	 /8Nlyo30HEXv8kenWsQE+0qO4Xl9ezX46D5RE8A48xVpBX3MCR8gGlqL9RL1SnNmpVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTrh4ivt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D0606A326;
	Thu, 26 Nov 2026 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTrh4ivt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52761F00AD3;
	Thu, 26 Nov 2026 18:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795716662;
	bh=u9v575CLn7pmoDOzWOn9peb7SoijlK+LbrKGpES9aRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eTrh4ivtfPOlk36i/Syox5jVW6dXJmhOgZwioO+nYxMKjGShC7TMyjjJl/zzRZ/W3
	 SkP6MLdWC5iwrRV6uvUn6/rKonHWO56PFB3c75THzdQTim1Mri+dYH52nOteGfRTCj
	 M+BZepOCmKNRYHvlRa117MS6yceBdzXjdmtuENyHhISgbQTyWosUB771P8KFuwQKC8
	 pVw08LjMZlVYdDIpRqOeWvsFhzaGdSX4qDT0MagmIoJIq2tNOTskLwvuvj9X76KZmW
	 omTnmVri/xaVPYJp7AvvaZYW/JxAmTrlzAhShiP47YqYQ+fQwkXl5svB+CMxRIbwv0
	 XMDyeevoEqAuQ==
Date: Thu, 26 Nov 2026 20:10:43 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
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
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-openrisc@vger.kernel.org
Subject: Re: [PATCH RESEND v2 12/21] mm/pgtable: redefine PGTABLE_LEVEL enum
 with ascend order from PGD
Message-ID: <awh2I4llsjkB7Vds@kernel.org>
References: <20261102-dummy_ptxp3-v2-0-78840b2ec73c@arm.com>
 <20261102-dummy_ptxp3-v2-12-78840b2ec73c@arm.com>
 <awXD4i47F-VAG1tD@kernel.org>
 <awXc0MSZl9t9VW8e@e129823.arm.com>
 <682c765f-332f-4ac2-b448-4201c8fae6fc@kernel.org>
 <awhCnpiUc1R_BLx4@e129823.arm.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awhCnpiUc1R_BLx4@e129823.arm.com>

On Thu, Nov 26, 2026 at 02:30:54PM +0000, Yeoreum Yun wrote:
> On Thu, Nov 26, 2026 at 03:19:13PM +0100, David Hildenbrand (Arm) wrote:
> > On 11/24/26 19:52, Yeoreum Yun wrote:
> > > On Tue, Nov 24, 2026 at 07:05:38PM +0200, Mike Rapoport wrote:
> > >> On Mon, Nov 02, 2026 at 11:21:25AM +0000, Yeoreum Yun wrote:
> > >>> The PGTABLE_LEVEL enum values appear to be ordered in the opposite direction
> > >>> from their intended usage.
> > >>>
> > >>> Intuitively, higher page table levels should have smaller enum values,
> > >>> but PTE is currently assigned 0.
> > >>
> > >> That's not what x86 thinks :)
> > >> They even expose it in /proc/vmstat with smaller numbers meaning lower levels
> > >>
> > >> $ grep direct_map /proc/vmstat 
> > >> direct_map_level2_splits 152
> > >> direct_map_level3_splits 4
> > >> direct_map_level2_collapses 0
> > >> direct_map_level3_collapses 0
> > >>
> > >> Just an observation, I don't mind either order.
> > > 
> > > Right. I made this change because a depth-based scheme seems more intuitive.
> > > 
> > > As you pointed out, though, the x86 specification uses smaller
> > > numbers (0) for lower levels (pte), so I think we can leave the
> > > x86-specific direct_map_* entries as they are.
> > 
> > patch #14 depends on this, no?
> 
> Interestingly, x86 documentation numbers the PGD level as 4 or 5,
> whereas helpers such as effective_prot_pgd() use 0 for PGD.
> 
> Anyway, this follows the usage and semantics of effective_prot_pXd(),
> rather than architecture-specific level numbering, which varies across
> architectures.

I asked an LLM and here's what it told me:

  x86, s390, riscv, LoongArch and powerpc count from the leaf. arm64 and
  ARM count from the root, and so does the generic page walk and ptdump.

My guess that the only reason that generic ptdump counts from the root is
because it came from @arm.com :)

> And yes, patch #14 depends on this, although changing the condition to
> level != PGD_LEVEL would remove that dependency.

I think the only real hard dependency on levels numbering is x86's KVM code
that manages secondary page tables, but it anyway does not use enum
pgtable_level but rather x86's own enum pg_level.

> -- 
> Sincerely,
> Yeoreum Yun

-- 
Sincerely yours,
Mike.
