Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4639A057
	for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2026 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543633; cv=none; b=L0qn3i+lBdXFcgDJCFgx2waz7XmpYCgxAKe0nRrj9nmze4DGGdfGsiu4+RMDYEWbpAxYYoF5DxjQoIj3wGAuBsMlj7lGzAqpw3lw3vJO/FPybFCrOiCg5aLPZdXqXeJdoHQ6as2pvIn5edccX03Ty9992IqPwt9WFx4mPPFD7AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543633; c=relaxed/simple;
	bh=vNzTTNorLK/lcTs7ZCp8rTFk6YoeQTy3sSMH8Bbrd0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ckAH8guJ5i231NWdkrT0z0dIeB4iODPL2qaVB0X137aa1W5wpoqkCDqLc+b0zBHm/tcIZre7j4t/iSMghtHNmAG7gqBAy3V45w2ykE+EqM3eM0hdiyCfCY1dRKSgkVeXsdvx5+popUEkXJ3P76VLWlwBUCYmnHznCAwnQ2R8OUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JuWS9dne; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JuWS9dne"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784543619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8q79kuXAVEYnr9iLpKLxlSni5uCiLAtouQidkOpLiZE=;
	b=JuWS9dneCXbgsTndGxL6q7zr9XOYD5ZLeaLueXzkgxfFb0SFG63EspwLYW80wpY99LGaP1
	vVh7sNiafYmE/J2TSfKFGijkVqfApJya7cd9S8LHgFks30Xuxi1kWpae9e/3FXIFOUdKN0
	t2LsCVrorEiY5gnmSqTc0yHKAl78rZc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v2] x86/serial: Use generic BASE_BAUD in asm/serial.h
Date: Mon, 20 Jul 2026 12:33:00 +0200
Message-ID: <20260720103259.58814-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1903; i=thorsten.blum@linux.dev; h=from:subject; bh=vNzTTNorLK/lcTs7ZCp8rTFk6YoeQTy3sSMH8Bbrd0c=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmxP6M1n9VymL4Irmh+tas1883bg7MS7/Uy7VRMCyn6v Mv87dkjHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCR7RUM/3OO6667bfd1l9G6 6JV+G6bKrOG7GGU/qdekN+toudXae+cZ/uebiZYll+Zf2KG6XN7eJTb1aSGT1etzwqI15vN2XeK 8zAwA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Include asm-generic/serial.h and use the generic BASE_BAUD definition
instead of redefining it. Consolidate the comments accordingly.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Preserve the note that BASE_BAUD should not be arch-specific (Arnd)
- v1: https://lore.kernel.org/r/20260717073149.3622-3-thorsten.blum@linux.dev/
---
 arch/x86/include/asm/serial.h | 9 +--------
 include/asm-generic/serial.h  | 7 +++----
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/serial.h b/arch/x86/include/asm/serial.h
index ece8299d2695..b623f6d70f64 100644
--- a/arch/x86/include/asm/serial.h
+++ b/arch/x86/include/asm/serial.h
@@ -2,14 +2,7 @@
 #ifndef _ASM_X86_SERIAL_H
 #define _ASM_X86_SERIAL_H
 
-/*
- * This assumes you have a 1.8432 MHz clock for your UART.
- *
- * It'd be nice if someone built a serial card with a 24.576 MHz
- * clock, since the 16550A is capable of handling a top speed of 1.5
- * megabits/second; but this requires a faster clock.
- */
-#define BASE_BAUD (1843200/16)
+#include <asm-generic/serial.h>
 
 /* Standard COM flags (except for COM4, because of the 8514 problem) */
 #ifdef CONFIG_SERIAL_8250_DETECT_IRQ
diff --git a/include/asm-generic/serial.h b/include/asm-generic/serial.h
index ca9f7b6be3f0..c06765a4f5f8 100644
--- a/include/asm-generic/serial.h
+++ b/include/asm-generic/serial.h
@@ -3,12 +3,11 @@
 #define __ASM_GENERIC_SERIAL_H
 
 /*
- * This should not be an architecture specific #define, oh well.
+ * This should not be an architecture-specific definition.
  *
- * Traditionally, it just describes i8250 and related serial ports
- * that have this clock rate.
+ * Traditionally, it describes i8250 and related serial ports using
+ * a 1.8432 MHz UART clock.
  */
-
 #define BASE_BAUD (1843200 / 16)
 
 #endif /* __ASM_GENERIC_SERIAL_H */
