Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618504;
	b=Sghrqr5I/Xyd2/BqNT7qDdhfY91usmgawl6SMMozG3sPKctBYJimnQMYDGBl+P2RWZYy
	 Agk3B4yuKouGimYcbmXQOsRDB6K+OLPLku3x3NX747fv4EJwmFAAeX2+q8rN3Jq+PBNjS
	 xZs3B2xNGR/WgPmz3J5HqxExJypdWBhcNQt0LwbMf/L/Mr2kkEqxevwz9EBAsXaCQ3XCC
	 BYvTWEAil/A1kT6cMQUOpDfiqLWfgriKDjYA5P9+cFi4W9kGLiLBiCsZ9pq48g7Sd8Q3m
	 ZjKiltjKPfj89+mvKOFo5Y7qUHRdwXrVlbgFPSsg73zjVE23g4cEYflIUbZqlyV+3qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618504;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Kp/z3MU7YGBqtXkYJdrZFPtXjtQiMfjPy6zAGRI75f8=;
	b=i48rR15M6jciqPPeL+B54P/NHbhZBpCanD+3XsGZ6LtsXhl/JqjuhijG7e7LYJkdAJV1
	 Sbw3h9jBsi3auN+7Y6VRzJ72kwsnHJ6NmwPHc+6QBWWogvjgO6GG0Xuc7cWCfofIPddwT
	 3t8pmpLtuCxWnJAL4nidl3OFQoHzG7EZqCpGFzub6Ecpog/eUAAX05D1jMltT0iwXyKSn
	 aMrKfmk17BjjbaLMJc2+BYfwF+RQhLTcZmMLFVGD6lTNc6i7PQ96b6aEHmIAnRj1tcayO
	 ZFf3jHUDt/69EdPAOIZbQtgpzjzqaYz6zEyMaZ/FnP6tQbBPjBKzaPGvE2Vq4OES8kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nbJ29IH6;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034ED606A32D;
	Mon,  2 Nov 2026 11:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 034ED606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nbJ29IH6
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 505DE2A31;
	Mon,  2 Nov 2026 03:21:39 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 638CC3F632;
	Mon,  2 Nov 2026 03:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793618502; bh=vEzrqCWaH6sVkcTMp6OI/QOpWZT9yXWBiNbXxiv6lmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nbJ29IH6dzX4ajlSXZsYxUhN1Lgz7qI7Kf5XaxQjBx/xo9v7XPDH8Ju+9BXJRBPse
	 e8oLA7buAWAo7aZl1xI9J9NpPa0gvVM1iZGlL9vD4OwU9kc5aWCdjj4sVHMsz5gOdC
	 kzyj1pP43iYB3WNlRCyithRJP5str24lHrOCdHmc=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 02 Nov 2026 11:21:14 +0000
Subject: [PATCH RESEND v2 01/21] ARM: mm: make nommu pgd_t a scalar
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
Message-Id: <20261102-dummy_ptxp3-v2-1-78840b2ec73c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=ODmKgHrv0SlU2okc3grPddikJ1BO4DLAINSWVDYQruI=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBq6HIvGLS699hx7hG7O/gmI78xbHdrhwDkf+7I9
 DWzP3L/JCaJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCauhyLwAKCRBt1cPRWsUx
 M3LaDACfxss2j2NeE3BbTwwhokaDiCVaW/H2/Mn+uUenKG2jgF/kgodnvVS74EsJjBiO+N61g8k
 jWQPIwa3DH8V2Bt7Ff/0DyErPtKYiTAgNkr0bTxKT8vl3v5bJYwh2f8oMpNlskDhO5YF9ajXEFZ
 4ER8DxM8Y0Bot9aN/p+GNwx5V7S7M+ZxGwyoFmLXbIMo8frKb97sxPDAfsQWhXc/21AGoZR07PA
 INOCEo64nIFS15biXbqjKkhz6Cg9u4ZiO2+9vVuGSmKykqv/EuGUfHOmt969sV+myhOj6IOf9Y7
 Pm5ViXArvK4RfqS7EjpzDiY+Ijjv+sJGjYyXgNxNfnVM57alioKTkUndEkuHX0dCDAOx2+PcrCg
 3E0y/PCa4svejSAe9h8r+1ip3k9DsHNUK382M6HKF32gPu7Wr7WsSAR4RGYgAKC+6k2G0Iy/yKt
 3AY/4iUvtbWQKzfONYzBUemon4pM3LwvK4VOQ4z77hFiMuT2j+pbqBBod0/uxLBwdhzPQ=
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

