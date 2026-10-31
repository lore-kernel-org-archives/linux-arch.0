Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.155.198.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793452372;
	b=L81RQxUgC/XRen0l9J9U/tpTec8xHMTN5Z0iDhW8kbAMGTUPg75tJe/698zWq9dm5IpI
	 04F2h2GUrs6DhzeThXEj+/Cl7EAowfpsHwnmLfjd2b9WW3uyAljdEZ2e0mqICnyzlW8Ta
	 BhjDn9WijZrkcpdCiC/LcAz+nGPM5ZbeynqtsG9wMgWR+/mdCx4teQ3oXTb+UefZlKhHm
	 kx+COK2TjKNDkQXytjqdfMmz8hOsz3L8WpUAIAsWTKyWl1/Sf7PAH/AIeB/x7unRfNJEn
	 uRTNxdJf89MsmeNWkuihppeX86Dh+l/LF5Pzbd4JLZn+VfijR/Mzp01pHargoueJpJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793452372;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=wjNkxACp2a55HF+/zxIAXoKGkbOib07rnlWdrsCGq54=;
	b=0pv8KTpzy18Sza7QdlJt265C5GWzWu1xE8FBlDGnVQ5XQR1pBZuvWZ1Euyr15R0aau76
	 N3L+hmu8KH8y6LhmBuh2L/wrIeF2/h96C8w/AGwocMshFPgC75vu/BZa00GRskfHomjU1
	 XLioBq6qgcunh+XsYT3d9/e3RjoUftnkv2Krif9vsWcbhBWHnch6NX5T8x6FKEYIXEILJ
	 RfT0zszZCjk5Vd/2C8qQ0PjHzfIyqZC1BRJA0rQbU+SNGP1LdQFmflmeo6cbo7z1i1u3I
	 JC+8ZXccvVTb36M/O+JDPRnD1hsSJ7nsegQ/SPq/6ohpwn0mQtuy5ABjOHBfzZUH2lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=m3P1UWed;
	arc=none smtp.remote-ip=35.155.198.111
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8057E606A31A;
	Sat, 31 Oct 2026 13:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8057E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=m3P1UWed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793452371; x=1824988371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wjNkxACp2a55HF+/zxIAXoKGkbOib07rnlWdrsCGq54=;
  b=m3P1UWedO//ttmvZ0lQmEj1n6LtJbSp2aZieVslUD6nSfsTk5azj9M/t
   xqCqPQxlnQUOjX/wYVrEldMh6TXDrlKaL2KVqdRwAkokjPBv2IZOyfOMr
   /v7tEbBj0n0bAdy0oBb5zRI+3z9TW32D1BFhNo16ueMqHPcj1OU1Ivtfc
   CRMIH3oA3zjkSc5eaKAtrBCbxonia5lG47vA1DayhQEVyQs0HEAoJS8q+
   T0MaPJEuVebfQnZ9yCV+JfIC0kpYbIWKKaAuNaCwic8vzxhU8PcbKSuv9
   1Nsk297x6k88yAqppueSjVm91fHQmivrRBE1lyVNOky+MhbHsf6jyFOsG
   w==;
X-CSE-ConnectionGUID: tDUIfL2aTlSgIwF9otuJsg==
X-CSE-MsgGUID: 0FwhQOD9QsSFjrWMKSltQw==
X-IronPort-AV: E=Sophos;i="6.27,188,1787011200"; 
   d="scan'208";a="32650488"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 13:12:51 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:26879]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.48:2525] with esmtp (Farcaster)
 id 19864c13-4a2b-4a0d-a697-5ff34512fca6; Sat, 31 Oct 2026 13:12:50 +0000 (UTC)
X-Farcaster-Flow-ID: 19864c13-4a2b-4a0d-a697-5ff34512fca6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:12:50 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:12:50 +0000
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
Subject: [PATCH bpf-next 11/13] bpf: keep module BTF until the vmlinux BTF is parsed
Date: Sat, 31 Oct 2026 13:09:57 +0000
Message-ID: <20261031130959.23472-12-wanjay@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Module BTF is split BTF on top of the vmlinux BTF, so every module with
BTF that loads parses the vmlinux BTF, and a system that loads any such
module at boot still pays for it there.  With
CONFIG_DEBUG_INFO_BTF_LAZY, keep a module's BTF unparsed until the
vmlinux BTF is parsed, and parse it then, together with the vmlinux BTF.

A module that loads before the vmlinux BTF is parsed keeps its copies
of .BTF and .BTF.inline unparsed (btf == NULL) and gets
/sys/kernel/btf/<module> and <module>.inline created from them right
away, before the entry is visible to the parse.  In-tree module BTF and
its inline BTF need no relocation, so the files serve the same bytes
before and after.  The task that parses the vmlinux BTF parses the kept
module BTFs first, oldest first so that BTF ids follow the module load
order, under btf_vmlinux_lock and before the queued registrations are
applied, so that a module's registrations find its BTF.  Modules with
distilled base BTF (.BTF.base) need relocation against the vmlinux BTF
and are parsed at load, which parses the vmlinux BTF.  Deferring them
too is left for later, to keep this series small (see the TODO in
btf_module_keep()): their BTF is not usable before the relocation, so
their sysfs files would have to wait for the first use as well.

Walkers of btf_modules skip entries without BTF, and
btf_get_module_btf() parses the vmlinux BTF first, except for a module
without BTF, which has nothing to find.  A module that goes away before
the parse just frees its kept copies.

A kept module BTF that fails validation later cannot be refused any
more: the module stays loaded without BTF, logged, and its files go
away, as with CONFIG_MODULE_ALLOW_BTF_MISMATCH, where the module load
fails today without that option.  An inline BTF that fails validation
loses its file, as today.  A kept module BTF that runs out of memory
fails the whole round, which the previous patch then retries, with the
module BTFs parsed in it freed again.

All kept module BTFs are parsed before any queued registration is
applied, so btf_check_kfunc_name() now also sees the BTF of modules
loaded after the one registering: a kfunc whose name such a module
defines as a function is refused, where today only the later module's
own registration of it would be.

The Kconfig help now describes what still parses the BTF at boot and
what changes with the option.

Co-developed-by: Ihor Solodrai <ihor.solodrai@linux.dev>
TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 kernel/bpf/btf.c  | 204 +++++++++++++++++++++++++++++++++++++++-------
 lib/Kconfig.debug |   8 ++
 2 files changed, 184 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a5b1cd63a1e4..631f5a32ec17 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9382,10 +9382,13 @@ enum {
 struct btf_module {
 	struct list_head list;
 	struct module *module;
-	struct btf *btf;
+	struct btf *btf;	/* NULL while kept, see btf_module_keep() */
+	void *data;		/* kept copy of .BTF, adopted by btf once parsed */
+	u32 data_size;
 	struct bin_attribute *sysfs_attr;
 	struct bin_attribute *sysfs_inline_attr;
 	void *btf_inline_data;
+	u32 btf_inline_data_size;
 	int flags;
 };
 
@@ -9395,6 +9398,149 @@ static DEFINE_MUTEX(btf_module_mutex);
 static void purge_cand_cache(struct btf *btf);
 static void btf_drop_deferred_regs(struct module *owner);
 
+/* /sys/kernel/btf/<module> and <module>.inline */
+static void btf_module_add_files(struct btf_module *btf_mod, const char *name,
+				 void *data, u32 data_size)
+{
+	char inline_name[MODULE_NAME_LEN + sizeof(".inline")];
+	struct bin_attribute *attr;
+
+	attr = sysfs_btf_add(name, data, data_size, false, NULL);
+	if (IS_ERR(attr))
+		return;
+	btf_mod->sysfs_attr = attr;
+
+	if (!btf_mod->btf_inline_data)
+		return;
+	snprintf(inline_name, sizeof(inline_name), "%s.inline", name);
+	attr = sysfs_btf_add(inline_name, btf_mod->btf_inline_data,
+			     btf_mod->btf_inline_data_size, false, NULL);
+	if (IS_ERR(attr)) {
+		kvfree(btf_mod->btf_inline_data);
+		btf_mod->btf_inline_data = NULL;
+		return;
+	}
+	btf_mod->sysfs_inline_attr = attr;
+}
+
+/*
+ * CONFIG_DEBUG_INFO_BTF_LAZY: module BTF is split BTF on top of the vmlinux
+ * BTF.  Until that is parsed, keep the module's copies of its BTF and inline
+ * BTF as they are, serve them in sysfs, and let btf_parse_kept_modules()
+ * parse them with the vmlinux BTF.  Distilled base BTF (.BTF.base) needs
+ * relocation, which needs the vmlinux BTF, so it is parsed right away.
+ *
+ * TODO: defer modules with distilled base BTF as well: keep them here and
+ * relocate them in btf_parse_kept_modules().  Their raw BTF is not usable
+ * before that, so their sysfs files would have to wait for the first use.
+ */
+static bool btf_module_keep(struct btf_module *btf_mod, struct module *mod,
+			    void *data, void *inline_data, u32 inline_data_size)
+{
+	if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY) || mod->btf_base_data)
+		return false;
+	guard(mutex)(&btf_vmlinux_lock);
+	if (btf_vmlinux)
+		return false;
+	btf_mod->module = mod;
+	btf_mod->data = data;
+	btf_mod->data_size = mod->btf_data_size;
+	btf_mod->btf_inline_data = inline_data;
+	btf_mod->btf_inline_data_size = inline_data ? inline_data_size : 0;
+	/* before btf_parse_kept_modules() can see the entry */
+	btf_module_add_files(btf_mod, mod->name, data, mod->btf_data_size);
+	mutex_lock(&btf_module_mutex);
+	list_add(&btf_mod->list, &btf_modules);
+	mutex_unlock(&btf_module_mutex);
+	return true;
+}
+
+/* A kept module without BTF: no entry and no files, as if refused at load */
+static void btf_module_drop_kept(struct btf_module *btf_mod)
+{
+	list_del(&btf_mod->list);
+	if (btf_mod->sysfs_attr)
+		sysfs_btf_remove(btf_mod->sysfs_attr);
+	if (btf_mod->sysfs_inline_attr)
+		sysfs_btf_remove(btf_mod->sysfs_inline_attr);
+	kvfree(btf_mod->btf_inline_data);
+	kvfree(btf_mod->data);
+	kfree(btf_mod);
+}
+
+/* Undo btf_parse_kept_modules() of a round that is not published */
+static void btf_unparse_kept_modules(void)
+{
+	struct btf_module *btf_mod;
+
+	lockdep_assert_held(&btf_module_mutex);
+	list_for_each_entry(btf_mod, &btf_modules, list) {
+		if (!btf_mod->data || !btf_mod->btf)
+			continue;
+		btf_mod->btf->data = NULL;	/* the kept copy */
+		btf_put(btf_mod->btf);
+		btf_mod->btf = NULL;
+	}
+}
+
+/*
+ * Called under btf_vmlinux_lock by the task that parses the vmlinux BTF,
+ * before that is published.  Parses the kept module BTFs in place, oldest
+ * first so that ids follow the load order as without
+ * CONFIG_DEBUG_INFO_BTF_LAZY; in-tree module BTF and its inline BTF need no
+ * relocation, so sysfs serves the same bytes before and after.  A module
+ * whose BTF fails validation cannot be refused any more: it stays loaded
+ * without BTF, and its files go away; an invalid inline BTF loses its file.
+ * Returns -ENOMEM, with this round's module BTFs freed again, if memory ran
+ * out.
+ */
+static int btf_parse_kept_modules(void)
+{
+	struct btf_module *btf_mod, *tmp;
+	void *inline_data;
+	struct btf *btf;
+	int err;
+
+	lockdep_assert_held(&btf_vmlinux_lock);
+	guard(mutex)(&btf_module_mutex);
+	list_for_each_entry_safe_reverse(btf_mod, tmp, &btf_modules, list) {
+		if (btf_mod->btf || !btf_mod->data)
+			continue;
+		btf = btf_parse_module(btf_mod->module->name, btf_mod->data,
+				       btf_mod->data_size, NULL, 0,
+				       btf_mod->btf_inline_data,
+				       btf_mod->btf_inline_data_size, &inline_data);
+		if (!IS_ERR(btf)) {
+			err = btf_alloc_id(btf);
+			if (err) {
+				btf->data = NULL;	/* the kept copy */
+				btf_free(btf);
+				btf = ERR_PTR(err);
+			}
+		}
+		if (btf == ERR_PTR(-ENOMEM)) {
+			btf_unparse_kept_modules();
+			return -ENOMEM;
+		}
+		if (IS_ERR(btf)) {
+			pr_warn("failed to validate module [%s] BTF: %ld\n",
+				btf_mod->module->name, PTR_ERR(btf));
+			btf_module_drop_kept(btf_mod);
+			continue;
+		}
+		btf_mod->btf = btf;
+		if (btf_mod->btf_inline_data && !inline_data) {
+			if (btf_mod->sysfs_inline_attr)
+				sysfs_btf_remove(btf_mod->sysfs_inline_attr);
+			btf_mod->sysfs_inline_attr = NULL;
+			kvfree(btf_mod->btf_inline_data);
+			btf_mod->btf_inline_data = NULL;
+			btf_mod->btf_inline_data_size = 0;
+		}
+	}
+	return 0;
+}
+
 #if IS_MODULE(CONFIG_DEBUG_INFO_BTF_INLINE)
 extern char __start_BTF_inline_link[];
 extern char __stop_BTF_inline_link[];
@@ -9504,7 +9650,6 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 {
 	struct btf_module *btf_mod, *tmp;
 	struct module *mod = module;
-	struct bin_attribute *attr;
 	struct btf *btf;
 	void *data, *inline_data = NULL, *relocated_inline_data = NULL;
 	unsigned int inline_data_size = 0;
@@ -9542,6 +9687,9 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 				pr_warn("failed to validate module [%s] inline BTF: %d\n",
 					mod->name, -ENOMEM);
 		}
+		if (data && btf_module_keep(btf_mod, mod, data, inline_data,
+					    inline_data_size))
+			break;
 		btf = !data ? ERR_PTR(-ENOMEM) :
 		      btf_parse_module(mod->name, data, mod->btf_data_size,
 				       mod->btf_base_data, mod->btf_base_data_size,
@@ -9574,30 +9722,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		btf_mod->module = module;
 		btf_mod->btf = btf;
 		btf_mod->btf_inline_data = relocated_inline_data;
+		btf_mod->btf_inline_data_size = relocated_inline_data ? inline_data_size : 0;
 		list_add(&btf_mod->list, &btf_modules);
 		mutex_unlock(&btf_module_mutex);
 
-		attr = sysfs_btf_add(btf->name, btf->data, btf->data_size, false, NULL);
-		if (IS_ERR(attr)) {
-			err = 0;
-			goto out;
-		}
-		btf_mod->sysfs_attr = attr;
-
-		if (relocated_inline_data) {
-			char name[MODULE_NAME_LEN + sizeof(".inline")];
-
-			snprintf(name, sizeof(name), "%s.inline", mod->name);
-			attr = sysfs_btf_add(name, relocated_inline_data,
-					     inline_data_size, false, NULL);
-			if (IS_ERR(attr)) {
-				kvfree(relocated_inline_data);
-				btf_mod->btf_inline_data = NULL;
-				err = 0;
-				break;
-			}
-			btf_mod->sysfs_inline_attr = attr;
-		}
+		/* data: the same as btf->data */
+		btf_module_add_files(btf_mod, mod->name, data, mod->btf_data_size);
 		break;
 	case MODULE_STATE_LIVE:
 		if (!mod->btf_data_size)
@@ -9621,6 +9751,11 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 			if (btf_mod->module != module)
 				continue;
 
+			if (!btf_mod->btf) {	/* kept, see btf_module_keep() */
+				btf_module_drop_kept(btf_mod);
+				break;
+			}
+
 			/*
 			 * For modules, we do the freeing of BTF IDR as soon as
 			 * module goes away to disable BTF discovery, since the
@@ -9705,9 +9840,12 @@ struct btf *btf_get_module_btf(const struct module *module)
 	}
 
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	/* kept module BTF is parsed together with the vmlinux BTF */
+	if (!module->btf_data_size || IS_ERR_OR_NULL(bpf_get_btf_vmlinux()))
+		return NULL;
 	mutex_lock(&btf_module_mutex);
 	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
-		if (btf_mod->module != module)
+		if (btf_mod->module != module || !btf_mod->btf)
 			continue;
 
 		btf_get(btf_mod->btf);
@@ -9888,7 +10026,7 @@ static int btf_check_kfunc_name(struct btf *btf, const char *func_name, u32 kind
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	guard(mutex)(&btf_module_mutex);
 	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
-		if (btf_mod->btf == btf)
+		if (btf_mod->btf == btf || !btf_mod->btf)
 			continue;
 		id = btf_find_by_name_kind(btf_mod->btf, func_name, kind);
 		if (id >= 0) {
@@ -11169,8 +11307,8 @@ static void btf_free_deferred_reg(struct btf_deferred_reg *reg)
 
 /*
  * Called under btf_vmlinux_lock, by the task that parsed the vmlinux BTF and
- * before it publishes it, so that nothing sees the BTF without its kfuncs
- * and struct_ops.  bpf_get_btf_vmlinux() returns the new BTF to
+ * before it publishes it, so that nothing sees the BTF without its module
+ * BTFs, kfuncs and struct_ops.  bpf_get_btf_vmlinux() returns the new BTF to
  * this task, so the registrations are applied as if they were made now, and
  * any they make in turn (a struct_ops ->init() may register kfuncs) too.
  * They run in whichever task needs the BTF first, with the locks it holds:
@@ -11187,6 +11325,11 @@ static int btf_apply_deferred(void)
 	struct btf_deferred_reg *reg, *tmp;
 	int err;
 
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	err = btf_parse_kept_modules();
+	if (err)
+		return err;
+#endif
 	list_for_each_entry(reg, &btf_deferred_regs, list) {
 		/* a going module's exit() runs before GOING drops its entries */
 		if (!try_module_get(reg->owner))
@@ -11206,8 +11349,13 @@ static int btf_apply_deferred(void)
 			break;
 		}
 		module_put(reg->owner);
-		if (err == -ENOMEM)
+		if (err == -ENOMEM) {
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+			guard(mutex)(&btf_module_mutex);
+			btf_unparse_kept_modules();
+#endif
 			return err;
+		}
 		if (err)
 			pr_warn("failed to apply deferred BTF registration for %s: %d\n",
 				reg->owner ? reg->owner->name : "vmlinux", err);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 700c4f67bdd8..45b2bc4d9a9c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -422,6 +422,14 @@ config DEBUG_INFO_BTF_LAZY
 	  milliseconds once.  The vmlinux file keeps the uncompressed BTF as
 	  a non-loaded section for tools.  Building needs the zstd tool.
 
+	  Users of kernel types at boot still parse it at boot: BPF LSM
+	  programs, the iterators of BPF_PRELOAD (loaded at boot, or at the
+	  first bpffs mount if bpf_preload is a module), and modules with
+	  distilled base BTF.  Kernel function and struct_ops registrations
+	  made before the first use are applied then and report errors only
+	  in the kernel log; a module BTF that fails validation then leaves
+	  the module loaded without BTF.
+
 	  If unsure, say N.
 
 config PAHOLE_HAS_BTF_TAG
-- 
2.47.3

