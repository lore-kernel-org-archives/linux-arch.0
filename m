Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from isilmar-4.linta.de ([136.243.71.142]:59628 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752699AbeC2L0G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Mar 2018 07:26:06 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 052/109] fs: add do_epoll_*() helpers; remove internal calls to sys_epoll_*()
Date: Thu, 29 Mar 2018 13:23:29 +0200
Message-ID: <20180329112426.23043-53-linux@dominikbrodowski.net>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <20180329112329.PDY1WyHbjPj7HPkrbnCLw9J-t8DUd8U8qOIBFTmO-vQ@z>

Using the helper functions do_epoll_create() and do_epoll_wait() allows us
to remove in-kernel calls to the related syscall functions.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/eventpoll.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 0f3494ed3ed0..602ca4285b2e 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1936,7 +1936,7 @@ static void clear_tfile_check_list(void)
 /*
  * Open an eventpoll file descriptor.
  */
-SYSCALL_DEFINE1(epoll_create1, int, flags)
+static int do_epoll_create(int flags)
 {
 	int error, fd;
 	struct eventpoll *ep = NULL;
@@ -1979,12 +1979,17 @@ SYSCALL_DEFINE1(epoll_create1, int, flags)
 	return error;
 }
 
+SYSCALL_DEFINE1(epoll_create1, int, flags)
+{
+	return do_epoll_create(flags);
+}
+
 SYSCALL_DEFINE1(epoll_create, int, size)
 {
 	if (size <= 0)
 		return -EINVAL;
 
-	return sys_epoll_create1(0);
+	return do_epoll_create(0);
 }
 
 /*
@@ -2148,8 +2153,8 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
  * Implement the event wait interface for the eventpoll file. It is the kernel
  * part of the user space epoll_wait(2).
  */
-SYSCALL_DEFINE4(epoll_wait, int, epfd, struct epoll_event __user *, events,
-		int, maxevents, int, timeout)
+static int do_epoll_wait(int epfd, struct epoll_event __user *events,
+			 int maxevents, int timeout)
 {
 	int error;
 	struct fd f;
@@ -2190,6 +2195,12 @@ SYSCALL_DEFINE4(epoll_wait, int, epfd, struct epoll_event __user *, events,
 	return error;
 }
 
+SYSCALL_DEFINE4(epoll_wait, int, epfd, struct epoll_event __user *, events,
+		int, maxevents, int, timeout)
+{
+	return do_epoll_wait(epfd, events, maxevents, timeout);
+}
+
 /*
  * Implement the event wait interface for the eventpoll file. It is the kernel
  * part of the user space epoll_pwait(2).
@@ -2214,7 +2225,7 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
 		set_current_blocked(&ksigmask);
 	}
 
-	error = sys_epoll_wait(epfd, events, maxevents, timeout);
+	error = do_epoll_wait(epfd, events, maxevents, timeout);
 
 	/*
 	 * If we changed the signal mask, we need to restore the original one.
@@ -2257,7 +2268,7 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
 		set_current_blocked(&ksigmask);
 	}
 
-	err = sys_epoll_wait(epfd, events, maxevents, timeout);
+	err = do_epoll_wait(epfd, events, maxevents, timeout);
 
 	/*
 	 * If we changed the signal mask, we need to restore the original one.
-- 
2.16.3
