From: ralf@linux-mips.org
Subject: [patch 08/14] i8253: Alpha: Cleanup remaining users of i8253pit.h
Date: Wed, 01 Jun 2011 19:05:04 +0100
Message-ID: <20110601180610.608083130@duck.linux-mips.net>
References: <20110601180456.801265664@duck.linux-mips.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=i8253-cleanup-remaining-alpha-users-of-8253pit.h.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The Alpha <asm/i8253pit.h> header is empty so this inclusion can just be
removed.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org

 arch/alpha/kernel/sys_ruffian.c |    1 -
 arch/alpha/kernel/time.c        |    1 -
 2 files changed, 2 deletions(-)

Index: linux-mips/arch/alpha/kernel/sys_ruffian.c
===================================================================
--- linux-mips.orig/arch/alpha/kernel/sys_ruffian.c
+++ linux-mips/arch/alpha/kernel/sys_ruffian.c
@@ -26,7 +26,6 @@
 #include <asm/pgtable.h>
 #include <asm/core_cia.h>
 #include <asm/tlbflush.h>
-#include <asm/8253pit.h>
 
 #include "proto.h"
 #include "irq_impl.h"
Index: linux-mips/arch/alpha/kernel/time.c
===================================================================
--- linux-mips.orig/arch/alpha/kernel/time.c
+++ linux-mips/arch/alpha/kernel/time.c
@@ -46,7 +46,6 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/hwrpb.h>
-#include <asm/8253pit.h>
 #include <asm/rtc.h>
 
 #include <linux/mc146818rtc.h>
