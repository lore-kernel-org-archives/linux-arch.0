From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 24/24] Remove rest of exec domains.
Date: Sat, 11 Apr 2015 22:48:03 +0200
Message-ID: <1428785283-20501-25-git-send-email-richard@nod.at>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428785283-20501-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, yasutake.koichi@jp.panasonic.com, lftan@altera.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, davem@davemloft.net, cmetcalf@ezchip.com, jdike@addtoit.com, akpm@linux-foundation.org, oleg@redhat.com, hch@inf
List-Id: linux-arch.vger.kernel.org

It is gone from all archs, now we can remove
the final bits.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/linux/personality.h | 40 +---------------------------------------
 include/linux/sched.h       |  6 ------
 kernel/exec_domain.c        | 37 -------------------------------------
 3 files changed, 1 insertion(+), 82 deletions(-)

diff --git a/include/linux/personality.h b/include/linux/personality.h
index 646c0a7..aeb7892 100644
--- a/include/linux/personality.h
+++ b/include/linux/personality.h
@@ -3,52 +3,14 @@
 
 #include <uapi/linux/personality.h>
 
-
-/*
- * Handling of different ABIs (personalities).
- */
-
-struct exec_domain;
-struct pt_regs;
-
-extern int		register_exec_domain(struct exec_domain *);
-extern int		unregister_exec_domain(struct exec_domain *);
-extern int		__set_personality(unsigned int);
-
-
-/*
- * Description of an execution domain.
- * 
- * The first two members are refernced from assembly source
- * and should stay where they are unless explicitly needed.
- */
-typedef void (*handler_t)(int, struct pt_regs *);
-
-struct exec_domain {
-	const char		*name;		/* name of the execdomain */
-	handler_t		handler;	/* handler for syscalls */
-	unsigned char		pers_low;	/* lowest personality */
-	unsigned char		pers_high;	/* highest personality */
-	unsigned long		*signal_map;	/* signal mapping */
-	unsigned long		*signal_invmap;	/* reverse signal mapping */
-	struct map_segment	*err_map;	/* error mapping */
-	struct map_segment	*socktype_map;	/* socket type mapping */
-	struct map_segment	*sockopt_map;	/* socket option mapping */
-	struct map_segment	*af_map;	/* address family mapping */
-	struct module		*module;	/* module context of the ed. */
-	struct exec_domain	*next;		/* linked list (internal) */
-};
-
 /*
  * Return the base personality without flags.
  */
 #define personality(pers)	(pers & PER_MASK)
 
-
 /*
  * Change personality of the currently running process.
  */
-#define set_personality(pers) \
-	((current->personality == (pers)) ? 0 : __set_personality(pers))
+#define set_personality(pers)	(current->personality = (pers))
 
 #endif /* _LINUX_PERSONALITY_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a419b65..14d9117 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -125,7 +125,6 @@ struct sched_attr {
 	u64 sched_period;
 };
 
-struct exec_domain;
 struct futex_pi_state;
 struct robust_list_head;
 struct bio_list;
@@ -2288,11 +2287,6 @@ extern void set_curr_task(int cpu, struct task_struct *p);
 
 void yield(void);
 
-/*
- * The default (Linux) execution domain.
- */
-extern struct exec_domain	default_exec_domain;
-
 union thread_union {
 	struct thread_info thread_info;
 	unsigned long stack[THREAD_SIZE/sizeof(long)];
diff --git a/kernel/exec_domain.c b/kernel/exec_domain.c
index b2fb57d..6873bb3 100644
--- a/kernel/exec_domain.c
+++ b/kernel/exec_domain.c
@@ -20,43 +20,6 @@
 #include <linux/types.h>
 #include <linux/fs_struct.h>
 
-static void default_handler(int, struct pt_regs *);
-static unsigned long ident_map[32] = {
-	0,	1,	2,	3,	4,	5,	6,	7,
-	8,	9,	10,	11,	12,	13,	14,	15,
-	16,	17,	18,	19,	20,	21,	22,	23,
-	24,	25,	26,	27,	28,	29,	30,	31
-};
-
-struct exec_domain default_exec_domain = {
-	.name		= "Linux",		/* name */
-	.handler	= default_handler,	/* lcall7 causes a seg fault. */
-	.pers_low	= 0,			/* PER_LINUX personality. */
-	.pers_high	= 0,			/* PER_LINUX personality. */
-	.signal_map	= ident_map,		/* Identity map signals. */
-	.signal_invmap	= ident_map,		/*  - both ways. */
-};
-
-
-static void
-default_handler(int segment, struct pt_regs *regp)
-{
-	set_personality(0);
-
-	if (current_thread_info()->exec_domain->handler != default_handler)
-		current_thread_info()->exec_domain->handler(segment, regp);
-	else
-		send_sig(SIGSEGV, current, 1);
-}
-
-int __set_personality(unsigned int personality)
-{
-	current->personality = personality;
-
-	return 0;
-}
-EXPORT_SYMBOL(__set_personality);
-
 #ifdef CONFIG_PROC_FS
 static int execdomains_proc_show(struct seq_file *m, void *v)
 {
-- 
1.8.4.5
