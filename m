From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 2/5] signal/signalfd: Add support for SIGSYS
Date: Sat, 28 Apr 2018 09:06:59 -0500
Message-ID: <20180428140702.3925-2-ebiederm@xmission.com>
References: <87zi1nctut.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87zi1nctut.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux-Arch <linux-arch@vger.kernel.org>
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, Richard Weinberger <richard.weinberger@gmail.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, =?UTF-8?q?Martin=20P=C3=A4rtel?= <martin.partel@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

I don't know why signalfd has never grown support for SIGSYS but grow it now.

This corrects an oversight and removes a need for a default in the
switch statement.  Allowing gcc to warn when future members are added
to the enum siginfo_layout, and signalfd does not handle them.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/signalfd.c                 | 6 +++++-
 include/uapi/linux/signalfd.h | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 31e960209a08..f652249f59f9 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -134,7 +134,6 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 		new.ssi_stime  = kinfo->si_stime;
 		break;
 	case SIL_RT:
-	default:
 		/*
 		 * This case catches also the signals queued by sigqueue().
 		 */
@@ -143,6 +142,11 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 		new.ssi_ptr = (long) kinfo->si_ptr;
 		new.ssi_int = kinfo->si_int;
 		break;
+	case SIL_SYS:
+		new.ssi_call_addr = (long) kinfo->si_call_addr;
+		new.ssi_syscall   = kinfo->si_syscall;
+		new.ssi_arch      = kinfo->si_arch;
+		break;
 	}
 
 	if (copy_to_user(uinfo, &new, sizeof(struct signalfd_siginfo)))
diff --git a/include/uapi/linux/signalfd.h b/include/uapi/linux/signalfd.h
index 6f0da42fc5ef..83429a05b698 100644
--- a/include/uapi/linux/signalfd.h
+++ b/include/uapi/linux/signalfd.h
@@ -35,6 +35,10 @@ struct signalfd_siginfo {
 	__u64 ssi_stime;
 	__u64 ssi_addr;
 	__u16 ssi_addr_lsb;
+	__u16 __pad2;
+	__s32 ssi_syscall;
+	__u64 ssi_call_addr;
+	__u32 ssi_arch;
 
 	/*
 	 * Pad strcture to 128 bytes. Remember to update the
@@ -45,7 +49,7 @@ struct signalfd_siginfo {
 	 * comes out of a read(2) and we really don't want to have
 	 * a compat on read(2).
 	 */
-	__u8 __pad[46];
+	__u8 __pad[28];
 };
 
 
-- 
2.14.1
