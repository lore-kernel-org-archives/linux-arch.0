Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618573;
	b=p0AdT74hDtW/aNh8M7NnhY5iNfvX/XWlB1yothbI0b5JeUg4MO9pskIe6hoCJRekGuCW
	 X5d+3cIuSiiUPJKhJ8GjLsE0fwnmfzxds3BmPBGeL0mv8IXDUwPtJjOMy2yv1mSSeGtnX
	 sx6I5/UDagbf7LIc5l0j+fHjjfceYYxB9s02m+ijBv22tB5PyO99diGRx1+GL9a0rWdvs
	 0r9LAX37W9OHUtfnCpfd5g01o/wWc/4ZjQJop3Ia0K29D55z8mqRqEeun9Ku3oD3VT8yp
	 5sWRJi7nNDahY8EKk89RoMXEcy1pP4H9g0puBV5zsQ5VGmVDgvJJNi1634qIL1AXJqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618573;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Tsb7ch0fkVycRE8l4lzI8CP6E88GuMX71rxiGXcRyD0=;
	b=zyXk47ocpfJfesCAjXR4iQ8ysHnd/tqxhV2JO6NYrrhxnA4X1QbFOSIPgQor/fBtKDtm
	 JIKhQP+ntaj1+CyOxg3msAv6PfoCNAMNUlIPSPIr9gSB/Twb+N/PEVt0gCpAnCsyGOKO3
	 sXsmB37MqQ3XJsSWxXrk58bROd87gTpoRim0wtKj7bF16eM9nVZh6LaOW1x8n8FzgHG+s
	 Rka/eetmrMSBtfHrtXMKTrWo5fnYS2Thfi0jd8Heqjt8YvIW4DDRA9u5N2g7jkqZN3n21
	 pW3oO0toEzOAM/mghG70E1UZxIDc8TF8HhON1x5/KndzOdfW9Zp1lFQIG26SkLpUCXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KZZ2pULE;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA73606A8B8;
	Mon,  2 Nov 2026 11:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AA73606A8B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KZZ2pULE
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42E7A2A31;
	Mon,  2 Nov 2026 03:22:49 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37B4F3F632;
	Mon,  2 Nov 2026 03:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793618572; bh=60Xa9B2iUtyR3r8ioE+XTXe+blj+2dKI9yzxVIZr1t0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KZZ2pULEBctEsGAXVrvXT+Vel6lV2ylQM7v0lus5odxyD77t9mWOEHrZc49tBaniz
	 nQ+V1k58GA0+D6TwKZwG0X5N6Rgew97i5ygFK83+IXfvCKtCKCzyF/kY02GLCg4Hkk
	 VwkyuVCUKrSmbbb+nsizpCRap0p4iBkAG7tU2GwE=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 02 Nov 2026 11:21:25 +0000
Subject: [PATCH RESEND v2 12/21] mm/pgtable: redefine PGTABLE_LEVEL enum
 with ascend order from PGD
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
Message-Id: <20261102-dummy_ptxp3-v2-12-78840b2ec73c@arm.com>
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
 linux-openrisc@vger.kernel.org, Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=60Xa9B2iUtyR3r8ioE+XTXe+blj+2dKI9yzxVIZr1t0=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBq6HI0QV4ojpgcFbw7NYJO5M3UEa0V4ttsQ5fcX
 PLtIuFXA9+JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCauhyNAAKCRBt1cPRWsUx
 M5ZvDADXVkFHHBDnee5VQHc1URqbVSLnRmZQGtwzLqlg+CacOzVx4f7Diht4dzRAiiK+1m9UF01
 wRfNSyqT67w0dI1bwZt6KHNKRN+XFKnks05m3unYkdsH3JMDguBAe8SXxh/WUsURKuHCFf/9FHS
 JE5HMbsaUR8G6yz3LC36b96W0UCpRr/7EQOLZ6PHOYoCayzJauK/OB58CtSVxuWSzi2sNEjL164
 3edL/DfNEjgvKH6m2eaH35w6admU/hQvZmWxMa6KbJN8bT5DZyzVo3tNRhmJGQkqGAaAW4egus2
 Ew8qNAr2sofw58ojK3Wec9idGsNAMVs5eaDhV/V+4XtuXB9aUY4wNVPUTouQtD+hOIM7bgv5msO
 M7P5Xb6PZcHXVtsDFOZFKgoj69nU3EGPXYrfSQ7shRw9Mc+7k0eqPaSEEIlD1mUn0Cs9peZCsro
 zWNQBVLh7Nn3TSK8C1Y/FKdh3N26DPsAkAb/jVrnq8PoxftkHncsqMLPSsZNp68ShBSVE=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

The PGTABLE_LEVEL enum values appear to be ordered in the opposite direction
from their intended usage.

Intuitively, higher page table levels should have smaller enum values,
but PTE is currently assigned 0.

For consistency and cleanup, reverse the enum value ordering.

Since there is no current user relies on these numbers to be ascending from
PTE->PGD, so it can be changed to be ascending from PGD->PTE, in the
direction of the page table walk.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 include/linux/pgtable.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 780fe849ff8b7..a032f95943357 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -2288,11 +2288,11 @@ static inline bool arch_has_pfn_modify_check(void)
 typedef unsigned int pgtbl_mod_mask;
 
 enum pgtable_level {
-	PGTABLE_LEVEL_PTE = 0,
-	PGTABLE_LEVEL_PMD,
-	PGTABLE_LEVEL_PUD,
+	PGTABLE_LEVEL_PGD = 0,
 	PGTABLE_LEVEL_P4D,
-	PGTABLE_LEVEL_PGD,
+	PGTABLE_LEVEL_PUD,
+	PGTABLE_LEVEL_PMD,
+	PGTABLE_LEVEL_PTE,
 };
 
 static inline const char *pgtable_level_to_str(enum pgtable_level level)

-- 
2.43.0

