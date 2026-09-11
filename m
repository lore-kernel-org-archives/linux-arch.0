Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6D4AEBFC;
	Fri, 11 Sep 2026 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154765; cv=none; b=EQlV/ribFzz8xqi4vyZeJiMlHX3un5s9UrWcQCaO0w9pBVvifGwR/N+8ocQMNaXOQsLemPEsWKWP10w3qQvlCpy0Jx+VkXXPBhdmUQ6Ojz8S9rZgGorxTf9S3r1W4jIWjo1+Cxg8SIqnLE1yfQnxQ3KwwkD63t/WxJAMZdXyZWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154765; c=relaxed/simple;
	bh=uVPs5A6Qu+KvY+G1L8EbmXnj9uwps/4rGlJ1l/f41oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chGY9CwkWmT+PlyvmCYR2yqQhRC+UOxIdLT0aNSPA59h/meP2+SdOUELpWhSS5zK4cgrCCe6eaa/6gG9gqzoOHDTrxRsA96oa3jwuMEzIefEm7308lNZdoB7IyBOaj1SVWTi/bquvWGPYeimzC+p8kERQ740bvnb1lNJSliSoPk=
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
Subject: [PATCH 3/6] ARM: Emulate two-byte cmpxchg on ARMv6
Date: Fri, 11 Sep 2026 19:25:36 +0000
Message-ID: <20260911192540.20983-4-brads@mainlining.org>
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

ARMv6 without the ARMv6K extensions, selected as CONFIG_CPU_V6,
has no ldrexh/strexh, so the __cmpxchg() switch only provides
case 1 through cmpxchg_emu_u8() and lets case 2 fall through to
__bad_cmpxchg(). Route case 2 through cmpxchg_emu_u16() so that
two-byte cmpxchg() works on these cores too.

ARMv6K and later already have native case 2 in the #else branch,
and __cmpxchg_local() already covers sizes 1 and 2 for ARMv6 via
__generic_cmpxchg_local(), so neither is touched.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/arm/include/asm/cmpxchg.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 9beb64d30586..6c0e2f21456b 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -167,6 +167,9 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	case 1:
 		oldval = cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
 		break;
+	case 2:
+		oldval = cmpxchg_emu_u16((volatile u16 *)ptr, old, new);
+		break;
 #else /* min ARCH > ARMv6 */
 	case 1:
 		do {
-- 
2.47.3

