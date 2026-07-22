Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18EA4EA38C;
	Wed, 22 Jul 2026 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734378; cv=none; b=LqYvnroer22Fjjg8NAGV0eZce8jToR9BtCxd+Zf02x0Mr6HUJGAxqbrOl1plq/JLfR3K2A/fJMXXyqbBvKL0rCU7g5bZGrl1x5IOg7KXWBKfZCGZTuc+zkEam3i7sV+yB1qySEQWjQgvOkBYAmtJMNvVxeEPC+nonqBY4wWHmVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734378; c=relaxed/simple;
	bh=Rrla32h3UFOwfDCIJ6mk+qS084GnFvMqrfkCfZ9JSzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GQ3oglrQbj3U2iu1FRPMgwdyMSMXDiYPBVmcUg6Llx7vOW6ofUNZi4JtdaUQKSuiWM5QOuFpAkYZkkWB2lji43lo1Ma9AGqhtVUGFrGq3Ge44hT/TfVOgSvPL00rxNq6LwirFDfa4n0R1iswmz6EYbBdYPbjuZCDioBBxdlNBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XyJKsFxP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XyJKsFxP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23D0D168F;
	Wed, 22 Jul 2026 08:32:52 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 814893F66F;
	Wed, 22 Jul 2026 08:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784734376; bh=Rrla32h3UFOwfDCIJ6mk+qS084GnFvMqrfkCfZ9JSzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XyJKsFxPiHVmHyMB5tdKC0VZOaJ5wDUT6AKN3Lte8vHdVyPzXh/uia/Z0HVn8xxLZ
	 MJpub7dt7bxTTRhnbNvCnV3PmBb+Vtgk1WPyZ7OiGixI1C5hpGVoPBrfhbhS1kEDgb
	 lEXOBfK4WlUhNlmJl4mGFF+ZmyhWn0p25in03lgQ=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 22 Jul 2026 16:30:27 +0100
Subject: [PATCH RFC v2 19/20] openrisc/pgtable: drop __pmd_offset()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-dummy_ptxp3-v2-19-d9e4bad31e0a@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=881; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=1xb3Ozyh2JOl/Co51IUX05GaQJt/5FuoyIGgUorDpg0=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqYOIYnrk3rC8ElTnTfer6SHj2oBWybBYLfju+d
 4SncyB+MwqJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCamDiGAAKCRBt1cPRWsUx
 M4boDAC/KmDndZaDO1jJrApOeQCuvkJuqhLMfdqukXrHibqTGpXvh7Lwc4sNcH7N5YegBcGYZnV
 j8OQzx42GbLagf+9QG/YfGPDybE4rC2OL5XPwimSbLMb+WN4I8/lilSnKa7wUaS7SL/b4GC2vkg
 8Jq/RbDvH+rgu805sIkfBKek5svMwWjMRRI14lIYZMBfgew6aO6qlqM9ztketbWrILpth4EwCEc
 cSBBO3cC/Pg7wWs25SiumksIV8bHn8Ze+9gPUFVMnrNwv9tddfeydkYK/jz7okv12hujP/fvdkj
 LDxJHLgKAtFsXVIjaQzaCp3WphsglIEJV99pn+5cw/JahUqiDyGT0p7IQT1hBvRb4s4d4fUo+Se
 D+tYt8k4B/cELCEj0LrTzVGfuWx+FVIESJpI0CfO6g+/Xzmfr7HkNrp4FAXv/nHkZbTes//Vc1B
 +otIwlYp1llqRUcFvB/JSLg+dlLxLagbPM2+dPFj+lO9ocdyz9TFn83w7Ns0+BMZmq00I=
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
index 6b89996d0b62..5a491cd0f008 100644
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

