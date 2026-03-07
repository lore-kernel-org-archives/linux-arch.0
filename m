Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D327991E
	for <linux-arch@vger.kernel.org>; Sat,  7 Mar 2026 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772875323; cv=none; b=APR+KhFSv4svLPDyLs+pSrFDDLxwqQIFjSlUeNuu/27XpTOfZs5LxoVGmZLnHZjTKolCVf7+dpenc3ddzNQ9Etiza4qUTnCNGRPUxpMaBxfUqCUqLGKtKRZIlV04iVZa8hfYPKkSvXHUEJ2RbK4m+RVE/NDsqpLhqyoVxTgN910=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772875323; c=relaxed/simple;
	bh=Ije5PRZmxTojxXIm7e2s1gqbY1PAvnVzbziTZqgQfyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OrxAc5bNIC6n2uQOHSPt9Yj7snUmBgiwt56O6bj5/4+KZ9HGieBQ5Zl9Jd0BRXPjknBLLGGQK6beSp559qjA5ctWdr0tSaWzbWWIQK+7lkjh7ukx9uKp9lkfSIhTN7RjXq8l0ZnQICRKVcBCNSDqqVDQocFqoEv2AW3MKwe7NXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgt6ldFM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgt6ldFM"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad21f437eeso72178595ad.0
        for <linux-arch@vger.kernel.org>; Sat, 07 Mar 2026 01:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772875321; x=1773480121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tUDMCyWm+/oO4Lw6ZRAVy2JWY6tSsMFprlNQtLkw/dA=;
        b=kgt6ldFMYULVx5+5bu6MZIbDIyDaCIjvPI6rC0SXvjp05eKLDFynbSMCUjTDZkM1No
         so7X2gK2CWzyDcRguI4rhZ9vavaANfab2q8ZAQ03RzHAJL8xlZ8HpxHzGQLTBb5+7Rx3
         acD5ZSCvws84Kefls3WN6PE5EHpsK04fVNph3/oywm789faIfNLCWlRBplOYk/g2sK76
         PK8cupfWwToxdZ8Fc22dCwdIafVkMJyGNLb7RJQ6WmjTwx1oAPQRg7FMh73PPOQNwrOF
         3+LFBhWoxgA1b8exQv1YDeg6QAOxJmF1dU7ZpdmEircSMf1zIOwRWAGtefqmtXZZYQfo
         yOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772875321; x=1773480121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUDMCyWm+/oO4Lw6ZRAVy2JWY6tSsMFprlNQtLkw/dA=;
        b=Epeu5rwZAohxgU4235uQZs9FU5Virk+Kpyc08VG6OOomeM5RFd1B6oDMzc134w54VW
         O1ke5sbGvpmZmQRMFiaE0WK4tPusrTVzDKKv8IOR4G1Cl4IWoyBf436ZrlqAYIlo63/i
         qnspbEpZ78topvfrwbEP/HmX3MQSNOsHY1W8k9ilGXYGQk+Xj+o+qyemVuDs9O0O5DJn
         4wzJlgkGsg50TFP63beNwhl82LiQKyPE+8Fr4IYjlqzx85apPEqnO1I6HdorGmamhqhn
         byTB636Pey7fg6KZp5aQVpTJILk97tQ6/pYNS1+P3+agfV6Xj5+r2sx9yxeWPa6dvpHQ
         PcrA==
X-Forwarded-Encrypted: i=1; AJvYcCVrO8D/bQfFKrQ7OGZlMn+fkxD4sHkh4SQAqVeiR548y6zuDVhRHbYS+gIiRSrRf1WwmyPuyciJeJjE@vger.kernel.org
X-Gm-Message-State: AOJu0YyDild+UK7F1M110FT5fU1o71TQjxlOQgwzYi4mQLlnZ1x42YtS
	7swUuMTBltAaEVVHBK8szNlmWgWVSUdRhjvB9qKAk6VXb8fBV2PPfBVHoppABA==
X-Gm-Gg: ATEYQzxWfAvPoLo6SlCswqkKw/+w8mqrCjxHHAlWOS0BeZlRbM5CdnN0QutBJW748m1
	AIdXOA6MWLGIv81Lu0jyWfb2l6ZdqU4T5L51RHZCZMX2zeyRyIcMauS0BXoXLB11b/r6kr9vQKU
	Ngfcn2OstBLbz5exOJ95lNaroxUic3TN7wutKouL/sQbRPFnqq4YsidzifHzvw5DBVOyGLeNc6m
	3UX2n9TROquSHdp9fydoLiADMI9I8I9ZI9QY89zdsvh8CNHp3aiGbcxA9VPNyyaZlpTFcAIDfjT
	rP4AJsH4UNGKp2eLv02PM/CwLTB9+szqZVgyIPPV8RYOyaBnVWAapMMfU9rx2oPcL16BKtbWgUg
	n3H28hueXcqsREM4DU88Tqk9YcRanvubbhc0/l8sgWfHMAg/dNIVGkl0U+mAZu4q0Aj/uBaTRoC
	6VQL13R6kNki0+OKLg5gwHwlkweU8WtBSQa+k3TvfXuUV/Ro2sFvLSeD3r4RMdGCITE8TZ9BS68
	o++BnaK219TbA==
X-Received: by 2002:a17:902:e541:b0:2ae:5c39:89c9 with SMTP id d9443c01a7336-2ae82a2598bmr47067115ad.24.1772875320536;
        Sat, 07 Mar 2026 01:22:00 -0800 (PST)
Received: from localhost.localdomain (123-194-188-82.dynamic.kbronet.com.tw. [123.194.188.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840c9967sm57525115ad.90.2026.03.07.01.21.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Mar 2026 01:22:00 -0800 (PST)
From: Min-Hsun Chang <chmh0624@gmail.com>
To: arnd@arndb.de
Cc: msalter@redhat.com,
	akpm@linux-foundation.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Min-Hsun Chang <chmh0624@gmail.com>
Subject: [PATCH] asm-generic: replace ________addr with __UNIQUE_ID(addr)
Date: Sat,  7 Mar 2026 17:21:19 +0800
Message-ID: <20260307092119.20733-1-chmh0624@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro __set_fixmap_offset() uses a hardcoded identifier ________addr,
which can lead to variable name shadowing if a caller happens to use the
same name in its scope.

Following the pattern in commit 44238e82670e ("rcu: Replace ________p1 and
_________p1 with __UNIQUE_ID(rcu)") and commit 589a9785ee3a ("min/max:
remove sparse warnings when they're nested"), replace the hardcoded
identifier with __UNIQUE_ID(addr).

Since __UNIQUE_ID() must be expanded once to remain consistent across
declaration, assignment, and return within the statement expression,
introduce a nested helper macro ___set_fixmap_offset.

Signed-off-by: Min-Hsun Chang <chmh0624@gmail.com>
---
 include/asm-generic/fixmap.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 29cab7947980..2d1e9a2c6a3b 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -16,6 +16,7 @@
 #define __ASM_GENERIC_FIXMAP_H
 
 #include <linux/bug.h>
+#include <linux/compiler.h>
 #include <linux/mm_types.h>
 
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
@@ -71,14 +72,17 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
 #endif
 
 /* Return a pointer with offset calculated */
-#define __set_fixmap_offset(idx, phys, flags)				\
-({									\
-	unsigned long ________addr;					\
-	__set_fixmap(idx, phys, flags);					\
-	________addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));	\
-	________addr;							\
+#define ___set_fixmap_offset(idx, phys, flags, uniq)            \
+({                                                              \
+	unsigned long uniq;                                         \
+	__set_fixmap(idx, phys, flags);                             \
+	uniq = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1));       \
+	uniq;                                                       \
 })
 
+#define __set_fixmap_offset(idx, phys, flags)                   \
+	___set_fixmap_offset(idx, phys, flags, __UNIQUE_ID(addr))
+
 #define set_fixmap_offset(idx, phys) \
 	__set_fixmap_offset(idx, phys, FIXMAP_PAGE_NORMAL)
 
-- 
2.50.1

