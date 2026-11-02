Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618522;
	b=L9EJk9Lr8hCSPUUbTPz/7Wx8DbkyLUlFuBV5JJxbaCWCKxwX3Bl8RrEGzNnujDrXPF6E
	 M1jkHgOfym5nXoh5IhF1Zv+FIbKntFKU95JgjWztIJflyL0qvUs7Ah9TzPu5+1V5cuYy2
	 /AAgJkqPoa2PpWoU65vCY+WmPKJUMtozCec0DdFBG8dJ1dFEMZcjLxx4Ya7yySvogFfqh
	 3KmBnhqvi19NwMZfANh1NRISfocthhKUQlS+5A4jhTX/277Pj4/VSht+ZoBPYUObJ//c8
	 5SNw+c2GATBgG/SgudRY/cQiSzKBIb47oIJWSs61YY5CmWyKS/fOl+DUEXiTQofe6PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618522;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=OIY1t0oPGMjY8wdeN25SmhCvTiQ+irrDhx4HcT07Fl8=;
	b=nsjhmg+4pW8/9Zpv9m99raa7lnzQM8q8BYIVaPAuZjGnGYGyPFw9BYspgdS4M8X3gUJL
	 nh0Sdbgs0M5Rc3fGmY8Nsmq5MeSikIrHnlAkg1hT6bIAVMdwosoZ/+waw65+xD0KAv91Z
	 xb/CWc/MkaJwI0ITUsWW1+zqklm1PJ5++IF5qtubDtSg9fEI6s2uVxZNTjhxGSys2/zZm
	 BFuQwHk73NmC2UcMsMCXhh90Ubv1VLuqSDascX7krYH7o7lQvLENGf9dwl7z58cJ8zRL9
	 1qX++kKLxOOQ6MY6J83F2j27jemPUY2AoCcbxhcONNP85ShMF7gsXgPEFgi5uo3lfWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=P7pPmEP1;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5E960A2608;
	Mon,  2 Nov 2026 11:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB5E960A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=P7pPmEP1
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 368B01691;
	Mon,  2 Nov 2026 03:21:58 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4818B3F632;
	Mon,  2 Nov 2026 03:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793618521; bh=kV7fmntEBngzWjlRtt0fXgbabk4vgoYlOIhmmgX++kY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P7pPmEP1+y7xcVY0D4K6XD0jQizTpCe9MveMakhuwNTgU2/rc02un0pmGMjXbJF0R
	 aYrAH5ZcOrnP+iq/bNtZh3I9kNmBsSIpcL/OxZxQcPA/T9dh0psHgdWo77wSDR8Jtr
	 w16o3AMZnYr0X/mED3RmiUDXSnMXprAQfKtqzhZg=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 02 Nov 2026 11:21:17 +0000
Subject: [PATCH RESEND v2 04/21] LoongArch: mm: define pud_leaf() only when
 PUD exists
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
Message-Id: <20261102-dummy_ptxp3-v2-4-78840b2ec73c@arm.com>
References: <20261102-dummy_ptxp3-v2-0-78840b2ec73c@arm.com>
In-Reply-To: <20261102-dummy_ptxp3-v2-0-78840b2ec73c@arm.com>
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
 h=from:subject:message-id; bh=u7CkBygp3t9kTReuMDaCmZH0s2byLy+RqHAVuQrH24I=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBq6HIwlxi0fq0NvoRR6wAM7dkyWS9oxQBI40Cgc
 DKUESF9vgqJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCauhyMAAKCRBt1cPRWsUx
 M0akC/9EGZkuiEkdTxl3CwYCFtvx1xhNG+FjrVxbus6mPWauJ8F5+J5sg5Np9DCF7VcqrJ7ge/+
 bth6MHuatRPh7bNm2qmt1JrSUpNXrDlMed/ARE35YCapddiVFrA/hyghxyvDrMd5RXiBZ1M4RTK
 PBpos5isVI6lqHRQNvFpm93ZH2dO+LOClaTapIUlIZCo5Lg/rNxgcJrdFYAMGgANqyeKI3gKPd6
 lQtVhU1ZcDtV2xOKlhJegzKtK8N2O6FCC0F/mzVAlow4BD/Owt2Y9Pla/PUoribW/NWNTCSJ5mV
 yQmIkHn4eDIrvIg4JJi4YgB0AVvnHsv9ctgHp71nNecFNaljvmmvh40iYvrgkfBuuxpwT2Hsyzi
 PDwD5+lh1C/9TTrOCsmc4rjeHahxJv3TCJ1ggX4w1/T9VRTBKxgZEgoQWtprkyPP6vK+BHLuFtd
 Y+v4psuuQM6VJV21P5UYO8NVMmjA0VothRLarZ8QJmarCmc3Eu856bpeW5BNJO+iTCRXs=
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
index f876031351319..9a62b87c246de 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -631,7 +631,9 @@ static inline long pmd_protnone(pmd_t pmd)
 #endif /* CONFIG_ARCH_HAS_PTE_PROTNONE */
 
 #define pmd_leaf(pmd)		((pmd_val(pmd) & _PAGE_HUGE) != 0)
+#ifndef __PAGETABLE_PMD_FOLDED
 #define pud_leaf(pud)		((pud_val(pud) & _PAGE_HUGE) != 0)
+#endif
 
 /*
  * We provide our own get_unmapped area to cope with the virtual aliasing

-- 
2.43.0

