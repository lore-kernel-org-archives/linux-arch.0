From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 03/24] Remove execution domain support
Date: Sat, 11 Apr 2015 22:47:42 +0200
Message-ID: <1428785283-20501-4-git-send-email-richard@nod.at>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428785283-20501-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, yasutake.koichi@jp.panasonic.com, lftan@altera.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, davem@davemloft.net, cmetcalf@ezchip.com, jdike@addtoit.com, akpm@linux-foundation.org, oleg@redhat.com, hch@inf
List-Id: linux-arch.vger.kernel.org

All users of exec_domain are gone, now we can get rid
of that abandoned feature.
To not break existing userspace we keep a dummy
/proc/execdomains file which will always contain
"0-0     Linux                   [kernel]".

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 kernel/exec_domain.c | 100 +--------------------------------------------------
 kernel/exit.c        |   2 --
 kernel/fork.c        |   4 ---
 3 files changed, 1 insertion(+), 105 deletions(-)

diff --git a/kernel/exec_domain.c b/kernel/exec_domain.c
index 83d4382..b2fb57d 100644
--- a/kernel/exec_domain.c
+++ b/kernel/exec_domain.c
@@ -20,13 +20,7 @@
 #include <linux/types.h>
 #include <linux/fs_struct.h>
 
-
 static void default_handler(int, struct pt_regs *);
-
-static struct exec_domain *exec_domains = &default_exec_domain;
-static DEFINE_RWLOCK(exec_domains_lock);
-
-
 static unsigned long ident_map[32] = {
 	0,	1,	2,	3,	4,	5,	6,	7,
 	8,	9,	10,	11,	12,	13,	14,	15,
@@ -55,94 +49,9 @@ default_handler(int segment, struct pt_regs *regp)
 		send_sig(SIGSEGV, current, 1);
 }
 
-static struct exec_domain *
-lookup_exec_domain(unsigned int personality)
-{
-	unsigned int pers = personality(personality);
-	struct exec_domain *ep;
-
-	read_lock(&exec_domains_lock);
-	for (ep = exec_domains; ep; ep = ep->next) {
-		if (pers >= ep->pers_low && pers <= ep->pers_high)
-			if (try_module_get(ep->module))
-				goto out;
-	}
-
-#ifdef CONFIG_MODULES
-	read_unlock(&exec_domains_lock);
-	request_module("personality-%d", pers);
-	read_lock(&exec_domains_lock);
-
-	for (ep = exec_domains; ep; ep = ep->next) {
-		if (pers >= ep->pers_low && pers <= ep->pers_high)
-			if (try_module_get(ep->module))
-				goto out;
-	}
-#endif
-
-	ep = &default_exec_domain;
-out:
-	read_unlock(&exec_domains_lock);
-	return ep;
-}
-
-int
-register_exec_domain(struct exec_domain *ep)
-{
-	struct exec_domain	*tmp;
-	int			err = -EBUSY;
-
-	if (ep == NULL)
-		return -EINVAL;
-
-	if (ep->next != NULL)
-		return -EBUSY;
-
-	write_lock(&exec_domains_lock);
-	for (tmp = exec_domains; tmp; tmp = tmp->next) {
-		if (tmp == ep)
-			goto out;
-	}
-
-	ep->next = exec_domains;
-	exec_domains = ep;
-	err = 0;
-
-out:
-	write_unlock(&exec_domains_lock);
-	return err;
-}
-EXPORT_SYMBOL(register_exec_domain);
-
-int
-unregister_exec_domain(struct exec_domain *ep)
-{
-	struct exec_domain	**epp;
-
-	epp = &exec_domains;
-	write_lock(&exec_domains_lock);
-	for (epp = &exec_domains; *epp; epp = &(*epp)->next) {
-		if (ep == *epp)
-			goto unregister;
-	}
-	write_unlock(&exec_domains_lock);
-	return -EINVAL;
-
-unregister:
-	*epp = ep->next;
-	ep->next = NULL;
-	write_unlock(&exec_domains_lock);
-	return 0;
-}
-EXPORT_SYMBOL(unregister_exec_domain);
-
 int __set_personality(unsigned int personality)
 {
-	struct exec_domain *oep = current_thread_info()->exec_domain;
-
-	current_thread_info()->exec_domain = lookup_exec_domain(personality);
 	current->personality = personality;
-	module_put(oep->module);
 
 	return 0;
 }
@@ -151,14 +60,7 @@ EXPORT_SYMBOL(__set_personality);
 #ifdef CONFIG_PROC_FS
 static int execdomains_proc_show(struct seq_file *m, void *v)
 {
-	struct exec_domain	*ep;
-
-	read_lock(&exec_domains_lock);
-	for (ep = exec_domains; ep; ep = ep->next)
-		seq_printf(m, "%d-%d\t%-16s\t[%s]\n",
-			       ep->pers_low, ep->pers_high, ep->name,
-			       module_name(ep->module));
-	read_unlock(&exec_domains_lock);
+	seq_puts(m, "0-0\tLinux           \t[kernel]\n");
 	return 0;
 }
 
diff --git a/kernel/exit.c b/kernel/exit.c
index feff10b..22fcc05 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -756,8 +756,6 @@ void do_exit(long code)
 
 	cgroup_exit(tsk);
 
-	module_put(task_thread_info(tsk)->exec_domain->module);
-
 	/*
 	 * FIXME: do that only when needed, using sched_exit tracepoint
 	 */
diff --git a/kernel/fork.c b/kernel/fork.c
index cf65139..f2c1e73 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1279,9 +1279,6 @@ static struct task_struct *copy_process(unsigned long clone_flags,
 	if (nr_threads >= max_threads)
 		goto bad_fork_cleanup_count;
 
-	if (!try_module_get(task_thread_info(p)->exec_domain->module))
-		goto bad_fork_cleanup_count;
-
 	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
 	p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER);
 	p->flags |= PF_FORKNOEXEC;
@@ -1590,7 +1587,6 @@ bad_fork_cleanup_threadgroup_lock:
 	if (clone_flags & CLONE_THREAD)
 		threadgroup_change_end(current);
 	delayacct_tsk_free(p);
-	module_put(task_thread_info(p)->exec_domain->module);
 bad_fork_cleanup_count:
 	atomic_dec(&p->cred->user->processes);
 	exit_creds(p);
-- 
1.8.4.5
