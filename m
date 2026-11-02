Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618599;
	b=CDB+NeRyHZ3r30GU9v08/KwPeXQrqUoUu7HXKfyvIfMvtWfDIxDvZc/M5BrTvSGm10ok
	 kAh0IqgbjFCpygaQFBBwJ4WKCs6+ZYYLNNJdzY1SctylzA0ZjcIvtyhpxXo+710DWwFzB
	 F7jwzf+HAG9z+SOtYeO/JzGaV3Vk5zN4fsJe+LXye56cWERqgh9zQ+z0lIRocWswT2jYi
	 u1mxWPI1t8W0WxMb7EHqMG/UtbVAioPB3esPQ+gQoVw9Y5mllKjp7z/6DL8Q7vyw0DHDG
	 R0QvSyKVOhmASy74THr4gHKi7XTM6abs2NIsMWQxzWnYrC3Z+WQPctGu7Bvw0sh+aFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618599;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=61mOQB/NPnyS6WFT1v6qj3vnbL64UK7nj4+n5n9dFHw=;
	b=AgGh5TgGD6Rkyxf09cgS1DGl7WPWqxq64YqO9WZoQDyAJILaqMakVYU230rX/sgsphuM
	 Bb9xvbjDDjq+G3NBNagA9hi/SATwG5FU9FgdB0ke06FIwctOgy4lz/cqIlN6ZO/NjbZKa
	 UKvbcEeHTUatEToEFwJd13vX+Ep70UdPHKYxg74TB2BuEGHHewDhd1HtLG/6rBQufbqhp
	 EJfdOhmbNXarVKBTjy3q1DEaEVH+YiZEmrtWKuEpYrT0SSDCuCWW3AsUsBNnKRyua9GMn
	 F+/ih267cYGqCxhoVI4D85SSlP3mj1VA4+kxpDQMWCMnz0XHwctdeG+muADYUNgvrFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VZKidji6;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8103A60A5BC3;
	Mon,  2 Nov 2026 11:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8103A60A5BC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VZKidji6
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD92D2972;
	Mon,  2 Nov 2026 03:23:14 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE2F03F632;
	Mon,  2 Nov 2026 03:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793618598; bh=fSF1q0uZ2D6D7eSotmHP8T3BZdnaiPG7UdplRIp/5/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VZKidji6e6O+6chEIb7bnFpe9r7WvFkyVmIiYaEEba1bfdN9JrXHk/VOjxcw7Jcv2
	 qFG379Foq/0vjKt0b37jJIKZ0fR8WbzX6hs+6FN6mIxGadRPx56BeD/OHqHj0M3Q3k
	 P/jCQurQOOjvmQK+t8GXmw74iH/Bo3dhkM8XPPwQ=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 02 Nov 2026 11:21:29 +0000
Subject: [PATCH RESEND v2 16/21] openrisc/pgtable: drop __pmd_offset()
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
Message-Id: <20261102-dummy_ptxp3-v2-16-78840b2ec73c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=HHmjFCiPkfuAa6Yg+gCAN1VqpmgkbnXOKSW8+pCvqDs=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBq6HI2QHNhLhdF8ydTZOu6McskHbnVKaSU6Y1AJ
 kMVzOl9su+JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCauhyNgAKCRBt1cPRWsUx
 MyWSDADUCB3Wh9MFEpUj8ayzq1Kie8YQYpCId3Wx6BZaE5A1K8xkvpBPTY/cf29xjfbRsl7YRod
 f1/gmxrhGnDXme+YBUt2LT+0R/6EYVFjWRb1HaF4XnJ7SRtR5AfMbVoeJOu3aHUtnyg9aqu7SDS
 YeA8/r9WGRtYatAteea4TTFtSp8P9eiyOX/iBhyYCy2PbEOYhYEeHT1QZuWAjUN1uhOQKpV8hl3
 mSpYhEruccW0rL5562glqtUyYO/ueaxe4V2cBBgrXSrho1pWtskDFplB3FGftnJ5yamOVzqEcuP
 sus6RmCTWMYsPRNee20/kjKQ84LvMCIBlqb+2evLIDmjhjbxT6pMa6fthG6IMlOMTv9j0Rk7vYZ
 PgWFxK6acMO4omG7AGcC1rIhrQD5WRMTW66aI38UR1xYHRCPFTR+MGptOyem0dOSHrXPIzrUiaS
 GsTuYuKe/a4MlFNlzuz4X287hGp2oOWGie0GnD81s6W+FjBJt8WVgJP5E2iMP4i/zfMKg=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

The macro is unused, and will collide with a folded page table helper.
Let's just remove it.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/openrisc/include/asm/pgtable.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 13afcc0bd8631..7fceed641610c 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -331,9 +331,6 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	return ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK));
 }
 
-#define __pmd_offset(address) \
-	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
-
 #define PFN_PTE_SHIFT		PAGE_SHIFT
 #define pte_pfn(x)		((unsigned long)(((x).pte)) >> PAGE_SHIFT)
 #define pfn_pte(pfn, prot)  __pte((((pfn) << PAGE_SHIFT)) | pgprot_val(prot))

-- 
2.43.0

