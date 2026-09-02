Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF21B47FAE1;
	Wed,  2 Sep 2026 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350320; cv=none; b=H7se3SCzoaYBKFOu+/bnNtEyvOu3qJeNt4Gyv/u1DuVZTGeURNYgdrtFXDCS92AX1Vt8yf/sDPUpaF1NZzSqYUZGUPXNBycrFrcqTrEZXfui8itPaxAOo0KK2KfEkN+RnuwPZn5W0nWGaVYV7Nq6hlroVoVNHylPXHRI2m7/kao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350320; c=relaxed/simple;
	bh=k2zH0FGZAHQHsE8iyLCaqqIz9EPe8wwBeb+yxtADtNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tilMZGysniL+lo8EBba2xIbfT0jSDKutLwtWLkvkQOgi9KsCKqYZugrZOTuqVToPaY2e0KTxiTXoxNkLKLIM6nAduih6LnA8i6pWZ2+y/lOEstH8KwM0YKgykFYFn2JZt+wxUJtmcikbgt8b8SXeUOcaQGnTdw1MpQgZ1xiJ/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jYatJEpX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jYatJEpX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A5EC1684;
	Wed,  2 Sep 2026 04:58:25 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C64723F85F;
	Wed,  2 Sep 2026 04:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788350309; bh=k2zH0FGZAHQHsE8iyLCaqqIz9EPe8wwBeb+yxtADtNc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jYatJEpXusEujngnHtU6I+YPUKEc9K8lGG+lz1k8jk0KjT5om9VcibE/ezX/VNx7b
	 lpj/LXh8tiH840xQlDjIN8NOZFbyzF3GoEjDO3+GBfOYuqP94T7AQrC++hekhMS6tA
	 8FkWEGa9JBOcKLOCiJlkvBaOKggzzYeRDZmNyDQM=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 02 Sep 2026 12:56:17 +0100
Subject: [PATCH RFC v3 15/21] x86: mm: skip collapse_pud_page() when
 CONFIG_X86_DIRECT_GBPAGES disabled
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-dummy_ptxp3-v3-15-5d8f5b17c25c@arm.com>
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
 linux-openrisc@vger.kernel.org, Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=958; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=k2zH0FGZAHQHsE8iyLCaqqIz9EPe8wwBeb+yxtADtNc=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqmA7pUQwEjNuqeUAg7BhIVlnxOYow79q+z+b/o
 Mu+s6x0zhqJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCapgO6QAKCRBt1cPRWsUx
 Mz9sDACbzWbwygGpa8m3XTPuxJjLPEKbMbsFtZoHAET7S3zJ2LzXLww4d97at64xdcy0C9qcaWn
 tUK+uYwT5SoDrcZGmfsCgkyKnZ3bcOfrvI1CTIx3pn9wi7HlvNnFpoHJWX1wFhyDvNnivGAWwsD
 RVZ6G5XrvM3ngBD9A3GaObxS/hOfNl6B2cAfrLJdXQlFvhTOA7evFUwYxbSFQtREo7W9iPBbbhm
 FPNf9wlD8mSt0yJmy3Qv97MpkoT7C4YN9hgXPoJ2xU+Q0YTYJi5hf71QPpJgYQrr2aCRm06oBrf
 Hjgq3DMzHZEQL3ROMxL2wlUgUj0dpPf6JXmI4z3zSpp0POGmdgTjUGkTKUflejOTbAnUKV3SOyA
 /5BZiBlXnygsBnRlMPKDve452e/HvUePcW2dHO4oVqHDg+1C2R3xXuQyq+w8kGdgQXAlc2papvE
 ACcncgIrI/l73eXzjT29pSeE28A+OoQGnf4+ycoq2SoHHMNmrkkPY3GeJeF6nalFI2ayU=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

The behaviour of pXd_page() will change with generic compile-time folded
page tables by disallowing its use and triggering a compile-time error
when it's used improperly, ensuring that the actual pXd_page() is used
instead.

To prepare fot that, skip collapse_pud_page() when
CONFIG_X86_DIRECT_GBPAGES is disabled.

There should be no functional change.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index a1a061d995b3..07a873775279 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1315,7 +1315,7 @@ static int collapse_pud_page(pud_t *pud, unsigned long addr,
 	pmd_t *pmd, first;
 	int i;
 
-	if (!direct_gbpages)
+	if (!IS_ENABLED(CONFIG_X86_FEATURE_GBPAGES) || !direct_gbpages)
 		return 0;
 
 	addr &= PUD_MASK;

-- 
2.43.0

