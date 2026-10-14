Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678B5410D36
	for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2026 03:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791950360; cv=none; b=V4iPRD7FzvPO96BWD4wD9PS/CepjyKrdGEx4VFa9ohN7HsjNyoMd3mMYW4jZ5/F0XX5qQgfQHlCaHicdPIxlw4vev1OadU1pp9kWlqXQG+PMR7p31SDoYuHDiomCc/p4qZiZB22W15DcL1kFGq+HfrmuYJFaGoKX1niYgmOTNsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791950360; c=relaxed/simple;
	bh=eo2KS1rD2mthJFfkPWGzxyjARkBBzJ1ObzuNrYesD1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtXPktwcq+yvzvB3cTzh+Vpypr9JuQ9czrA8DZXrmXe9mXAMhVvNHuhFoXyV6BQOJGu6Ea5veI+NfiixKpUdklNWddvRUKs+PowDPMmPrxBQ6M6g+TDrkx5vwg6ZF1hViTnHnXM6Hj9y1bK9WLyxCOVR+vmofpCmJED1mRs7NeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ajkvbjk3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ajkvbjk3"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab450c0873so3030392a91.3
        for <linux-arch@vger.kernel.org>; Tue, 13 Oct 2026 20:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791950358; x=1792555158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5STA7RRpF0bZE7yNESPvMRAN/jMwPnFqOs2b9BGo7gc=;
        b=ajkvbjk3kTPfvCqcZGv4EJqKjl+5/xxRCJuc52x+TJywPi/B9lU7YuQiSJvhgrdZFS
         ZCqGSfrf5efC82Vl+nSlFwfDM8PcreOEcIMxYFLkZrGBQinbjcZFV3cn95wzsuFAKNHu
         c9EXuJyOrgR43wPTICZCiqx5zbn10VaDruDFaTZfhr7STZmLeLqeWpOaTxV+GdLRUa+P
         LGG2A4hNTeO0nvLe6CVn+adZh+nalPuwJGwWWc9+5jMH2ejXNhIY1ByllNNuX1r2oUCu
         DgUfkyOmM15luwL/Gz0oEp/tEOp7ECgdgo6JMC9cruIIn3aGKDIvi7a1+d8e7OmPq/32
         gXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791950358; x=1792555158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5STA7RRpF0bZE7yNESPvMRAN/jMwPnFqOs2b9BGo7gc=;
        b=nt+sV3jnn0sSXCkSZReDJhIhmszYG5YUOrZ+ILWLS/fvTyR8tXT/cWbwlPkf+PNjAa
         A/N1YvdLD1o+IhgL7mtcwY0nwRdINYYTe4kOV0IHmhsvwJ03biOC4gbHsFZFJsuqGpzl
         J0AA/ljHrpVgEqtmB/ER0PLO8CNa/164iMQysb456r74HFaAmuFlpb7SZcMHVz9xRXA6
         N/sG4FQJJoXdcKQtKy9DSdvnDA17dVtG27OlNE8c/sD0zaRqUaYLxwGcecskqtWVr1Mf
         MKY/s88gJFjFYG1VK8nHMML1J0qUGxVjGOYFPYhtd895FcJW4abDADy5Eu508q72Jn7H
         xqSA==
X-Forwarded-Encrypted: i=1; AKwUvBwFCqfZ3PLu4vhLTt1wR4GnvbCm5G8GFEgEC6GkeFZ0WjvzjNxzEG6/eLm/INuG4EKGOxre5UDinmx3@vger.kernel.org
X-Gm-Message-State: AFq9FYIuJrwCxdKXrfuvmdOVO3IDcG5Mv4EepoUBkM4SmDrv6yXKcnkp
	s6lhwhZ6wpHA/YPchkvcNTa0UOGpfXL1Oy91NEdj/68wqGsYwArAfa7oltqDeTYas2U=
X-Gm-Gg: AYBFou20cwKiRxGZMe5MGK9tnYcQk1BCXQ3Kc8cXBmiFuGk0aAA7HPlvMg2/YE3CCj1
	TSWu2UigDRReBC65OOvXaCqm8YRwcvB3KXrKx05iEB79DDGhVSQCCW4OAANGp9Q9IunZMCsTiIF
	9hATjbIBjCn4Ksp9D0s5pY9NBVdV/grgJu6nDGcFIkcU60hatq/aqI12K3Nkhq3Weg3dN/6lgdN
	e/6ini7MV6o7IP974Ini2qAe/sgBlBSUjfvZzVcywYGERyQWmn/uzDHlX8pCgkUX/oYwId6acDW
	iF5kaXUVNIK1uIQVIhVY9LmT8byiIc7wKJn0F2PgU1OaRhBnhpaxT/cnx/VhQOBzzriRWBj0DkR
	jmZRryVXCY4tZfup2RGpEZztAK8D6xg3fghxntGwR/SCfCSLkQFLzkVimCUZbn2Qyd5omYcCyLZ
	o9s2uox5kIXHYbnvyjpuk8eh2rpRKYp97l8nuW1k0SxXbbAWc2/V+O/T3rsRT7J1aMe8rl7At8B
	2WYQ3D9gmk4+anA0ALr
X-Received: by 2002:a17:90b:4c8a:b0:39e:6a80:b799 with SMTP id 98e67ed59e1d1-3ac63bfe81amr1395913a91.41.1791950357376;
        Tue, 13 Oct 2026 20:59:17 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f24a538sm2492305a91.9.2026.10.13.20.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 20:59:16 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mm: Generalize page table allocation helpers
Date: Wed, 14 Oct 2026 11:59:07 +0800
Message-ID: <20261014035910.687847-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A subsequent series will switch runtime vmemmap population to the
generic page-table allocators. Since vmemmap tables belong to init_mm,
the allocators must select GFP_PGTABLE_KERNEL and mark the ptdesc as a
kernel page table.

Some architecture-specific allocators do not preserve both semantics.
LoongArch and MIPS choose PMD/PUD GFP flags without checking the mm,
which can charge kernel PMD tables to a memcg and leave user PUD tables
unaccounted. The private PMD/PUD allocators also omit kernel ptdesc
marking.

Rather than duplicate this handling in each architecture, extend the
generic PTE, PMD and PUD allocators to support architecture
initialization hooks and non-zero table orders. LoongArch, MIPS and
parisc can then drop their private allocators and inherit the generic
GFP selection and ptdesc handling.

This series only prepares the allocation interfaces; the runtime
vmemmap conversion will be submitted separately.

Muchun Song (3):
  mm: generalize kernel PTE table allocation
  mm: generalize PMD page table allocation
  mm: generalize PUD page table allocation

 arch/loongarch/include/asm/pgalloc.h | 48 ----------------------------
 arch/mips/include/asm/pgalloc.h      | 40 -----------------------
 arch/parisc/include/asm/pgalloc.h    | 17 ----------
 include/asm-generic/pgalloc.h        | 29 ++++++++++++++---
 4 files changed, 24 insertions(+), 110 deletions(-)


base-commit: ad9f2d463666c64e94b04be5263c9bf8f9f96fb7
-- 
2.54.0

