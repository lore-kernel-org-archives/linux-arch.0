From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 04/10] signal: Replace memset(info,...) with clear_siginfo for clarity
Date: Tue, 23 Jan 2018 15:07:13 -0600
Message-ID: <20180123210719.10456-4-ebiederm@xmission.com>
References: <87607s5lra.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87607s5lra.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

The function clear_siginfo is just a nice wrapper around memset so
this results in no functional change.  This change makes mistakes
a little more difficult and it makes it clearer what is going on.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/um/kernel/trap.c      | 2 +-
 drivers/usb/core/devio.c   | 4 ++--
 kernel/seccomp.c           | 2 +-
 kernel/time/posix-timers.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 428644175956..b2b02df9896e 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -306,7 +306,7 @@ void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
 
 	arch_examine_signal(sig, regs);
 
-	memset(&clean_si, 0, sizeof(clean_si));
+	clear_siginfo(&clean_si);
 	clean_si.si_signo = si->si_signo;
 	clean_si.si_errno = si->si_errno;
 	clean_si.si_code = si->si_code;
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index a3fad4ec9870..3f9bd3e4c373 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -595,7 +595,7 @@ static void async_completed(struct urb *urb)
 	as->status = urb->status;
 	signr = as->signr;
 	if (signr) {
-		memset(&sinfo, 0, sizeof(sinfo));
+		clear_siginfo(&sinfo);
 		sinfo.si_signo = as->signr;
 		sinfo.si_errno = as->status;
 		sinfo.si_code = SI_ASYNCIO;
@@ -2613,7 +2613,7 @@ static void usbdev_remove(struct usb_device *udev)
 		wake_up_all(&ps->wait);
 		list_del_init(&ps->list);
 		if (ps->discsignr) {
-			memset(&sinfo, 0, sizeof(sinfo));
+			clear_siginfo(&sinfo);
 			sinfo.si_signo = ps->discsignr;
 			sinfo.si_errno = EPIPE;
 			sinfo.si_code = SI_ASYNCIO;
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 5f0dfb2abb8d..3153c9ea51bf 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -515,7 +515,7 @@ void put_seccomp_filter(struct task_struct *tsk)
 
 static void seccomp_init_siginfo(siginfo_t *info, int syscall, int reason)
 {
-	memset(info, 0, sizeof(*info));
+	clear_siginfo(info);
 	info->si_signo = SIGSYS;
 	info->si_code = SYS_SECCOMP;
 	info->si_call_addr = (void __user *)KSTK_EIP(current);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index ec999f32c840..75043046914e 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -462,7 +462,7 @@ static struct k_itimer * alloc_posix_timer(void)
 		kmem_cache_free(posix_timers_cache, tmr);
 		return NULL;
 	}
-	memset(&tmr->sigq->info, 0, sizeof(siginfo_t));
+	clear_siginfo(&tmr->sigq->info);
 	return tmr;
 }
 
-- 
2.14.1
