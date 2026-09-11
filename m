Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C264078E1;
	Fri, 11 Sep 2026 19:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154765; cv=none; b=F5ap54l68Vb76PgeIwqjPB3n+6O599Dh5/eMBw+I7USS0rnw5CjDh0gC0oFZUHXuEoHmA/tuQwTx7xO4e7pAIFen8x7WGdiKmoBtMJ5Te/XgDd4ZGpcMLQOILJ2skGV5UeDrT+Nu2dyhZa9m3Xbxt/upxAPOX803XbnJWawFl/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154765; c=relaxed/simple;
	bh=GB1GwFjqXeqizek/00dnvDkz0F+QNMMfI6yJw319v/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/bOtHdbnSqpAEywLHkIvfIn1yI09t+t+hottSwFoyGZXQ4GJLg3mnAHISyr4JGSHkpV6nNhWPxROw/5BY/ZB1wJ5K8CglLe7QCdVaZnxGIH7tdcAkbC7pMn6z3jNmrPtF3N56+lSuHseJB9VDw9DtDMZ333gz+70T5HOE2dKxU=
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
Subject: [PATCH 6/6] xtensa: Emulate two-byte cmpxchg
Date: Fri, 11 Sep 2026 19:25:39 +0000
Message-ID: <20260911192540.20983-7-brads@mainlining.org>
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

Xtensa has no byte or halfword atomic memory operations, so the
__cmpxchg() switch routes case 1 through cmpxchg_emu_u8() and
lets case 2 hit the default, __cmpxchg_called_with_bad_pointer(),
which is declared but never defined, so a two-byte cmpxchg() fails
at link time. Route case 2 through the new cmpxchg_emu_u16().

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/xtensa/include/asm/cmpxchg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index b6db4838b175..8dea8e357fc0 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -76,6 +76,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 {
 	switch (size) {
 	case 1:  return cmpxchg_emu_u8(ptr, old, new);
+	case 2:  return cmpxchg_emu_u16(ptr, old, new);
 	case 4:  return __cmpxchg_u32(ptr, old, new);
 	default: __cmpxchg_called_with_bad_pointer();
 		 return old;
-- 
2.47.3

