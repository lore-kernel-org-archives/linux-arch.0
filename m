Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B5F483BEE;
	Mon, 21 Sep 2026 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988221; cv=none; b=hrfNj0dpw8J2Hv5a06Eww9tsSbVpElEJRcHisBfS/YmEq/NSUzS7LuOdf/Vb9cckXzlosOCIP8jS46AHLWBwbFwwA3qCzJdbtsSauONyx10AtAmKA2Hn07e9abXdJ8X/Rxai6v59nVosTQ78cE2itnatXznMTnXzIb/HFbr4JUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988221; c=relaxed/simple;
	bh=rnI7y0Fpi9EpSaKs0zPg/sympiblJU7quGD2p5tv2as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FlgCwt8iSexa8aqQwUF7tHkKY1zOw36F44uNthooDfnraIV3Bks4wuQnm14Pmy/h7C3XxFO6i1vJho+R5JCHakGSBzkmPGxEahGEF/vGDE1JqNEY0Rce6FGAYwvubWn5BoCVQOppc+IjzApPTVnTfsIcZ7iB7IFnx3IpbmWq1/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Erxu0w3k; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Erxu0w3k"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B0B41CE0;
	Mon, 21 Sep 2026 03:56:55 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA2C53F86C;
	Mon, 21 Sep 2026 03:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789988219; bh=rnI7y0Fpi9EpSaKs0zPg/sympiblJU7quGD2p5tv2as=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Erxu0w3k0j6ub5hHfj+RN6pEhjSNKHkKz8ooYKskXllnoLVwJ8Ut4DZ7NeEJ5/rDP
	 SPY3vbUR4axOfHnsqT+sZBjZVHL/E9nsVWbpsXIhcl8s27YOeWUOZEH7qpSiFxdsmr
	 myTCIU+NKUGM4uM3qVejSjvoXD/mXvabuVl3WG3g=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 21 Sep 2026 11:55:26 +0100
Subject: [PATCH 04/21] LoongArch: mm: define pud_leaf() only when PUD
 exists
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-dummy_ptxp3-v1-4-cd40cf68242e@arm.com>
References: <20260921-dummy_ptxp3-v1-0-cd40cf68242e@arm.com>
In-Reply-To: <20260921-dummy_ptxp3-v1-0-cd40cf68242e@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=993; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=uHP3fCujvTA7teOGPJseRh4165tfxVj1UjkqwzmtCWQ=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqsQ1MsnYSzGCrfSvMhPR2nenqzfaOWd2TWY08B
 FS8dv7UCUWJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCarENTAAKCRBt1cPRWsUx
 MwVVDADY86GBwYvZ/9NRAVbtoFfHEGdfPzdSbaqYPaX2rteHd+ssXS7FQyNXF7l/1y5jgMN6f8T
 u7ZaYgOKw41FfG1EJ8ZIDiu9bHuqzDTTvuRML+XcjRwJXrhPRAztnbXo/OZ1RTqo729jpcB5Xl9
 9PS3DceEj++x8zDzmyN8uxazCUfLRsT6GzwULKx9ysQ+5jUUhYPliUTuPjjCAry4VEjHRk2u0Ed
 vQh9FTH94HI/jFBfC4SZtHDWf6T1x5Mb0/CSBtnqPk4Pme3fbJMuU2FsPfmyKx2KBuYHJkBfRDZ
 2znp1ATgR9+XFXRZo4l/N1jmwBMxYXnA63Q4aLVjuDFyHKRaqnvXBv39ZW6q6spPgH9F7MIAiZ8
 X6kHCzMocHrCdxMnZwrD4R9ifssomtcBwjrY1xxB7PCNiew50qsZ9SlhqunzUmYP5D4KRNdR9Eu
 yEbDNwJYCgqoM0+XH0D/u8DleX7OGnVzPCTqimSGz40CcsWXg4oKF9+WTv4QSQoYAQubY=
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
index cf29a4c8ac593..8aee4fc27a26e 100644
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

