Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349493;
	b=hu2VHlrEFL9VnuN70mrMVrHS0K6mkWuscHjO1qEHRV8fuHseCBIweifFGhRpb0sVyH3F
	 TnHAytP11dxC78F7B0RMGUXiuF4Rg7vGKXBkCNVtL4N3jIGSoUPTWSUsV5p02BQh212Be
	 mQKHaAcZCns8RMoDHEoqb+y2Df18uTpC212lWZrRDEKtqfuHMBVXxfPVnzyci/nNf2nT8
	 4gyB2bR0BBf1EOedZBGHwgVi6olPyU/JFyolcxw5JsMEx/dou0G2o4Uzh264sb65K+fv9
	 VXqvp71xNy+/w0ZDUyBTHtKJjqqwF0E+kEDmxXBoIoW1EJ5eh1SYauLQuYlELoD1QtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ml5g8GJyiKqZW7cPKgtShDnwVwZ+S7TeGUyvRqBFqBI=;
	b=C3IgZV+/x+067h0eCUnaXTR4Q+yNa+X8yGN+GXo6tEjDic/7Bmd4VOedS2SwO7bAy6xL
	 CBAqkv9kf6Bq9vc1XI3kbxBGS0HiSp9TAq8tKSFeCTTn9bIOsTKniVFnqPpzLTAArmHkd
	 57MrY7UZMNPg9E21DlNI11SQrwQwlOhi2o0IhFtizElLb1T8WlMudVwuUVXoEo4ke/Pkn
	 Jl4JouGhf1BdDkCZoAPl53HQe/NkD4SK7ra9NyoQqEqfXKn3hHiDvk2aq1bKyW3mnVpS3
	 vqyPvcIJPZaHTWqzPkjap+NZSWvAiLVvcx9rnd/EGt3MDpsuwUeRhsL7jN9YZZJ+2dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=B3qLNBas;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69223606A31F
	for <linux-arch@vger.kernel.org>; Fri, 30 Oct 2026 08:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69223606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=B3qLNBas
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc758830601so284960a12.2
        for <linux-arch@vger.kernel.org>; Fri, 30 Oct 2026 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793349492; x=1793954292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ml5g8GJyiKqZW7cPKgtShDnwVwZ+S7TeGUyvRqBFqBI=;
        b=B3qLNBasitzf6QWVfYdSO4M4fb+3mJygu2Kl+gY3YU+aYRkjSfNxVvnwbTc3Y1MYmh
         SrNHFFRP6u2kzxV2WkRKPt9zbzjRMIwFCENvXZJEr5iJb2yyq4eNLacHh1Wob+gtM9uy
         SbRswPI2mty1hHvr+50TA7YXj8o6GoxMu+ZpgFZFbUjoHzq+uqnCw8jAimDCDM3LcXJi
         zTMWX2laLn/Zw3UlsiR7ZX2lydLN59p4udq8E+ZMZmtUOFVcJaSBpcM2upIYp1RJaq4O
         Y46Pn/FkGHCTZtrkCXyufob1K6unSqc3aA8EgpD1o5WUG1FxNrtm8KYgAx+zgnbrluK7
         2mVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793349492; x=1793954292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ml5g8GJyiKqZW7cPKgtShDnwVwZ+S7TeGUyvRqBFqBI=;
        b=0UqIeMkaOKnBY3Id4UvYpMH8XafcgDyQOq1WcJc7GxqklvIETiU4pG+3H1t4TDZxnK
         h8zP5Lhmyts7tFqCBO2776nQA6yH7Z4hycVjQ9qpl151ksIrYnF1YKjRznqHu43q9iEN
         iRKze7KmuwngrnyRGW4eB9TwxUXiAnV4uY+qouIyzgiC3X1ctkNt971ovDKjssZr6rg4
         nRgngGtPkawgkJsI9EVIYz1P3EGpOyHkF53BcEU/94XY/QtwndKe9yZcQNE1w/hW0bPX
         kD3+yd95/Ax0+ysSruGT3fuNbIPurlh32OJJdg5ingtf1NSIYC04WsCSgKAGMVYRMy88
         yeKA==
X-Forwarded-Encrypted: i=1; AKwUvBzXMalnDM1AutFlwv5z8wpnDBQOHS4KgWH5Vb8dwyU6B5QXN3naXk+oZGRWUvR0wgJK5JbXJhdvNkyU@vger.kernel.org
X-Gm-Message-State: AFq9FYLdMv5pJVmOlmWOCiIhL2bQcoC57T2VmqbailGX6wD1t2W+5uO0
	iwBAhjiVvKRLzHQs42PNkkYXtOBzARkRxQcPISbKneQBTfyD9rAn9h4yj49naSSpe08=
X-Gm-Gg: AYBFou2s5UgrMLrYDVUuCOmePfhsIFtdkIKyYi/Ba+WlU4VgDQTrf+VggpO9L7vPbAu
	YXUqJ3nAmLwwA4RuczNidAc8YgRui5uD/0ejKEePZvJonJ/V+cSCUYpx6ZIG1Uf9qWZNLhbpBc/
	eM3Whr+eCdiHETZTqBrCVdbG2H5eE+BxaBRo+I+vnI7eB2GeMfm3k0EB9Ig9X8UVK6uiy5r2sfJ
	uf3pO/9rISzOJu0TGMeQhnoy35e8a6jWhoo+JJo4OTZmNnsaptmYkiKohRWirZD9qC7EHlytXsj
	qm+qiVdo20YiLzu0AUl2dkglom8GFjtOwup+RxbsGwGYp0l+al/FsdWyRi1XioOVLHo8atlepzz
	BkjMFEqYQG4FLSLgGtz64p0FUvSm7hRzQ7g+4mYx3AXsguEnoCWhJsnmXBQfm6VQ9mNrwf6RYUa
	HnedjmDV2o6lZUlW4DoxsY8T7GLxX3wpC8hBVPUkw9FDPXxr1rdwkqHTR9NXJnXltGnulbevjiS
	1KhqdksHTcg/PcbkhnpjC5EKSPksm/vyoEfyphWlRrQ6WQCxAKMOiek+KTQQYjhycUhteUHe0xU
	g5yX3u6CRVzb6MBMH5jeKSXSF71XuLWZGVv44SeXifjzbDaZNCg=
X-Received: by 2002:a17:90b:5147:b0:3ac:97bc:4c7b with SMTP id 98e67ed59e1d1-3ae897c7c28mr1424866a91.14.1793349491405;
        Fri, 30 Oct 2026 01:38:11 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9b1506sm7542122a91.15.2026.10.30.01.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 01:38:10 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Alistair Popple <apopple@nvidia.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH 0/2] mm: Remove pagetable_dtor_free()
Date: Fri, 30 Oct 2026 16:37:58 +0800
Message-ID: <20261030083800.599152-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up cleanup to the page-table teardown fixes [1].

pagetable_free() now invokes pagetable_dtor() for constructed page tables.
This makes pagetable_dtor_free() redundant and leaves explicit destructor
calls immediately before pagetable_free() duplicating lifecycle handling.

Remove pagetable_dtor_free() and convert its callers to pagetable_free(),
then remove the remaining redundant pagetable_dtor() calls. This keeps the
destructor decision in the common free path. No functional change is
intended.

[1] https://lore.kernel.org/r/20261023063428.3658761-1-songmuchun@bytedance.com

Muchun Song (2):
  mm: remove pagetable_dtor_free()
  mm: remove redundant pagetable_dtor() calls

 arch/m68k/include/asm/mcf_pgalloc.h    |  5 ++---
 arch/m68k/mm/motorola.c                |  2 +-
 arch/powerpc/mm/book3s64/mmu_context.c |  1 -
 arch/powerpc/mm/book3s64/pgtable.c     |  1 -
 arch/powerpc/mm/pgtable-frag.c         |  2 --
 arch/s390/include/asm/pgalloc.h        |  4 ----
 arch/s390/mm/pgalloc.c                 |  4 ++--
 arch/sh/mm/pgtable.c                   |  2 +-
 arch/sparc/mm/init_64.c                |  1 -
 arch/x86/mm/pat/set_memory.c           | 10 +---------
 arch/x86/mm/pgtable.c                  |  5 ++---
 include/asm-generic/pgalloc.h          | 12 ++++++------
 include/asm-generic/tlb.h              |  2 +-
 include/linux/mm.h                     |  6 ------
 14 files changed, 16 insertions(+), 41 deletions(-)


base-commit: 9c449f885765cf8d80b2c60b1971e774bba51a3f
-- 
2.54.0

