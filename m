Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130501;
	b=OCg6XA9HT9xLA4EjWc/6Q2XhiObp/WwnkHVeXRQjdxI60qaxOEJm4mgHBusfFDmkcUxV
	 nUnvSWlOyhFS8cC4qI7n7XUDYoXv/Hd7EEfd5CjzqRQdLjmJ5rzW4U8wZ71QtQ/Rp3IlJ
	 HngxxeNbh0wnhGQrFgxW67bA7fevO3IhNcvZJXUI/waTehkMC2s1Mv/AdHvUckE8MuGuJ
	 oGVubnbQceh2FOoeYJXEtRDWodcKcdXuJ8l5HapA4ennFpPtJv145c0Yu+3ZTQTCb3df6
	 er1UvCDMoSNxzTeXabzUdN2vdFe2REEmfbPATsVCBuycCYTr3P614Xg87SqTRR4acIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130501;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dBXyCpRHgO+MYx+nOUuoDTL78tUn9LIeQ2aFxfEucBY=;
	b=FweRRoWgd2K+WV6hjCPDABVym/eE8EdcuNb0KeC9H/gMLXgBbs8HuUYLOLoK3Mf0DrDT
	 43ACRyEQLfJMCHXv1QNQcYAAYxeXHqaL5QY62kgAY0dBRTSK+KhQ7WBO6iYdHXA9U37V4
	 7F6jZ4McB9Owc8+/WOdr74YJiO6+Yi/2RM6L5NT9mrmTdAU2Az+5DE6hPVeDltv25eze8
	 5M5l3uM/+e3og3pLrrLUMNZFghdqmxvqRodTxsilv1TDKLK1m+iqFzrY0ndF4ItXArrVU
	 Xz1wx7aGPSDqEtihr+x/JlBhJeGZ9r9+L/KMwuYh97/rCj6T3mVVaZhyyBnyxNjNM4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1ektPkr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F64606A31D
	for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1ektPkr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F291F01828
	for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 19:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793130500;
	bh=dBXyCpRHgO+MYx+nOUuoDTL78tUn9LIeQ2aFxfEucBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=X1ektPkr07/Laf4mhxGMYACp9EUSpX9DhVF1/tTXmR8R3XJLK/ig9jlr5MNsopi6V
	 JXYaaZS4Ka/elkmjbJrVLj6hijeKuf4QN82dz5bxl8JMRYZES6pWFYL4LcNRV97ZOg
	 30nkS6WxaeT5i9Y3h0Qx9ngL/znS/aDemcg2PGM/o4P3ucWR1i25zowTWWrQrK+FJY
	 jOeXt+P0QWk2sWEf6svV5gj6s1S9b3wJVh8jSa6YxX1LC/nmhQeIffDpIU2q694IRl
	 Yl9+/FsVZi0pSIShvD0DD6xRjE0byx72bsDp3J7k+jPh8yWCvohBZQShVXxaoXrYez
	 q7nUtfNlrno2A==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f079a63b8so14233385a.3
        for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 12:48:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwbvCHJKddESl3tXz02qe7x/zZsURPrSW96ZmCyv6AH/0OpONmQKoBhmLrA2yLTbtJO4RnRVa5pKURa@vger.kernel.org
X-Gm-Message-State: AFq9FYLdfxTp144dJp5HRgvh7Nq0duhuCUS1pOjWrNuoxJZRGLr2+DVk
	Db84jdxDqgJtZSqC95tNEsqYpXunuArOM2rL4uFuJNNjFTeXRNcuWeOJkspn5s5NjATPH991vwM
	t297tdlxAfICK/W3QoTaoCNGJA1FhjuA=
X-Received: by 2002:a05:620a:171e:b0:93e:c12c:4409 with SMTP id
 af79cd13be357-940ef99a3dbmr1852566585a.69.1793130499936; Tue, 27 Oct 2026
 12:48:19 -0700 (PDT)
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
 <20261027-fixes_core-v1-2-6f74bec9a5bb@kernel.org> <auB-3BQn_rR6IfY8@pedro-suse.tail5790ac.ts.net>
 <22b819a2-631d-468e-b724-770caf9f94e4@kernel.org>
In-Reply-To: <22b819a2-631d-468e-b724-770caf9f94e4@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Wed, 28 Oct 2026 03:48:09 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z3qgCPBpCDitVTq+xiGsS=-yEhKSbEO4Lbdn9MVAHK0g@mail.gmail.com>
X-Gm-Features: AclHuK-TztIwEQBE6javSaaaoybdbPKwOAcVqEYuGwGbjltsm1heJMFfzyWkRwA
Message-ID: <CAGsJ_4z3qgCPBpCDitVTq+xiGsS=-yEhKSbEO4Lbdn9MVAHK0g@mail.gmail.com>
Subject: Re: [PATCH 02/46] fork: take mmap_lock before copying mm_struct
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Hugh Dickins <hughd@google.com>, 
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

On Wed, Oct 28, 2026 at 3:07=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/27/26 11:38, Pedro Falcato wrote:
> > On Tue, Oct 27, 2026 at 12:17:22AM +0100, David Hildenbrand (Arm) wrote=
:
> >> dup_mm() copies the parent's mm_struct before dup_mmap() takes the
> >> mmap_lock. A concurrent brk() can leave the child with a stale mm->brk
> >> and newer heap mappings, causing later brk() requests to fail.
> >>
> >> Other operations (e.g., PR_SET_MM) on the parent's mm_struct can simil=
arly
> >> cause inconsistencies.
> >>
> >> As a simple and robust fix, grab the parent's mmap_lock earlier. This
> >> way we don't need to update individual mm fields in dup_mmap() and
> >> keep missing ones. Stop updating the 4 existing members (total_vm, dat=
a_vm,
> >> exec_vm, stack_vm), as that is now no longer required.
> >>
> >> Keep releasing the parent's mmap_lock in dup_mmap(), before
> >> userfaultfd completion, to avoid moving the userfaultfd handling into =
the
> >> caller. This should get cleaned up later.
> >>
> >> Move uprobe_start_dup_mmap() to preserve the lock ordering.
> >>
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >> Cc: stable@vger.kernel.org
> >> Reported-by: Josef Bacik <josef@toxicpanda.com>
> >> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >
> > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> >
> > FWIW, strictly speaking malloc() isn't usable in a forked
> > (multi-threaded) child, but glibc/musl provide this in a best-effort wa=
y.
>
> Yeah, I'm more concerned about other things that can race ... :)

Regarding the race with memcpy(mm, oldmm, sizeof(*mm)), we
still have one [1] even after this patch.

That is, copying mm_struct can happen concurrently with
lru_gen_del_mm(). However, this race doesn't seem harmful.
I might be missing something here though.

[1] https://lore.kernel.org/linux-mm/6ab08265.71f81b7d.15fa6d.001d.GAE@goog=
le.com/

Thanks
Barry
