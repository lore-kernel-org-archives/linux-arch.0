Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C2F320A22;
	Fri, 20 Feb 2026 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579678; cv=none; b=CnxY4DQYfpaOGFO8+Xo7nUaQN75pfkMzyJjctLuqFhE/IlglMXHswrSV8/KPi26pmix0duXrggNGHRoi694FNGw10Fb8W3aiMoTT2ayDF9X+cTr4BvO7alenP7nw02KAHpc+800Qq2bW1Tis1Y+E3Gg6giVSNYYGA6qTT+0GA6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579678; c=relaxed/simple;
	bh=FpYf/Yzczcf4tEFC1kjBsEmpa/YzVd1pXhcZ6yjPTiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBhMtRhlErlos5yR3sNFkty2lvwjZunGNCEfaODvCQTGSIn3Sqex7BJP6igw2+85ventJkF3dXVgrrqic8m7yqVVUVkBOaqZ5VrloAT9zwBbtfJIszEGQkzA6lywhaRprdUDSvGdqSWpHbSOFTMI/uTiyP3py+NLLlYac+oOk6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/pnUe2C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/pnUe2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70999C4AF0D;
	Fri, 20 Feb 2026 09:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771579677;
	bh=FpYf/Yzczcf4tEFC1kjBsEmpa/YzVd1pXhcZ6yjPTiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B/pnUe2Csc8sf4nePbeD8HOLkbhporccdV2gXzpFBwFl8bIIkz59+hExV3Lf6wc7n
	 5jwRljJiVEzlgRuxSNCkmMB/S8QZ8E0o9cY2PN/tNv8tgW6MSxiRM02W732ECLr/hT
	 dx3Pm5WYwBSz0u2GEl5tTcIwZGZNO1nQxdjTsl3akqYfZYrYIi4Ifvn0epsmPF9NXJ
	 UNc13112JN8SQQx5pX6EYq+qDsEXtyURVXTESGlrSc8PJg5/JLTVqbl5W4yPab30xY
	 ZTbv+qSqn1z9a3CyfUKfbDvFsizqh7JH/CRHquLzJXI1+AIBqnpA4/IwRPSCkTdLWG
	 TRfVEQ1zmVeWA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Guo Ren <guoren@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-csky@vger.kernel.org
Subject: [PATCH 1/3] vmlinux.lds.h: add _handle_arch_irq RUNTIME_CONST section
Date: Fri, 20 Feb 2026 17:09:20 +0800
Message-ID: <20260220090922.1506-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220090922.1506-1-jszhang@kernel.org>
References: <20260220090922.1506-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will use the runtime constant to optimize the handle_arch_irq
accessing. This is preparation patch.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index eeb070f330bd..c4af2c7d0eed 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -973,7 +973,8 @@
 		RUNTIME_CONST(shift, d_hash_shift)			\
 		RUNTIME_CONST(ptr, dentry_hashtable)			\
 		RUNTIME_CONST(ptr, __dentry_cache)			\
-		RUNTIME_CONST(ptr, __names_cache)
+		RUNTIME_CONST(ptr, __names_cache)			\
+		RUNTIME_CONST(ptr, _handle_arch_irq)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
-- 
2.51.0

