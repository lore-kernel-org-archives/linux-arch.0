Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C33A7F49;
	Wed,  9 Sep 2026 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940151; cv=none; b=fiCib80LkzclomqCOmlFSl5MDUl2ajD29C7ZwUEvTnMIocDZ1VQBCFWFgxo5v4TQ1zJcC1yIE5lFh0efTNWsGTyqiv/NHOyu4pqy15fblC+P0vbu6ILHLjHQL8cgPp5V3wgj2fIarceeb3P2m1zEgtT4IUvAZvwGfBcspxTAOMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940151; c=relaxed/simple;
	bh=n/YUHToCu4xFzFyURJPKym92O2SUcgsTqgNBRzWypyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iXsRZIgnO1P0d1nfV/33F6YFH0ozf9NW0ua82K9No+wrt23LrAJm15cJDMPav6gQXRNIPtrK84wbsMQEmL90EPfH8sucVErjFHYZwNGcgjxgz5APHg/AS9L7EzMN7YtDTdDJ4pVGnZnRhLuoxM1c9ESS2Th2vG3u2qFDM3Tutzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lA4UvNb/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lA4UvNb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2679F1F00A3A;
	Wed,  9 Sep 2026 07:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788940149;
	bh=CtjHw6tdgvoCt/S+ovgmKPDM4t7AdlJ2arISz/nBgmE=;
	h=From:To:Cc:Subject:Date;
	b=lA4UvNb/XirQdQKQbXONbFRB2eb+4zrQLcZBfjDDNtOPGEsANHBI1s7O2Y2uAx70v
	 JPnnOfJPM67k6uDHnaxLhj+Ki9UlhWnUXOxMmacrwttqJrahibnlaGDvWXv02N8Zex
	 fmKGpb6KscP4TgyvUPmPQXKb80X4b1Au0iThM2NzpDX9xwV1cIVTvwrw2NtdbJUGqR
	 yPSPgEPYK6ccxCp6hl8za/wDfMY/pfnxuQyh2Wqf+vt1XppE6Vl4494heWBU3c1mjV
	 mah8nkU7vSY8ZqD88xgVctnv3dSa/5p2GURY09O+i208oyJHOZZyle36SIOgSEU2YW
	 Mjus+5bTMYSYg==
From: Thorsten Blum <blum@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH RESEND v2] x86/serial: Use generic BASE_BAUD in asm/serial.h
Date: Wed,  9 Sep 2026 09:46:54 +0200
Message-ID: <20260909074653.408945-4-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=blum@kernel.org; h=from:subject; bh=n/YUHToCu4xFzFyURJPKym92O2SUcgsTqgNBRzWypyI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkL+d7+v8J52bh630KhNuXcgg27Ph8unJb+Wb/UeGXv0 ZZb/y6HdZSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBFnBn+8P398Pi3TIaC4r0T JU/jOjJbmV6dCbkhZ2C81PlweamtAiPDNekXy+vPiT15FsU9R8o2f5vWbrZdTlXXPGtfpN+XSf7 IAQA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Include asm-generic/serial.h and use the generic BASE_BAUD definition
instead of redefining it. Consolidate the comments accordingly.

Signed-off-by: Thorsten Blum <blum@kernel.org>
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
