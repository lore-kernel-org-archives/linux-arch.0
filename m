Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from exmail.andestech.com ([59.124.169.137]:19846 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbeITI2P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Sep 2018 04:28:15 -0400
From: Vincent Chen <vincentc@andestech.com>
Subject: [PATCH 5/5] math-emu/soft-fp.h: (_FP_ROUND_ZERO) cast 0 to void to fix warning
Date: Thu, 20 Sep 2018 10:46:22 +0800
Message-ID: <1537411582-23723-6-git-send-email-vincentc@andestech.com>
In-Reply-To: <1537411582-23723-1-git-send-email-vincentc@andestech.com>
References: <1537411582-23723-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, deanbo422@gmail.com, vincentc@andestech.com
Message-ID: <20180920024622.Bv96GgIp-vkPKesoUyoq2u3hCDwOx6kmHIKUDpxjBu8@z>

  _FP_ROUND_ZERO is defined as 0 and used as a statemente in macro
_FP_ROUND. This generates "error: statement with no effect
[-Werror=unused-value]" from gcc. Defining _FP_ROUND_ZERO as (void)0 to
fix it.

This modification is quoted from glibc 'commit <In libc/:>
(8ed1e7d5894000c155acbd06f)'

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 include/math-emu/soft-fp.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/math-emu/soft-fp.h b/include/math-emu/soft-fp.h
index 3f284bc..5650c16 100644
--- a/include/math-emu/soft-fp.h
+++ b/include/math-emu/soft-fp.h
@@ -138,7 +138,7 @@
       _FP_FRAC_ADDI_##wc(X, _FP_WORK_ROUND);		\
 } while (0)
 
-#define _FP_ROUND_ZERO(wc, X)		0
+#define _FP_ROUND_ZERO(wc, X)		(void)0
 
 #define _FP_ROUND_PINF(wc, X)				\
 do {							\
-- 
1.7.1
