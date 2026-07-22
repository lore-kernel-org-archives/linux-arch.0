Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF8F4D8D9C;
	Wed, 22 Jul 2026 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734271; cv=none; b=bjl3oLWu2usy1QjmhP9mwNHbYKji0Tvop3gzbuHrtrSKkGobyN3fdLp/9nn4C8XyBNtnLEgz1TiEbYGzRClsWTEsRwT52M2tj8c23qaQk/DmfriyBzDjLipTsEOHT5KxQr0t7R2HaLMXRlsT1wfhf4tKPxnGlOImq4vopy8MQBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734271; c=relaxed/simple;
	bh=j0suFj/k8Gjr4NVwWjc1PSJ1cuCmTYQ6kxO/jY4zAXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mnKG6NRHy2I86a24GPT86/OK4lKupjzJdnwam1jkKRGzV7Mp4gD1tkTHXFZ8uZKUp9b2D0D2tIbrLv9KSNkaOszOhxCU3elqfH3KE6ZqOoJPOLPC0BmjE4d4Qs1TU3vJeHcv40ZYZhxASvVe/McebFgVt77BNxa64eRVah49un0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bYolj3D9; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bYolj3D9"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C53141595;
	Wed, 22 Jul 2026 08:31:04 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C0253F66F;
	Wed, 22 Jul 2026 08:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784734268; bh=j0suFj/k8Gjr4NVwWjc1PSJ1cuCmTYQ6kxO/jY4zAXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bYolj3D92O1Bkcb60RbrELEOeLxC7qGiqrMWoWtuCVK9o1rROA8BeSTEehzqczBjF
	 eYwaWgknouSSn8Jr4x8hjddfjdjfPza4khbR2hWMic7OBD53WOHQBqO1G9dCqsrvXW
	 gFBujbdyV1Mk5pLV6+vLyHnOJZ3ZEHNvXsqCp0Ew=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 22 Jul 2026 16:30:12 +0100
Subject: [PATCH RFC v2 04/20] LoongArch: mm: define pud_leaf() only when
 PUD exists
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-dummy_ptxp3-v2-4-d9e4bad31e0a@arm.com>
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
 linux-openrisc@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=XSgg9DU4z+fpwZlmcppVFAW3W7NViUDDiwwjek4Nc8g=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqYOIRg3ZFYgpHwFK1On9j8uxrxy90og7ahILe6
 1yqnuhRWRWJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCamDiEQAKCRBt1cPRWsUx
 M1QWDACgUOyq20o0bRU6YzrYy+b7sre2Ng1kMqamUWE3FtJ3UDmIzrC5o6Iq/xiJuQ3V8mER2+u
 sevnTIQQr89vZ9/I5k+KZosUXZ7NfZlvXH+uxw6usioIMN8Efb/0o7XAhncpDgnrhz0jqJReJ0c
 1FeAfWsc6PjjC+VCtxvXVgha6Xl8aEoKHnRFFsFgjeWCpMSQSvWE5cvMWaPhrkMA8dipKjE9B3n
 uJJ9l4UBtZuIa+OiF0higvwhEHRNZWiJvfJBssIZRq4J+qNjYnJmWaAfiiEEJtExocw3XkhHcZR
 bMflTxQkLe50zAegke/F3vuVZzXG0oSAyz5bDqzjnCYTY0YLf4L4C+PVKcIeOg8L1CMkgY7ZuAs
 jzmsrFaiIVlZeT+2qxJHempmPcEYOFmjrXOS+OlUA39p1kZ8vQzlvLM63vb4Ync4R1M4lQ7dOhq
 guDP4rJuLCL73MzRDrsWdrcsvjAB/6UlAUTfuSNeyvc4TBQH32QYx3FAtAbKB/T/1YZiE=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

In include/asm-generic/pgtable-nopmd.h, we do have a hard-coded
pud_leaf()=false inline function, but we miss the "define pud_leaf
pud_leaf" part.

To prepare for fixing that, define pud_leaf() only if we don't have
__PAGETABLE_PMD_FOLDED.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/loongarch/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 1952e34bc8ee..434e5b483466 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -636,7 +636,9 @@ static inline long pmd_protnone(pmd_t pmd)
 #endif /* CONFIG_ARCH_HAS_PTE_PROTNONE */
 
 #define pmd_leaf(pmd)		((pmd_val(pmd) & _PAGE_HUGE) != 0)
+#ifndef __PAGETABLE_PMD_FOLDED
 #define pud_leaf(pud)		((pud_val(pud) & _PAGE_HUGE) != 0)
+#endif
 
 /*
  * We provide our own get_unmapped area to cope with the virtual aliasing

-- 
2.43.0

