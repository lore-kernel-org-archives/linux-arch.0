Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B704E511E8C;
	Fri, 11 Sep 2026 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154909; cv=none; b=NvZ6UAQjAuG7wW3pqUSKISxp8FgKfdmGD5KOJyN8TO2JMXDqtHWHQWhy/XzU4aLx9fAbkgij6lGIgO0cmyvwN/TkUu+YzIQ2W9+MsGs18HadonPrStELnxPtswy8E+ivZ8qnVY78eWC4PU30ht+ojYj/WbPMUWeYr34JFBWDGn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154909; c=relaxed/simple;
	bh=hFNZfjG7awykZCdqNUHs3x/U/7ivwWB0Evtzikm7ItA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ly6ZI2qNy2NkNU1B9pq64v656uyzia0yMYRr3BkPbZG8DoWslnkia23kksrFo394542kKyaV/tta3E86DeByeMl01P5lWmNLi5EmjmKuUGZW9IdkI0UTA6jN/BYL4bvpmWYRqELIOJl53boA2uANnQfb9tJDIvYyUyCuxWn5w3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
From: Bradley Morgan <brads@mainlining.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	boqun@kernel.org,
	joelagnelf@nvidia.com,
	rcu@vger.kernel.org,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Arnd Bergmann" <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	"Vineet Gupta" <vgupta@kernel.org>,
	linux-snps-arc@lists.infradead.org,
	"Russell King" <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	"Guo Ren" <guoren@kernel.org>,
	linux-csky@vger.kernel.org,
	"Yoshinori Sato" <ysato@users.sourceforge.jp>,
	"Rich Felker" <dalias@libc.org>,
	"John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	"Chris Zankel" <chris@zankel.net>,
	"Max Filippov" <jcmvbkbc@gmail.com>,
	linux-kernel@vger.kernel.org,
	brads@mainlining.org
Subject: [PATCH 5/6] sh: Emulate two-byte cmpxchg
Date: Fri, 11 Sep 2026 19:25:38 +0000
Message-ID: <20260911192540.20983-6-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911192540.20983-1-brads@mainlining.org>
References: <20260911192540.20983-1-brads@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SH has no byte or halfword atomic memory operations, so the
__cmpxchg() switch routes case 1 through cmpxchg_emu_u8() and
lets case 2 fall through to __cmpxchg_called_with_bad_pointer(),
which is declared but never defined, so a two-byte cmpxchg()
fails at link time. Route case 2 through the new cmpxchg_emu_u16().

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/sh/include/asm/cmpxchg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index 1e5dc5ccf7bf..477d3025a441 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -59,6 +59,8 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
 	switch (size) {
 	case 1:
 		return cmpxchg_emu_u8(ptr, old, new);
+	case 2:
+		return cmpxchg_emu_u16(ptr, old, new);
 	case 4:
 		return __cmpxchg_u32(ptr, old, new);
 	}
-- 
2.47.3

