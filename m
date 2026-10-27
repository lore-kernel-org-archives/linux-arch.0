Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072574;
	b=bGpjS20HXMqarroXZ3DZmbdFWCSaAGlVlHbvs7yrEg/uHQmPX/0bjXiPVRcjYkRr+z71
	 AZylOdfJA92tnoJW2Zca/TJgveCr2G+zgn+sOl5PcD5lqh5+lUsJP21C9vnzp10FQq+gh
	 1Z0PuXwUM6ddGXhCDjXyttbWv26faZypWU0vDQyDMClc2vNpzVOuKqH1mso3KWM9ImWUI
	 CtOsIyB7/kRRDCDjlHvPzEsilEDAUj0LbZfCj38zENW8Vipcxbl/sje80sbBbDqnyjQcE
	 WqUysklERirrsVXJg1eFN0snkvOEcFIuhxEwAg8vGOS01h6A9RNNsSHWWxh5+mEoSzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=3AmNHif0hEkmbwEeTcZrwdr+/HB8qgSmoybIARXFX10=;
	b=T2fHjAGdjFzlbWIbDuGbLTKHg+QZDalxn/Ef8NaRoeFCYw7grn55eKJ4cnTU/Fza1Fp1
	 PFNK3ZW0AClk3rGYJXjo07dLLb5K4x2JCE3l+y9KceIhZkZ4qDkHAwhZjMLaB/kHT6Yh5
	 bsWfeQQ/Bl7AA1w3m4d0n4Wid1ZEN3SG1YZLoSiTmihC4H8Nw5QOjnU4vxgF8OolLV1SE
	 BIMCm9YZOFkZ1DTXO2idaJVGNYnmBtVlLD2ZRzhazi06tRbl3uFw1SmTaVAk2JJkdjVD1
	 8hATCg+p1Hgt8p7ZDgMXXJ60yI92Sk6IVz+HPxX/PIFSpg5IUdJZTEq/8EKThfIp7Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TP6Wb0G9;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A16606A327
	for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 03:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9A16606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TP6Wb0G9
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c247f6687dcso556629866b.2
        for <linux-arch@vger.kernel.org>; Mon, 26 Oct 2026 20:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793072572; x=1793677372; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3AmNHif0hEkmbwEeTcZrwdr+/HB8qgSmoybIARXFX10=;
        b=TP6Wb0G9zLDqWuDXb4AhwPpwuHlSKdtp7vOXpYDf7eGm1a80xAQ1Kk7a3BAwdBSgbf
         7jIsPCCAndPaIyaXMt1h9L+v3YN04he2Yn/CRRvHVdHgoUlgLlSgwa9hE7a1amSX74cH
         Kwjdvwabbe16pgNJqcLstwt0irlt7+SuIDQSlFjPA8tQknv+O8lFGJzh6gB7RDu1kMgs
         b7Ioo0qZ28U44QqcJ5fTkQnZXkb4QTONZ/A3yzR+1a7MYD/SYCY6zoTd6EcwzJuhItLH
         0B0L6IlHYe4/Vnwr07ZM2/roJJBr1DR/QdSECM7/FpaBVLw/yoke4fT7pykNvEVAzfsJ
         pBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072572; x=1793677372;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3AmNHif0hEkmbwEeTcZrwdr+/HB8qgSmoybIARXFX10=;
        b=AHo3VgEjxWgeJgOPjixPXkvxV/lXC4igyuHMci5cB/NUHxCFbHEpgKJRr9a9R5nNpG
         gwLTw5eDPcOOY13HkbKlH0dxcqQao0kU3A+NiJXmw+MImLKrRgLD/atngPTIHj/2OZyj
         QbKLhgwD854a0tBJp6YxHJ8NNq+92O0bb578fX208s+6W70DgJTLz4iYI5EtEvDnXAgl
         cIyRH3AXEB46oCFlOszTLfLLB1yg4PzvdO91nP6xoKo61Ksmmy0aWudr6/pqb0+lpOYg
         hEnmYU19CvrVW6vPfWrGsrzGpnqDUgWF/PUBxGTot/HMGRT+97J5Fl6zeb+RPlPepOOT
         ZhDg==
X-Forwarded-Encrypted: i=1; AKwUvByEl9rEsg3dniPp/4OLgAbes8AQ/MNl7+f6jYg7v7laFbimFIUaCGeChEGWj2gBAwxPWjAYQcIOOzJy@vger.kernel.org
X-Gm-Message-State: AFq9FYJQ3DIqdAexy0UbVDolOBiVAnQnVSwb00cWDYSkDHGsfBZGGIdw
	kMgclxtsR9tf9nUlSBqY43Y3J31zw0a3sKUZ8oqVitNYE97TmM6bzaH4SniOPBAXt2c=
X-Gm-Gg: AYBFou1whWxx00MZkn7CE1ylFIGQwfkQ6riJ1zrfa59Ad0k1s+lF6Gecw9cryFU2zg3
	YEWU7VigzxfdeIkUn1j/qEb5idcViGyjTsywvc/pm2Bl+zZjLkKO82HVIQ6ZFuzTUFd4EGDJ7mr
	kNNQUeHxjUOE4yg94F+/W1S6uQIe85LfmEVnqBaV9FHYus+qPxvGqQymB7ZN8hP/ds+wSM7aLZ3
	LHcxZWVwyE8qDl8bi24lyymoS4YXAntKsqdV3vBDimI1L9OIfP9KAUJuew+pn54hc18L3GAN2t0
	yfTbJOs6DcACo+ptyWc24JtGbk8E2RUZT/ubCnNoRSvaByxhy2OCghTqPB+crLpyL9gW2q1j/vM
	0YWYm+TAn5uUN/ZrxAOdNP+9Tv6aUg75H1dDzRsivZwRZOZCsWotTVeTXlofnPOmIUjE/hz9GLh
	7vyM0pzK57k3YZ6F9nsP9b2/7owTxqhtauGfGsjvuZJ56MFVxO3rdQmkt8hvITZyfjRNx72wcOP
	Z1XwyZHU5qYEO5aCKQGwD4yuV1WHuh5h+53yh/5AmBu3Y6L8u+EDF0nmEEtd5jdkkYc
X-Received: by 2002:a17:907:96a4:b0:c42:102f:15d7 with SMTP id a640c23a62f3a-c46bdbf000fmr901757066b.10.1793072572116;
        Mon, 26 Oct 2026 20:42:52 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:4a::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd649997sm382056866b.42.2026.10.26.20.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:42:50 -0700 (PDT)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 28/46] mm/mmu_notifier: set ->mm only after mmgrab()
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-28-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-28-6f74bec9a5bb@kernel.org>
Date: Mon, 26 Oct 2026 20:42:49 -0700
Message-Id: <179307256988.1171062.17835586018092384558.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> Radeon uses a non-NULL notifier->mm to decide whether to call
> mmu_interval_notifier_remove() when freeing a buffer object.
> __mmu_interval_notifier_insert() sets ->mm before validating the range,
> so a wrapping userptr range can leave ->mm set after insertion fails.
> Cleanup then tries to remove an unregistered notifier for which no mm
> reference was acquired.
> 
> Set ->mm only after mmgrab(), once insertion can no longer fail. While
> we could fix radeon's code instead, setting ->mm on success only makes
> the code more robust.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 3506ff69c3ec ("drm/radeon: use mmu_interval_notifier_insert")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price <gourry@gourry.net>
