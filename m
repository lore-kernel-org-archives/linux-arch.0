Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439509;
	b=PyuO4X1OPl9IWkTsOe28x6CiXg8KM46YU6ZObRseFNIUotDAIbNTdFePW4VdF2BU+eCP
	 E4mFE33ZHvstZsZWpk3c9EZuwSVAWjnwjS0xwa3ARvCb+COwMDUE5wK6hOTjEwk+5s7yE
	 ayXeZ/EeQ2QUDNNy06UYkG2G7YqgiQ0gqop2az3q1cZ6AQhOeF25dP2WfF8XpizpmX/hp
	 8WIvaq7NJOPNqkbPB5Neyun/OoSc4Dk4SOieKzFaWM6RdjubdpotaEmpqlBCZxTC6XcDV
	 lKjnFH8pV5mgkmzvKFuOsCewA99LGHfnkTSaE66VjRrWmwz2sGyBTRGr2cLY92aXRmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EdMsunFDcUtQDGISK9BC5BpmhF0KnQn+rijOh7gG9a8=;
	b=sNL/KgJKlCGSgsTom1N9KJc1CYZp8zaLiog7Br4Qqb03W33r2rRSJppt3O+M/UjnfUuw
	 vqUyYhEBGZVSw73KnvLkOJkP9FL4L9ylE8aP+uyfoxcJbx0kRAo3y0Lxg8R85GfHKWvK3
	 Z3TACkSFPDjFIvlVxcc6xYSLaa/h6e7ey4bfOPkJev6UsJGZ1ZvNCCYUE2tTjcQYxeyeE
	 pGmAg66tsmLgvfKN0fD9S8qTgbmeK8g25/BosI5VewtHErZebDtOYmek3afuOL+FHDjZB
	 uhYICLLEvCeE++H5HbPlKHM5UP9cZLhPL+sQDDvqqLuoPG9LvYW0cyfnYNCleqeTQdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m7P3m4i7;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B53606A32E
	for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2026 13:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8B53606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m7P3m4i7
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f03920c4a0so20373735ad.3
        for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2026 05:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795439505; x=1796044305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EdMsunFDcUtQDGISK9BC5BpmhF0KnQn+rijOh7gG9a8=;
        b=m7P3m4i7mpTAsF5vYQUL2a3YyTEZyXaP5vtj1pseQbnG1cviEluS7w/CpTuyZpfkAo
         ESOXXv1h5Ah7ImMP2vqT4lqwG2AglXSmSQEDVpxvdnxQSXDSsX2v7OjpQe+l/a/4TkbV
         rfliWXysYAm28oJSbD2H807c94SFJXqc8NqVRr2FjOTBx87YjUB8ecJXBZPUWEwtyOES
         yHI5H3KuXuBIrlYi0qmXZjcxHsRq4ycbUy9/IpINj4R5yrdwX2tGMxuAY80YqWKW4VOQ
         g0nkcC435JSG9A6x6dYHjiRGLnyty16lG9urLH+//C+wuxJvqGdsOwiV1snjowuTmgEL
         I8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795439505; x=1796044305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EdMsunFDcUtQDGISK9BC5BpmhF0KnQn+rijOh7gG9a8=;
        b=bp6FGQkw5j+1/dL8ZVIuMLkkkX6PM156rOKjgOMcpcx/Y+3F2fXrMB6AA5IFr7D47t
         UUE4tKXFsPUxAzM0yQPrEZvgGv8b789DmdKLzcksrQ0kAwY8vGVFowE99irydib/2SFs
         rgIEXX84DmPkBZ89//2CGZ6msu4uY2528hU/jmz32PFZGX0NCzETgYzlO/UPHWeUJ9Ry
         6lb9CmqC93YLCc/AMjtHTccz3LpmdkRzEbzQACRQSygEsjkLfWLJfiafWkfSZDp8O/tm
         /LwZVTQ95C5TBYahz/xXLsjltnojDQEf/Efb0VnJCU2AaDy8/I0tkMRaJ3pUboM4fBKF
         1GUg==
X-Forwarded-Encrypted: i=1; AL+hErERTCTnXmN9wT8IdVpiIEnuLWeV9Z6sfZgcI/mEx4t1X5msw3Tr5YSD/6DNyf6O4tvKt4QND6xUI7i9@vger.kernel.org
X-Gm-Message-State: APuU4Z9B4cnG/hlX1ED/MJ1Uv3bM5ehwc8tSqRA1OtSmFffgRWLIioEs
	4+X7Ac9Y9OOYn6hm7J64fFHTzOfde1+04YFH5+H8LdlptzxXQL+JYekN
X-Gm-Gg: AZFdTZfFfuf/IpL8kd4l+7Nu0coAzkwd4ffHCB5dk9g+2/Uwx1RLdUwgXPAd+qdWB2X
	BRIPajB3yjxW6/b0yZjb22Qw718ZqqVP6yn1y4CintQ/K1MsUVZJYP8XUlqLF++vrLBL7m6i4CQ
	ZCkem0WTs9WjiC7jwuZHMG+/IrM/teNmGqbbDhaQF/ywi2jko3adzG4goC/Y1yAUQENTuYkK51C
	hwYo51v9QbXMFmI69lTLGRkyzCy2cWfGMQLenQxQhvQl72f1FGzS/BiGvVvC2WbVx3PmVg2cYOH
	84inTI/jLachdpxgpmqu7Rcl3r0UY2k/vMNLEY4GiNzKLf3KsDtZ6w2DmZewsxkNPLyKsKtJs2w
	BrCDHhJcFUp7umRkZvnEz90h++1cy3k0Je+uxZEeLh+sZl6KMwMECj3ci0lGwMH+uqLGybQAZbk
	eEXulV5pen1CD7xqEaG3fFfXl97jpnkn1eeq2OXVXOkfAyPmihZoJroglGPbGm324c5llIV0PRc
	GJea9tUy0GSbkmIp3U/NepKEQ+VuvbLeE1EF2fOSPAqLg9R8w63qzJfcd9d0xvTW5zQT3uFLXzf
	xK289AHLg9WoxLurHrJSsijuKmOi2MjB4w==
X-Received: by 2002:a17:90b:2d8a:b0:3ab:413:49b6 with SMTP id 98e67ed59e1d1-3b41c952eefmr10186812a91.41.1795439504874;
        Mon, 23 Nov 2026 05:11:44 -0800 (PST)
Received: from arm-a100.. ([140.112.28.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b409330ae8sm20903469a91.7.2026.11.23.05.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:11:44 -0800 (PST)
From: Tzu-Ching Yang <shingekinocore@gmail.com>
To: Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org,
	Angelo Dureghello <adureghello@baylibre.com>,
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: coldfire: Use the builtin fls() and __fls() on ISA_A+ and ISA_C
Date: Mon, 23 Nov 2026 21:11:01 +0800
Message-Id: <20261123131101.639643-1-shingekinocore@gmail.com>
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

Let fls() and __fls() use the ff1 instruction on ColdFire ISA_A+ and
ISA_C cores instead of the generic binary search in C, as __ffs() and
ffs() already do. GCC emits ff1 for __builtin_clz() on exactly the cores
for which it defines __mcfisaaplus__ or __mcfisac__, the macros that
already select the ff1 versions of __ffs() and ffs(), so no new
condition is needed. Commit a6260ef84103 ("m68knommu: add ffs and __ffs
plattform which support ISA A+ or ISA C") added the ff1 versions of
__ffs() and ffs() in 2008 and kept the generic fls(); the generic
__fls() followed in 2009.

Use the asm-generic builtin versions of fls() and __fls() when
__mcfisaaplus__ or __mcfisac__ is defined, and keep the generic C
versions for ISA_A, ISA_B and 68000. The bitrev/ff1 asm of __ffs() and
ffs() stays, as this asm is shorter than the code GCC generates for
the builtin versions of __ffs() and ffs().

With GCC 12 to 16, fls() shrinks from 28 instructions to 8 or 9 and
__fls() from 24 to 6. With GCC 8 to 16, the functions of each ISA_A+ or
ISA_C defconfig kernel shrink in total by at least 8676 and at most
13266 bytes (scripts/bloat-o-meter -t), depending on the defconfig and
the compiler. In lib/find_bit.c, only _find_last_bit() changes, from 55
to 35 instructions for m5208evb with GCC 16.

fls(0) still returns 0, and __fls() still returns unsigned int.
__fls(0), which is undefined, now returns ~0 instead of 0. For other
CPUs, the preprocessed source changes only in its line numbers.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/all/dbb44e92-0bc5-449d-9e43-1f93362aa6c3@app.fastmail.com/
Signed-off-by: Tzu-Ching Yang <shingekinocore@gmail.com>
---
I have no ColdFire hardware. On QEMU mcf5208evb (ISA_A+), the ffs and
bitops KUnit tests pass before and after with GCC 8.3 to 16.2. In
find_bit_benchmark on that machine, with the bitmaps drawn from a fixed
seed so that the kernels before and after use the same bitmaps, and the
executed instructions counted by a TCG plugin, find_last_bit goes from
52.3 to 38.3 instructions per iteration on the random bitmap with GCC
16, and bitmap_find_next_zero_area_off, which calls find_last_bit(),
from 3302 to 2864; the tests of the other helpers do not change. The
ISA_C kernels were only built, as QEMU has no ISA_C machine.

Under QEMU user mode, with the kernel's flags for -mcpu=5208, 532x and
54455 and each GCC at -O2 and -Os, old and new fls(), __fls() and
fls64() agree on all 2^32 inputs (fls64() in either 32-bit half)
except the undefined __fls(0).

The seven ISA_A+ and ISA_C defconfigs (m5208evb, m5235evb, m5275evb,
m5282evb, m5329evb, m54418evb and stmark2) were built with GCC 8.3 to
16.2 before and after, with the same .config before and after. A W=1
build of these seven and of twenty other ColdFire and m68k defconfigs,
each with at least GCC 8.3, 12.5 and 16.2, has no new warning.

The new out-of-line fls() for m5208evb with GCC 16.2:

	movel %sp@(4),%d0
	tstl %d0
	beqs 1f
	movel %d0,%d1
	ff1 %d1
	moveq #32,%d0
	subl %d1,%d0
1:	rts

Against v7.4-rc1; also applies to the m68knommu and m68k for-next
branches and to next-20261113.

 arch/m68k/include/asm/bitops.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index e9639e48c6c3c..81923a9fa4494 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -506,13 +506,14 @@ static inline __attribute_const__ int ffs(int x)
 	return __ffs(x) + 1;
 }
 
+#include <asm-generic/bitops/builtin-fls.h>
+#include <asm-generic/bitops/builtin-__fls.h>
 #else
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/__ffs.h>
-#endif
-
 #include <asm-generic/bitops/fls.h>
 #include <asm-generic/bitops/__fls.h>
+#endif
 
 #else
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.34.1

