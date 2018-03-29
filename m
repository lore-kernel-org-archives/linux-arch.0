From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 054/109] fs: add do_eventfd() helper; remove internal call to sys_eventfd()
Date: Thu, 29 Mar 2018 13:23:31 +0200
Message-ID: <20180329112426.23043-55-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

Using this helper removes an in-kernel call to the sys_eventfd() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/eventfd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 012f5bd46dfa..08d3bd602f73 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -380,7 +380,7 @@ struct eventfd_ctx *eventfd_ctx_fileget(struct file *file)
 }
 EXPORT_SYMBOL_GPL(eventfd_ctx_fileget);
 
-SYSCALL_DEFINE2(eventfd2, unsigned int, count, int, flags)
+static int do_eventfd(unsigned int count, int flags)
 {
 	struct eventfd_ctx *ctx;
 	int fd;
@@ -409,8 +409,13 @@ SYSCALL_DEFINE2(eventfd2, unsigned int, count, int, flags)
 	return fd;
 }
 
+SYSCALL_DEFINE2(eventfd2, unsigned int, count, int, flags)
+{
+	return do_eventfd(count, flags);
+}
+
 SYSCALL_DEFINE1(eventfd, unsigned int, count)
 {
-	return sys_eventfd2(count, 0);
+	return do_eventfd(count, 0);
 }
 
-- 
2.16.3
