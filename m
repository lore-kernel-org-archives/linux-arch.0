From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 11/11] sysctl: Make do_sysctl static
Date: Thu,  5 Nov 2009 16:41:54 -0800
Message-ID: <1257468114-6823-11-git-send-email-ebiederm@xmission.com>
References: <m1tyx8trik.fsf@fess.ebiederm.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932082AbZKFAmi@vger.kernel.org>
In-Reply-To: <m1tyx8trik.fsf@fess.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com>

Now that all of the architectures use compat_sys_sysctl do_sysctl
can become static.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/sysctl.h |    4 ----
 kernel/sysctl_binary.c |    2 +-
 2 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 1e4743e..82c32b8 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -996,10 +996,6 @@ extern int proc_doulongvec_minmax(struct ctl_table *, int,
 extern int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int,
 				      void __user *, size_t *, loff_t *);
 
-extern int do_sysctl (int __user *name, int nlen,
-		      void __user *oldval, size_t __user *oldlenp,
-		      void __user *newval, size_t newlen);
-
 extern ctl_handler sysctl_data;
 extern ctl_handler sysctl_string;
 extern ctl_handler sysctl_intvec;
diff --git a/kernel/sysctl_binary.c b/kernel/sysctl_binary.c
index a2fed5b..b9b841e 100644
--- a/kernel/sysctl_binary.c
+++ b/kernel/sysctl_binary.c
@@ -134,7 +134,7 @@ static void deprecated_sysctl_warning(const int *name, int nlen)
 	return;
 }
 
-int do_sysctl(int __user *args_name, int nlen,
+static int do_sysctl(int __user *args_name, int nlen,
 	void __user *oldval, size_t __user *oldlenp,
 	void __user *newval, size_t newlen)
 {
-- 
1.6.5.2.143.g8cc62
