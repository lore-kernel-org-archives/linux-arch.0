Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670376;
	b=JEY6WIv6VVVqik7vb0xJsTUolsKY9OMUOIns9vZ5ekJQB/MgOwr06HQQ71sd18QHlNwJ
	 GMJgQsFgJaDp2uBwkuVv58GZOSe/91NSumyQRR6YLQz0w2v2og4ZPlVRwocAYmQwT4NnM
	 U2NQHLtaxrMcN+AxdmpMc62GK/VEZuMNC23ElkmWV/pxp6yyoxrjvljU+Zx4sja1N+4Tr
	 4v+34DFUrOAkPHi0ughz7/QUXWnWtKdwWEdpw2q+IJK1U/8GMntTSR+Y7qL8L+GdwaiY0
	 iPAcXuCjIP3KRv9nSlaeVURe8/qZNO46eyRucGh2unvd7gQLHtHkvkfPwhwOBxjgfQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XINGVnXS/59fmZDTv/3fLoxUfeQVR9Y3Vo1ejBBatBE=;
	b=nVgPisg+DNbrADabDTXgUVQ+U6pz8b1DOWhLhJ8lpCfcmdddYFuzPNBrtZgi2ytvV5uf
	 E+HbvCOQeDU7Ho0kT94rjLr1SqxwrOJiuIrguLqMDgsRwiSg1hKmrkdLUNDireuMCr4wh
	 lLnD3KCdAb+zIpayIXBOTJeQnW4FETqceIsPB2RwJIbRaiszn8Kquxebmtf3i8I+OAp6+
	 wbmWOdW6mrtubzzwLqN7rYvqHywiJ9ffQfNns6qxgPtcclAvjpMpat1ocfyT/yE5lzXjE
	 7Tr40MgzMV4aYQufsz/bp4dQ0JkC7/oIheeN/iqpa17oI07vV0kfGuwZMdN1fZCo+MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H8MV5mHe;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97425606A31A
	for <linux-arch@vger.kernel.org>; Thu, 22 Oct 2026 11:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97425606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H8MV5mHe
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a070781f63so799734b3a.1
        for <linux-arch@vger.kernel.org>; Thu, 22 Oct 2026 04:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792670375; x=1793275175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XINGVnXS/59fmZDTv/3fLoxUfeQVR9Y3Vo1ejBBatBE=;
        b=H8MV5mHePY61sZTF1PItFLG8m+SDaYKHDRqB1gr5Vk0h4SfvTU4pYNyiZPg0K1UtGX
         sOlN/iywGbBkOgN8XVRD/VqYX2zs3GMNNE9jX7GPoIc4s3VAqly7omE37kAtT8YZMn/z
         jRnpFa/jLmT3sHPgV/+BE0TthFw3r/rnYFCjb3NJAqfGC6Ls0HIJM6wM9pKJnMI7lS4L
         spW10lbuM/JoZQFK7Cq3leTxmQbymKQVyg+lfXJqQmWUejs1IsMgzhfQv90o4KmQRbTp
         DhL04C/PhxI3aS8HZZrrw4YXzhJ+G6t6vYVGV2KbRqoUNyQ1IICC5+534NwP/Gkfbpba
         alyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792670375; x=1793275175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XINGVnXS/59fmZDTv/3fLoxUfeQVR9Y3Vo1ejBBatBE=;
        b=i2wKSVIJh+g5cSOxec7ORiLs4/2buvMQRVBdHC0nmv+QxtE9zSR5FBKXqovshvii+a
         OKeue+4dCKhQ029x0AvGTAinf4xOyKdhuFvhsyzVIxmMbT3R49+GBZLxw5SOYbEpOV8a
         Aog3fkbGhoWgKIFkYHcB0G0HONqaoyFZ4warG4eGNsEQDqmyKjAag9eBk3HRcX1tW2S5
         fuH34Cx9dnSoqS0XR86jKpXFiaqz8wf38JTQiAb2w0OOudb31k2XAAVmu3d6aC1O7lX1
         a710poEW94KrpbXwNhVgmAwz5HBlxZMTUzAf9AUtsoDo60HFx+nnWOvxiI7qjV1RHvsj
         0ziw==
X-Forwarded-Encrypted: i=1; AKwUvBybhLvFUzR6km0JDKrN9FJLLLPnZ2nHMQz7DTzZwDiOJi+JuCiPSvG1OUo/zQjftWxDLw7V25u8tuk2@vger.kernel.org
X-Gm-Message-State: AFq9FYLbTfQCo4LeC3LeAVHurqhLhU/pXNRooTQbYzenoCsCwWrySRY9
	HRjeO/HpC/nhQZMRZrXmgIU1lmfjH9kE1JFlsIp8QmC7AebQ4bSxbz/W
X-Gm-Gg: AYBFou0VZHKEwkChR0MQQ1osicLrmWl0ghXAImRKjOU9KQ0obSp+TJklLhJ1kzcTUUD
	uHolvn8c18N5/V8cbb93KABcficrn1KXXr6J8zCyopRTCmfuHEeKmpOqjq6QK+6Ey3bXrdjnn8w
	R8PZTHzzLDVeZZjIZbMLNb9WqCHoTOn4x6YqXW9JKgvpWU4/n/l8ujT9FFcFzPzs4JfNj5H4Enj
	76e2i8bi9HGT/zJ8zCGs/kTV0QZF9t1xSEUGw4Q0Ilaor+Pvr6XtAVJbTKK5Mik0nudVYoA1qMj
	yNzhjT+fi0rL2FT9cDUpzE3YLNJuRdinRoKcsxEPmNmUzpApooHMrTuhpeFpz+hEkEdubg8G4Vp
	0+4NpdCRGviGaT2rMqpiyKR76kN+mRdSHOG00tpaBOo+v5GpORGNBkO0GSTMYhf/U+UnjbhWAiq
	K7EfxZ6H7o4wf2v5z41Yat7hXxJn0oVB1J/jBvcYghulU8YOCYrl2ZhZPgzjPqpSFNZBOW0DJ+i
	8YV58S+n/N/Z1wML3cQkCAMZEINeJxGRD11AWSzKF3MlABnRBFR6c8lE0Wv
X-Received: by 2002:a05:6a21:48b:b0:3dd:a195:fa25 with SMTP id adf61e73a8af0-3e287eea3a3mr3590304637.74.1792670374907;
        Thu, 22 Oct 2026 04:59:34 -0700 (PDT)
Received: from arm-a100.. ([140.112.28.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b49d1sm2035007b3a.12.2026.10.22.04.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:59:34 -0700 (PDT)
From: Tzu-Ching Yang <shingekinocore@gmail.com>
To: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] csky: bitops: Use the compiler builtin for __fls()
Date: Thu, 22 Oct 2026 19:59:22 +0800
Message-Id: <20261022115922.1210342-1-shingekinocore@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The csky __fls() is a C wrapper, fls(x) - 1, around the ff1 asm
volatile in fls(), so the compiler can neither fold it for a constant
argument nor merge repeated calls. GCC implements __builtin_clzl()
with the same ff1 instruction for CK807, CK810 and CK860; CK610
(abiv1) cannot be built with upstream GCC.

Use the asm-generic builtin __fls() instead. ffs(), __ffs() and fls()
keep their asm: GCC has no ctz pattern for csky, so builtin ffs() and
__ffs() would become calls to __ffssi2() and __ctzsi2(), and a builtin
fls() needs a test for zero that ff1 makes unnecessary by returning 32
for 0.

__fls() now returns unsigned int instead of unsigned long, like the
asm-generic version; both are 32 bits wide on csky. __fls(0) remains
undefined.

With GCC 9 to 16, the text of every defconfig-based vmlinux tested
shrinks by 128 to 320 bytes.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/all/affe7da1-41aa-4710-bee0-5e3c2b8a8dfc@app.fastmail.com/
Signed-off-by: Tzu-Ching Yang <shingekinocore@gmail.com>
---
In a test function, __fls(x) takes 4 instructions (return included)
before and after with each GCC and CPU tested, at -O2 and -Os; with a
constant argument, it now folds.

CK610 needs an abiv1 GCC; the only one I could find is the vendor's 6.3,
older than the 8.1 minimum and without a clz pattern for abiv1. There,
__fls() would become a call to __clzsi2(), which lib/clz_ctz.c
implements with the fls() asm, so it would still work; a builtin fls()
would make __clzsi2() call itself.

Testing: 35 defconfig-based kernels for CK807, CK810 and CK860, some
with KUnit or SMP, built before and after with W=1 by kernel.org GCC 9.5
to 16.2 (GCC 8 has no csky port, and GCC 9 to 11 reject -mcpu=ck860): no
new warnings and no calls to __ctzsi2(), __clzsi2() or __ffssi2().
allmodconfig with GCC 12 and 16 compiles the same objects with the same
warnings, but does not reach a vmlinux because of GCC internal compiler
errors, before and after. Under XuanTie's qemu-cskyv2 user mode, the old
and new helpers return the same values for every defined 32-bit input,
built with the kernel's flags by each GCC for each CPU at -O2 and -Os.
On qemu-system-cskyv2 -M virt, the ffs and bitops KUnit tests pass
before and after; test_bitmap passes with GCC 12 to 16 and has the same
one failure with GCC 9 to 11 in both, from a test bug fixed in
linux-next. No csky hardware was available.

Against the linux-next branch of c-sky/csky-linux.git (abb81e5ce7d9);
also applies to next-20261021 and to bitmap-for-next. Full build and
test data on request.

 arch/csky/include/asm/bitops.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/csky/include/asm/bitops.h b/arch/csky/include/asm/bitops.h
index 80d67eee6e86..118fb0df5267 100644
--- a/arch/csky/include/asm/bitops.h
+++ b/arch/csky/include/asm/bitops.h
@@ -49,14 +49,7 @@ static __always_inline __attribute_const__ int fls(unsigned int x)
 	return (32 - x);
 }
 
-/*
- * asm-generic/bitops/__fls.h
- */
-static __always_inline __attribute_const__ unsigned long __fls(unsigned long x)
-{
-	return fls(x) - 1;
-}
-
+#include <asm-generic/bitops/builtin-__fls.h>
 #include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/fls64.h>
 

base-commit: abb81e5ce7d995baa41556b8125fa59e28ba3be8
-- 
2.34.1

