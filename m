Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:41140 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529AbbKBWsq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Nov 2015 17:48:46 -0500
Content-transfer-encoding: 7BIT
From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH 1/5] div64.h: optimize do_div() for power-of-two constant
 divisors
Date: Mon, 02 Nov 2015 17:33:26 -0500
Message-ID: <1446503610-6942-2-git-send-email-nicolas.pitre@linaro.org>
In-reply-to: <1446503610-6942-1-git-send-email-nicolas.pitre@linaro.org>
References: <1446503610-6942-1-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>
Cc: Arnd Bergmann <arnd@arndb.de>, rmk+kernel@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20151102223326.y6YmVJ42qtGhc-p7R9CC5Y-0Et-tVQKgvN-9wvOBTro@z>

On 32-bit targets, gcc is able to do the right thing with a constant
divisor that happens to be a power of two i.e. it turns the division
into a right shift inline.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 include/asm-generic/div64.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index 8f4e319334..47aa1e2134 100644
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -41,7 +41,12 @@ extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
 	uint32_t __base = (base);			\
 	uint32_t __rem;					\
 	(void)(((typeof((n)) *)0) == ((uint64_t *)0));	\
-	if (likely(((n) >> 32) == 0)) {			\
+	if (__builtin_constant_p(__base) &&		\
+	    (__base & (__base - 1)) == 0) {		\
+		/* constant power of 2: gcc is fine */	\
+		__rem = (n) & (__base - 1);		\
+		(n) /= __base;				\
+	} else if (likely(((n) >> 32) == 0)) {		\
 		__rem = (uint32_t)(n) % __base;		\
 		(n) = (uint32_t)(n) / __base;		\
 	} else 						\
-- 
2.4.3

