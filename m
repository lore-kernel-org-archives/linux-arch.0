Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618560;
	b=p61M2zETNQwwhTto3kD0mg3qa6l1kyKudJhVImAnCb9MNjlRDXOQzhT88fHWFAd85N+r
	 5w4etgZv2I3ck6pz8QyHOb3X9gA5T6Ge3Px5CKOCJ7Ytq89GsUk2Ej1Yd8wjQ3ZuK/PFr
	 Dm3U8S4ah3GFU0huUL96OUMqAvD8qmle6fhgOKrJ2vOS22CR28VK4AYAPleiEENFRGSdc
	 NdA/Yy7GOcRKw9FYr1HE6YaKSUSmZrejfoWwM1Uqa2qUnfVWXrr3I1SdpekVWkOTOu97O
	 Xlp1lgY9aJDONCJ6hVC9uZlObRIH6sfXOu8OPyLaCJP/1JeHRfbyesBe9sNGZFmKgMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618560;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=R0uSF5qpsIfEXe0LqMz/VFLuJzJd291vneuC3VxqkSI=;
	b=c7tdcECgeVIDYVHtLQLU/qkwhhR+zto2PxwS4rpCfSeqsM6OkM5tEtGQIojy4UHxomnX
	 QcoUE0jk+2TMSxMKAlP6eMciAf083Aaou+HrmVOIqCgASX+zOi+zgJ8SsGF/0bB+KbgYh
	 A8OtR2ppFDnmQAgN9RkaKSYtVngj0t+dBreU1ZF63RISSmk4cpRXqQu+gT2D4KvaiIiZx
	 2KC4xNqwL4YAwXFcqNdJ6WHmMbOZbagZKX8OP0LT9aTMi28SbfH5j1AMhuPqC1Q9LqhVv
	 xCYrZiuJ3iwzQYtgNWA4/PzXmwJMX9KQWBMr7E2bdMQc7aDe+eZ+5HozGk6oGTR1g1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ctcgk8m6;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBBA60A6F4C;
	Mon,  2 Nov 2026 11:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DBBA60A6F4C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ctcgk8m6
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D25A1691;
	Mon,  2 Nov 2026 03:22:36 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6474F3F632;
	Mon,  2 Nov 2026 03:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793618559; bh=bDxr5gvFE+Bb+w20GZGn+s22BxRoQqetE+tU52d6PfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ctcgk8m6cdw5AgQ2Im/7eFAWIBTpDgXbtAAO8GJUIWWh/YkZBAZaw9T1WzoMpEVS2
	 9posqID6bDX94oqX9vEed1OT6H8QPauiWj5F4typRunUthD06NqbA4adWOmWErHOFp
	 ZJmVrpwHNi9xgaTlU68f4MNjQeHKzt2spQZCrMtg=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 02 Nov 2026 11:21:23 +0000
Subject: [PATCH RESEND v2 10/21] riscv: kvm: remove stack copy address of
 pXd in pXd_offset()
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
Message-Id: <20261102-dummy_ptxp3-v2-10-78840b2ec73c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2080; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=bDxr5gvFE+Bb+w20GZGn+s22BxRoQqetE+tU52d6PfY=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBq6HIznkcwZYOsTE4W01GcU4mYfE39Lhkjeb/kl
 qYNmf69jTeJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCauhyMwAKCRBt1cPRWsUx
 M1nPDACyTxKW0QIf1aki2ILBtcSj+P8SuxY2HQa9GTNUVsd/UcGoLZY6uA/dg7A/Yvuw0TCGbPd
 kcIgBiMNtSZrHn52D6+1EE8BRFSLynEcFOZhgBpTFFw/vtZ6INCLbtKOpOsjDg4DyfpI12y0ZfB
 6LW3z7kJtoWiIOxcg7yDeqiif4xh2+ukAxnSqDWrIA8XkmLrl0meoz8b/5o0DmW6BjtbNX138z1
 KgMPTeBvji7YOP9l4nxY0uRo11y9BlRHu9pYQE8CO0ghDHcBDVdF9JDf7OaNAFcMMlfAco1VUec
 5xAY2JevPpbxhhIvzqN/7k9SEa7bJIpRNqP/uwAp4sA0o4LQYqs94OeBxp7lPb5y1agzCGGwynH
 F3F0i1TidoUuvK9RtQr4nVouqnI2kCZ7OD+1YaNGfAelozaDSsnKalZS3jbFtWUTTPcpx6ZrZ74
 yDINCJGTkAAOUpALpC2WLfbfFmJVgwf9O+hkJStfemMtmTCYRBWPE/h7YvjwkvOWcAHD8=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

The behaviour of pXdp_get() will change with generic compile-time folded
page tables. To prepare for that, rework get_hva_mapping_size() to avoid
use of a stack copy of a pXd and pass it as argument to pXd_offset() so that
the folded entries value is ignored.

Replace direct uses of stack-based pXd values with pXd_offset_lockless()
and there should be no functional change.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/riscv/kvm/mmu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 371fccaf9df08..a062e8508d3f9 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -450,10 +450,10 @@ static int get_hva_mapping_size(struct kvm *kvm,
 {
 	int size = PAGE_SIZE;
 	unsigned long flags;
-	pgd_t pgd;
-	p4d_t p4d;
-	pud_t pud;
-	pmd_t pmd;
+	pgd_t *pgdp, pgd;
+	p4d_t *p4dp, p4d;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
 
 	/*
 	 * Disable IRQs to prevent concurrent tear down of host page tables,
@@ -469,15 +469,18 @@ static int get_hva_mapping_size(struct kvm *kvm,
 	 * value) and then p*d_offset() walks into the target huge page instead
 	 * of the old page table (sees the new value).
 	 */
-	pgd = pgdp_get(pgd_offset(kvm->mm, hva));
+	pgdp = pgd_offset(kvm->mm, hva);
+	pgd = pgdp_get(pgdp);
 	if (pgd_none(pgd))
 		goto out;
 
-	p4d = p4dp_get(p4d_offset(&pgd, hva));
+	p4dp = p4d_offset_lockless(pgdp, pgd, hva);
+	p4d = p4dp_get(p4dp);
 	if (p4d_none(p4d) || !p4d_present(p4d))
 		goto out;
 
-	pud = pudp_get(pud_offset(&p4d, hva));
+	pudp = pud_offset_lockless(p4dp, p4d, hva);
+	pud = pudp_get(pudp);
 	if (pud_none(pud) || !pud_present(pud))
 		goto out;
 
@@ -486,7 +489,8 @@ static int get_hva_mapping_size(struct kvm *kvm,
 		goto out;
 	}
 
-	pmd = pmdp_get(pmd_offset(&pud, hva));
+	pmdp = pmd_offset_lockless(pudp, pud, hva);
+	pmd = pmdp_get(pmdp);
 	if (pmd_none(pmd) || !pmd_present(pmd))
 		goto out;
 

-- 
2.43.0

