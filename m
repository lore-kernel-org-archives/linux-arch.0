Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5471242AF86;
	Wed,  2 Sep 2026 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350332; cv=none; b=OGWiF/PGtiPKTE2x3CRMPgq5QuOAxPjU8iRizE4+8qLJKhykC3bd5m1v52GyFC0i3RhRbsA/x3XD0EF2ARAh1Uyqi9cLLAzmRlp+EnpefYtK4Pb7z8u7ibboVjB6LpPZwrp/4RunI5lEiYsmSMQD5RkzIcur0ZBCxUduOGD6Kb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350332; c=relaxed/simple;
	bh=bvSJZEYuUzSfTp3lnl+FWsv3APh8RUXfn9Dgh5TGgK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R7beScHSl1a565kgGYAjovVonRZg1wS5TPmP7njr8Z1FxedXEq88j+H1J7eY2ztChM7fPSPxsuLS+uGBPktNXVdf69WeXrac98gZDAtMJmAflQUkvkjIltBgO/MC7st/GYxE6F6U/bAtygIGqtCILIl3+mPLa5E9UV6/NRpSFU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VQDp4hB/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VQDp4hB/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8A7D1E32;
	Wed,  2 Sep 2026 04:58:32 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61C613F85F;
	Wed,  2 Sep 2026 04:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788350316; bh=bvSJZEYuUzSfTp3lnl+FWsv3APh8RUXfn9Dgh5TGgK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VQDp4hB/Qs/Re5WMKT8eqfXJiFXvWLSISYhYoKX0hMDsRtHpHjqO21RHcFTSnCFI6
	 9b+/JcPwiTaEGulcsFqpFvAx1qS0KIMrLmFTc0tWPd7LPxqmE8dpefCsYzCMnCsR6B
	 zJuttsNkz19sQCyKpC+z6xj4ZDKTo0Dv3LF3T3PE=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 02 Sep 2026 12:56:18 +0100
Subject: [PATCH RFC v3 16/21] openrisc/pgtable: drop __pmd_offset()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-dummy_ptxp3-v3-16-5d8f5b17c25c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=881; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=4wz8+CbWxbmBm+0duGq5oUD3gG+4iNNsSmDgW/+hufM=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqmA7pv10L56yITmkv7MZ8IOM5fh/CxySzocw7K
 IjEcsCxfDiJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCapgO6QAKCRBt1cPRWsUx
 M5aWDADYxAtyl+y2LxVBunlEjk46XhMmo1UlcGdl5tNFIppFTuiJhVz3RKSgMUkVVjwS56w3C6T
 coZfHX4bmgmO43d/gJSuWdFh5kXUDgY3QDfBeyzp08Id41DqlxVCwLPqhJgCg9mdV4NVbgU2rZ/
 djZdFPPzSc4qfWSpf4+UrquyNsHCkCs5hq/y21rF4TFaVoWijqkePHGMpxzH+V79M7kExoU/SFB
 FWmz5Ktb5Wb/6bBN51Y9ONW/XgI2o/yHg0AX6Qu6ruJZa8qUy/820NP3j+vAEwIov4Di6GdoEUW
 aQG1oDixs8oGNV1tSkB7ssu4WZWi8YnyYkh1I1atY36mS9tFc+8MQLVUp23sR1G1fI6wFq7Vqo7
 tQV07xnn9hKFxLcHFuE5sIW6ZidPx1NmbpwiInknq1O6vZx2+kWeRvJ3YDLVOwWgriq+mUt0CZ9
 lS/JZhKiBZfe66sAP6+SVS/mcsN8zk74Y9THLHnG8h9J8pKbVkhKBC2T2rVPfu8txo4SY=
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
index 13afcc0bd863..7fceed641610 100644
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

