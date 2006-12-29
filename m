Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.233.200]:10858 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755027AbWL2Pps (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 29 Dec 2006 10:45:48 -0500
Date: Fri, 29 Dec 2006 18:52:16 +0300
From: Alexey Dobriyan <adobriyan@openvz.org>
Subject: [RFC] Use jiffies_64 in sched_clock()
Message-ID: <20061229155216.GA11125@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: devel@openvz.org
List-ID: <linux-arch.vger.kernel.org>

Would it make sense to always use jiffies_64 instead of jiffies?
(module hardware specific version)

This is what FRV, UML, one ia64 version, one i386 version do.

Also substract initial jiffies.

Signed-off-by: Alexey Dobriyan <adobriyan@openvz.org>
---

 arch/frv/kernel/time.c |    8 --------
 arch/um/kernel/time.c  |    8 --------
 kernel/sched.c         |    3 ++-
 3 files changed, 2 insertions(+), 17 deletions(-)

--- a/arch/frv/kernel/time.c
+++ b/arch/frv/kernel/time.c
@@ -139,11 +139,3 @@ void time_init(void)
 
 	time_divisor_init();
 }
-
-/*
- * Scheduler clock - returns current time in nanosec units.
- */
-unsigned long long sched_clock(void)
-{
-	return jiffies_64 * (1000000000 / HZ);
-}
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -27,14 +27,6 @@ int hz(void)
 	return(HZ);
 }
 
-/*
- * Scheduler clock - returns current time in nanosec units.
- */
-unsigned long long sched_clock(void)
-{
-	return (unsigned long long)jiffies_64 * (1000000000 / HZ);
-}
-
 static unsigned long long prev_nsecs;
 #ifdef CONFIG_UML_REAL_TIME_CLOCK
 static long long delta;   		/* Deviation per interval */
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -64,7 +64,8 @@ #include <asm/unistd.h>
  */
 unsigned long long __attribute__((weak)) sched_clock(void)
 {
-	return (unsigned long long)jiffies * (1000000000 / HZ);
+	/* No locking but a rare wrong value is not a big deal. */
+	return (jiffies_64 - INITIAL_JIFFIES) * (1000000000 / HZ);
 }
 
 /*

