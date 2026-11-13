Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558227;
	b=2X+FdAA4uLQn3WBn2Hp9GSsuKT01b28KEUx76iP28O2LX+4H+dDeuuKdSdVAyOZ2OCmO
	 b4wJ3JmMrttkeags5VN6JWz1WqHMUyiBBMf4HybYlUqYlUAET2dXWEiFTdLeRAAQ/hymr
	 dMwWLpcL8NPWcEAohvJb2VWEVstI70RrPPT7MdQn1FYJiW2+gvpMeAERD2/pBFwncqZUL
	 +9moegWQ2tJBiij1abgPA/quOyXuE7FsfSM8/GiiaO6ykZAZLazQVMojtbS85cKT9MTQo
	 1y9SyrNrp76tHrbkCBIungnQO/Phqvh7yE1nSFPmNeF6uLen+AFlzJk65t2KNZi58IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558227;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=JmVK8mPZD2Muk/XHNqoGXAaMUyvsZFSxGlhDHiE/5kw=;
	b=tUkkXtlWuDhCN11zgdQEbErhMRA+RAgLOCwT8/UCp8CBOj21Ioirzidmf+VYvj9ymp2E
	 BToPoLbTS3ql9tbTr2UEM8ChDAc9pAIH8y4lVSl7zoPiTIuL/Xg1nOboNliawpVAEZdYG
	 4r0NFTM29bSiOdJ7+nBpSN3yubjPoNXWE69ix+ugw0m4GHi4FD71edixARNbuB05FDTJp
	 wIQR4s6mc6lNhVf7U3yO0Q4zBKUnjoO2oS9KkFEccUPfDL3VkZumWQGprwEI0w4bgVBCK
	 xyomeZ6irfnmEn8SkznKsRNs3Qyrdv5MSxIzorDkmmZbxrx2nzBEe0hLNxAF7hogj3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UNJ8Kkxm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBBC606C99A;
	Fri, 13 Nov 2026 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UNJ8Kkxm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268681F000C5;
	Fri, 13 Nov 2026 08:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794558227;
	bh=JmVK8mPZD2Muk/XHNqoGXAaMUyvsZFSxGlhDHiE/5kw=;
	h=From:To:Cc:Subject:Date;
	b=UNJ8KkxmYlNX61+S35V1QNj5bs2YUC3tmnUkmGOyFvhytbizkyJkLqPGadIzJK2C6
	 hkEL9F2HdJ901GNz1ZoqfijkuhfIaZLH9dN8omJtqX8rV5+cYTisqVWcPB7VWaSxXG
	 0o3JzVfnTW07i12SzTWc0e0h2Zsar4gpnjol5Vs7MpqMN/065rbXlw1VeXgPnglFwW
	 1FPvZWW9F26lrYIDtXhmG7CJRqJFctAQSVh/ERXHC77r+qMgfyH6fq85+Z9PqkF2is
	 e/B75WRr/abC+p9V9ipPYos0PaeBppJcxlKtFJ2AKRZI2nTNE1UxOuy2/8qHwD4QgN
	 6+tz2UUB8NNhw==
From: Thorsten Blum <blum@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Thorsten Blum <blum@kernel.org>
Subject: [PATCH 1/2] x86/serial: Use generic BASE_BAUD in asm/serial.h
Date: Fri, 13 Nov 2026 09:23:15 +0100
Message-ID: <20261113082316.67375-3-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850; i=blum@kernel.org; h=from:subject; bh=yKOZZ5ZExRMc/9NGFqQWLoalsO8mmPlI3N0ufvH5VWw=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnfTnxp+hsyZ9eOKFmT7dv/T3dYtnOu+ak5H+3l+ab5N J55y7yns6OUhUGMi0FWTJHlwawfM3xLayo3mUTshJnDygQyhIGLUwAmUiTPyHCiyKYvzaWcR1LS +rJxRH9KX+ydq9rybI3b/G03Sy9pC2D477G7iPn0/rKksCPerxjXqvEavv/cOiGpvP1dwkWTqUF XuAE=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Include asm-generic/serial.h and use the generic BASE_BAUD definition
instead of redefining it. Consolidate the comments accordingly.

No functional change.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
Please note that patch 1/2 was originally submitted as a separate patch:
https://lore.kernel.org/r/20260909074653.408945-4-blum@kernel.org/

 arch/x86/include/asm/serial.h | 9 +--------
 include/asm-generic/serial.h  | 6 +++---
 2 files changed, 4 insertions(+), 11 deletions(-)

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
index ca9f7b6be3f0..28915df0de05 100644
--- a/include/asm-generic/serial.h
+++ b/include/asm-generic/serial.h
@@ -3,10 +3,10 @@
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
 
 #define BASE_BAUD (1843200 / 16)
