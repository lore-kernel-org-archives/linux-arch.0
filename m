Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEA04B44A0
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179797; cv=pass; b=d+6xNqcWbPDqT87PsA4xsts0Lg8WKtPz4nfthlue44MbghH79PoW1wAITwCUn5SFjR/gHGO+nJ+gfYuC5g0FcKKpxAS5BJe1XdZuCIzh2lcwWML6C4OimFb4C0rk4KkLWzzoKqiZ8HjhBcLxWskiPfQfUrxhaxxKAI5lo8xjUac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179797; c=relaxed/simple;
	bh=LIPPg22fa+TonvxEf6vmQam+ZQ7bHd3Sz9GxpyKknbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzosOe8r/nxMuZqH/Z07Qvsx5dVMNjpfiJqaDpJD4nELqgcseydQyXM71uBfOcXGvSH8fvPIOhVxfWMph9KdewrwjsA9MY3EWkRxk1hnHCpSAHh+s5vWeZAiZCnnS4xgTQA73shUWT8ZmEXYSapl92MhTKPFqk6ASiA5/hIQnCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffAONYry; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffAONYry"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-530e8c6fb80so271431cf.1
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 09:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790179793; cv=none;
        d=google.com; s=arc-20260327;
        b=A9OCmHqFJym6KLN2DRdaSDPbaH61J3UB/ZY1tIZS2JMz9r7G2AJJ1gYgqefPTqq7sN
         /FQm7vWuj2BWgOyhJlFbeQb+2rSbarg4JyWWC5NE4Qaf4DPvebZAtdynma/+959wiI7L
         k8Mx176+W11gyZ58zHsJo60bnbtpq4mQUDTtnFx6RZDQ2yiBmgU8nzBtgRsm0/+T97RC
         CTDysG/xVyUo+AuK/tj0njAx7W/lzixN1hOidYyXVi6wagTar/UvkVi7Ct0MsZMDL6Dd
         HEAXz62C0S91vyqwEOcV0PPdUFXSBcMbgT4ZGVvM2M00bkAy6K9/DaeDCuy1aNqbwG6e
         noJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HHWyBmRaGzTNumsbsfRRD90WYZuPVsFs3XssqLSLFrU=;
        fh=U0ll4nueUS/pnm3LVsav5xwovPgV7AGtbbn4N9kxE00=;
        b=Jt9U9DdJL3nam2/ZOVK2V+8aZDtbNflwBU1qyvyFrKiTYzXoG/kx9sKVqmESN18XYP
         ogaHFRRjjZac4Z6dlsKVQctCugA7poatueTDnrKV7GsHv4JSVNhVOm6SiNYA04IOgNB6
         v2LUNgQtT1ayF+CBTcuDuLYz/R3jQa0k1Zt7kCGgmrUTKwioHfmJqsNSIUsDfJHzfGKi
         WhNsy9FVHTDddmVlN4z8UP6J/zTkZZ3UeM5kvvUKwMi8La9C5Bu0bFbD0hSqPJujaSTq
         dLGSpy5Yj8QGRdnXX1EhYdDas34MRidjrtJ2Wtq9MdulCGEmNODO/lSZJxhc3FA5dtDZ
         xS4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790179793; x=1790784593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HHWyBmRaGzTNumsbsfRRD90WYZuPVsFs3XssqLSLFrU=;
        b=ffAONYryNjJ2EHoS5QHMRrqzT4ilT1/bzD4pQflN/w0SVWtQDM5iJJApRpsctD9FlE
         d9m34qFn8hN698yQE4f92nXTgkQYbCc6icEX2oDBE7sL7M2sqnCjuc50zKeV4rGPaZ1Z
         s8uDrU4CC4iId27Kuxmw2XnUF8Dbcoacyg6+R55QsN1miV28LLQ8/N8jmmqUEuyvroPc
         522amINxI5m5mx3I/wzQPo+NHPt6F4Y9Fi62UVpStUpxHQKRuGVJlJc/il2H45jDxgR1
         nC2+bUdaruNiRScOOZw2r/SRYDIrmzyGl7/JdJo2YcK+Q+8NHWdzWP0ffmEs8GnppU1T
         J/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790179793; x=1790784593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HHWyBmRaGzTNumsbsfRRD90WYZuPVsFs3XssqLSLFrU=;
        b=f8lY6CtTEGTuKwtcLcLCuvuTF+vTMBW188I701KBKdZsTMzEGIBucGRpsO4gLVQori
         PimKLYPjqqtqDzC5293AULPC57paNLOZbPcowXbYx8diqwG2tX0xcguPUO1NoTsp0Ag9
         9M/GKTWnACj88yehBqxOFYH2VS/7JexjOyGaNOBmMgd4wuKwAr6vrS34Nk/riyZ+TQHX
         t66q9dcx1gGA3yzUzOJLCT4JR/ehtifUyRjMo0O08O5c/MSi44wEQbvVd4bxl8hm0vY3
         ryZc4u6MHcmv2gQ4K4PFP9WMTivnaR8t3fcSzzWJP9ob5X19SacKMt5YUKqZc+/3lwOn
         uEMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxA64DYU+fv5IN57R5oKg7DqIjt6bhA+HYGwergqaB/VzSSzFY3Ds7OlYrs48JsVXwj0k+T42QypEm@vger.kernel.org
X-Gm-Message-State: AFuF++lexGF8iC1R0QOtCJyD+1k1xB41C600qzS0nzAVEHQOObaJfrTS
	RIWsz1aOR1CYA491lF4a/EXMHKjzV93hyE0HRYyZ6ZEPCo2uqaoBft8zR9gZnEKH4FTa3Zsht5g
	fW182vuD0ED45tFw8OEIUuQewCEDNhjECZ55G1G8q
X-Gm-Gg: AYBFou3kFutjDCyzKEuJvJVf0xJigU0InvWe1cRzipIzi833Z4GKqAO6uo20nBFL/dR
	bh1Y6E65RCrvl/iW5Zb1KqDIyiV/KbROxLMftqPg03WNPqjugOUCLdIijAXbjB340h3FSK2jNBx
	cEA1VCtsfOTpkdMlNlg/vgmYk3fvZTr/Y3BdFP9IBliajmTfHd+qXW4OZvo19XsawKkn7ts1cGr
	3qo5hNNBVcKvA1DTK98KQ+qL0sQpZxP9ai9Gu5TfUDyjnftVEvBi9lj+/qmH7zsjl7qeKp5o3dE
	zMmxKfDZamCt1I92XbhFtnUXt+/+8l85OFbcHnLkv2SIwiRtnEchJnaYSzXEK4o87SXC/5opqXd
	vKfBkQIi+7+o=
X-Received: by 2002:a05:622a:591b:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-532f8b3b7d0mr1642301cf.0.1790179791981; Wed, 23 Sep 2026
 09:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-2-4583d8a23bca@kernel.org>
 <CAJuCfpEa8tUmYJBjx-cRdAE8y-jcKY0C81kAOa1QZS7F6tKdfQ@mail.gmail.com> <arP0oJgrgZlgtrb6@gremlin>
In-Reply-To: <arP0oJgrgZlgtrb6@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Sep 2026 09:09:38 -0700
X-Gm-Features: AclHuK-pjLwt7GcAJrmXZc-kWYiEiXZ02rewi0rtPA2ju4vBD2OPEsiN1JlMpG0
Message-ID: <CAJuCfpFPPGaK-grNx9qiQOhzAXbxU+SO+95Fht1571TGREx2oQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/40] mm/vma: predicate setting mmap_prepare VMA
 fields on new vma alloc
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 8:54=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Wed, Sep 23, 2026 at 08:32:43AM -0700, Suren Baghdasaryan wrote:
> > On Thu, Sep 17, 2026 at 9:24=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kern=
el.org> wrote:
> > >
> > > It only makes sense to manipulate VMA fields if we allocated a new VM=
A,
> > > rather than merged it.
> > >
> > > VMA merging does not compare vm_ops or vm_private_data, so a merged V=
MA
> > > keeps its own, which is also what the legacy f_op->mmap path does sin=
ce it
> > > never touches an existing VMA. Previously set_vma_user_defined_fields=
()
> > > overwrote the merged VMA's fields with those set for the new mapping.=
 In
> > > practice these are the same values, with rare exceptions such as shme=
m
> > > selecting vm_ops based on whether the file has been unlinked, so no
> > > user-visible change is expected.
> > >
> > > Make this dependency explicit, and additionally constify have_mmap_pr=
epare
> > > while we're here.
> >
> > The fact that we might be overriding attributes of an existing VMA
> > that we merged with is technically a bug even if we never hit it,
> > right? If so, should we have:
> >
> > Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")
>
> It's not a bug, it is an in-built assumption that the state used to asses=
s
> mergeability implies the same properties.

Hmm. What prevents two VMAs with different vm_private_data members to
be merged? IIUC is_mergeable_vma() does not check vm_private_data. In
such a case set_vma_user_defined_fields() would override
vm_private_data of an existing VMA, no?

>
> And if it was, it'd need fixing a different way (check the field for inst=
ance)
> and would apply to the legacy mmap hook also.
>
> This change is needed for the series though.
>
> >
> > >
> > > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>
> Thanks!
>
> >
> > > ---
> > >  mm/vma.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/vma.c b/mm/vma.c
> > > index fa784f069da4..4b74b48c29b7 100644
> > > --- a/mm/vma.c
> > > +++ b/mm/vma.c
> > > @@ -2894,7 +2894,7 @@ static unsigned long __mmap_region(struct file =
*file, unsigned long addr,
> > >  {
> > >         struct mm_struct *mm =3D current->mm;
> > >         struct vm_area_struct *vma =3D NULL;
> > > -       bool have_mmap_prepare =3D file && file->f_op->mmap_prepare;
> > > +       const bool have_mmap_prepare =3D file && file->f_op->mmap_pre=
pare;
> > >         VMA_ITERATOR(vmi, mm, addr);
> > >         const pgoff_t anon_pgoff =3D addr >> PAGE_SHIFT;
> > >         MMAP_STATE(map, mm, &vmi, addr, len, pgoff, anon_pgoff, vma_f=
lags, file);
> > > @@ -2937,7 +2937,7 @@ static unsigned long __mmap_region(struct file =
*file, unsigned long addr,
> > >                 allocated_new =3D true;
> > >         }
> > >
> > > -       if (have_mmap_prepare && !map_is_anon(&map))
> > > +       if (have_mmap_prepare && allocated_new && !map_is_anon(&map))
> > >                 set_vma_user_defined_fields(vma, &map);
> > >
> > >         __mmap_complete(&map, vma);
> > >
> > > --
> > > 2.55.0
> > >
>
> --
> Cheers, Lorenzo
