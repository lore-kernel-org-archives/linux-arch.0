Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A43E38A72B
	for <linux-arch@vger.kernel.org>; Fri, 17 Jul 2026 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784273566; cv=none; b=RoWGQeJ5gv5O9lXrgHJ8UCSI29KqDB1piU5uhuLBA0GuhOXZifAdA+NpnpbFEIszZ4smdfhq9d4MCLwe1fRquRUW8O0HFDeCmEIVggJE7E9LcoAvVWp3GB2SxL9ouHpTkbImgsvCzo6WuII7cDdtvwm0mv2CExktChaPSxsCINg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784273566; c=relaxed/simple;
	bh=Vy5ZSJ22cdtNWDqeuqJPSM8EgqDujfx3XdweAxFOAKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTZtaVVGO35C/x6BTslvLMjbfcCbdPcPR3ksM+JykeQpAvyOU2pCIDzHweUbDXZv9DlXD0zfhjKul17wmZSFbhaBfSLNaDWr5rlYtZ02Pxz8wUJfRtiGY5NEJFReB3zbWqRCW1bk74GHq9GQpm1x2QKyf5mad/AStWdcKh+qYmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SZDc8iyH; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SZDc8iyH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784273551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=elRl5YRyZ0y1WMkVX9LMG4a6K2L6QLQxfDuvThpHS/4=;
	b=SZDc8iyH/xzfzc61bGU0vNcrYNP02mRyzVgqIqje1igvLl6swc8fNHMULP7KoWEFG/eAGh
	ym5LHR6L4GR1b5pLxPLBtDoXzlf/EEkeJmG2eMX96hQzQb8eyr2m6WQ+b2bKgAwESBlEg4
	KtMywIDT1V+NEk0PZixwQ+dYxTbDdIM=
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
Subject: [PATCH] x86/serial: Use generic BASE_BAUD in asm/serial.h
Date: Fri, 17 Jul 2026 09:31:50 +0200
Message-ID: <20260717073149.3622-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=thorsten.blum@linux.dev; h=from:subject; bh=Vy5ZSJ22cdtNWDqeuqJPSM8EgqDujfx3XdweAxFOAKg=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmRt9Icl+oH3HWoOPvO6OOzTLca0Qi/Y7cutwYWPImrs elavcKyo5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACaiosbwT+FNl9m/P2JzH3X9 mWVq0bKqts15VWej4/8woUW1HvLd+xkZ3hpfCBNi5i1Q0L+/Jjypb+ajV1vDj+0SuP16k2zbnJu VvAA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Include asm-generic/serial.h and use the generic BASE_BAUD definition
instead of redefining it. Update the comment accordingly.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/include/asm/serial.h | 9 +--------
 include/asm-generic/serial.h  | 7 ++-----
 2 files changed, 3 insertions(+), 13 deletions(-)

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
index ca9f7b6be3f0..53b04e607972 100644
--- a/include/asm-generic/serial.h
+++ b/include/asm-generic/serial.h
@@ -3,12 +3,9 @@
 #define __ASM_GENERIC_SERIAL_H
 
 /*
- * This should not be an architecture specific #define, oh well.
- *
- * Traditionally, it just describes i8250 and related serial ports
- * that have this clock rate.
+ * Default base baud for i8250 and related serial ports using a
+ * 1.8432 MHz UART clock.
  */
-
 #define BASE_BAUD (1843200 / 16)
 
 #endif /* __ASM_GENERIC_SERIAL_H */
