Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020115.outbound.protection.outlook.com [52.101.195.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EED43CF207;
	Thu,  3 Sep 2026 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461787; cv=fail; b=gJcZ9/L2h9vyTxQs5Ij9Gq/1tUHQDk2rEg6ZP6iLjcYdCFERRb40IkOSaZPtUP55xQ9gWnD3gjJ06oHVBvTD3951WO5gdsxgrzxUCOScLyWUEAaNYnJECz7i5YwH0o5bQ6PSeRRSa+8UxwXu0tOepoLrMI0mw9Yy/RRjvuGI9LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461787; c=relaxed/simple;
	bh=zzydivu2JFaAiIXrWj4/Nh8GHd0Ue+uecpurWdzGPKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rkAEtLCV90/UMyjTOaj39zDxVKRO8JeukaUEo63ck+r0k+OjcitK9jWs3QVHMhX5HjP5qCZ+VpMjgFg5xzXPrR0l3rP0TjGqth6dhdgkqQu0uB4EdIjj71AmoaQA2C2SDqwaET8tDuyneJWMBytKv46eKODNOcBw2nleKjiNDnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDLVZs7Ag/1d2f/pFyr/lyiV5u3YSLi0bHYCjZzZCq8V/WtKD4cAo4/bQCt4G5jdCUGoIOlQJOpJdgz+Q7H5NVC2V6qjS1nx272WF0RaXm/LI5gnue0NBQvuaCHqi/facxAPCgTTbmwBsJujhj4SGtFsRf2QKbC3fxK8IwfMksJGkKEfXu7S6pgSJv7Rx4SCJ7KltifDTF4a/7+sb1LnNVQ/m0Z02hcjB1MpgqJjQhow6MNbk4grfe/BEztNh6ad+uvBpPC5TzPz+A3C+ACtFozA6R3Lfn0R0w/Dkly3gPX1eSXjIqfVKwtZPXCmwO8XiXCB1q2hOmtBY/RWxTUWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=vPMDeSHG5NKVFFWGgc9Wq/7epv7YVoVuXjYRmJB1j5s=;
 b=DKjpdA744d5ZfBKO0d33BCYCdWzGycApvHzqqDixdk3hdMa3RjSmxu6OHmVGNsfV9/wGKmPTCTBAMjIZjtTmSeFrexPbtBoLFv0k+u6sNLitK3JiuPxpjU6eTz+a04djyN2xgEvdpJVje0L77KQ/Wqe1sqsI2nZOugBIPDKVwT/5jqf1/y+hePxAaIK0ee8O/KX62URShno6zBB8zysHXNx/uALweiMobEKEcyCl45IwjV7FIVex+gTkP8b+5gEuq7m55k7V1xs/mw0JUqbLPE3rirlTd1PF0y8CnOHQ75bsqOxadKeaB8O5AFzQKkuCAEWK+08w2w0dk+M/heyMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3048.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 18:56:05 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 18:56:05 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	peterz@infradead.org,
	ojeda@kernel.org
Cc: akpm@linux-foundation.org,
	mhiramat@kernel.org,
	boqun@kernel.org,
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
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 1/2] module: Extend module_blacklist parameter to built-in modules
Date: Thu,  3 Sep 2026 14:55:56 -0400
Message-ID: <20260903185557.183224-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903185557.183224-1-atomlin@atomlin.com>
References: <20260903185557.183224-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0043.namprd18.prod.outlook.com
 (2603:10b6:610:55::23) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3048:EE_
X-MS-Office365-Filtering-Correlation-Id: ee24d509-a4f0-4394-cd14-08df09ed01fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/8FZMpHsTonek9m/3yQ8UVKAAXe4wbHM1FEy7n0zuNkBXugXxpGNwtDe1+X8d2vsg/WdDtijeDONgABwA+fUIuLPFQvtHvLJmUlCbX7ln5HfLb9JIdXxOxaYTLFl4YYeyZS+W+Z6w3nUq8zxjahONQm3wQB7rqeLPWQgGaBzs16xmh2vCbceoQpIgXo7oRdzslKt52Ak8shDSFiVZ8m2x0Hq02WWS+Hh7DdFRcBTaVBAeYoSZgIshP8QmWfV/i4nFdf+I5E9Di83dQaa9bKYlAFfQ2HLQiMB2s0FeSzVouGZwFJQdDlThLIN2G2EEtZPapn2rbx3+W2495keYq86tLIcvBvl7xXMPKtwT28661vdiZ6yNcxQQ+Z6YYR+txJkEYK1VcRzqla6HX59Q7Al0ICvdlhSQbaWLEbRzZWS18PmpLgQJAhe86zC/JwUnMD2klt21LOjkdsdXDWXdU+uyuSU/n8m8aaTOwhNIZLAw3/l4kkdhAAxkO2+j/hHdadDPkJv49TUJ7dA9ZB0xIOEhUwcJOuiTU1cFJGwtbtQa4+CB+uzEcvq8YwMq+n+Qhf2g5F8CnTib3SzDeWOWtXvERfOHMz6nk9RfVwOCMuzzRqbbC0I9a4gHVYYb7OJiP7vx7UnRU2HoDgP6p9gLtjxHoMlH+Gmg3JsJV3pnxXbEeQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zzy3eiKcoArK7m7D9TSj+/mboNZ6N4wzGYDxlwwt7CXi+Lh7pugqErCGhpky?=
 =?us-ascii?Q?0FJszLGnee6NECYbU8vLxkUIyPlFtnsVSJtL4EKcE6SAZG3ch3krpylleb7b?=
 =?us-ascii?Q?3382q8lheVW/4T+cKeYDiLlVXcV7gEbN0uwHsWFxK9reJsQoee8p4dLM0v9K?=
 =?us-ascii?Q?bHYP6uLtrpu0DtMw3S2AzZqaXnxN+H/yMXK1XUhrIcd/FNMQ47w9R1IF8BtB?=
 =?us-ascii?Q?xMKPL1raZUJi3tPTgp3poOFiwF8G5u9cHKwD1bs46hBBHFxzCET6qBJfBa5Z?=
 =?us-ascii?Q?Pqzffa3QuUBlt/EG8E6dxWrl7m7/S0c725SVeLzzTag+ErnOkmkXX42iVnFw?=
 =?us-ascii?Q?wkkhlh65c4vlFN1Gj3MFK3BgzOcuPGUEBpkZS40qvTWi0TmW3CGL9X0x1OgR?=
 =?us-ascii?Q?3as64ipGfrDyGn1w1qe8NPGPJhsgZci0IaBeyuJOSnonam0fIoKA+yY9LUdR?=
 =?us-ascii?Q?k6/W0/1bFCqpOg7bAiVK76+/G/BIVQwDQHmeloSO0bhftIz6Mx+uZ8WdRKWm?=
 =?us-ascii?Q?g649oblmD08zuAoSbMioDXMQ4ahqGQoMU1UtTYR97xPF1M0eTC2cI/b0j585?=
 =?us-ascii?Q?hP5iUcu/nJ7BNg+8jctiDpIExWfCr1iC85rFXUKnchfoNpBTqndenbwNfjbW?=
 =?us-ascii?Q?70sLz9Ho+yS91ob8nE3NYTa+M5xAi10kFqBcjur8hzgjlfDm35yotka6k1zs?=
 =?us-ascii?Q?v6kRa5LOnlizfgWmttBzA1q35SCwP8ndKqvjSHh2/dweMfn8EBu06YJCkKiY?=
 =?us-ascii?Q?YxsQbfK/yqEILqLGg18JXVOKWiFZqhUBPcNRyRQPqxaQxXsLbS/qsnWdbLNR?=
 =?us-ascii?Q?Wg2nQD6QejPYoFn3sn17hbUgsymcHgWJ4Q4dLDYuBRVpfR7/fIQ0BVTmEZNP?=
 =?us-ascii?Q?Bk8EcTIkTnbUJiLjKXFhnaJ+mjykMy0iA0R84DMBRQmPELHjZZA0PY0Ki+G5?=
 =?us-ascii?Q?gd+dcBA+G1I8Rb5vXw0eICSW7XnK+QnOsU0wNYOddRcM4dUvW9eXNoDl55QY?=
 =?us-ascii?Q?Oco5wm7TZTlhubAMEBCjGCnyuMtnw9zdoyK7fIy1yoq4UIZT4jRysjUguHqi?=
 =?us-ascii?Q?sJE8oj9lyjPjP5pcvv2qV2QRkCV7haZs11c+3UFr1eb6JLqYUobQfMcaylGb?=
 =?us-ascii?Q?7ZMZ5cxoGzNO9kyAA7VixwxmeNRuKIRau4txBlMeAhXuMxRDJJH1x0vMsmlH?=
 =?us-ascii?Q?LODyx1gDQeljWr0TSXRU1tJwkh0Hyx6WAXTFO0HyGVjJXwoVdyPh2U76wDyO?=
 =?us-ascii?Q?9Ej4fX3l0M0kGezxVJe1iQB83X56XyqgEdnQd7cvfxnE5dV5iJ7MLrUL4G6q?=
 =?us-ascii?Q?/uDXCQ85wbAyErKAhjb6AaQs6AKSA608zvEQr4yisIoreTG6vwOBtdzn/+Jj?=
 =?us-ascii?Q?ey5qLt4nKEPRjDxcw+GMLbY+nbKqxOaOsJKbgZmfDzk3LyKYv4lW01oxtGSb?=
 =?us-ascii?Q?/cAGBz+H08OgUqKr9UCbUE0tfxDmxpZ1wLel9F46LF+DSgImjN2DtVFsu5MW?=
 =?us-ascii?Q?Gz17rXMj5l8SlqYp7VZ9qlTpA3ylQdSVIH/PT7JcvCO2JcHdpMpQ4N+KO6tE?=
 =?us-ascii?Q?xb4yA2cH6YM1OyLL7SPWDkfwL0e46cxs1dop54K6qvuTVTchGbUnGfsptMi1?=
 =?us-ascii?Q?fatYdGocDoGmH8aVX9Oa5TiYNYvzCrKYODteFs1DOi+x4FjkQscNyIqzyHE8?=
 =?us-ascii?Q?mQsy+BBTMVnFyUjkrMRqs68tzBcpRhFrP4/OTvpvpNHAlhna2x0ZVlfILMqx?=
 =?us-ascii?Q?Z5JyGnTdrw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee24d509-a4f0-4394-cd14-08df09ed01fa
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 18:56:05.6307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hl3fiCVx9ZeQ9utAP97kxzdCL+JwrmJAZuLa6sRVw5GIVuhMRaNINbOYR7lBIyGNUwSU2LjN9skq5j4Ze6v1tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3048

Currently, the "module_blacklist=" command-line parameter only applies
to loadable modules. If a module is built-in, the parameter is silently
ignored. This patch extends the blacklisting functionality to built-in
modules by intercepting their initialisation routines during early boot.

To achieve this, we introduce a new ".initcall.modnames" memory section.
For each built-in module, we use a standard C structure (i.e., struct
initcall_modname) to map its initcall function pointer to its associated
KBUILD_MODNAME string. This mapping is restricted only to files implementing
built-in modules via module_init() to avoid mapping core kernel subsystems
and save memory.

During boot, built-in initcalls are executed sequentially via
do_initcall_level() and do_pre_smp_initcalls(). We introduce a new
wrapper function, do_one_initcall_builtin(), to cross-reference the
initcall function pointer against the ".initcall.modnames" table. If
a match is found and the module is present in the blacklist, the
initcall is skipped.

To make the blacklist functional on monolithic kernels, the command-line
parameter parsing and the module_is_blacklisted() lookup function are
decoupled from the loadable module subsystem and moved to init/main.c.
This enables "module_blacklist=" to intercept built-in modules even on
kernels built with CONFIG_MODULES=n.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/asm-generic/vmlinux.lds.h |  3 +-
 include/linux/init.h              | 25 +++++++++++++-
 include/linux/module.h            |  4 ++-
 init/main.c                       | 54 +++++++++++++++++++++++++++++--
 kernel/module/main.c              | 23 +------------
 rust/bindings/bindings_helper.h   |  1 +
 rust/macros/module.rs             | 17 ++++++++++
 7 files changed, 100 insertions(+), 27 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2988aa12f66..7490278b7a2d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -734,7 +734,8 @@
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
 	EARLY_LSM_TABLE()						\
-	KUNIT_INIT_TABLE()
+	KUNIT_INIT_TABLE()						\
+	BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
diff --git a/include/linux/init.h b/include/linux/init.h
index 6326c61e2332..833b837ce11d 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -252,6 +252,7 @@ extern struct module __this_module;
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define __initcall_fn_ptr(fn, __iid, id)	__initcall_stub(fn, __iid, id)
 #define ____define_initcall(fn, __stub, __name, __sec)		\
 	__define_initcall_stub(__stub, fn)			\
 	asm(".section	\"" __sec "\", \"a\"		\n"	\
@@ -260,6 +261,7 @@ extern struct module __this_module;
 	    ".previous					\n");	\
 	static_assert(__same_type(initcall_t, &fn));
 #else
+#define __initcall_fn_ptr(fn, __iid, id)	fn
 #define ____define_initcall(fn, __unused, __name, __sec)	\
 	static initcall_t __name __used 			\
 		__attribute__((__section__(__sec))) = fn;
@@ -271,7 +273,28 @@ extern struct module __this_module;
 		__initcall_name(initcall, __iid, id),		\
 		__initcall_section(__sec, __iid))
 
-#define ___define_initcall(fn, id, __sec)			\
+struct initcall_modname {
+	initcall_t initcall_fn;
+	const char *modname;
+};
+
+#define ____define_initcall_modname(fn, id, __sec, __iid)		\
+	__unique_initcall(fn, id, __sec, __iid)				\
+	static const char __initstr_##fn[] __used __aligned(1)		\
+		__section(".init.rodata") = KBUILD_MODNAME;		\
+	static const struct initcall_modname __modname_##fn __used	\
+		__section(".initcall.modnames")				\
+		__aligned(__alignof__(struct initcall_modname)) = {	\
+			.initcall_fn = __initcall_fn_ptr(fn, __iid, id),\
+			.modname = __initstr_##fn			\
+		};
+
+#define __define_initcall_modname(fn, id)				\
+	____define_initcall_modname(fn, id, .initcall##id, __initcall_id(fn))
+
+#define __builtin_module_initcall(fn)	__define_initcall_modname(fn, 6)
+
+#define ___define_initcall(fn, id, __sec)				\
 	__unique_initcall(fn, id, __sec, __initcall_id(fn))
 
 #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..bcc54edbde7d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -86,7 +86,7 @@ extern void cleanup_module(void);
  * builtin) or at module insertion time (if a module).  There can only
  * be one per module.
  */
-#define module_init(x)	__initcall(x);
+#define module_init(x)	__builtin_module_initcall(x);
 
 /**
  * module_exit() - driver exit entry point
@@ -879,6 +879,8 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
 }
 #endif /* CONFIG_MODULES */
 
+bool module_is_blacklisted(const char *module_name);
+
 #ifdef CONFIG_SYSFS
 extern struct kset *module_kset;
 extern const struct kobj_type module_ktype;
diff --git a/init/main.c b/init/main.c
index 2613d3f9b3ce..0ee3b23bcd2b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1344,6 +1344,56 @@ static inline void do_trace_initcall_level(const char *level)
 }
 #endif /* !TRACEPOINTS_ENABLED */
 
+extern struct initcall_modname __start_initcall_modnames[];
+extern struct initcall_modname __stop_initcall_modnames[];
+
+/* module_blacklist is a comma-separated list of module names */
+static char *module_blacklist;
+bool __init_or_module module_is_blacklisted(const char *module_name)
+{
+	const char *p;
+	size_t len;
+
+	if (!module_blacklist)
+		return false;
+
+	for (p = module_blacklist; *p; p += len) {
+		len = strcspn(p, ",");
+		if (strlen(module_name) == len && !memcmp(module_name, p, len))
+			return true;
+		if (p[len] == ',')
+			len++;
+	}
+	return false;
+}
+core_param(module_blacklist, module_blacklist, charp, 0400);
+
+static const char *__init get_builtin_modname(initcall_t fn)
+{
+	struct initcall_modname *p;
+
+	for (p = __start_initcall_modnames; p < __stop_initcall_modnames; p++) {
+		if (p->initcall_fn == fn)
+			return p->modname;
+	}
+	return NULL;
+}
+
+static void __init do_one_initcall_builtin(initcall_t fn)
+{
+	const char *modname;
+
+	if (module_blacklist) {
+		modname = get_builtin_modname(fn);
+		if (modname && module_is_blacklisted(modname)) {
+			pr_info("Skipping initcall for blacklisted built-in module %s\n",
+				modname);
+			return;
+		}
+	}
+	do_one_initcall(fn);
+}
+
 int __init_or_module do_one_initcall(initcall_t fn)
 {
 	int count = preempt_count();
@@ -1416,7 +1466,7 @@ static void __init do_initcall_level(int level, char *command_line)
 
 	do_trace_initcall_level(initcall_level_names[level]);
 	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
-		do_one_initcall(initcall_from_entry(fn));
+		do_one_initcall_builtin(initcall_from_entry(fn));
 }
 
 static void __init do_initcalls(void)
@@ -1461,7 +1511,7 @@ static void __init do_pre_smp_initcalls(void)
 
 	do_trace_initcall_level("early");
 	for (fn = __initcall_start; fn < __initcall0_start; fn++)
-		do_one_initcall(initcall_from_entry(fn));
+		do_one_initcall_builtin(initcall_from_entry(fn));
 }
 
 static int run_init_process(const char *init_filename)
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d0e1e0bd2ad0..a9fd6aaedc69 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2930,27 +2930,6 @@ int __weak module_frob_arch_sections(Elf_Ehdr *hdr,
 	return 0;
 }
 
-/* module_blacklist is a comma-separated list of module names */
-static char *module_blacklist;
-static bool blacklisted(const char *module_name)
-{
-	const char *p;
-	size_t len;
-
-	if (!module_blacklist)
-		return false;
-
-	for (p = module_blacklist; *p; p += len) {
-		len = strcspn(p, ",");
-		if (strlen(module_name) == len && !memcmp(module_name, p, len))
-			return true;
-		if (p[len] == ',')
-			len++;
-	}
-	return false;
-}
-core_param(module_blacklist, module_blacklist, charp, 0400);
-
 static struct module *layout_and_allocate(struct load_info *info, int flags)
 {
 	struct module *mod;
@@ -3402,7 +3381,7 @@ static int early_mod_check(struct load_info *info, int flags)
 	 * Now that we know we have the correct module name, check
 	 * if it's blacklisted.
 	 */
-	if (blacklisted(info->name)) {
+	if (module_is_blacklisted(info->name)) {
 		pr_err("Module %s is blacklisted\n", info->name);
 		return -EPERM;
 	}
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 4b31aa7f432f..1075b26e53ac 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -63,6 +63,7 @@
 #include <linux/fwctl.h>
 #include <linux/fs.h>
 #include <linux/i2c.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
 #include <linux/ioport.h>
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index bc7027f8dbb2..a96157598197 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -480,6 +480,8 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
     let ident_init = format_ident!("__{ident}_init");
     let ident_exit = format_ident!("__{ident}_exit");
     let ident_initcall = format_ident!("__{ident}_initcall");
+    let ident_modname = format_ident!("__{ident}_modname");
+    let ident_modname_str = format_ident!("__{ident}_modname_str");
     let initcall_section = ".initcall6.init";
 
     let global_asm = format!(
@@ -491,6 +493,7 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
     );
 
     let name_cstr = CString::new(name.value()).expect("name contains NUL-terminator");
+    let name_len = name_cstr.to_bytes_with_nul().len();
 
     Ok(quote! {
         /// The module name.
@@ -591,6 +594,20 @@ pub extern "C" fn cleanup_module() {
                 #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
                 ::core::arch::global_asm!(#global_asm);
 
+                #[cfg(not(MODULE))]
+                #[used(compiler)]
+                #[link_section = ".init.rodata"]
+                static #ident_modname_str: [u8; #name_len] = *#name_cstr.to_bytes_with_nul();
+
+                #[cfg(not(MODULE))]
+                #[used(compiler)]
+                #[link_section = ".initcall.modnames"]
+                static #ident_modname: ::kernel::bindings::initcall_modname =
+                    ::kernel::bindings::initcall_modname {
+                        initcall_fn: Some(#ident_init),
+                        modname: #ident_modname_str.as_ptr().cast(),
+                    };
+
                 #[cfg(not(MODULE))]
                 #[no_mangle]
                 pub extern "C" fn #ident_init() -> ::kernel::ffi::c_int {
-- 
2.55.0

