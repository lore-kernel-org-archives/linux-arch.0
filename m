Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CB3436BF0
	for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2026 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784112172; cv=none; b=PlcLqB8Vq05ysKaIwGGmsUvDkWz6qdM4Gan0lNKqO9A/2azNFEevDoCyZpdODdjn3+icisGno7Ju3tQ/33FJN+dWItb6WdVSdVQlYagArf9fJTPIlFDS1En3VRQx1SOCmzpdiLfe5AMOHQEkXKKf+8At+K0T+bqwuFVlqdsYFeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784112172; c=relaxed/simple;
	bh=dYuyA6Dz/ajxhYT4dU+02MPd/j4lWQd1ctOD3UM1CNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCGC6SnnrhJqFresB7jGpjUmQqkYhwI38ChXw4PdepGhEpgEwG31TAN6ye6GhjC1X4WIR+VwVpCpdU/RuKqCTlOmBo9X07gPIA2EtJMsjyQ/vATpQZbGrFN7B0exwQQ+tV5rBFnoh6OlNwyvd11mXvfX4BuAEFpA+KWFvGBaCfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c5382806fso15011021cf.2
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2026 03:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784112170; x=1784716970;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BcTdMoZv6JVy6M/fO3WdP9FofoXGw30zAP9bsFgIqfs=;
        b=bKxO3cRkPGiYNib0PGTeA0frblrLTqXDbj8knToovSmjPglVD097QgY/8TGA4FLUtf
         EIyEaE061ynkutFA9OI2PdJerETH5LoEQ5wwKA4JDogoB/iTfQtMpkHhLH+V64g6vkrr
         OPolKJCoLM2/KA1MPgKzdd6JQLmick2BvfHnqpcxRBiKWOvzT4ffHMKLRQ+ejdj8MxBX
         USYgWEe8uiNmsMkB+wHDK31kGD7VfgHOBw4fcE9JsTlGPerYoCeupHptJsmlWlGZbx3J
         5y3mQOg39TR+6moFZKKP8hzp9sw65QUcEKpjwCA7l6BzZUlx1AYvT8eZTe/5LFnhQ3D+
         qZMw==
X-Forwarded-Encrypted: i=1; AHgh+RoZFBu+tX4uQahQie+wf1nq9xwPn0MUejXyI6KjcdKAcpxc/FMswSI31K3Pz8/FoWfx3qfpBua1h+xA@vger.kernel.org
X-Gm-Message-State: AOJu0YxF/uBiVGJQd1qSxe19wB/0YMSHXVIYp+6enVysHcB6MiMAn81O
	YmIoXKD8zOly68c+IGmELQLzw39Z9dGADESsu6aH7U/cVqxvRbNrAHDmeeFjs98p9qU=
X-Gm-Gg: AfdE7cmat2i44baOCgjuRWJkMlFcYPHzkGEDCfrAO1HD9btfb4CiXjI4jP5bUSBY0JC
	FFxiA+ueyByjBBmGOYmXvG84kLFhWC/wuDuiAZcHxwEVXT0VGoxAhSUIL0fMQ3iAFsfyXjELBY7
	jxpannnfUc6u6XzY491++E0cRw0JvWGoX08ngr8a2YrJeOJFENw0+SLCHLmmdupl5t9IzeA3HOA
	54TZ41AUjtfAml9qwSf+5628HQm7M0ciyea6vhQOoKDVZuS+nmayEWcRU9PcuyJwvj/eWJOHKS7
	/c0ntB57ncEkdsuhkghjjahIUM3ciDyKu1xbi8WoNxr46pBmVGUeCfmn3PrBfY4bUpy8NDJ996Z
	nd1pCprtzinag5J/o0sDCTuSxd3K8cuE4fDEdsq868xDwogt13mIg1zKD4BVpSRQ4oZUZXuvz1s
	zNIG5ri9WDEshkZ402Z3dBCKILdeTzlfztLsxjrq/C5rXXZb3CgEx62w==
X-Received: by 2002:a05:622a:111:b0:51b:eb55:2919 with SMTP id d75a77b69052e-51cbf27709emr170688271cf.51.1784112169951;
        Wed, 15 Jul 2026 03:42:49 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56bf455sm189027676d6.13.2026.07.15.03.42.49
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 03:42:49 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c2cce930cso17929721cf.0
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2026 03:42:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RraxvKEpSnrKraiVj7/2Y9V1vBhARmceHfirLqqTeYBUyvXVex6kh/QGB3uFVTteZfJxttJkDSgGAiX@vger.kernel.org
X-Received: by 2002:a05:6102:94c:b0:730:db02:1d08 with SMTP id
 ada2fe7eead31-74533c1eae8mr11245328137.10.1784111681255; Wed, 15 Jul 2026
 03:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3ea30f8a-bb29-4bf5-8400-1c4840d46a88@kernel.org>
 <7e84b200-25eb-43a6-b5e2-5f27f2d82a77@intel.com> <31988089-095a-4eed-b5e2-c677c70f79f6@kernel.org>
 <14e250db-1641-4085-8d13-02f819657d5f@intel.com> <d83c76b3-ea4d-4c41-b4c5-f5ae558ace55@kernel.org>
 <alYgMxKqRnF6_X0A@e129823.arm.com> <6df814c9-405c-48d8-96ea-929c4b28949b@intel.com>
 <alZe-Cu7yQw9qRXU@e129823.arm.com> <alZo9feSrSB_StfO@e129823.arm.com>
 <CAMuHMdUqL=vJFAzYgcRVNbD_VWWwhehwTuhTfwLt_yRR8c+B0g@mail.gmail.com> <aldV23PwIXnFloaN@e129823.arm.com>
In-Reply-To: <aldV23PwIXnFloaN@e129823.arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jul 2026 12:34:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVOHm6MmP9QsNVvxLsGp1e0jC9u9RGb6+xee0ZBs4Zwfw@mail.gmail.com>
X-Gm-Features: AUfX_mxU0lxjO-fzCeQeNX344H_SVkvovWXaE8EEgaGKFYO5e9NLd2LkTofC79k
Message-ID: <CAMuHMdVOHm6MmP9QsNVvxLsGp1e0jC9u9RGb6+xee0ZBs4Zwfw@mail.gmail.com>
Subject: Re: [RFC PATCH 10/34] x86: mm: carve out the generic compile-time
 folded pgtable case in effective_prot()
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-arch@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org, linux-mm@kvack.org, 
	kasan-dev@googlegroups.com, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
	linux@armlinux.org.uk, akpm@linux-foundation.org, ankur.a.arora@oracle.com, 
	rppt@kernel.org, linmag7@gmail.com, chleroy@kernel.org, klarasmodin@gmail.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, kas@kernel.org, 
	zhangtianyang@loongson.cn, wangyuli@aosc.io, tsbogend@alpha.franken.de, 
	ljs@kernel.org, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, ryan.roberts@arm.com, pasha.tatashin@soleen.com, 
	rmclure@linux.ibm.com, baolin.wang@linux.alibaba.com, tj@kernel.org, 
	kevin.brodsky@arm.com, anup@brainfault.org, atish.patra@linux.dev, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, kasong@tencent.com, baohua@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, anshuman.khandual@arm.com, 
	yang@os.amperecomputing.com, chaitanyas.prakash@arm.com, ardb@kernel.org, 
	guoren@kernel.org, yang.li85200@gmail.com, viro@zeniv.linux.org.uk, 
	dinguyen@kernel.org, schuster.simon@siemens-energy.com, 
	wangruikang@iscas.ac.cn, junhui.liu@pigmoral.tech, muchun.song@linux.dev, 
	vishal.moola@gmail.com, namcao@linutronix.de, pavel@kernel.org, 
	djbw@kernel.org, yu-cheng.yu@intel.com, baolu.lu@linux.intel.com, 
	Jonathan.Cameron@huawei.com, coxu@redhat.com, andreas@gaisler.com, 
	liam@infradead.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com, 
	shorne@gmail.com, jonas@southpole.se, stefan.kristiansson@saunalahti.fi
Content-Type: text/plain; charset="UTF-8"

Hi Yeoreum,

On Wed, 15 Jul 2026 at 11:42, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> > On Tue, 14 Jul 2026 at 18:51, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> > > --- a/mm/ptdump.c
> > > +++ b/mm/ptdump.c
> > > @@ -190,6 +190,23 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
> > >         st->note_page_flush(st);
> > >  }
> > >
> > > +bool pdtump_pt_level_first(struct mm_struct *mm, int level)
> > > +{
> > > +       if (!mm || level > CONFIG_PGTABLE_LEVELS)
> > > +               return false;
> > > +
> > > +       if (mm_pmd_folded(mm) && level == 3)
> > > +               return true;
> > > +       if (mm_pud_folded(mm) && level == 2)
> > > +               return true;
> > > +       if (mm_p4d_folded(mm) && level == 1)
> > > +               return true;
> >
> > Is this order (... && level == ...) the optimal order?
> > On arm64, mm_pud_folded() and mm_p4d_folded() perform several checks.
> >
> > > +       if (level == 0)
> > > +               return true;
> > > +
> > > +       return false;
> > > +}
>
> It is. since the purpose of ptdump_pt_level_first is designed to be used
> in the *callback* of pXd_entry(). IOW, if we check level 0 first,
> it always returns wrong return in folded case.

I meant the order inside the if () conditions.
E.g.
"if (mm_pud_folded(mm) && level == 2)" does the expensive check first.
"if (level == 2 && mm_pud_folded(mm))" does the cheap check first.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
