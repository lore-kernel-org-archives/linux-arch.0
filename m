From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 09/30] compat: Use COMPAT_USE_64BIT_TIME in the input subsystem
Date: Sun, 19 Feb 2012 16:07:47 -0800
Message-ID: <1329696488-16970-10-git-send-email-hpa@zytor.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:57189 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab2BTAM6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 19 Feb 2012 19:12:58 -0500
In-Reply-To: <1329696488-16970-1-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org, akpm@linux-foundation.org, hjl.tools@gmail.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>

From: "H. J. Lu" <hjl.tools@gmail.com>

Enable the input system to be used with a compat ABI with 64-bit time.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input-compat.c |    4 ++--
 drivers/input/input-compat.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/input-compat.c b/drivers/input/input-compat.c
index e46a867..64ca711 100644
--- a/drivers/input/input-compat.c
+++ b/drivers/input/input-compat.c
@@ -17,7 +17,7 @@
 int input_event_from_user(const char __user *buffer,
 			  struct input_event *event)
 {
-	if (INPUT_COMPAT_TEST) {
+	if (INPUT_COMPAT_TEST && !COMPAT_USE_64BIT_TIME) {
 		struct input_event_compat compat_event;
 
 		if (copy_from_user(&compat_event, buffer,
@@ -41,7 +41,7 @@ int input_event_from_user(const char __user *buffer,
 int input_event_to_user(char __user *buffer,
 			const struct input_event *event)
 {
-	if (INPUT_COMPAT_TEST) {
+	if (INPUT_COMPAT_TEST && !COMPAT_USE_64BIT_TIME) {
 		struct input_event_compat compat_event;
 
 		compat_event.time.tv_sec = event->time.tv_sec;
diff --git a/drivers/input/input-compat.h b/drivers/input/input-compat.h
index 22be27b..148f66f 100644
--- a/drivers/input/input-compat.h
+++ b/drivers/input/input-compat.h
@@ -67,7 +67,7 @@ struct ff_effect_compat {
 
 static inline size_t input_event_size(void)
 {
-	return INPUT_COMPAT_TEST ?
+	return (INPUT_COMPAT_TEST && !COMPAT_USE_64BIT_TIME) ?
 		sizeof(struct input_event_compat) : sizeof(struct input_event);
 }
 
-- 
1.7.6.5
