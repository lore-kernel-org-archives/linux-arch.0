From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 062/109] inotify: add do_inotify_init() helper; remove in-kernel call to syscall
Date: Thu, 29 Mar 2018 13:23:39 +0200
Message-ID: <20180329112426.23043-63-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Using the inotify-internal do_inotify_init() helper allows us to get rid
of the in-kernel call to sys_inotify_init1() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Acked-by: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/notify/inotify/inotify_user.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 2c908b31d6c9..43c23653ce2e 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -635,7 +635,7 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
 
 
 /* inotify syscalls */
-SYSCALL_DEFINE1(inotify_init1, int, flags)
+static int do_inotify_init(int flags)
 {
 	struct fsnotify_group *group;
 	int ret;
@@ -660,9 +660,14 @@ SYSCALL_DEFINE1(inotify_init1, int, flags)
 	return ret;
 }
 
+SYSCALL_DEFINE1(inotify_init1, int, flags)
+{
+	return do_inotify_init(flags);
+}
+
 SYSCALL_DEFINE0(inotify_init)
 {
-	return sys_inotify_init1(0);
+	return do_inotify_init(0);
 }
 
 SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
-- 
2.16.3
