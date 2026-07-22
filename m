Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26A63BCD04;
	Wed, 22 Jul 2026 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734328; cv=none; b=E+wW9Re8bAnUEXLHCKN1LCmzqaxv6admK0aGj7mKPaTK2FG3kNJAhhIcqqtJa9YfgeQTmTjhjFFziuWJ2NLxTU2Bb6bywmFI94FATBoR2+lZYGobXj1nZJlOXB/tfY0I5BJxSJNTu5My04wG4w695FFsw+b0ynwwCgz73FuOaj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734328; c=relaxed/simple;
	bh=wmJtmiPytl3HyZyDqwtjxdRsUOFgZxGgVlONXYHiJqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hJfnOHraOcSXLYwweD/ajM+5TyxC/ErsQIOx/OzsgPATP7VQ+8+2vo/p1OCxRT/E/tBxKUX9BY5fNoe7hbpzTO/e+u3AFdh8ocRQZicwXb3RwlnHyfWPkaRIifUwooX5o7thwEJUlshy00kolaw0RlnrqcnCzku7Py8ygMg5W08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f6SmQojq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f6SmQojq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B4C4168F;
	Wed, 22 Jul 2026 08:32:02 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 749C13F66F;
	Wed, 22 Jul 2026 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784734326; bh=wmJtmiPytl3HyZyDqwtjxdRsUOFgZxGgVlONXYHiJqA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f6SmQojqGR7brRiEZavDDkmTWbw75QsPyhFd4pAG4O5+6Ju2I8ri3QCdZWN2rXkyN
	 DCTNnGSdIhw7z2ehWnVgZaQ2zE6WyM6dw1A5orUEziWCCg2RkmxAjlcAHyBQDq35NO
	 soM9uXuZ1k30ziofw8vM4Eb1IcYS6m8WnZbnkIfw=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 22 Jul 2026 16:30:20 +0100
Subject: [PATCH RFC v2 12/20] x86: mm: define pudp_set_access_flags() when
 CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD is enabled only.
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-dummy_ptxp3-v2-12-d9e4bad31e0a@arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
In-Reply-To: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
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
 linux-openrisc@vger.kernel.org, Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=wmJtmiPytl3HyZyDqwtjxdRsUOFgZxGgVlONXYHiJqA=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqYOIVfJAQ0bxNGFW5YSiAzNm7IwBxCLOqc80gj
 i7axQ/7jfKJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCamDiFQAKCRBt1cPRWsUx
 M8CyC/9q4ATnNzBRhzDxRuqLX64PSTzrSfdIPjo8WlRytut8ZrhHFMfgcsu1OWhST0JPWq+r22v
 zJ6g8PXhJN5GkfC/aA5WFgbNDhiJO9mfOY4WJaWFSoB5qLe4rVE8KL1nSOeHn4he5thhorlk+FZ
 o1l4TLcbjqnpdwBpnKy9yw8hjMCo1D5TlY7XD6cf4nX6YeSoQzJK3j77HvuaM/zd+70XJcuZkfL
 5Oyds34g83k0HLkkrjLBNu0DPunfEw8czmxodjY9Gvre/8CMOBUGGPSoNrCzTLjf/vjX5PWo3Rc
 oIGj8lh9egTAe+ruiexvMFVgMd62WeL/DvqiV/9KgLIluHYqsG7i7w9KvNOtjtUQ0XjkMtGcuOO
 nZVxKCU95sKFoKLDo5eYIJEZMubYpNqePB4xQQofkIs0yKScpMw20O2n7w64nCyFnn7uV86yb9N
 uOyUjDcvEWXUFQO0OPQ0pIwg21NrgYutufdstDwZ9vqKWkJclvbzJ9HKcNZlfdJcGaxsM=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

pudp_set_access_flags() is not used when
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD is disabled.

Therefore, define pudp_set_access_flags() only when
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD is enabled.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/x86/mm/pgtable.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f32facdb3035..edad847a2ecd 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -411,6 +411,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma,
 	return changed;
 }
 
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 			  pud_t *pudp, pud_t entry, int dirty)
 {
@@ -430,6 +431,7 @@ int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 
 	return changed;
 }
+#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 #endif
 
 bool ptep_test_and_clear_young(struct vm_area_struct *vma,

-- 
2.43.0

