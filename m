From: ralf@linux-mips.org
Subject: [patch 09/14] i8253: Alpha, PowerPC: Remove unused <asm/8253pit.h> header.
Date: Wed, 01 Jun 2011 19:05:05 +0100
Message-ID: <20110601180610.684557757@duck.linux-mips.net>
References: <20110601180456.801265664@duck.linux-mips.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=i8253-remove-unused-8253pit.h-files.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org

 arch/alpha/include/asm/8253pit.h   |    3 ---
 arch/powerpc/include/asm/8253pit.h |    3 ---
 2 files changed, 6 deletions(-)

Index: linux-mips/arch/alpha/include/asm/8253pit.h
===================================================================
--- linux-mips.orig/arch/alpha/include/asm/8253pit.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/*
- * 8253/8254 Programmable Interval Timer
- */
Index: linux-mips/arch/powerpc/include/asm/8253pit.h
===================================================================
--- linux-mips.orig/arch/powerpc/include/asm/8253pit.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/*
- * 8253/8254 Programmable Interval Timer
- */
