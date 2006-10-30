Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:62874 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965508AbWJ3KqN
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 30 Oct 2006 05:46:13 -0500
Subject: [PATCH 5/7] severing skbuff.h -> poll.h
Message-Id: <E1GeUej-0002p7-8H@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 30 Oct 2006 10:46:13 +0000
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
List-ID: <linux-arch.vger.kernel.org>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/compat.c                        |    1 +
 fs/gfs2/locking/dlm/plock.c        |    1 +
 include/linux/skbuff.h             |    1 -
 include/net/inet_connection_sock.h |    1 +
 include/net/udp.h                  |    1 +
 5 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/fs/compat.c b/fs/compat.c
index 0f06acb..1c3e9a6 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -46,6 +46,7 @@ #include <linux/personality.h>
 #include <linux/rwsem.h>
 #include <linux/tsacct_kern.h>
 #include <linux/highmem.h>
+#include <linux/poll.h>
 #include <linux/mm.h>
 
 #include <net/sock.h>		/* siocdevprivate_ioctl */
diff --git a/fs/gfs2/locking/dlm/plock.c b/fs/gfs2/locking/dlm/plock.c
index 7365aec..3799f19 100644
--- a/fs/gfs2/locking/dlm/plock.c
+++ b/fs/gfs2/locking/dlm/plock.c
@@ -8,6 +8,7 @@
 
 #include <linux/miscdevice.h>
 #include <linux/lock_dlm_plock.h>
+#include <linux/poll.h>
 
 #include "lock_dlm.h"
 
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c9c83ae..6aa8b11 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -23,7 +23,6 @@ #include <asm/atomic.h>
 #include <asm/types.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
-#include <linux/poll.h>
 #include <linux/net.h>
 #include <linux/textsearch.h>
 #include <net/checksum.h>
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 0bcf9f2..4167a24 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -18,6 +18,7 @@ #define _INET_CONNECTION_SOCK_H
 #include <linux/compiler.h>
 #include <linux/string.h>
 #include <linux/timer.h>
+#include <linux/poll.h>
 
 #include <net/inet_sock.h>
 #include <net/request_sock.h>
diff --git a/include/net/udp.h b/include/net/udp.h
index db0c05f..e287df5 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -27,6 +27,7 @@ #include <net/inet_sock.h>
 #include <net/sock.h>
 #include <net/snmp.h>
 #include <linux/seq_file.h>
+#include <linux/poll.h>
 
 #define UDP_HTABLE_SIZE		128
 
-- 
1.4.2.GIT


