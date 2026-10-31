Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.162.73.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793452356;
	b=YQRVeQrk3EyXkXcvz+eFZUDyFvLKUwrWGbllS5BBTL1ZGB3QatyPVA3Mb9p9Pjk/Lx8t
	 OtzAAcylDJpmsIW9kozCQjyDNOA4CX1d4W31B/TPjjqypzHNMyBc0FpdjpHDrGOzEnuB/
	 L102aZok5ywwc0jWrg4olxXUKi9cguGANrsNBOEno6DfSQQ30La8Iy8I2Szob2AehB4+d
	 zju0VBm/EfBgZSSzmY+rUOYFp7vMZ+z8h9noqyzX3O8hhC1drY7QNql1+MHP8pGdUMR0q
	 J8HziZbRULmZ8D7gpMGF+b0S4D7SOQoacpVtZ5BTokHaqXw1iAt/I0IspZ41o7ofGbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793452356;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=9Mcdo9InwCGqhJKJu06XLGqE6NCBgd/6MakkJKubvP4=;
	b=VCHbRfDRVptMkx/Vx6AI5AwKIXaUnB5QpdFSYxAOPSYaGOzw0B7fR0Tem11F/AKCMfx3
	 Q9XbSUCaFjgbucUYDLcnWaoikUN+duZ4OMjpTeMIo2Pkcw3p8F26zDJl0tL0WCRtUD9rA
	 81jA/WOS5BntDA91nhWGCqQG+Yogr95Xb4ErXDmHfSBT7mDlUypm2d0FXiHdlMBAnsh2H
	 aBYxTL7Hu3MCAaa5SCefttpVw39xE8OLvGXJVvenvmOgCMH8T03nhUZOTpzos6bAyHG4P
	 WZca4MqHxtETW9bkQcB7dLLEzK3SyXLk54EAeSTnAZO9xvjsVlPmLWEKFh1vkf447gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=kRkZD1rB;
	arc=none smtp.remote-ip=35.162.73.231
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8926606A31D;
	Sat, 31 Oct 2026 13:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8926606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=kRkZD1rB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793452355; x=1824988355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Mcdo9InwCGqhJKJu06XLGqE6NCBgd/6MakkJKubvP4=;
  b=kRkZD1rBxf89Sd6buui8hcxqGX6ZVfQqZCsIKJm1nrx6Mvg7grHDLaYB
   eXAiOgo+Qa7h/+BQlxgVuHs7wMyzOP6L+IPwlwACvfkrYGFOLB84qBf0L
   I/pMf+mx0fw156a4YrbqQZudz67o6ajY2hxx8x7lVKsQHyF07zFq5iSrJ
   quBNq9t6R4L5b4H2+i8X0Tx5duVVPUJ+3c6wv880QbpA7NtG3WLvAvgBZ
   7F03tsIjLTtQfvyjamSlcL/ZUu+eoJ4vFU7STkyV+SXSVaSjrurSxXAqb
   Sem2UofvfkTdcWVYPEWoq2BAKGILyNvemXWYA73t5OYGmuNK4Pim9S2vH
   g==;
X-CSE-ConnectionGUID: pS37GWOvTMyOzZHDjdRchg==
X-CSE-MsgGUID: u3bWBQroSV+juIjC2IMViA==
X-IronPort-AV: E=Sophos;i="6.27,188,1787011200"; 
   d="scan'208";a="32554089"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 13:12:35 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:30029]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.238:2525] with esmtp (Farcaster)
 id 3b05eddc-af64-4981-aeaf-89c9c27db9dd; Sat, 31 Oct 2026 13:12:35 +0000 (UTC)
X-Farcaster-Flow-ID: 3b05eddc-af64-4981-aeaf-89c9c27db9dd
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:12:35 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:12:34 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>
CC: Ihor Solodrai <ihor.solodrai@linux.dev>, Alan Maguire
	<almagui@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song
	<yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, <linux-kbuild@vger.kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, <linux-arch@vger.kernel.org>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hazem Mohamed
 Abuelfotoh" <abuehaze@amazon.com>, Bjoern Doebel <doebel@amazon.de>, "Martin
 Pohlack" <mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>
Subject: [PATCH bpf-next 10/13] bpf: defer kfunc and struct_ops registrations until first BTF use
Date: Sat, 31 Oct 2026 13:09:56 +0000
Message-ID: <20261031130959.23472-11-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261031130959.23472-1-wanjay@amazon.com>
References: <20261031130959.23472-1-wanjay@amazon.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

With the BTF compressed, the kernel still decompresses and parses it at
boot: initcalls registering kfunc sets, dtor kfuncs and struct_ops look
up their BTF ids.  With CONFIG_DEBUG_INFO_BTF_LAZY, queue these
registrations until something actually needs the vmlinux BTF, and then
parse it and apply them synchronously, in the context of whoever needs
it.  Nothing waits for user space, so there is no "not available yet"
state and no syscall retry: every caller of bpf_get_btf_vmlinux() gets
the BTF or an error, as today, and verification results do not depend
on whether the vmlinux BTF has been parsed before.

bpf_get_btf_vmlinux() already parses on first use under
btf_vmlinux_lock.  With the option, the task that parses it then, still
under the lock and before publishing btf_vmlinux, replays the queued
registrations in order through the unmodified register functions
(btf_apply_deferred()).  Meanwhile bpf_get_btf_vmlinux() returns the new
BTF to that task (btf_vmlinux_builder == current, in task context), so
the replayed registrations, and the ones they make in turn (a
struct_ops ->init() may register kfuncs), apply directly.  Nobody else
sees btf_vmlinux before its kfuncs and struct_ops are in.  The vmlinux
BTF gets its id while it is parsed, before that, so BPF_BTF_GET_FD_BY_ID
parses or waits for the parse first, and so does BPF_BTF_GET_NEXT_ID
for a caller with CAP_SYS_ADMIN (checked without audit, the command
checks it again), since kernel BTFs only have ids once parsed.

The first use can run out of memory, also only because its task is
being killed: vmalloc() gives up then.  A round that fails with
-ENOMEM, in the parse or in a replayed registration, is not published:
the new BTF is dropped with whatever was applied to it, the queue stays
as it is, and the next caller starts over (a struct_ops ->init() then
runs again with the new BTF; the in-tree ones only look types up or
store the BTF pointer, which nothing can use before the BTF is
published).  Other errors of a replayed
registration are only logged, as they would be at boot.  If the vmlinux
BTF fails for good, the queue is dropped with a warning.  As any call
may now be the one that parses, bpf_get_btf_vmlinux() calls
might_sleep() with the option.

btf_defer_reg() queues a registration while the vmlinux BTF is not
parsed, with a copy of a kfunc set or dtor array, which callers may
build on the stack.  Only registrations that need the vmlinux BTF wait:
built-in ones and those of modules with BTF.  A module without BTF
registers nothing but a warning today, and the module notifier that
drops a going module's entries does not see it, so its registrations
are not queued.  A queued entry is applied only if a reference on its
owner can be taken: delete_module() runs the module's exit() before the
GOING notifier that drops its entries, and a registration must not run
after, or concurrently with, that exit().  The replayed registrations
run with the locks of whoever needs the BTF first: they must not load
modules or take locks that users of the BTF hold, which the in-tree
ones do not.

The BTF of modules is still parsed when they load, which needs the
vmlinux BTF, so on its own this patch saves the parse at boot only for
kernels whose boot loads no module with BTF; the next patch defers
module BTF too.

Errors of queued registrations are reported with pr_warn() when they
are applied, not to the initcall or module init that made them.

Co-developed-by: Ihor Solodrai <ihor.solodrai@linux.dev>
TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 kernel/bpf/btf.c     | 224 +++++++++++++++++++++++++++++++++++++++++--
 kernel/bpf/syscall.c |   4 +
 2 files changed, 222 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a7bb780743fb..a5b1cd63a1e4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6930,17 +6930,54 @@ struct btf *btf_parse_vmlinux(void)
 }
 
 static DEFINE_MUTEX(btf_vmlinux_lock);
+/* CONFIG_DEBUG_INFO_BTF_LAZY: the task applying deferred work, and its BTF */
+static struct task_struct *btf_vmlinux_builder;
+static struct btf *btf_vmlinux_new;
+static int btf_apply_deferred(void);
+static void btf_drop_all_deferred(int err);
+
+static bool btf_vmlinux_building(void)
+{
+	return in_task() && READ_ONCE(btf_vmlinux_builder) == current;
+}
 
 struct btf *bpf_get_btf_vmlinux(void)
 {
 	/* Pairs with the smp_store_release() on the parse path below. */
 	struct btf *btf = smp_load_acquire(&btf_vmlinux);
 
-	if (!btf && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
-		mutex_lock(&btf_vmlinux_lock);
-		btf = btf_vmlinux;
-		if (!btf) {
-			btf = btf_parse_vmlinux();
+	/* with CONFIG_DEBUG_INFO_BTF_LAZY any call may be the one that parses */
+	if (IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY))
+		might_sleep();
+	if (btf || !IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
+		return btf;
+	/* the registrations btf_apply_deferred() applies see the new BTF */
+	if (btf_vmlinux_building())
+		return btf_vmlinux_new;
+
+	mutex_lock(&btf_vmlinux_lock);
+	btf = btf_vmlinux;
+	if (!btf) {
+		btf = btf_parse_vmlinux();
+		if (IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY) && !IS_ERR(btf)) {
+			int err;
+
+			btf_vmlinux_new = btf;
+			WRITE_ONCE(btf_vmlinux_builder, current);
+			err = btf_apply_deferred();
+			WRITE_ONCE(btf_vmlinux_builder, NULL);
+			btf_vmlinux_new = NULL;
+			if (err) {
+				/* nothing saw it: drop it with what was applied to it */
+				bpf_ctx_convert.t = NULL;
+				btf_put(btf);
+				btf = ERR_PTR(err);
+			}
+		}
+		/* a lazy parse that ran out of memory is retried by the next caller */
+		if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY) || btf != ERR_PTR(-ENOMEM)) {
+			if (IS_ERR(btf))
+				btf_drop_all_deferred(PTR_ERR(btf));
 			/*
 			 * Order the parsed BTF contents and the globals the
 			 * parse populated (e.g. bpf_ctx_convert.t) before
@@ -6949,8 +6986,8 @@ struct btf *bpf_get_btf_vmlinux(void)
 			 */
 			smp_store_release(&btf_vmlinux, btf);
 		}
-		mutex_unlock(&btf_vmlinux_lock);
 	}
+	mutex_unlock(&btf_vmlinux_lock);
 	return btf;
 }
 
@@ -9302,6 +9339,10 @@ int btf_get_fd_by_id(u32 id)
 	struct btf *btf;
 	int fd;
 
+	/* kernel BTFs get their ids while parsed, before they are published */
+	if (IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY))
+		bpf_get_btf_vmlinux();
+
 	rcu_read_lock();
 	btf = idr_find(&btf_idr, id);
 	if (!btf || !refcount_inc_not_zero(&btf->refcnt))
@@ -9352,6 +9393,7 @@ static LIST_HEAD(btf_modules);
 static DEFINE_MUTEX(btf_module_mutex);
 
 static void purge_cand_cache(struct btf *btf);
+static void btf_drop_deferred_regs(struct module *owner);
 
 #if IS_MODULE(CONFIG_DEBUG_INFO_BTF_INLINE)
 extern char __start_BTF_inline_link[];
@@ -9573,6 +9615,7 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 	case MODULE_STATE_GOING:
 		if (!mod->btf_data_size)
 			break;
+		btf_drop_deferred_regs(module);
 		mutex_lock(&btf_module_mutex);
 		list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
 			if (btf_mod->module != module)
@@ -10170,12 +10213,88 @@ u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 	return btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_FMODRET, kfunc_btf_id);
 }
 
+enum btf_deferred_kind { BTF_DEFER_KFUNCS, BTF_DEFER_DTORS, BTF_DEFER_ST_OPS };
+
+/* CONFIG_DEBUG_INFO_BTF_LAZY: a registration made before the vmlinux BTF is parsed */
+struct btf_deferred_reg {
+	struct list_head list;
+	struct module *owner;
+	enum btf_deferred_kind kind;
+	enum btf_kfunc_hook hook;
+	void *data;
+	u32 cnt;
+};
+
+/* protected by btf_vmlinux_lock */
+static LIST_HEAD(btf_deferred_regs);
+
+/*
+ * Does a registration by @owner need the vmlinux BTF?  Without module BTF a
+ * module's registrations do nothing but warn (check_btf_kconfigs()), and
+ * btf_module_notify(), which drops a going module's queued entries, does not
+ * see such a module.
+ */
+static bool btf_reg_needs_vmlinux(const struct module *owner)
+{
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	return !owner || owner->btf_data_size;
+#else
+	return !owner;
+#endif
+}
+
+/*
+ * Initcalls and modules loaded early register kfuncs, dtor kfuncs and
+ * struct_ops before anything needs the vmlinux BTF.  Queue these until it
+ * is parsed (btf_apply_deferred()).  Returns true if the registration was
+ * queued, with *err set to 0 or -ENOMEM.
+ */
+static bool btf_defer_reg(struct module *owner, enum btf_deferred_kind kind,
+			  enum btf_kfunc_hook hook, const void *data, u32 cnt, int *err)
+{
+	struct btf_deferred_reg *reg;
+
+	if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY) || bpf_peek_btf_vmlinux() ||
+	    btf_vmlinux_building() || !btf_reg_needs_vmlinux(owner))
+		return false;
+	guard(mutex)(&btf_vmlinux_lock);
+	if (btf_vmlinux)
+		return false;
+
+	*err = -ENOMEM;
+	reg = kzalloc_obj(*reg);
+	if (!reg)
+		return true;
+	/* callers may build kfunc sets and dtor arrays on the stack */
+	if (kind == BTF_DEFER_KFUNCS)
+		reg->data = kmemdup(data, sizeof(struct btf_kfunc_id_set), GFP_KERNEL);
+	else if (kind == BTF_DEFER_DTORS)
+		reg->data = kmemdup_array(data, cnt, sizeof(struct btf_id_dtor_kfunc),
+					  GFP_KERNEL);
+	else
+		reg->data = (void *)data;
+	if (!reg->data) {
+		kfree(reg);
+		return true;
+	}
+	reg->owner = owner;
+	reg->kind = kind;
+	reg->hook = hook;
+	reg->cnt = cnt;
+	list_add_tail(&reg->list, &btf_deferred_regs);
+	*err = 0;
+	return true;
+}
+
 static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 				       const struct btf_kfunc_id_set *kset)
 {
 	struct btf *btf;
 	int ret, i;
 
+	if (btf_defer_reg(kset->owner, BTF_DEFER_KFUNCS, hook, kset, 0, &ret))
+		return ret;
+
 	btf = btf_get_module_btf(kset->owner);
 	if (!btf)
 		return check_btf_kconfigs(kset->owner, "kfunc");
@@ -10292,6 +10411,9 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
 	u32 tab_cnt, i;
 	int ret;
 
+	if (btf_defer_reg(owner, BTF_DEFER_DTORS, 0, dtors, add_cnt, &ret))
+		return ret;
+
 	btf = btf_get_module_btf(owner);
 	if (!btf)
 		return check_btf_kconfigs(owner, "dtor kfuncs");
@@ -11009,6 +11131,9 @@ int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
 	struct btf *btf;
 	int err = 0;
 
+	if (btf_defer_reg(st_ops->owner, BTF_DEFER_ST_OPS, 0, st_ops, 0, &err))
+		return err;
+
 	btf = btf_get_module_btf(st_ops->owner);
 	if (!btf)
 		return check_btf_kconfigs(st_ops->owner, "struct_ops");
@@ -11034,6 +11159,93 @@ int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
 EXPORT_SYMBOL_GPL(__register_bpf_struct_ops);
 #endif
 
+static void btf_free_deferred_reg(struct btf_deferred_reg *reg)
+{
+	list_del(&reg->list);
+	if (reg->kind != BTF_DEFER_ST_OPS)
+		kfree(reg->data);
+	kfree(reg);
+}
+
+/*
+ * Called under btf_vmlinux_lock, by the task that parsed the vmlinux BTF and
+ * before it publishes it, so that nothing sees the BTF without its kfuncs
+ * and struct_ops.  bpf_get_btf_vmlinux() returns the new BTF to
+ * this task, so the registrations are applied as if they were made now, and
+ * any they make in turn (a struct_ops ->init() may register kfuncs) too.
+ * They run in whichever task needs the BTF first, with the locks it holds:
+ * they must not load modules or take locks that users of the BTF hold.
+ *
+ * Returns -ENOMEM if memory ran out, which may be only because that task is
+ * being killed: the caller then drops the new BTF with whatever was applied
+ * to it, and the next caller starts over with the queue intact, as for the
+ * vmlinux BTF itself; a struct_ops ->init() then runs again with the BTF of
+ * that round.  Any other error of a registration is only logged.
+ */
+static int btf_apply_deferred(void)
+{
+	struct btf_deferred_reg *reg, *tmp;
+	int err;
+
+	list_for_each_entry(reg, &btf_deferred_regs, list) {
+		/* a going module's exit() runs before GOING drops its entries */
+		if (!try_module_get(reg->owner))
+			continue;
+		err = 0;
+		switch (reg->kind) {
+		case BTF_DEFER_KFUNCS:
+			err = __register_btf_kfunc_id_set(reg->hook, reg->data);
+			break;
+		case BTF_DEFER_DTORS:
+			err = register_btf_id_dtor_kfuncs(reg->data, reg->cnt, reg->owner);
+			break;
+		case BTF_DEFER_ST_OPS:
+#if defined(CONFIG_BPF_JIT)
+			err = __register_bpf_struct_ops(reg->data);
+#endif
+			break;
+		}
+		module_put(reg->owner);
+		if (err == -ENOMEM)
+			return err;
+		if (err)
+			pr_warn("failed to apply deferred BTF registration for %s: %d\n",
+				reg->owner ? reg->owner->name : "vmlinux", err);
+	}
+	list_for_each_entry_safe(reg, tmp, &btf_deferred_regs, list)
+		btf_free_deferred_reg(reg);
+	return 0;
+}
+
+/* The vmlinux BTF failed for good: nothing will apply what is queued */
+static void btf_drop_all_deferred(int err)
+{
+	struct btf_deferred_reg *reg, *tmp;
+	int cnt = 0;
+
+	list_for_each_entry_safe(reg, tmp, &btf_deferred_regs, list) {
+		btf_free_deferred_reg(reg);
+		cnt++;
+	}
+	if (cnt)
+		pr_warn("vmlinux BTF unavailable (%d), dropped %d deferred BTF registrations\n",
+			err, cnt);
+}
+
+/* @owner is going away: drop the registrations it queued */
+static void __maybe_unused btf_drop_deferred_regs(struct module *owner)
+{
+	struct btf_deferred_reg *reg, *tmp;
+
+	if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY))
+		return;
+	guard(mutex)(&btf_vmlinux_lock);
+	list_for_each_entry_safe(reg, tmp, &btf_deferred_regs, list) {
+		if (reg->owner == owner)
+			btf_free_deferred_reg(reg);
+	}
+}
+
 bool btf_param_match_suffix(const struct btf *btf,
 			    const struct btf_param *arg,
 			    const char *suffix)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9273b7dee0aa..79e65cfc4267 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6519,6 +6519,10 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
 					  &map_idr, &map_idr_lock);
 		break;
 	case BPF_BTF_GET_NEXT_ID:
+		/* kernel BTFs have ids once parsed (CONFIG_DEBUG_INFO_BTF_LAZY) */
+		if (IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY) &&
+		    ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN))
+			bpf_get_btf_vmlinux();
 		err = bpf_obj_get_next_id(&attr, uattr.user,
 					  &btf_idr, &btf_idr_lock);
 		break;
-- 
2.47.3

