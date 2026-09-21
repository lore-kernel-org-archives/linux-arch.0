Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3300A485956;
	Mon, 21 Sep 2026 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988199; cv=none; b=iJTvDi+ALjKNxVClzQXorUN3vPkCYBy9lZNBamU8owdqeX4d02JRN+iNBMxrV+gAVhDHJT20Y7XBAkQgRnVQJTzz8+uPCpxddLdx5WKcfuu8Uuq9063rXpjITsu1w5cdVTaMnbBIvw3JtIoqnkr5Gye0XXpaj+RYpnunyxQxEV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988199; c=relaxed/simple;
	bh=vEzrqCWaH6sVkcTMp6OI/QOpWZT9yXWBiNbXxiv6lmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DuCfCOJMei8y6Noni/WQlj0XYieBV6wpFVdYRGyzk56Hb9mUrtGyi90NvGkLEZUrc8BEHw5Lz7ULnF5ALPqeHlRkY+ExEo8V2czBL5TEwsIaOw3L8GdjnqMHbpITyfbTt01LXop+2uoOAEJPytoHuwKmbosay27ueaDXSD7C+hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LoVIGTLg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LoVIGTLg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B0511D13;
	Mon, 21 Sep 2026 03:56:33 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B6A43F86C;
	Mon, 21 Sep 2026 03:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789988196; bh=vEzrqCWaH6sVkcTMp6OI/QOpWZT9yXWBiNbXxiv6lmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LoVIGTLgqzJ/qsqv8y1uGB4x3jrgj3tiInD07+v3on40VZbIKUJCAuRuyG/NV29tp
	 2kYvHL/ObZV5edLNO5Ve1LLYQoVIgW623hWmFpOHtD/L2MkwE2PM9UirSqKqtoX4Rd
	 H6xBWMlbZQB3YaYeY2mpGRniH91/tkMG7ynZ8B04=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 21 Sep 2026 11:55:23 +0100
Subject: [PATCH 01/21] ARM: mm: make nommu pgd_t a scalar
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-dummy_ptxp3-v1-1-cd40cf68242e@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=ODmKgHrv0SlU2okc3grPddikJ1BO4DLAINSWVDYQruI=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqsQ1LlWiizi4t012wrwJwrwJTjWi/Wb29nF79i
 J4qQoShg02JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCarENSwAKCRBt1cPRWsUx
 MweXDADISibCvJvF96puZBjP6/j4fMPKgIlf5MS3C5eSagiY6JFxwj3lAIkbhiPFMPYCnHBJnoL
 2GA0NpEJpJyNWbhsAV12S4u7OvsEXVxhwfJkIzZS58W9csiUCIZFEIJeeoRnQzGnOFzFUkakRVx
 qkc8XmG8/eJznmc+Dxlnulm0n2bZYi5j54S/rQd/Ikdo5m9A+FMeYf04ijW4O0svRQScvjMFPe6
 kVraASsRz5EGbbRfoH4SMzCaalxthaqxKHBUq7g+H588eoHoKXinUFv1W98H6pqtwKWe5asm+To
 Eq0zBQRFHajwr8D6LBzww0jQnu+df2It+l03o7y/78Q44wTlBaVaUJDhnjb5Pdeawtwtx9Z7aj8
 duzExW/pl4kS3fr3Qof0bszw06VRUoqAUgb0W9KH9UoDBlwrzFdOABfQtidFW/gnhWEAX7o8d6b
 xzsbDSxkRRzb2wd4Lxch76ZEGXJe1I90lQHqznhSf5wCWubXXZK8jVHUqdjrcZKH73914=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

As pgd_t is returned  from a function, like pgdp_get(). pgd_t shouldn't be
an array.

There is no need to match the actual arm page tables, because with nommu
there are no page tables. It's all just in place to make the compiler
happy. Making it a scalar will make the compiler happy.

So let's just use an u32.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/arm/include/asm/page-nommu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/page-nommu.h b/arch/arm/include/asm/page-nommu.h
index e74415c959bea..88659b38e2364 100644
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

