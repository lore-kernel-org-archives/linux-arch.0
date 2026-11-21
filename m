Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795269898;
	b=jmGdOCzDy2FDb0EWFaVFg/rG3RZhZFFKB7XlkDMz7iRbmbS63DQ0qsZdx1iMy8qv/9pb
	 xzGMft2SAVa2HLiQ4z0hLFsmugQj/JRsrqFRSwun/zYGOosz/nE8ptLHJHnu7i5Hqohvy
	 oX1LA+cSHMA303vPpPiA6DGHuoP+CIQ2Wo+lYgcRtP7DHrUnh9dcLQcMp/C0ljcPKD5Kh
	 ofS+R52INYwKB3kx9ofRYZT0ompm9ybiqzU81P0kGbNbeHIC7sAQhq5QQLTduTcCwdSmm
	 r06mCUttJMEdgq/83DXd3Xlav1Fa5a9e2fFTY31KnVdy024GPh9xfuCJicRjIW1nUMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795269898;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PKtVeCaua4JhrI5ou+iiHT4NA8Q2Cj43f5Zms2EDi7c=;
	b=ri6HHQRD0+R9rmf4LqETAcsA7yfwdBR6BKIXDP1DeAUwd+JC3FmviZ16y9/AUg1bAHC4
	 Mc2ilaq9m9aGC1DQGSxrL+1dtoV2ZVgExce42cPPDg+acNC8ZGwu8QKTUtV1owKd8fG8F
	 wTz+fKjcbOEppWfDxBrpDcC+iTobhULAdGwLa3OvRyLwhM40cnencZBOOwqmj1lZSw9bh
	 /r0E/a6RVVKR3MbWSlTIBkWX+UGHHdrfq5yAOVXTTK8+sWx5CJAMaGaplPS9bylvWv92V
	 FhZSlvSfdbO69BftioXzvp4//9VwqcO/OW9bFh2wb7uY9RJNNOu/OndR3KwKRT8BkbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=uKDloGwS;
	arc=none smtp.remote-ip=115.124.28.3
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389F606A320;
	Sat, 21 Nov 2026 14:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A389F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=uKDloGwS
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795269886; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=PKtVeCaua4JhrI5ou+iiHT4NA8Q2Cj43f5Zms2EDi7c=;
	b=uKDloGwSQN78itVpvgPB22oV8tU/UqGDN6riQoqkTh/ByQRM+3y8GRHiiNyCwp+IHbYQBX8BSbsIm+lf8gKNtmZen+XB5OiK4fjmy3WN4NxrJSVf8PJa917b4rw5U40Tlypk64JYZVwsi4Z+h9hQC0IB+w+XB82LPpZnM9UveH4=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.5188516|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0573754-0.000396786-0.942228;FP=15482861394436111488|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034020;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.k7FMYJ4_1795269885;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.k7FMYJ4_1795269885 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 21 Nov 2026 22:04:45 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH] asm-generic: bitsperlong: Remove the disabled BITS_PER_LONG check
Date: Sat, 21 Nov 2026 22:04:44 +0800
Message-ID: <20261121140444.57953-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A FIXME in this header asks to fix x86-64 and reenable the check
between BITS_PER_LONG and __BITS_PER_LONG. However, this check
cannot be enabled because the two values can legitimately differ
when building the compat vDSO.

BITS_PER_LONG is derived from CONFIG_64BIT and reflects the
kernel's configured word size, while __BITS_PER_LONG reflects
the compiler target ABI.

The existing sanity checks validate __BITS_PER_LONG against the
actual C type 'long'. For regular kernel builds, this also detects
mismatches between BITS_PER_LONG and __BITS_PER_LONG, since
BITS_PER_LONG matches the kernel's native word size.

Remove the dead check and the misleading FIXME.

Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---
The preprocessed output of this header is unchanged in 64-bit, 32-bit
and compat vDSO (-m32 with CONFIG_64BIT) builds. Build-tested on x86_64
defconfig (IA32_EMULATION=y), including the vdso32 build.

 include/asm-generic/bitsperlong.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/asm-generic/bitsperlong.h b/include/asm-generic/bitsperlong.h
index 90e8aeebfd2f..5183b50d3080 100644
--- a/include/asm-generic/bitsperlong.h
+++ b/include/asm-generic/bitsperlong.h
@@ -11,14 +11,6 @@
 #define BITS_PER_LONG 32
 #endif /* CONFIG_64BIT */
 
-/*
- * FIXME: The check currently breaks x86-64 build, so it's
- * temporarily disabled. Please fix x86-64 and reenable
- */
-#if 0 && BITS_PER_LONG != __BITS_PER_LONG
-#error Inconsistent word size. Check asm/bitsperlong.h
-#endif
-
 #if __CHAR_BIT__ * __SIZEOF_LONG__ != __BITS_PER_LONG
 #error Inconsistent word size. Check asm/bitsperlong.h
 #endif
-- 
2.50.1

