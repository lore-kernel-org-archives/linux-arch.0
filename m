Return-Path: <manfred@colorfullife.com>
Received: from dbl.q-ag.de ([213.172.117.3]:25475 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262007AbUDJLxz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 10 Apr 2004 07:53:55 -0400
Message-ID: <4077E04A.9060901@colorfullife.com>
Date: Sat, 10 Apr 2004 13:53:46 +0200
From: Manfred Spraul <manfred@colorfullife.com>
MIME-Version: 1.0
Subject: Re: posix message queues
References: <20040407120720.6b937deb.akpm@osdl.org>	<40745360.6000709@colorfullife.com> <20040409164506.0611846a.davem@redhat.com> <4077D851.7000008@colorfullife.com>
In-Reply-To: <4077D851.7000008@colorfullife.com>
Content-Type: multipart/mixed;
 boundary="------------070003060506060504050504"
To: linux-arch@vger.kernel.org
Cc: "David S. Miller" <davem@redhat.com>, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070003060506060504050504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Manfred Spraul wrote:

> 
>+if (notification.sigev_notify == SIGEV_THREAD) {
>+	if (copy_from_user(cookie, u_notification.sigev_value.sival_ptr,
>
notification, not u_notification: sival_ptr is a union on sival_int, and 
sival_int was copied to kernel space by get_compat_sigevent.
Updated patch attached, sorry.

--
    Manfred

--------------070003060506060504050504
Content-Type: text/plain;
 name="patch-mqueue-compat"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-mqueue-compat"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 5
//  EXTRAVERSION = -mm3
--- 2.6/ipc/compat_mq.c	2004-04-10 09:59:40.000000000 +0200
+++ build-2.6/ipc/compat_mq.c	2004-04-10 13:46:26.713887203 +0200
@@ -139,6 +139,7 @@
 {
 	mm_segment_t oldfs;
 	struct sigevent notification;
+	char cookie[NOTIFY_COOKIE_LEN];
 	long ret;
 
 	if (!u_notification)
@@ -147,6 +148,14 @@
 	if (get_compat_sigevent(&notification, u_notification))
 		return -EFAULT;
 
+	if (notification.sigev_notify == SIGEV_THREAD) {
+		if (copy_from_user(cookie, notification.sigev_value.sival_ptr,
+					NOTIFY_COOKIE_LEN)) {
+			return -EFAULT;
+		}
+		notification.sigev_value.sival_ptr = cookie;
+	}
+
 	oldfs = get_fs();
 	set_fs(KERNEL_DS);
 	ret = sys_mq_notify(mqdes, &notification);

--------------070003060506060504050504--
