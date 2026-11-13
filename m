Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558233;
	b=nBoh8WvOwMmqvHnHqtm8LdKRD7OaCrkkSXcBTaHS3Oxwkg3PAmYBOzyQQjasnFGk+zGR
	 nSwcZYxQNzExmkOzUyqgGjW9zyNEn6ZZ78oXLPEHSlcLVGhHsFOYEncMF67S3TZG0hIdB
	 chFk/5/TXIr+zzWLkTueLAovYn+qvB/U17kfKHUdlaF34qZV8r8cKq/QPDe0hEVIAVirc
	 KUBfuhzwnBHRCx1n00nutmSc39QLlaSM5zvH65M9Xhi1npDKjIKwDtmdHhsaBPP2iX6lg
	 mq9SUX1/o3ceo0p/Lfpfaks/aGHVMuM6be/+1kAD9FPDx4c3rm2JZXK2cOjmN9DM6qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558233;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=g1Sq569NjbNvOseLvN4cMzcZgoFKooEXMty61nE8y3Q=;
	b=UNJYwRwFFR6KUNEsU2IAtafRYv4BboZCIQ3Q4wT115m67zfBHaRmzMgQWHfTDT39qgmI
	 V6ZQ2ry8AtDxpuSJDJBqRiTIf3M9W3bz+4MvLT4SNMfwRM9wyS9xJ2G35zqLeH7GvZEYX
	 jXvALcLClXv4imbG6DDzObnLGN4xygR0NSg+0M3bhbfZ0zsWGMWDvTxGyC0XN4KnhM4vu
	 Dg/zzjquxvGB4HiiCXGW9mfVeP5ocKxFl6ELFWxKyqfrqr7pmRBj/CrsD6ETCxaNsB+yD
	 JWzTnNx95TSvIfSBI09JscqnwgN3u76mb0BVDHieV3ZNOJH7zBvYjqvtc8/LvoxSsPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRXg05SG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D725606D57F;
	Fri, 13 Nov 2026 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRXg05SG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AA31F000C4;
	Fri, 13 Nov 2026 08:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794558232;
	bh=g1Sq569NjbNvOseLvN4cMzcZgoFKooEXMty61nE8y3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cRXg05SGPyjX2HlpKCmkKvwoiMEDEtMZL2de8BfBe/rIlfJpxlwKn+Bu62yBNMb46
	 dmGG80mWWjael66fQlzYtdSy6haJCWB8xVWmZ5KFymScEYVfQ15WUD5g9CNZ4Pd9N9
	 B45ftcoRMTgydtw4LyMMRy5g4g+fWMCJgY+A4X4sbguGjsOguyKuFfOYvWLoZtCigA
	 hIioTpj0EuJ8XRo057oq7xbebL44OWOXbfjbGLENwPpcbhmw0xE//jzkfnjvGhzAuX
	 hj8Cb2SAOOrxlCQ01R9guK0YwHz29f5eaeO31q6i1UT8RUAJkZ+FqZZQnX+20sk/9n
	 dVLT7L9c0/vqg==
From: Thorsten Blum <blum@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	x86@kernel.org,
	Thorsten Blum <blum@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 2/2] x86/boot: Use BASE_BAUD from asm/serial.h
Date: Fri, 13 Nov 2026 09:23:16 +0100
Message-ID: <20261113082316.67375-4-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113082316.67375-3-blum@kernel.org>
References: <20261113082316.67375-3-blum@kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=931; i=blum@kernel.org; h=from:subject; bh=aQ5ikhDzh8mXNF0lVKjywqsuBPFJoMqkNpGyQlh9lIs=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnfTrJ8d2f01WMsmXBPdo74gjZGSy7JefJNreZHQs/nR j6sb7frKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgImIXmFk6Dbg2n/qwPLjbHe4 q5+rBdTeUSnjitwxqbq6Yq3CwyPaKQz/zEKmd27YbGLTueNV+c4/0y9q38po/bZi6Tk9uXcq351 Z2QA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Use BASE_BAUD from asm/serial.h instead of redefining it.

No functional change.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/x86/boot/early_serial_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
index 39fcd551fc81..59471fea5018 100644
--- a/arch/x86/boot/early_serial_console.c
+++ b/arch/x86/boot/early_serial_console.c
@@ -3,6 +3,7 @@
  * Serial port routines for use during early boot reporting. This code is
  * included from both the compressed kernel and the regular kernel.
  */
+#include <asm/serial.h>
 #include "boot.h"
 
 #define DEFAULT_SERIAL_PORT 0x3f8 /* ttyS0 */
@@ -22,7 +23,6 @@
 #define DLH             1       /*  Divisor latch High        */
 
 #define DEFAULT_BAUD 9600
-#define BASE_BAUD (1843200 / 16)
 
 static void early_serial_init(int port, int baud)
 {
