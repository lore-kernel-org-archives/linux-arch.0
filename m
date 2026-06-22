Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020093.outbound.protection.outlook.com [52.101.195.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E69B3B2FC6;
	Mon, 22 Jun 2026 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136989; cv=fail; b=YFo74AYf34hacdqmvxQSgrv2OHNdDo7zpgXVoCCplxvDYS8//a58OmMMAa9SVB+47of4giqHnNkVaTKso18LhkWWxEWlPCgG40T5o4dTvgqSBPGAr57lsn8sl23mkhHYkM+xGp42vdQBHJc74Xd9Ov0gqIm+OTKhA/PDdB/6JWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136989; c=relaxed/simple;
	bh=N9+n1jdT+/c0MAaB9gIBny20eHCqlK0g/efgk7VD5oo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QBy6T6266aPDVEk6/pBLHNadiranhMUbbqq4olY4MbA8xMZbDYcm8vDYcMRgGE/WvQShbvnJsMGjelE+jHqx++xwbNsEWnMdYPj0PvGjcHXo/TU5gdRtP/onSQMX8pyPutZbDO4PpCGMhkto1vhUieb57QtlsDc3BmWymdLAI+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vY3ymSXdOcT2rqZYwEGwUP/kcjeb+joLriljqDVRBPhRC8qfbgnuc+MXesHqQNIyW0wThvmXQTYYzbqIKIRmEH+NesskQROag5spVPZRJNrqZRhWEAsEB57//RPlGfSccmYlq/NZLhObLyDP439a7LI1cVJIRocs0wDNA6PPqGfAOSqeAhhU2plHqueL7qbibG2r7rnblx+53FKt7Nn8yQePXjo1/Cx9NBVbkiXOIo/6u8wiFQJZ0LYUv3UFWzYo0GFrZCWHjclaK54hvr02dgxhatbwEtmO4BLuk6cbtXKRtyTvShBPTyI/g72RwJtsfXQDHFhXa/rnsu/L0FKJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=BgUDj775ybzVbUS5f+NjDxvsoc/Nx5PZ5ycsb2xzxiE=;
 b=XyPzCLRMcVmAqF6EXhCUaktfbqR61hwtbeI+z/IbIFFWvR+KDYIlCpgRs1aIGW4Vq5XNxn4bdLgtZIdc0k1tepWusVmnzAOatb9+L2mprzojKkHbPwPKt/WyD8SwgiFIdPWbrj1aLIBosxG+o/cgeNZ+CDEWlGaxVI0Prhkh2VEPhl0KGjXiDYPcohySlsbH9aGGEFsbX26zRRD1k4bQZ1Cxtxsj0KmYYYgRLEVBke9S3XHNdBvdvmGVWeIyfHWS+qGzV9gBySX1r5lUVNYxFmtm/+UwExIq6f+beLkKun+qcUB9/orf6xmYrY8QmR4Y/p3eGEfTwiNtHLHuyiDOxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6556.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:24a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 14:03:04 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 14:03:03 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	peterz@infradead.org
Cc: mhiramat@kernel.org,
	atomlin@atomlin.com,
	neelx@suse.com,
	da.anzani@gmail.com,
	sean@ashe.io,
	chjohnst@mail.com,
	steve@abita.co,
	mproche@mail.com,
	nick.lane@mail.com,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] module: Extend module_blacklist parameter to built-in modules
Date: Mon, 22 Jun 2026 10:02:59 -0400
Message-ID: <20260622140259.2974-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::35) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 354ead39-6463-447f-ce54-08ded066f9f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|7416014|56012099006|5023799004|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mL167yMFLU2D5CxLKHy46Jw/nIv8J4I/5ulvc8zv2pc+UjpwBk5cH3tiVK0Z2m1bFRU783UqkhCR20Oiu45iUktvte1VRD/uMr2bQ4hTlvAYPJRatc1aDpW4k+im5SnWJqK8mCGA+7htpj7UkyvXOiqYW4Kihmfj20rVU6k2dStCWILhyL0xRg+/I9jqg37Hf8CABl5QKPIxpTX+3Dbe7WjOVjX7rA3gVEO49OK33SpMOO06JR9JfAR9w+7UalGvSynCRD+NKJYcsIsNIg09td+nnaTito9+RX4CFaaNOo7hJ/2CxPk6SL8LLYR3gaIIGujD6w2Rk/l15MzjRUmc4y/mRr6Yu1utz2ivXZIHGHxq/h+K9g+puSQy5jwCnBr6bXpBBAKOEy80xaA9IfC2dlP41qSFV7bPHkndQwdxauPVzPyiEhzaogwvIr+knd4VIt76OiDuWLnXZ7jDSV0TgFL3F1corfId/9vzklpwRoQ/Man9vvr6t627dQxTvDWgWOS08istyVslv3JFfYw5thxtSrSLPIwSh9r0EbaDjMxMNQGfi0Y4y0+KJriDP7yCDsbGZDqF6yeO9et8YQgMTNza84jBWdbI3wJDfPqYgzIe18faELv1fjtX4Clw3JGg+cULVcL+AW2wxJc5HQmyaddeyQxqYNU4w7o0uCMWsXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(7416014)(56012099006)(5023799004)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RcrrMYlBDZnffsqFWiNci8NcxcJBSe4PHMXdTFgDU4FxAUr4OOCPDMHmgFGS?=
 =?us-ascii?Q?iuCN8UAvnj6OpZsEUHnh/KEtYEyOJzSiOadquHT47s16P0/djC0sA6xN7vuz?=
 =?us-ascii?Q?FiDIK9TID/Gl6L6/OK0NW84gF5maByCcRWwHuCnO2+2LRGQ510m/rIVl4t1b?=
 =?us-ascii?Q?cVi+k8kVeE17JWRv2v2xS7MhFO3gOE3nrCjh+3BUPy8i2EwnK0C3s3yQFd3N?=
 =?us-ascii?Q?SaBZ714b+zB2VMBKBtC5rQzejXmLeAWYvsMe9CRdpIKTPRJt6n4qkyEkp8Ed?=
 =?us-ascii?Q?5nrIW7r44D7yDs2QeWUjWxKAJhZs57WVXI8dc/j/QiuhFBHwRZw/V1pw7F9U?=
 =?us-ascii?Q?ywn8ktzQbfCwcxQB72BzcNGmcesdEwPOLmfexh4Nxw8/SjzuYNCwcwQcwNQw?=
 =?us-ascii?Q?vtWK20MBK+oYUbx8YiKMfblGffJoYfu69iuDghfnP76gY8W4J0oTqi8VhN+l?=
 =?us-ascii?Q?JyskRwfZLmGcRhPmkVnJqt9AIi95SbVBO6IsbHm6tNXqF4WkSM3SKdWa+uAH?=
 =?us-ascii?Q?tY8YpqzMqtzZMFe4IJzgZEL6zxMv+XK2XGeHbgVmjbl0MUjoU+qP/QPoaf9J?=
 =?us-ascii?Q?/Qkn3plgp2FtPBDhQ18/1bmA1G3TWBkYJ0DflNTEje2hz15S2KyfyQl0M1s6?=
 =?us-ascii?Q?GTlC4Tg52E1COKddUwdu5VdDn3lOYUkNdU9nGk7JsvFekmNG+u3AHQ9MeATM?=
 =?us-ascii?Q?7zQ5cWB0KDGGk11WhcpEkV/j0V4UMvaRtyp/4v9kEfKZDQvzIj4zBi7YhiCj?=
 =?us-ascii?Q?MGh8ktpmX+gCctlOlTgW24/ayRZEzY0IXWZ4C0NI4Akf2INDtywbB5JsQhUs?=
 =?us-ascii?Q?2sRKByq0W7GsPOSZ9uWhvnxw1M6WZBgEpxmzm/ONtjHvO6JjCFV/4zOsz7Qd?=
 =?us-ascii?Q?rGQht/D2Q/9CknMEDAFatdmduF5l8pNqA3rrDlECzsjzSohPsF5jIjjC27Ph?=
 =?us-ascii?Q?gleJxyZvjb/JXX01Y53YWfyi53hCW+K+ZfFR0hvfmYVoFa/ykBk2//A0aUAe?=
 =?us-ascii?Q?NVN9A8uhP1yIb22X9saMPJaJpRhKXXxpISJeMgaKMKuflbOICFK+hpvIle96?=
 =?us-ascii?Q?+zDr0himGehGfrowyjUJNPVmsYPqEnVUzKt6gmPEL2eJuZOH+0lNqzlHKzW2?=
 =?us-ascii?Q?gKyEyhP5qoE1wrS/0eGGqIXP+D/wAdp2Bss8GQfjmu4NFI0ho5mp/GJ3pn0I?=
 =?us-ascii?Q?rFwRlWPXn11MVbuv5N30teFVjQmjxxCDeQrlw7xdNWmpQ7aWkToj6D2AwVpP?=
 =?us-ascii?Q?kvF6z775vpdHXkVvRb9Lzq63tZY9+LvO4ASpM+GkC74IO2V6sMIwoXnqxmtc?=
 =?us-ascii?Q?1rtr5s5B8sNSJ1ankEFIRgzSMgVBnFo2ciU/UDlsmT9akZWT3Ccx3yrJTFC2?=
 =?us-ascii?Q?AmnB+MeMb++e6o+NBTREGpUktjeUkingnW8nRCUtPvRbhp6i3SG+4/kJXOaV?=
 =?us-ascii?Q?HTyvScfHn7eORbKGOwn5wDCxBE6dVEwC+JamvbAq7fzrQj6ZvOMecz9LWZUB?=
 =?us-ascii?Q?Zi0s7ZaQTbRVPq3YrN+5dgEqJeYNBttlhl1qjSHDienAxYILzUNyt9YM82GL?=
 =?us-ascii?Q?Ss0lJ6qBDG/vjpUB37rBtbJE2lhZBVDVNBA/TrU9UuS9iiTfWfTsP2HR0OrM?=
 =?us-ascii?Q?OoAdV7i6rQy9KG+DnrbzpWkHI9s7PNS1RhxdR4kEZaYCveX3AIjlzjD+U/pQ?=
 =?us-ascii?Q?zu/2oag6qX2nWzr1vMmdXiMWoHkRube2BTHjwDzOXgjUAN08dZTzJv/UfZuQ?=
 =?us-ascii?Q?3pxA7d1z0w=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354ead39-6463-447f-ce54-08ded066f9f0
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 14:03:03.4708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgNVYmvTF888HZ71975i29/aXicecGCDeCHlfuEBFVfGaHShlpC8+1H43jlZeQ8QHgzF3kFEtqsfI+oFYL1DEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6556

Currently, the module_blacklist= parameter only prevents
the dynamic loading of external modules. It possesses no mechanism to
intercept or prevent the initialisation of built-in modules, as their
associated initcalls are invoked unconditionally during system boot.

This patch extends the blacklisting behaviour to encompass built-in
modules. It introduces a dedicated ".initcall.modnames" section into
the linker script, systematically mapping each initcall to its
originating module name. During the boot sequence, do_one_initcall()
interrogates this mapping; should the executing initcall belong to a
blacklisted module, its execution is explicitly bypassed.

Furthermore, to preserve the efficacy of Kernel Address Space Layout
Randomisation (KASLR) and prevent binary bloat, the mapping mechanism
rigorously adheres to CONFIG_HAVE_ARCH_PREL32_RELOCATIONS. Rather than
storing absolute function pointers, it employs 32-bit relative offsets,
successfully avoiding the generation of thousands of absolute
relocations.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
--
Changes since v1:

 - Pivoted entirely from exposing built-in initcalls and their blacklist
   status via a debugfs interface to directly extending the existing
   "module_blacklist=" to intercept built-in modules at boot (Petr Pavlu)

 - Implemented 32-bit relative offsets (CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)
   to store the mappings, preventing binary bloat and preserving KASLR
   efficacy

 - Linked to v1: https://lore.kernel.org/lkml/20260510061301.41341-1-atomlin@atomlin.com/
---
 include/asm-generic/vmlinux.lds.h |  7 +++++++
 include/linux/init.h              | 31 +++++++++++++++++++++++++++++--
 include/linux/module.h            |  2 ++
 init/main.c                       | 27 +++++++++++++++++++++++++++
 kernel/module/main.c              |  4 ++--
 5 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5659f4b5a125..ac0e5f4f2893 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -957,6 +957,12 @@
 #define CON_INITCALL							\
 	BOUNDED_SECTION_POST_LABEL(.con_initcall.init, __con_initcall, _start, _end)
 
+#define INITCALL_MODNAMES						\
+	. = ALIGN(8);							\
+	__start_initcall_modnames = .;					\
+	KEEP(*(.initcall.modnames))					\
+	__stop_initcall_modnames = .;
+
 #define NAMED_SECTION(name) \
 	. = ALIGN(8); \
 	name : AT(ADDR(name) - LOAD_OFFSET) \
@@ -1166,6 +1172,7 @@
 		INIT_SETUP(initsetup_align)				\
 		INIT_CALLS						\
 		CON_INITCALL						\
+		INITCALL_MODNAMES					\
 		INIT_RAM_FS						\
 	}
 
diff --git a/include/linux/init.h b/include/linux/init.h
index 40331923b9f4..212f64a07c73 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -125,6 +125,16 @@ static inline initcall_t initcall_from_entry(initcall_entry_t *entry)
 }
 #endif
 
+struct initcall_modname {
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	initcall_entry_t initcall_fn;
+	int modname_offset;
+#else
+	initcall_t initcall_fn;
+	const char *modname;
+#endif
+};
+
 extern initcall_entry_t __con_initcall_start[], __con_initcall_end[];
 
 /* Used for constructor calls. */
@@ -270,9 +280,26 @@ extern struct module __this_module;
 		__initcall_stub(fn, __iid, id),			\
 		__initcall_name(initcall, __iid, id),		\
 		__initcall_section(__sec, __iid))
-
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define ___define_initcall(fn, id, __sec)				\
+	__unique_initcall(fn, id, __sec, __initcall_id(fn));		\
+	asm(".pushsection \".initcall.modnames\", \"a\"\n"		\
+	    ".balign 4\n"						\
+	    ".long " #fn " - .\n"					\
+	    ".long __initcall_modstr_" #fn #id " - .\n"			\
+	    ".popsection\n"						\
+	    ".pushsection .init.rodata, \"a\"\n"			\
+	    "__initcall_modstr_" #fn #id ": .string \"" KBUILD_MODNAME "\"\n" \
+	    ".popsection\n");
+#else
 #define ___define_initcall(fn, id, __sec)			\
-	__unique_initcall(fn, id, __sec, __initcall_id(fn))
+	__unique_initcall(fn, id, __sec, __initcall_id(fn));	\
+	static struct initcall_modname __initcall_modname_##fn##id __used \
+		__section(".initcall.modnames") = {		\
+			.initcall_fn = fn,				\
+			.modname = KBUILD_MODNAME	\
+		};
+#endif
 
 #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
 
diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..7e25fcd61b50 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -756,6 +756,8 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr);
 int register_module_notifier(struct notifier_block *nb);
 int unregister_module_notifier(struct notifier_block *nb);
 
+extern bool module_is_blacklisted(const char *module_name);
+
 extern void print_modules(void);
 
 static inline bool module_requested_async_probing(struct module *module)
diff --git a/init/main.c b/init/main.c
index e363232b428b..fbdc42859791 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1334,12 +1334,39 @@ static inline void do_trace_initcall_level(const char *level)
 }
 #endif /* !TRACEPOINTS_ENABLED */
 
+extern struct initcall_modname __start_initcall_modnames[];
+extern struct initcall_modname __stop_initcall_modnames[];
+
+static const char *initcall_get_modname(initcall_t fn)
+{
+	struct initcall_modname *p;
+
+	for (p = __start_initcall_modnames; p < __stop_initcall_modnames; p++) {
+		if (initcall_from_entry(&p->initcall_fn) == fn) {
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+			return (const char *)offset_to_ptr(&p->modname_offset);
+#else
+			return p->modname;
+#endif
+		}
+	}
+	return NULL;
+}
+
 int __init_or_module do_one_initcall(initcall_t fn)
 {
 	int count = preempt_count();
 	char msgbuf[64];
+	const char *modname;
 	int ret;
 
+	modname = initcall_get_modname(fn);
+	if (modname && module_is_blacklisted(modname)) {
+		pr_info("Skipping initcall for blacklisted built-in module %s\n",
+			modname);
+		return 0;
+	}
+
 	if (initcall_blacklisted(fn))
 		return -EPERM;
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..02deee5a7480 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2921,7 +2921,7 @@ int __weak module_frob_arch_sections(Elf_Ehdr *hdr,
 
 /* module_blacklist is a comma-separated list of module names */
 static char *module_blacklist;
-static bool blacklisted(const char *module_name)
+bool module_is_blacklisted(const char *module_name)
 {
 	const char *p;
 	size_t len;
@@ -3391,7 +3391,7 @@ static int early_mod_check(struct load_info *info, int flags)
 	 * Now that we know we have the correct module name, check
 	 * if it's blacklisted.
 	 */
-	if (blacklisted(info->name)) {
+	if (module_is_blacklisted(info->name)) {
 		pr_err("Module %s is blacklisted\n", info->name);
 		return -EPERM;
 	}
-- 
2.51.0

