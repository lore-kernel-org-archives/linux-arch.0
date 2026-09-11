Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F704CCDF0;
	Fri, 11 Sep 2026 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154905; cv=none; b=omRfBEo+j/iC573mY5TTvlgQllKEGrVKtXVS0Z3DB2VbE69TLUkSuWHoXVCaZrzJA+WfyzUydjkSv+ipuDLkVwe5ajvqwdTkbKyzFG9xCP2FhH/c/DxhfQpG9czTCDTdc9uquLwl6lcl4aASLPBuZKhGPrIeOq/IWMdCfV2CJ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154905; c=relaxed/simple;
	bh=C/hHoeoyZgl/552acrQr1Xi0twY+CEaGiAmnrc7FhVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAjF8vjXyHr6cvoZ60hMR/QqLTHdC2z0bt8N455lM0Q9aeqdnFD5fDs8FJK+47HwxGZwN/RRrA1SazQHGbYqLOmTskVg/up2C47Znj1n/R0Qo7YTF1o9Gf/l6KoRPH6hQjUNE8gpww4pxIoDTEmDF66xrxlmfzLkIjRB0WMMx5s=
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
Subject: [PATCH 2/6] ARC: Emulate two-byte cmpxchg
Date: Fri, 11 Sep 2026 19:25:35 +0000
Message-ID: <20260911192540.20983-3-brads@mainlining.org>
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

arc has no byte or halfword atomic memory operations, so the LLSC
arch_cmpxchg_relaxed() switch routes case 1 through cmpxchg_emu_u8()
and leaves case 2 to fall into the BUILD_BUG() default. Route case 2
through the new cmpxchg_emu_u16() instead.

The !CONFIG_ARC_HAS_LLSC arch_cmpxchg() already handles any size,
reading and writing through the typed pointer under the atomic_ops
lock, so it needs no change.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/arc/include/asm/cmpxchg.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 76f43db0890f..9b48b8fe0db2 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -50,6 +50,9 @@
 	case 1:								\
 		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *__force)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
 		break;							\
+	case 2:								\
+		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *__force)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
+		break;							\
 	case 4:								\
 		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
 		break;							\
-- 
2.47.3

