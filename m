Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CBD471420;
	Wed,  2 Sep 2026 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350247; cv=none; b=YOfjv0zm1W98zhabijE9RzRG6zUbs3iYYa0dzxqOrfuSXBy94NDlgNqrynJQKmBmIMikQIhH3FOu7ou8SOSFapq0lcGpW3DlH5xg7OXqxN4bbDfGqxyZ7jGCvAOxBeaz5WuKdfLM7XIY4XLqbmSIwHrq808Q8J6pA2ARsjGFx74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350247; c=relaxed/simple;
	bh=j5KZYcW3oeEza4wEEPuE0tmGJJW/8LJA7zNPUWzIuhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ccOeL8JVu9LZ0k3w8Q7RuqkWRm/84L1wPOiUD4lN8RORKDuZMBk1kYXnpUSoAXX4QGxQrLh4JChca0YaV9CFOMwm3besoYbcstT3Tc7l86otkVnxl1qPf7R0gjTYyeFjsspS354+dLGOGcw5ZdGK/6XrCanckOmTRsYdXHBDRqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f884vSlO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f884vSlO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1327F1D70;
	Wed,  2 Sep 2026 04:57:02 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF15D3F85F;
	Wed,  2 Sep 2026 04:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788350225; bh=j5KZYcW3oeEza4wEEPuE0tmGJJW/8LJA7zNPUWzIuhk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f884vSlO+uAcSOf6hpsG5kaWDJDu6ROVeqIxakx81gtXhm/KayFYQx3b0SCK781i+
	 ZSk6qtseiictiBC97Kr4v1QHtwtGjl/atFe3flG+GhuG+wfBXuUBazoiBAngDR8fvR
	 tKEl/qlZ1BbKg9E51TqNwea+bodKg9gJ9tMXlYsY=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 02 Sep 2026 12:56:06 +0100
Subject: [PATCH RFC v3 04/21] LoongArch: mm: define pud_leaf() only when
 PUD exists
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-dummy_ptxp3-v3-4-5d8f5b17c25c@arm.com>
References: <20260902-dummy_ptxp3-v3-0-5d8f5b17c25c@arm.com>
In-Reply-To: <20260902-dummy_ptxp3-v3-0-5d8f5b17c25c@arm.com>
To: Russell King <linux@armlinux.org.uk>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
 Bibo Mao <maobibo@loongson.cn>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-openrisc@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=MeOlGX5zz7TlceiZpHJLSajwL3IbIwIyElnPnwNLJYM=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqmA7jTpyCvz3weXiiloXvIu0HwGyNZYxNUOeR8
 zzOVDDHkf+JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCapgO4wAKCRBt1cPRWsUx
 M3FsDACKI0amFDWitWwqgh1X55KBW3r2psT1svJy9ACAY/TLdpJ2t6SqKg8N3iwOgav6tFmT1XU
 86PQMGlakmgCrVcxwGzFtiDfDMkcWhmxqA/hhBGByyFv3V8gAiqsIoTquASbDXeL6LoJdJ5A/xg
 IebsQSd4VBxzbzb0gOXKeqBB+7iXnGt0wae0LXAeHWxCPmG9kDER4VE2c68yCvvDMmeoYfzr1BH
 +OFsMihMBsPX8/ZK/6nTeTCYg8IPT+9DnZPLlxl0lP+VsQbT0ev47AJ3nVeUHxgAOk8zPIY9K9I
 dCABHAruCzWiJw+oV/AwPm/soI68/eQC5VVhARWFqQbPX19ouqoqsU7X4HJpSm751C8/KxvRCja
 Xy/x/jEo2crwE3wqLwygg1u2ZnbLaY8I5NsAH2gLHc3J9pcUSFUnPbsXlRmoFcDcVLAZVj5ic6J
 mm/ikE8OecbRalNsAOP1gdwZSr3I6i2GxLBhGHvtVWYZUt6+GxdiXpV3MblQM1dbfU9L8=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

In include/asm-generic/pgtable-nopmd.h, pud_leaf() is hardcoded
to return false as inline function, but it misses the "define pud_leaf
pud_leaf" part.

To prepare for fixing that, define pud_leaf() only when
__PAGETABLE_PMD_FOLDED isn't defined.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/loongarch/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index cf29a4c8ac59..8aee4fc27a26 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -630,7 +630,9 @@ static inline long pmd_protnone(pmd_t pmd)
 #endif /* CONFIG_ARCH_HAS_PTE_PROTNONE */
 
 #define pmd_leaf(pmd)		((pmd_val(pmd) & _PAGE_HUGE) != 0)
+#ifndef __PAGETABLE_PMD_FOLDED
 #define pud_leaf(pud)		((pud_val(pud) & _PAGE_HUGE) != 0)
+#endif
 
 /*
  * We provide our own get_unmapped area to cope with the virtual aliasing

-- 
2.43.0

