Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2997E46F4B2;
	Wed, 22 Jul 2026 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734254; cv=none; b=ob0MTW8KphduKEwbDep/SV9bjOLivrlOQsbefotmsN/YFP/6qXS37VqF0tfatqqy/xJiARVVkPnx0p6KYxwfZwZRMpwN+7XPPnvTx25Sqfl+fMrTrjDI5UzimONrt2iUx4o9KTjoSq3YmpD3Ey19D2jTDA2gT4oqKtbI5mcUis8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734254; c=relaxed/simple;
	bh=1TxWbr6Rxpr/d5K1ZjUMXUxW7m3hsO+YJqbH2QzQwcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HSMNZk/9CDAuTMRdS9ak0CMLvjLrXHjWNTbPxBb3efIq6BP4p1I8SbHZYgPEKVqmdXzT5pJry+chnHzDP64KuyI4OXLJwHHpzeZWZZyC2a2OH3OUh9LfDA2xfyImRZfnfCqFY+c3RogJYRcCOVic5uholuOmig6xrSS20KQW6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LnOf3bdG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LnOf3bdG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C92B1692;
	Wed, 22 Jul 2026 08:30:43 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D54C73F66F;
	Wed, 22 Jul 2026 08:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784734247; bh=1TxWbr6Rxpr/d5K1ZjUMXUxW7m3hsO+YJqbH2QzQwcI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LnOf3bdGHBtoZ9/i1k15T6gHd7dFP7WuoAJk570GxSvUgd5BdOxok9HLl2YCyOHBL
	 GJxB7U5uIFfxd4a2DVlw6fjpxicCHGnU/35kh4VYvLmym+Ij0aC+RhyHruWS9eiadq
	 gW3ecxtyYk43muPXW0R4LEdqJ1kDHBQE3XVjR/zs=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 22 Jul 2026 16:30:09 +0100
Subject: [PATCH RFC v2 01/20] ARM: mm: make nommu pgd_t a scalar
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-dummy_ptxp3-v2-1-d9e4bad31e0a@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=os/Mhoh7pmCouvRwHLkdVyqjdGpvrfvwObzVbRePc/o=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqYOIPcYgvYMqhwm4vdMbW1urTvtv95E4cikIjK
 9DPVoDpWPSJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCamDiDwAKCRBt1cPRWsUx
 MxtADACQ5kPn20eoyFghflTLYxkjfk9WmMH1osH5jieI1yjfetiAaE48NyNlaslyLflmRD3m8V2
 IzZhaFDaREkU/XBda6pU7oJRJCCkiOotAMqZxAvZX/Nd0MF6rAx7hg4kBftgowX7T24YeTiwjsk
 oR97ApgGOy9jhvsswneZVWYwMRBqKQIc0YifuSw4QsQ6YxH/uVJ9RXEVXDh8eAkUNDGq/5/FHz+
 fgYUvvW/mudG8ph8NK/bi46YJTSkKJewn0uSLAvgOo8iM+Yyoh4w4jfTzWr0RB6cL+V8dwNwZfT
 8EBqdswQ7UYO8u9xGlI1ZJ+hdCIt+TpzHAZHTy/nkDt0Ierri61xOfIEpb5muzV+Ng4V3sinnMy
 LUrit2NI1caaxtzJwcEXYkYnmcSOd6eLO8crfcjPSq+mhUn3i59hVIvFOwQhgUZT4T+1nEKvBmh
 z53Y2TNgYmiKgtoqRRExR9LCqzH8L8CJiQ3bkkb9K4QZ56iY9jVjj8TiMg4dlnITDoX4w=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

We don't want pgd_t to be an array, as it prohibits returning it from a
function, like ptep_get().

There is no need to match the actual arm page tables, because with nommu
there are no page tables. It's all just in place to make the compiler
happy. Making it a scalar will make the compiler happy.

So let's just use an u32.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/arm/include/asm/page-nommu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/page-nommu.h b/arch/arm/include/asm/page-nommu.h
index e74415c959be..88659b38e236 100644
--- a/arch/arm/include/asm/page-nommu.h
+++ b/arch/arm/include/asm/page-nommu.h
@@ -18,12 +18,12 @@
  */
 typedef unsigned long pte_t;
 typedef unsigned long pmd_t;
-typedef unsigned long pgd_t[2];
+typedef unsigned long pgd_t;
 typedef unsigned long pgprot_t;
 
 #define pte_val(x)      (x)
 #define pmd_val(x)      (x)
-#define pgd_val(x)	((x)[0])
+#define pgd_val(x)      (x)
 #define pgprot_val(x)   (x)
 
 #define __pte(x)        (x)

-- 
2.43.0

