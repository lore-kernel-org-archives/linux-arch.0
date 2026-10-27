Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793122721;
	b=FxFWDZKgvcJeadg1+tpBWD982ZDsx+/kPU4hFEP/F9Qt9/I2BH93kRVA4EaMhZWiaC1G
	 AkFc130JiIs/esQJGUWPaJR3iYo1KBXh+HmTH7nt/Lv1HCsNdgQfHIpQWspR/JYqoloYt
	 WnpnAJmd0wlIVlUMNQOl39G5OBwrsUj9mz4dFgekf1XYclcFoa8dJXFkpqoeJSCmpPY5/
	 sRCRukYR/eRLC/TUIkhZoBj/iV35agSfcvjUVlcMmD9YUcubA5oTsXDc6aljN/xToDYrM
	 oXiq3OWZJYVxkEFL2ye649u/YdqJeP4ZyhhLWH181b9nUiZiqysNXVmtdU8hFxh9JiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
	b=O4G+BGo2kK+P15SpmgJftXzmsRX+upjo++LDmiwxG0+WEv6oluP6iZlEYzw+dfFwr7+x
	 BhEySAdcFJ4zJrtUHnQfzwiefUQJRwhV+/887VZyoyb7f/951iZwSVxPABJ++IrJOxj61
	 tGUsTZerUBC8aYLivF9kCMUd++d/tszlepgr7h/Cw9YB2v3SPoJ+yiSsVSg8Ygo4DXvnd
	 0FzuuCytn3PK8GfV1xek8JFgu4iY1l1FDgg3F5ofwQV+vWpgTHJHOoT/cOLBAfwv+wjhe
	 L+aIttDG6jC5BJdyiAv9CFIf1l0M9H8cxhmFBJVaTKHH1oKjY/AoMPNGW1hDOK2npYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TMbu8PxL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77122606A31F
	for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 17:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77122606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TMbu8PxL
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so631a12.1
        for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 10:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793122719; cv=none;
        d=google.com; s=arc-20260327;
        b=KjCwtf5ujiwbzeahaYVNdISABRJxfZSpZOFogecPZpC6fh4pKYL+c7q5o2mC/Ja4FP
         BNs2feHfSDtW4/VysXhcQ+4U1NpRc1oH3VxD8jmsD1tG0Cnmjd2IaABnG1KENbL5MCs0
         ltcPh+oKca34li0lYSHhr/8Ev02QWhUEcXtWFpTeAAUL4xzwIB1kuYMhdpugiK+NY3jf
         y3l38SsyPcKoSzlw4DJfzxLBv7Q/lnFZqMWoEaWe7XxygmabSJlgF6Zv2+CF9snNZojO
         HMDSdNLKvkBKsFGrj5RAJaivQkI71oixwfbxeiCDyUU14EJr6MeFSACbgds3qvd/qiO8
         P66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
        fh=KD3rnXbZ9thseBzBUkv1h2noB5qCQ8Es/jsNqR5CkbA=;
        b=hkruAryJwHKJt3XodU3ZEX9vZ8SjgW7VB2VwOkrhvs/vIWWsGNUJwj/qTDmWBJbcQL
         1MZuGsj+KQuGulLS9Zg0tSCKUMkESozYsH2hRnmP/XaGyKGibTPOOf1EzrQ9r5tO3ON0
         LZWRIcv6nbMixp3PHOexYYull2inqB/1HOqWuSxQzMZ2McHX2OgWvg+IFvngtq5fE53J
         9rj68UzY6AZN8lGL8pm0vrrtPvrObjwrfoCDYksyP1sN8sC425hmYMcGgAb4XHA2LgCh
         lXlubY7azPiP3PzZPRrDhqLv54X/cVNjrqVxVU2+Gb48c16yULNd7d0HM4rs2NnlNTJf
         pVcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793122719; x=1793727519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
        b=TMbu8PxLhpBm5Jxc+UmD3OrKaB4W+TrO+HcdLK/qemtnz4THsUOJblzPEUuFNQdsAX
         xVppISd9HZVk1k52dXnBDZH5JY2olDDSO95++GZTKXt09LrvWQXh0bdmoGTLejAK1OLt
         bxZAkxblGRQiGMML4G9URFa8xQWaDlL49VzCVKznumP2+MyKHmYFopFrp7Vomsp36yZT
         yCc03PZELOyQAfukDHyz3vOgAGIADyvURsSBd2Fsfa6RJBwz/JWJp+HSEvxtvlpPmo9U
         hDMP72JYBeOYHs8QzW38V9/J7Ub9YckAD4l0ZmHIvx0H8IlISifANZcUpwjvV3oxhTkL
         uyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122719; x=1793727519;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
        b=beA64r3n/H7pf/k+QpNF7q7SDVs/mFjsIa32klBupfHo/BcI8UKpF6RvmviVxg4bRe
         71zOiRqMlb95s36cGW580LXs2JIaQendAHqqFLkrDENzpUYWZB7Xm00UtXW0AWbA7ZBP
         rCsWtwF9bMXu07pPcfNgsax4DfcyjYEVCXUEuzq+5kcyLwAvhNLrllHp4sBrB8HlRnAY
         R3szOw74rlmmgtEi1iyxHdX+RRfy0qBHAbgxck3VfORUsL0RanD0BXIEphfByI5lXdCn
         eszm8EjDa4NEjuVYKsc05sQrbWL1y66Th4s6oog92rXIN6xzXiHYeBHdT1gN6yCY42dY
         UPjg==
X-Forwarded-Encrypted: i=1; AKwUvBwhi75wTY4YL6fEW6vsuH3BpzLf2XXdNCkgLvkFt/XuLq6FOte+4+jDQsVLeXAi1oH4iFLxY+0PGOwu@vger.kernel.org
X-Gm-Message-State: AFq9FYLlUUNAx+Nj3tyMsjTZZaflvG0KUD4TZK3cAZCdwmYiWc/hfO/R
	+11XNUlrNdgS0O446FG15Rei+fgyKh4oLlNPutHtopg8i1zQjghIFEp0OVyxPrcKBa87WoyzAOG
	iWWg9fNGWe4hnzbseTZApIMCSqqFHuQBy5mYjJdvS
X-Gm-Gg: AYBFou1mm4m+U9p7QxtpjM7OnL0XmNaYW+yX2nkNTosnPtwNQkA4fgTBwAbeqNUN28S
	dPJo0XwmbSyjZLc2vhYwoTuNMSJWX04de0cV2erZMXBrizLXNr1vne2sAHuDurnecRTpwmGA6RK
	Ehdlq4SLPykMvsOjHG5YCNfJFhhgbB82+/0rmoQxB6jOBWhAuzH5Vt8L6iSNlomgO1/VfYBFY9l
	4Z1K1eLf5Gbb5hVF+GmOb+tJJHfCVaF2Ds1nkakFF4MG4It2/h7wesXIyfnJu3q+31bW8Lnjng7
	eidAOrYUHZovFrDchxJs5vgv5hkO5xB/7tfLhJz+xFC5cZMkO6p+jZS1vWwWlZHOTRm7Nse8jS9
	CnK0Cn8ZfuTzidMdO9CUC9vRkNIx+awF85qsyFKEx15yhUoUvFXNygHY3sbkq2XCDrQ==
X-Received: by 2002:a05:6402:a2cf:10b0:6b4:597f:50ed with SMTP id
 4fb4d7f45d1cf-6b4994c5b30mr2214a12.5.1793122718174; Tue, 27 Oct 2026 10:38:38
 -0700 (PDT)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-23-6f74bec9a5bb@kernel.org> <auBityGTDQjXURWg@gremlin>
In-Reply-To: <auBityGTDQjXURWg@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 27 Oct 2026 10:38:22 -0700
X-Gm-Features: AclHuK8I8xcfhrxH9JH4rYz28CrMoohsxda9QortkIHbiI93aH5ozWron9iLPAM
Message-ID: <CAJuCfpHEHPNj9DKOGbVHYCUsmLf==-XkhzBAR94gNt_ErhdnnA@mail.gmail.com>
Subject: Re: [PATCH 23/46] mm/userfaultfd: write-lock the VMA before waking
 waiters when unregistering
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 1:43=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Tue, Oct 27, 2026 at 12:17:43AM +0100, David Hildenbrand (Arm) wrote:
> > userfaultfd_unregister() wakes pending missing faults before clearing t=
he
> > VMA's userfaultfd registration. With per-VMA fault locking, holding
> > mmap_lock for write does not prevent another fault from queuing after
> > the wakeup but before userfaultfd_clear_vma() write-locks the VMA. That
> > waiter can then remain asleep indefinitely.
>
> Oof.
>
> I guess userfaultfd_clear_vma() only implicitly takes the VMA write lock =
via
> vma_modify_flags_uffd().
>
> >
> > Call vma_start_write() before waking waiters. Existing fault handlers
> > queue themselves before dropping the VMA read lock, and new readers are
> > excluded until mmap_write_unlock().
>
> Clearly an oversight from the VMA locks work. I guess was always a Hercul=
ean
> task to catch every single point at which there is an implicit assumption=
 that
> mmap write lock ~ readers (esp. faults) excluded.
>
> >
> > Fixes: 29a22b9e08d7 ("mm: handle userfaults under VMA lock")
> > Cc: stable@vger.kernel.org
> > Reported-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks!

>
> > ---
> >  mm/userfaultfd.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 669f71d485d02..7e30b5ff17be1 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -3991,6 +3991,9 @@ static int userfaultfd_unregister(struct userfaul=
tfd_ctx *ctx,
> >                       start =3D vma->vm_start;
> >               vma_end =3D min(end, vma->vm_end);
> >
> > +             /* Prevent new userfaults from being queued after the wak=
eup. */
> > +             vma_start_write(vma);
> > +
> >               if (userfaultfd_missing(vma)) {
> >                       /*
> >                        * Wake any concurrent pending userfault while
> >
> > --
> > 2.43.0
> >
>
> --
> Cheers, Lorenzo
