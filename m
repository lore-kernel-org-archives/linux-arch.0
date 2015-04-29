From: David Howells <dhowells@redhat.com>
Subject: [PATCH 08/13] Make tick functions that return a boolean value
 return bool
Date: Wed, 29 Apr 2015 20:22:21 +0100
Message-ID: <20150429192221.24909.3135.stgit@warthog.procyon.org.uk>
References: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40014 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414AbbD2TWZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 29 Apr 2015 15:22:25 -0400
In-Reply-To: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org

Make tick functions that return a boolean value return bool so that gcc can
make better decisions.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/clockchips.h   |    6 +++---
 kernel/time/tick-broadcast.c |   16 ++++++++--------
 kernel/time/tick-internal.h  |    6 +++---
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index 96c280b2c263..c98f07b352cc 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -197,9 +197,9 @@ extern int tick_receive_broadcast(void);
 
 # if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_TICK_ONESHOT)
 extern void tick_setup_hrtimer_broadcast(void);
-extern int tick_check_broadcast_expired(void);
+extern bool tick_check_broadcast_expired(void);
 # else
-static inline int tick_check_broadcast_expired(void) { return 0; }
+static inline bool tick_check_broadcast_expired(void) { return false; }
 static inline void tick_setup_hrtimer_broadcast(void) { }
 # endif
 
@@ -210,7 +210,7 @@ extern int clockevents_notify(unsigned long reason, void *arg);
 static inline void clockevents_suspend(void) { }
 static inline void clockevents_resume(void) { }
 static inline int clockevents_notify(unsigned long reason, void *arg) { return 0; }
-static inline int tick_check_broadcast_expired(void) { return 0; }
+static inline bool tick_check_broadcast_expired(void) { return 0; }
 static inline void tick_setup_hrtimer_broadcast(void) { }
 
 #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 7e8ca4f448a8..8effac895974 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -117,7 +117,7 @@ void tick_install_broadcast_device(struct clock_event_device *dev)
 /*
  * Check, if the device is the broadcast device
  */
-int tick_is_broadcast_device(struct clock_event_device *dev)
+bool tick_is_broadcast_device(struct clock_event_device *dev)
 {
 	return (dev && tick_broadcast_device.evtdev == dev);
 }
@@ -155,11 +155,11 @@ static void tick_device_setup_broadcast_func(struct clock_event_device *dev)
  * Check, if the device is disfunctional and a place holder, which
  * needs to be handled by the broadcast device.
  */
-int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
+bool tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
 {
 	struct clock_event_device *bc = tick_broadcast_device.evtdev;
 	unsigned long flags;
-	int ret;
+	bool ret;
 
 	raw_spin_lock_irqsave(&tick_broadcast_lock, flags);
 
@@ -177,7 +177,7 @@ int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
 			tick_broadcast_start_periodic(bc);
 		else
 			tick_broadcast_setup_oneshot(bc);
-		ret = 1;
+		ret = true;
 	} else {
 		/*
 		 * Clear the broadcast bit for this cpu if the
@@ -206,7 +206,7 @@ int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
 			 * caller initialize the device.
 			 */
 			tick_broadcast_clear_oneshot(cpu);
-			ret = 0;
+			ret = false;
 			break;
 
 		case TICKDEV_MODE_PERIODIC:
@@ -227,7 +227,7 @@ int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
 			break;
 		default:
 			/* Nothing to do */
-			ret = 0;
+			ret = false;
 			break;
 		}
 	}
@@ -511,7 +511,7 @@ struct cpumask *tick_get_broadcast_oneshot_mask(void)
  * to avoid a deep idle transition as we are about to get the
  * broadcast IPI right away.
  */
-int tick_check_broadcast_expired(void)
+bool tick_check_broadcast_expired(void)
 {
 	return cpumask_test_cpu(smp_processor_id(), tick_broadcast_force_mask);
 }
@@ -934,7 +934,7 @@ void tick_shutdown_broadcast_oneshot(unsigned int cpu)
 /*
  * Check, whether the broadcast device is in one shot mode
  */
-int tick_broadcast_oneshot_active(void)
+bool tick_broadcast_oneshot_active(void)
 {
 	return tick_broadcast_device.mode == TICKDEV_MODE_ONESHOT;
 }
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index b64fdd8054c5..c41e267ae772 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -49,9 +49,9 @@ extern ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt);
 
 /* Broadcasting support */
 # ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
-extern int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu);
+extern bool tick_device_uses_broadcast(struct clock_event_device *dev, int cpu);
 extern void tick_install_broadcast_device(struct clock_event_device *dev);
-extern int tick_is_broadcast_device(struct clock_event_device *dev);
+extern bool tick_is_broadcast_device(struct clock_event_device *dev);
 extern void tick_shutdown_broadcast(unsigned int cpu);
 extern void tick_suspend_broadcast(void);
 extern void tick_resume_broadcast(void);
@@ -118,7 +118,7 @@ static inline int tick_check_oneshot_change(int allow_nohz) { return 0; }
 extern void tick_broadcast_setup_oneshot(struct clock_event_device *bc);
 extern void tick_broadcast_switch_to_oneshot(void);
 extern void tick_shutdown_broadcast_oneshot(unsigned int cpu);
-extern int tick_broadcast_oneshot_active(void);
+extern bool tick_broadcast_oneshot_active(void);
 extern void tick_check_oneshot_broadcast_this_cpu(void);
 bool tick_broadcast_oneshot_available(void);
 extern struct cpumask *tick_get_broadcast_oneshot_mask(void);
