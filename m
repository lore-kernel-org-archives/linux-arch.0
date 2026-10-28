Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793206481;
	b=oSi11JTg1+CY9Aoeqlz4V4aDY507jP3sbV1Se9Wz8kDw/RFwbQFCIYoNBgAZheAMi13i
	 PPgvYuYzv2hcmGB3JvEzKLV9lfo4MyzWDpdRGc81V0IsmVi+ZY1GKLvBU7Gk6Xto0/gu4
	 sMX0MlorSDqXm19VeTbmSUANLO4Cnam63INn4rJ3Ll6GAOBdz+3/4S0TUmI68CuHaC2R7
	 YXjx9PimiMt7rMlSMKA5/WIIghrpKD0iT1FWoBpodT0uTLx4qepVeEinIhsI7ydemT6rN
	 AqHorYIP9OoR70SQYVPSnCXXZX7baRhJr9VYM3h377nPi/DPegDHEEJuoqJcPcI0SEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
	b=n/IWwBFD0+hCre+8UCuFkM6knhC9BOYGptAFR0TOH0NJhysWQX3BTmu+KGwVKi5dl10K
	 bocMorwPuq97Y7ciqj0Go+x3kADAVrT4wiNROY69yaJd+pe6RuABflx45YqT7jL34dHKo
	 vNAJNYXPzPwi6cLxrZKbopoW0JoD+eOwWE+ZKgBohiKYl8Pps5S5AQNl+SF/sxCxvMhGr
	 p/OWpSIYSZ52Q+zmpVhb+qAlgyruXeEm42HmoX3EHyVoNJL4OM7B/rbjD2buEKB6n25Y8
	 elCkTax1Ei2im1xDT1LfJDEu1NzGjM2ewUHnzhCYhhLZROh0s027N4+0HmfgbAO285A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PRhbnoa7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D016606A31D
	for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 16:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D016606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PRhbnoa7
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso207708166b.2
        for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 09:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793206479; cv=none;
        d=google.com; s=arc-20260327;
        b=r0+4ze8Sy/JY/U+XNz8AVfPvaRCID36A/xbXHPn6XBWgMU9e3+MOb1ZCVQ3JkIPmpv
         GT9RPqyqyRuwjXcQYbFbMEnUi/Jy3S5z1a+ss/iHEWe0Ys8cWE/5yFgxNWZYI15qZgPE
         xccrNZJ2SSnbIWOad2LzJurASF4FueCETigG4vvt08EkqfxZOskkJpoQS3qc2zPhoJFW
         etfvHsxjQqLo0waotoDfil9UtChsWRkrU9dIW1TWutvi9bXwJCjvLbFCx5A7cFvzI/pB
         C9e5CERoTOpBDaKPegC6OFCGs+xxL1vgEN9/UP18F1bXp6NlduCgLDkhh6keCR4rlPNK
         5IXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
        fh=ajQufppPLGkPS160x2br2/bKAfyMFIc8AaHDZ9i2vs8=;
        b=Ni7b4qbYgYUnqWXHBzClyY5bOQ65GsIm2+bvisepvQy6ijHg6wblR64qO81bDwpnBN
         2sjNfDCez6qq9WaDpDRoNgUZw8xcIozvkoRDEWxxz9ahgDupoSGtBPrOvlvFVaHhe4ID
         SSZbsxO28J3vrA8+v9cXr7JB8RmMcn9xfPfWlSucVrn4Tn895RCxXFNprvJLfiU4lMg9
         eNCkcstnlA92YCaNyYnNUg2spUkQYW9ee0bkAgAf3WcqZ3+4gq4ktuBfDGIBqjU++jSS
         NvsvmI+LnUvKa8lfOAnAeoLwc8VTDgBjXlEbiYKIdNl4c10MSVvGb2ms9KYsojSEq/Y+
         xMnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206479; x=1793811279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
        b=PRhbnoa7YxinnQj3QNivHrbBVNpMg2JQKByq1MbGKHKovSXkHqO7Akg6VyOvsb0vqb
         Ui4L6adwS0mya7ddLHKg0D8cuMlaQmVzM3PM46vxaelme6Pv+M89oJOx4Yx08bdvn1y5
         FkDhTXGN0xbYiNxQjc0mJNr3PWieQnIcXHcwb1dcUZ0beR1zsPfaiEQ/rKSh8XJsAmfs
         SYa+MzOW3fu7n8+EZYgnfPtfDSGsI9OuvUhm8kzJE10ql9ktz+174FbpAHNu6/r5XSBQ
         Ivf0nkw+W5jQFx20edXXpoOw2qu4/8aRRmxi7vgKLnFhf4BhPEqVAWzygmyFhVNMymka
         dFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206479; x=1793811279;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
        b=ArV15dNJJ48xfdwIfEbE9JksYGofoEonMFbu/fkulks7djqs8GJh2AcKJckMle0yyv
         y6iPygdqBW2sa1ZssxVkRo8moOalLYmjrovP5DbvVMvAnC+hHfkPipEKrRkRbpo25Lqg
         nlQQzbLXtesgbGUhuAsZImNAyMTxWnCnDojivlu500zGdAZ/2nZufWkbET1Sp6Uoque1
         S9QkdlEaNv3dMrImfJR5EkkFUE6A11AWc9WgCd+Q6IeFL2Kv/eZieIpz00R3EJKbdogK
         aBoq4f/DECXI5zG1gWNrNxEfIkqjLKQfarhLbbyQuiyw20PSk2qLJSqKGyjqplBRCHWS
         fplw==
X-Forwarded-Encrypted: i=1; AKwUvBwTGEhOB2zdMbjHxLSjzwTbCUVraSnp/ol7EYr2nLAHNUbWFn2cRCTizFtnp05Xcb1UWy1IyPnJ2Fv+@vger.kernel.org
X-Gm-Message-State: AFq9FYL2yBZJGR39+Q4C4kxksEeZ7mzYScluL4Ee2wt8iyiFrwgeGdlb
	saBSFKliC9TpeHT8unT7+Mwb/C8/u51+wv/g8TYBX62MNgZCI/ME6S3UqDAYVs2YwQO2QphCGee
	G036iTsbbfX1JghzvV4OQkfPGWbvMzLQ=
X-Gm-Gg: AYBFou2Ny5lrwXtI3CNUZqJ8lWztvNA6PCXXkHj51FNoE2UtlaG4iJCIxL7jp+ZAExE
	ha45HSZ75rZ29EyNdY04UDo2t0hPhlP0KmJQGshh/GkV1NS/i59UPIASPp1HlVBJZXgDAJhztFv
	D1aRt4nIJGjbdIn7gHy0P3V2MMqwpJFS/5Anj+tFLaFpKy1zPbbuoqKPLtbgIV9qB9ZGa4rl4K2
	1+1fxcTGBAN1GfTXTMqHyCuyzKBqyDRhxbraBwwiEMi099cBxMMSC+vqR/Xqx4k1KnhUtchUQUb
	42L2lEzhNCheUYWOC9/QNg3VAk9Acicfk24JT1NKz5aSvFod//d5gnHUIp2OFkm3RZnW6bCslGR
	a52L+xKaO5Z5yQtuTKA3cMrEA/VRwL9nRo+D/4ESZwdzQSLltHgtJkRX6f8/7Towsm4mPtg==
X-Received: by 2002:a17:906:f586:b0:c46:5973:2a1c with SMTP id
 a640c23a62f3a-c49be00bf7amr248310266b.37.1793206479455; Wed, 28 Oct 2026
 09:54:39 -0700 (PDT)
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
 <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org> <auBbKP8UNI9talDL@gremlin> <e5766fe2-6cbb-45bc-bc57-87314c130de8@kernel.org>
In-Reply-To: <e5766fe2-6cbb-45bc-bc57-87314c130de8@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 29 Oct 2026 00:54:01 +0800
X-Gm-Features: AclHuK9Ir5cjQUbkmvsMXXN1XNQvMKyhNeup0qo5sC4qB6sDOiJzphX3Pz6BQcc
Message-ID: <CAMgjq7DzLFcznTqVaRneoN+qa9StPTvcBwHMdLM52ZbfZ-ffEQ@mail.gmail.com>
Subject: Re: [PATCH 01/46] mm/mglru: don't use stack pointers when walking PUD
 and PMD tables
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
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
	linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 3:07=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/27/26 09:06, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Oct 27, 2026 at 12:17:21AM +0100, David Hildenbrand (Arm) wrote=
:
> >> From: Josef Bacik <josef@toxicpanda.com>
> >>
> >> MGLRU passes stack copies of page-table entries in walk_pud_range() an=
d
> >> walk_pmd_range() when walking to the next level. These copies can beco=
me
> >> stale when khugepaged or MADV_DONTNEED (CONFIG_PT_RECLAIM) removes a P=
TE
> >> table concurrently.
> >>
> >> This pattern dates back to commit bd74fdaea146 ("mm: multi-gen LRU:
> >> support page table walks"). Likely, earlier locking masked the latent
> >> bug. Later changes exposed it: commit 1d65b771bc08 ("mm/khugepaged:
> >> retract_page_tables() without mmap or vma lock") allowed concurrent
> >> retraction, and commit cf4a65539c13 ("memcg-v1: no need for memcg lock=
ing
> >> for MGLRU") dropped the walker's outer RCU protection.
> >>
> >> The fix is simple, so just fix the original commit so we don't have to
> >> speculate. To fix it, pass the actual PMD/PUD pointers. This restores =
the
> >> RCU-protected lookup and validation against the live PMD. Note that th=
e PUD
> >> handling is required as well to handle folded page tables correctly in=
 all
> >> cases.
> >>
> >> Fix generated by an LLM and sent by Josef Bacik in private.
> >>
> >> Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >> [ david: handle walk_pud_range() as well, clarify+simplify description=
,
> >>          adjust Fixes: ]
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >> ---
> >
> > God, terrible. And why does MGLRU feel it needs its own independent pag=
e
> > walking mechanism?...
>
> It's all a big mess. I think at LSF/MM there was some talk of using that =
also
> for traditional LRU, but I guess it might take a while ...

Right, there are reasons, MGLRU's page table walker uses a bloom
filter and have some zig-zag avoidance. It would be nice to fold that
into the generic walker eventually, but it=E2=80=99s not a high priority ri=
ght
now, but we=E2=80=99ll get there eventually. And using that for CLRU lacks
support for lazy promotion so I'm not very sure about that, but still
things are being unified bit by bit, so it will at least looks better
step by step. :)
