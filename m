Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.85
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793806823;
	b=PpBQZE4CglcfGc9xEcC5bEOvNPO52jyVspD2dluclM4350BkWPz2Y6O5fhCt6fGjbwUh
	 LR2DpQBTaetiFxTE0ODGiFMc7LgTxQNR9KaSuI7lx5ME5rOxFcFrsoFK7EIKt2E2byVy8
	 pzKkvZey5MCO+kyOUrZnUyOnqGVBa+ZTB2BGEJVWMerjXKlA6cc8J9oMt9g6Bp3AKH8/j
	 8uoELBfFpNs5LV2cO+GpI6qOfgUTS/dh3pkIHRR0WPnsYMQdlb9jcrkjeEOZ1d3Vdza4V
	 WjfRVGYzY0zyn8TdQMyqDnK9y6wVc8Txna7RfMhDdv1WIa2v5UWK82cPdwK7w2Vkevw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806823;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tHhs4Ai5nunkCyO+s59XnAE4sfWaugvS06e1d8lcNc4=;
	b=kqnNbeh05rZ4N3tjeUUXfzoltQ2Znl8V1UA4/GHob/S7P/0faOePKqBeHFGn3BetMLvQ
	 l9gkREOzqoTHBUZOm9Em2Tc4jQtD4yDOK6L25m14NSB1ZiBaqrKUF60fm6xvGL3fGSmTd
	 6uaut/bbo5BFUTS8ndu+1gOS7ttSUNMTwMFV3dbq5aQy4ScyW9QKEHsAHPFWDZMLZH0Ay
	 7lcGBHdZSe8hI897f0dSRJabphxLnin3JkTIzbBDsN57/Io3Ro9Z7144ur/RXOyph5aJN
	 P0KcHpvJG5bVtZ2rsFAY9sm8HPPvQd8w1tzgHy5qxkRITAYW04tu0muOkcwxNXlLg1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.85
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020085.outbound.protection.outlook.com [52.101.196.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F71606D81E;
	Wed,  4 Nov 2026 15:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88F71606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoMl3vOd12bKvOALI5Bof46KDusQIYijlp7MkKbguONtTnkFqZW3l/GilPm4hesaY9lEP1ZvuaEptwGMZmxzx82cHLWlx++ENhyy5p8zot5Kb/6Le/D0FUFshr9uhwtLkaluQKLadLJwUxrQCg7kYPwGCTVxIpQAKgGldLGDzp/CwTFJ5wa+b2CZEAy8oG5CY41qdkpZU6rLekZU08l6WDvoVnXReLjrcAhn+89duUWQ+tqFt9x+uQgT1HFBzxfXPPYxK6sVzPztUSe8yetDIGVgObWVKwooMdcwaxteKkffCfRiUbyfeAz8PX72rUNVhlckuPh5dsegTIbIsoN28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=tHhs4Ai5nunkCyO+s59XnAE4sfWaugvS06e1d8lcNc4=;
 b=xp6cXPogRxav9OMSqSfUsKpi3ReL9XdjpMQGINSc1RhHysJH1ryCshm70AZUGU/Qrw0JOCDwDWKGsu0X75KnjNN5wLtJTF1Iu2avFOu/sj9RaUgg3qJcnDtl5M6149wlOgcj0AOYQ6dkJgvaYWaK0xR6v20kkrB2L/vfQtlR8N2V/oAena7TKV1wBM8oUSc8X/tHcTX4lcbjEUy/ztRk43Sf9OY9BqvsBHgm13bVvs+YGFll0dQhy50EKbxQ/3bqvu6e47QXu8jkX1gX4qVDFSYPx7+ipX4J6NqAlJgOKS5gzbKW/r7267UknpF9hFOsgSSdEBmfbNn0yqbRlQBupw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by CWLP123MB6624.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:182::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 15:40:15 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:40:15 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	peterz@infradead.org,
	ojeda@kernel.org
Cc: akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	mhiramat@kernel.org,
	boqun@kernel.org,
	atomlin@atomlin.com,
	neelx@suse.com,
	da.anzani@gmail.com,
	sean@ashe.io,
	chjohnst@mail.com,
	mproche@mail.com,
	nick.lane@mail.com,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 2/3] module: Extend module_blacklist parameter to built-in modules
Date: Wed,  4 Nov 2026 10:40:02 -0500
Message-ID: <20261104154003.43313-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104154003.43313-1-atomlin@atomlin.com>
References: <20261104154003.43313-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0240.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::14) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|CWLP123MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: adaaf9c2-f926-4ead-cb73-08df3a89ebfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|5023799004|56012099006|261021130227099003|261021123027099003|261021121427099003|261009221227099003|261009223027099003|261102123227099003|261026121527099003|261102124527099003|261022075727099003|261022105027099003|261022115727099003|261022113327099003|261028144727099003|261026140227099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	s74rWJy+BepSrXHqEiDt/mJLdKZZFtTHA6urGADve61KCrSXUcV3rDnwHJl1kCvfCx6c23YBtReUIF6Y/1Um88MnzwZlljj+UH2fx1jyxtLMPJBzBI8KGLagMMquwDP2ygyW84CujbEDIn5GlgperEESUtBx65/xLY32xJ0b49sfCVFtnPoXEawZIPnXvq9TMDDb2fUDDObDj2bi5NUh3PRK4QuZB2CBp3vjyius0ilQbAAGKiQPi/LWlaPy739J5vdf/O5RGGg0aH5/E9h/3l/qGR3HB5erfbyb3wZuSpD0eBAntGZFS4wIXs9611VUCo/zPczr09HKcPhowbI4/cfTZkKk/miwDfH7jX5P9caiyF/vv4IV0MdPLx6GymwenJZuAHmEyvOF0B3Dn5RvABPh5/TYJpzWg5SJqXsKpvTnAKVXW+xC0fh/VVysV8S0DdTfgI8YyXcwOBFmlSAZ8GFCciKNqHhhvv8GHcL7Byt0rZzHK1oh2UplX+lxp3y2BMIKtXRa70Z99hz4M5RFVKwBsrDydmSshdnXJGPyhS/1LFY/ojZv1EIqPkqz2b0XAqlKWBmUHWOHEoWqKeUoA6ASD3FZl/XUF3crkO73Mv+jK83B7SjCtSun1BjDmpZ+q/Fwb5hD+6eJebtxiEtiRjwPn32pq37fMy56PG2hJqM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(5023799004)(56012099006)(261021130227099003)(261021123027099003)(261021121427099003)(261009221227099003)(261009223027099003)(261102123227099003)(261026121527099003)(261102124527099003)(261022075727099003)(261022105027099003)(261022115727099003)(261022113327099003)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LDTlNQAnWkDIV70Qx7JwkH/4TgA/FZjGwx5U1Fg9D0K9GwneCz48LC8/6C7v?=
 =?us-ascii?Q?nng/UoT4FKZgH4Tvwmyb3bgqKyMmtuuu1R7iso3gyiqAH8/D6anoHtjPDEgL?=
 =?us-ascii?Q?eH9NINy7p0GZRlRDQJabdW0bhkBdopswGa60H7z5rXAG1k+F/lYXAsMxG7uz?=
 =?us-ascii?Q?zMtl/kT889jW9xkC6sFr/LnhJ4KvvHn1Of7uENLg9/hVQBIHO32Yf+SCn1My?=
 =?us-ascii?Q?pIf+d4H8iqpGHmSt/ybLW33i8zpHYu5trQihTK7DLRGW2dbvExh9gxluLdfH?=
 =?us-ascii?Q?dK3SU5hRAz/El8dsxRnSbEi+H1FKemkr2hWBg70yCpKL/ZuO29lF3S3GitRm?=
 =?us-ascii?Q?wRkMyQNenFdNvR3YDH22Ap6dD8JJhadfR/quyn0WjNongVY7Vepd14PrCN8U?=
 =?us-ascii?Q?SNrXclIbVXQEgpc1mmSW9+2WUpl1Xhuv5hKuayCVfRgwGMLycsNswtxHkRRp?=
 =?us-ascii?Q?JAuZTsjhMa4Uoz1Kl6HTQ1RyDxqY5DUQD0S3EL40Di7ycpVy14pmnuptf9Wc?=
 =?us-ascii?Q?7bAhutJqko71yTpoVieMcY6HerKiT1fVRPfWFyPn6fqurR/jsjQ1cIPdwD0M?=
 =?us-ascii?Q?mibAEUtsqEeinf1OulBxkqD2CVdagadwY7GgM9TkcEMIi2rsLCJbTF022TiO?=
 =?us-ascii?Q?nbNIdyBQgXfVnH/Jh05LZSqk84LWqS0j0XztXrt0YKIEc9QIrF11sSzOCQuP?=
 =?us-ascii?Q?nkYW5ySS2bSfqVBwIqVGfHtBee6LWKjJGF29POj7pn9+mXYKlk8xXVK1Ymrl?=
 =?us-ascii?Q?jelwHX5Ag5Mg/6Y6oxPyqxYkVihgGoAoUhBR+nHjdWO4MIiRitR1px1tLQkV?=
 =?us-ascii?Q?tpJtoj4i0NYXG+3nXpHqfZNjQUinvkrGNmBlyb/FRm+tleiN1wu38FiDQxRj?=
 =?us-ascii?Q?ziCi18ppYfeRX8pdOHXRASQBmp1Rb7ULphEpO57HIfLGyGekcaeMghw333LU?=
 =?us-ascii?Q?EHu/ziJcA4FzuKQrIIajNNj16uGejeXNejrJLEUGKqziZ3hrK/RZqvvgCKb3?=
 =?us-ascii?Q?axcM9trFCEhz/Wo1aid0TdGJR4pFY3tOZZfx1hHuYL5+2bC5Od7wPzc2eQnA?=
 =?us-ascii?Q?LYQxttcsPWtyEnfqlthmPr1BPoTrpJrbPHjpxoiNvmixB1+NuFnTYW79p49R?=
 =?us-ascii?Q?vU88UvZiTtYHLvsQMpqpTP1K+ljzvTUVkRQDVqJB80z8g5P6EGo5wOQRs27e?=
 =?us-ascii?Q?2XPDgavl03KBJhj0Nph9xopnF4QpVFLQAHZ8LmDGJ/NxeudisEvrWsUtj1sx?=
 =?us-ascii?Q?4YSMBbXJUTODm5WQenvKe42Xf7g325M1jygbjhBrzA/rllCrKV9JGTmEfiND?=
 =?us-ascii?Q?GsttXQOHpBPEFFVN5BghduLG38CrIRr5ad9OutGtqGJu3d7vjQhebgHiyaXI?=
 =?us-ascii?Q?qIHgvyayXiIJchuVD9m4P/yemrTD2GRsgvJiqaW7l/aIU/aRCNBtrd4frmf9?=
 =?us-ascii?Q?SGUlEq5KpcD6EpXlxPi3WttVLWTUvZ2Jty/ujsbovZPTA84AE19e6LptF+it?=
 =?us-ascii?Q?B9J2CA9Z5azp5OA62pdReOy5wGY+5OKwdMsW6d6fdpMXfGa834t7Q7cfgFNt?=
 =?us-ascii?Q?aoAfb2I37l84KyVzprONmixtxRt5+OizLk0+HH15cIqROSNXlh9LhZ6nLtqK?=
 =?us-ascii?Q?1mASdB2xdlMqfOjtcc9dnll1P0a9m4Lmv+8bP7se7iWXbuajiWGT1d9ca0qg?=
 =?us-ascii?Q?9WcY+AesptMQM6Vi5LlkWLRVXJ1Lm5/KC2SYYP8JwllJUHd7Pg+DCjBIbLhh?=
 =?us-ascii?Q?xKuOndnaRA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adaaf9c2-f926-4ead-cb73-08df3a89ebfc
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:40:15.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mF6RvoE7U9xAPK6zKUehG9hz71ThB7xFsehz6FzAdtSrzer4/g9e7F0IQeWVaTd9h78jkHncdEQTkPLsWkjqcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6624

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
 .../admin-guide/kernel-parameters.txt         |  5 +-
 include/asm-generic/vmlinux.lds.h             |  4 +-
 include/linux/init.h                          | 25 ++++++++-
 include/linux/module.h                        |  4 +-
 init/main.c                                   | 54 ++++++++++++++++++-
 kernel/module/main.c                          | 22 +-------
 rust/bindings/bindings_helper.h               |  1 +
 rust/kernel/module.rs                         | 18 +++++++
 rust/macros/module.rs                         | 23 ++++++++
 9 files changed, 128 insertions(+), 28 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..6cdee2dc4193 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4226,8 +4226,9 @@ Kernel parameters
 			Note that if CONFIG_MODULE_SIG_FORCE is set, that
 			is always true, so this option does nothing.
 
-	module_blacklist=  [KNL] Do not load a comma-separated list of
-			modules.  Useful for debugging problem modules.
+	module_blacklist=  [KNL] Do not load or initialize a comma-separated
+			list of loadable or built-in modules.  Useful for
+			debugging problem modules.
 
 	mousedev.tap_time=
 			[MOUSE] Maximum time between finger touching and
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3eb732942d69..96559b67293f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -765,7 +765,9 @@
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
 	EARLY_LSM_TABLE()						\
-	KUNIT_INIT_TABLE()
+	KUNIT_INIT_TABLE()						\
+	. = ALIGN(8);							\
+	BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
diff --git a/include/linux/init.h b/include/linux/init.h
index 6326c61e2332..08cb8a294375 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -109,6 +109,11 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
+struct initcall_modname {
+	initcall_t initcall_fn;
+	const char *modname;
+};
+
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
 typedef int initcall_entry_t;
 
@@ -252,6 +257,7 @@ extern struct module __this_module;
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define __initcall_fn_ptr(fn, __iid, id)	__initcall_stub(fn, __iid, id)
 #define ____define_initcall(fn, __stub, __name, __sec)		\
 	__define_initcall_stub(__stub, fn)			\
 	asm(".section	\"" __sec "\", \"a\"		\n"	\
@@ -260,6 +266,7 @@ extern struct module __this_module;
 	    ".previous					\n");	\
 	static_assert(__same_type(initcall_t, &fn));
 #else
+#define __initcall_fn_ptr(fn, __iid, id)	fn
 #define ____define_initcall(fn, __unused, __name, __sec)	\
 	static initcall_t __name __used 			\
 		__attribute__((__section__(__sec))) = fn;
@@ -271,7 +278,23 @@ extern struct module __this_module;
 		__initcall_name(initcall, __iid, id),		\
 		__initcall_section(__sec, __iid))
 
-#define ___define_initcall(fn, id, __sec)			\
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
index 76f4f3596477..98196204fe27 100644
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
@@ -892,6 +892,8 @@ static inline void add_taint_module(struct module *mod, unsigned flag,
 }
 #endif /* CONFIG_MODULES */
 
+bool module_is_blacklisted(const char *module_name);
+
 #ifdef CONFIG_SYSFS
 extern struct kset *module_kset;
 extern const struct kobj_type module_ktype;
diff --git a/init/main.c b/init/main.c
index 7b0c8c34e6a9..1302fa71a733 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1406,6 +1406,56 @@ static inline void do_trace_initcall_level(const char *level)
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
+		if (strlen(module_name) == len && parameqn(module_name, p, len))
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
@@ -1478,7 +1528,7 @@ static void __init do_initcall_level(int level, char *command_line)
 
 	do_trace_initcall_level(initcall_level_names[level]);
 	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
-		do_one_initcall(initcall_from_entry(fn));
+		do_one_initcall_builtin(initcall_from_entry(fn));
 }
 
 static void __init do_initcalls(void)
@@ -1523,7 +1573,7 @@ static void __init do_pre_smp_initcalls(void)
 
 	do_trace_initcall_level("early");
 	for (fn = __initcall_start; fn < __initcall0_start; fn++)
-		do_one_initcall(initcall_from_entry(fn));
+		do_one_initcall_builtin(initcall_from_entry(fn));
 }
 
 static int run_init_process(const char *init_filename)
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 6b1604018cc9..1787c8784aa3 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2946,26 +2946,6 @@ int __weak module_frob_arch_sections(Elf_Ehdr *hdr,
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
-		if (strlen(module_name) == len && parameqn(module_name, p, len))
-			return true;
-		if (p[len] == ',')
-			len++;
-	}
-	return false;
-}
-core_param(module_blacklist, module_blacklist, charp, 0400);
 
 static struct module *layout_and_allocate(struct load_info *info, int flags)
 {
@@ -3421,7 +3401,7 @@ static int early_mod_check(struct load_info *info, int flags)
 	 * Now that we know we have the correct module name, check
 	 * if it's blacklisted.
 	 */
-	if (blacklisted(info->name)) {
+	if (module_is_blacklisted(info->name)) {
 		pr_err("Module %s is blacklisted\n", info->name);
 		return -EPERM;
 	}
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3791af0aadc7..d86872912eee 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -64,6 +64,7 @@
 #include <linux/fwctl.h>
 #include <linux/fs.h>
 #include <linux/i2c.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
 #include <linux/ioport.h>
diff --git a/rust/kernel/module.rs b/rust/kernel/module.rs
index d71370598447..3f0545c4d7dc 100644
--- a/rust/kernel/module.rs
+++ b/rust/kernel/module.rs
@@ -78,3 +78,21 @@ pub const fn as_ptr(&self) -> *mut crate::bindings::module {
         self.0
     }
 }
+
+/// Newtype to make `bindings::initcall_modname` [`Sync`].
+#[repr(transparent)]
+#[doc(hidden)]
+pub struct InitcallModname(crate::bindings::initcall_modname);
+
+impl InitcallModname {
+    /// Creates a new [`InitcallModname`] wrapper for `.initcall.modnames`.
+    #[doc(hidden)]
+    #[inline]
+    pub const fn new(val: crate::bindings::initcall_modname) -> Self {
+        Self(val)
+    }
+}
+
+// SAFETY: `.initcall.modnames` entries are immutable metadata only read by the
+// C initcall runner during early boot.
+unsafe impl Sync for InitcallModname {}
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 0a7b9e24c960..df1d0eb89c16 100644
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
@@ -491,6 +493,9 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
     );
 
     let name_cstr = CString::new(name.value()).expect("name contains NUL-terminator");
+    let name_bytes = name_cstr.to_bytes_with_nul();
+    let name_len = name_bytes.len();
+    let name_byte_literal = Literal::byte_string(name_bytes);
 
     Ok(quote! {
         /// The module name.
@@ -591,6 +596,24 @@ pub extern "C" fn cleanup_module() {
                 #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
                 ::core::arch::global_asm!(#global_asm);
 
+                #[cfg(not(MODULE))]
+                #[allow(non_upper_case_globals)]
+                #[used(compiler)]
+                #[link_section = ".init.rodata"]
+                static #ident_modname_str: [u8; #name_len] = *#name_byte_literal;
+
+                #[cfg(not(MODULE))]
+                #[allow(non_upper_case_globals)]
+                #[used(compiler)]
+                #[link_section = ".initcall.modnames"]
+                static #ident_modname: ::kernel::module::InitcallModname =
+                    ::kernel::module::InitcallModname::new(
+                        ::kernel::bindings::initcall_modname {
+                            initcall_fn: Some(#ident_init),
+                            modname: #ident_modname_str.as_ptr().cast(),
+                        },
+                    );
+
                 #[cfg(not(MODULE))]
                 #[no_mangle]
                 pub extern "C" fn #ident_init() -> ::kernel::ffi::c_int {
-- 
2.55.0

