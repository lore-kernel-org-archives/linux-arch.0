From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 10/10] signal/memory-failure: Use force_sig_mceerr and send_sig_mceerr
Date: Tue, 23 Jan 2018 15:07:19 -0600
Message-ID: <20180123210719.10456-10-ebiederm@xmission.com>
References: <87607s5lra.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87607s5lra.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Delegate filling out struct siginfo to functions in kernel/signal.c
to simplify the code.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 mm/memory-failure.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c5f5f31bd979..4b80ccee4535 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -181,19 +181,16 @@ EXPORT_SYMBOL_GPL(hwpoison_filter);
 static int kill_proc(struct task_struct *t, unsigned long addr,
 			unsigned long pfn, struct page *page, int flags)
 {
-	struct siginfo si;
+	short addr_lsb;
 	int ret;
 
 	pr_err("Memory failure: %#lx: Killing %s:%d due to hardware memory corruption\n",
 		pfn, t->comm, t->pid);
-	si.si_signo = SIGBUS;
-	si.si_errno = 0;
-	si.si_addr = (void *)addr;
-	si.si_addr_lsb = compound_order(compound_head(page)) + PAGE_SHIFT;
+	addr_lsb = compound_order(compound_head(page)) + PAGE_SHIFT;
 
 	if ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm) {
-		si.si_code = BUS_MCEERR_AR;
-		ret = force_sig_info(SIGBUS, &si, current);
+		ret = force_sig_mceerr(BUS_MCEERR_AR, (void __user *)addr,
+				       addr_lsb, current);
 	} else {
 		/*
 		 * Don't use force here, it's convenient if the signal
@@ -201,8 +198,8 @@ static int kill_proc(struct task_struct *t, unsigned long addr,
 		 * This could cause a loop when the user sets SIGBUS
 		 * to SIG_IGN, but hopefully no one will do that?
 		 */
-		si.si_code = BUS_MCEERR_AO;
-		ret = send_sig_info(SIGBUS, &si, t);  /* synchronous? */
+		ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)addr,
+				      addr_lsb, t);  /* synchronous? */
 	}
 	if (ret < 0)
 		pr_info("Memory failure: Error sending signal to %s:%d: %d\n",
-- 
2.14.1
