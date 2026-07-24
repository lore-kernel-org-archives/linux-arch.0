Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020112.outbound.protection.outlook.com [52.101.195.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3DD349CCD;
	Fri, 24 Jul 2026 02:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784861275; cv=fail; b=MVUcYc3uAkJdq8X3/cHzybzZpEln6zL9vM9B4bC1KNA/Fr/np4JsJxcN70WdPOX7Q7ZQ4EZPjg9+f1pu8KrFrpZTSKpbzmFDRbrSQFN29FIb9+xs7B1TiZEDQWK2/7RdCSKYp+YBaPBcz8VGNNt4mE3osRuN5ft5gbcUfpjgeJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784861275; c=relaxed/simple;
	bh=gxgsqE5rfkhzmhizE3h8ID/t17HUvUkxTOPIb/yXI5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lD+bGMn4cXKqS6DWsVHdTR2MLj+w/YM/uOWQnazSt5wxZ7hdWaiqcCE8Whyi3f51C1ZIUc3bClyED5LhPwC5QOChB90bm3HyPBaqQaMxkhGnmyeAbk7sPVp3Z6jZ26S+ga/3r24oiXvK6yOCXEoo1GDI2LWVbASxgKvXLNURTGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okz9dRzNelN2dcacO9TkCin/DdQJUvuNAtrC+EOEU+HQHRrfMDACtUZIecG7U25K9jNhdfvetlhtd2YUtaF31/EdXlpVd59c9/4NHdfLStFbBvive4oaOyIGH9WBMOHvSDMxvhzh5DJz7gRs0iknIRV3EfwTIm8tdM3bBBV06bCKYTml18vhJ2Q/uUVgYASJNeQmmuVO9JFtVRonXj/XAr71T85jg1k663LtpxmEJzltbjS5l/Q8M5VZm4Rp7AnvUXDaYJ1mb2Uul0AGbyUVjXKhyIZblWfPwfhInlAdj5EF3bZ8LtyeULPe+uzvi9qYGo/rF8oH1C+9Ih8dL6rJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=kzOAeh/2x7BTeQK2R41NefmTG6YNDLvJSkxAzX0ZBlg=;
 b=C67N9VoJlhpM06Zchg+mWPFIJqhw32WYA1U+PudEgy2MUa1vi0H1VbjiEDsFtHom8gKXuNxRvp7r1aG1ezzuX5SZfp3AkccSOwMKsKGbwj0kZWltIsBQh8MJqZHVsscX16rUz6znXhThRZ/60ba12IkEA7dFx9dXRmqR8U/BsRujD0OS6G14lS3XOHzM5Y9SDb8msVd0SdDX/73BpiHxTCztKaqWCyKACqE1NSLQ2khuDJg2zcaWS/DTRMwY7BSZRAPW+txKlnp+6xbZw1aFxJN2W09o6qcgL5J2Z6myJvr8LkRagXJIvrNRyXuK1cFV0yGXE5uIGqg85ob8ehluGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8488.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:269::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 02:47:51 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 02:47:51 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	peterz@infradead.org
Cc: akpm@linux-foundation.org,
	mhiramat@kernel.org,
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
Subject: [PATCH v8 1/2] module: Extend module_blacklist parameter to built-in modules
Date: Thu, 23 Jul 2026 22:47:43 -0400
Message-ID: <20260724024744.616286-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724024744.616286-1-atomlin@atomlin.com>
References: <20260724024744.616286-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0599.namprd03.prod.outlook.com
 (2603:10b6:408:10d::34) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c99981e-bae6-441a-6387-08dee92df440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|56012099006|5023799004|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ha5vXwo7tDcUVVro27qma/IGdv2WJc4VGbwzfDyCJb9dbryWGa4dGcDZJdJN9CDAhbimoZJNmIATI4WNNtZKZgbxRWEElmNmTDIfLMZhGHLDTkBKpO70CazD/fTAKEwMTUOdPdFgL/iwBEe94wX1giQR7oZ0C02w+EIrFbsP4GqqdCUDQvuwHGZYlTytMXAiRrlxBdPxuh2+QktylhELSoJ2EAF4T//bPV1n/Uvz+xGgTjVxJWI+8XrFPVG95wvnmF9Da1BCuzfH6XQ98bxr8kCduqijF+Se+3t7zG9zAfjVyfLq6WYA/OlzIdVD18dFr1OjvK2MqnCOGQiGMcvlivK/CiCUZfhVZTCIwC5G40RdLBclG8cY/791a+hrXvIhVP+4H/jcMKsYbt3UVYq5vGsWl0BD3du7DlIh1gsMK506qe6IAMBpo3bNDO1IOz1kQnMk1hMmTcYWKuy6dF15svbUIkUVeKlhVpoXcJJWC+AvxFeThRdPd9A8ZVurQrf/CpZh8GXsLj75uZOhVW+bTsw8VcJn4tjElrfgWMP6y2zkkLYl9572FHn8xdAqF2B2LJRfnQbb6wMBk2buRMqS+sxI1q8dx5QQTMrS1f32DNDLG2/5GwgtCghJoJ5wa0wl5VW2HF/QC1IMK17xzKwXWGJ8g/x9xw8UJ/I0oPIMqxo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(5023799004)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+QvZvld99fmjyiNBgzKft3l+PjmZA3hmnA4cdsg4b1VzZBj0iSXF843mUxaW?=
 =?us-ascii?Q?PXnwCNkHhQNGpd370P/cHNRUz84vUXSZLD/TQHM6z2UmJ2eV4WeEsDe/IvOl?=
 =?us-ascii?Q?KMG1JUC5e8ZErpgI/h50lfyt4gK26EwFx4jT+xdEIQzQ4152RPyt6+UM1Oyg?=
 =?us-ascii?Q?wZAgaryU8CABtJbacSJFm731LE4EIztsg0pt0YHSkRhEr3Ebo6+Wyk/vTiub?=
 =?us-ascii?Q?lsMfHjv3yb1SVsOdFIQ4Gu16ADfgt1oCWsJMne9xTWKE7fEm7sbT4N19YPyh?=
 =?us-ascii?Q?x+tAfnyhRGtqtFYEO3ceC/lNNUJAYn0nWGTg7YI86ZUlPIedjv0yt7s/LB4M?=
 =?us-ascii?Q?incfk7cIwWHRhxvYChscJvemZJ63r7IPPaxM5BLiTJJnRLtqsk5OgUsThl35?=
 =?us-ascii?Q?1XAzl05uTTvZmikpNuOxWkxIhWQcFJouNxeUf1acv7hkvhC8Vitxtr8qfAdh?=
 =?us-ascii?Q?OiOXVdZi/fUzaXWMxUg5wPz9R47dBqJ5NeXntA5kl7yTvVqo5spVX1zEyy7b?=
 =?us-ascii?Q?j38MNioM/7UUgJVl39A2XpvAuE6pEO6CC3yBU3eBX4Wx7wbOSbH6oJvlGhn9?=
 =?us-ascii?Q?cI9LWh6enJzN2B9QpVLezYFWp0E6aPYqR5i/3iUxHlkZj7tS6TxM8ZaG3EiV?=
 =?us-ascii?Q?P5nJANrYZFMnFKmjTgxgqs5S9/dYxuakEwUqC14UTaeweLyezKf1ooJe6JPy?=
 =?us-ascii?Q?5eavljto8lXNlGx1G+vNcgnoxzlehLb9JGuOyonQYF9mms6LQWuzJU1mvYhq?=
 =?us-ascii?Q?NUHX0AhKUJ6OjJFnHdTGBcgA7g2BFnEosIn4HzT42M4KXthRibGZS7iDUOtA?=
 =?us-ascii?Q?1sKTB9iNieXWwdvQufw3txay+UOIZ8ITmpIlofxybvKFCElBJ0KX7ylZzA3E?=
 =?us-ascii?Q?K6rF+hRvHsADYhFsof1Zn+Y2h1e1WMoERKKIvwIgTs0bfkanvcFxaL8p6yfU?=
 =?us-ascii?Q?L6wSL/uBdxM4cntPaRjg1FiVRc9KgSMCIO563gBOgCFXHRuaILzwEJNZXcNe?=
 =?us-ascii?Q?zhL9MKBGdGD5oS4mwG62uDG2G+QY4SHdRIO7KMi2o4n3BvQgQquBv+my4ykU?=
 =?us-ascii?Q?8WnuMNMPQtMEK9iM4K022gCNKg6YQ08p7eJSykTntaVfmgCi0zLKPCAUoxXT?=
 =?us-ascii?Q?EC3QRRT+lB0+yLFFwiGspt6D22GP83uHwptkh2744UFOzGnJJ7YrYjtodHCy?=
 =?us-ascii?Q?a+4OGF27UXecDDvuN4M6fsjI/eOWNtUx8uKfyFEHxaPvlC33fnlcI3Xk2Yqy?=
 =?us-ascii?Q?sjNAiCjDaXvBnA6NVY0uo8r6lRWzfofbaD+gWwc/eJ1trkv/8xxl6vnAjt+V?=
 =?us-ascii?Q?A6k87nOQbyzItLeMpyW/Q+LDet7BUgEnpmzlxqpi7y5yceVauRCp8NMWLvuj?=
 =?us-ascii?Q?gLlEyUNv6NxH6fXaPUyB3MzCl7BsvoCDbTpfn04+Poa6DAagssfCF4MS21LC?=
 =?us-ascii?Q?2O+xKlKobf6S/wtNKssHWYY9NPwlgTH/IT22jWHY9JNnYypLTIjWNtxILXb1?=
 =?us-ascii?Q?UYH4cXek5v7BkhhRDBrvEGLS4Gg8rBTyngYOcg6u+4kWOzueI1FoLSMpOaqi?=
 =?us-ascii?Q?mUTDLGs9HuswTaBXkoFbMeSPJ6tAEFabk4efOFsBGL/KZNiYh93vPxsY32Cj?=
 =?us-ascii?Q?8iaKlWdJdncabKaLoxkNXFnx549aW0siM6au+CsU5Ujd5Zn0bH+5CNF09MM7?=
 =?us-ascii?Q?sN6hhrAERSxOs89NYnOVElsKucuxpy01upcBipJfwdhwR91swS2MFEgfxpaf?=
 =?us-ascii?Q?X9UaIiIrMQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c99981e-bae6-441a-6387-08dee92df440
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 02:47:51.5056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Uh+zFvhLYfKUW2hATV9ghnesfG+IwBA0F/TdNwnl28ysNA15hNsqxgv+Bi9JVxyLn2aAbrMgC/8KQC0wsTkIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8488

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

Design Considerations and Trade-offs:

    1.  LTO and CFI Compatibility vs. PREL32

        Previous iterations of this patch attempted to use top-level
        inline assembly to generate 32-bit relative offsets (PREL32) to
        save memory. However, raw inline assembly operates blindly
        outside of the C compiler's visibility. When compiled with
        CONFIG_LTO_CLANG or CONFIG_CFI_CLANG, the compiler applies
        symbol renaming and generates Control Flow Integrity stubs.
        The raw assembly string-matching fails to track these changes,
        resulting in undefined references or runtime address mismatches.

        To resolve this, we strictly use standard C structures to hold
        the function pointers. This natively allows the compiler to
        resolve LTO renaming and map CFI stubs correctly. We trade the
        minor spatial optimisation of PREL32 (using absolute 64-bit
        pointers instead) to guarantee architectural safety under modern
        compiler protections. Because this metadata is placed in an
        ".init" section and freed entirely after boot, the temporary
        memory overhead is negligible.

    2.  Architectural Safety and Elimination of Runtime Vulnerabilities:

        By embedding the boot-time blacklist check inside the
        do_one_initcall_builtin() __init wrapper function, we ensure
        the metadata lookup logic is exclusively invoked during early
        boot. This approach provides strict structural guarantees:
        - It inherently eliminates Use-After-Free (UAF) and race conditions
          since loadable modules (which execute post-boot and invoke
          do_one_initcall() directly) bypass this __init wrapper entirely.
        - It prevents modpost section mismatch warnings since the __init
          metadata is strictly accessed by other __init functions.
        - It mitigates Spectre v1 speculative execution vulnerabilities
          by guaranteeing the unprivileged runtime module loading path
          cannot speculatively branch into reclaimed .init.text instructions.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/asm-generic/vmlinux.lds.h |  4 ++-
 include/linux/init.h              | 27 +++++++++++++++-
 include/linux/module.h            |  4 ++-
 init/main.c                       | 54 +++++++++++++++++++++++++++++--
 kernel/module/main.c              | 22 +------------
 5 files changed, 85 insertions(+), 26 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5659f4b5a125..799d912dcbc0 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -734,7 +734,9 @@
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
 	EARLY_LSM_TABLE()						\
-	KUNIT_INIT_TABLE()
+	KUNIT_INIT_TABLE()						\
+	STRUCT_ALIGN();							\
+	BOUNDED_SECTION_BY(.initcall.modnames, _initcall_modnames)
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
diff --git a/include/linux/init.h b/include/linux/init.h
index 40331923b9f4..623d8642797c 100644
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
@@ -271,7 +273,30 @@ extern struct module __this_module;
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
+		__section(".initcall.modnames") = {			\
+			.initcall_fn = __initcall_fn_ptr(fn, __iid, id),\
+			.modname = __initstr_##fn			\
+		};
+
+#define ___define_initcall_modname(fn, id, __sec)			\
+	____define_initcall_modname(fn, id, __sec, __initcall_id(fn))
+
+#define __define_initcall_modname(fn, id)				\
+	___define_initcall_modname(fn, id, .initcall##id)
+
+#define __builtin_module_initcall(fn)	__define_initcall_modname(fn, 6)
+
+#define ___define_initcall(fn, id, __sec)				\
 	__unique_initcall(fn, id, __sec, __initcall_id(fn))
 
 #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..ecc4db15ff4a 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -86,7 +86,7 @@ extern void cleanup_module(void);
  * builtin) or at module insertion time (if a module).  There can only
  * be one per module.
  */
-#define module_init(x)	__initcall(x);
+#define module_init(initfn)	__builtin_module_initcall(initfn);
 
 /**
  * module_exit() - driver exit entry point
@@ -883,6 +883,8 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
 }
 #endif /* CONFIG_MODULES */
 
+bool module_is_blacklisted(const char *module_name);
+
 #ifdef CONFIG_SYSFS
 extern struct kset *module_kset;
 extern const struct kobj_type module_ktype;
diff --git a/init/main.c b/init/main.c
index e363232b428b..3747ccaeef42 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1334,6 +1334,56 @@ static inline void do_trace_initcall_level(const char *level)
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
@@ -1406,7 +1456,7 @@ static void __init do_initcall_level(int level, char *command_line)
 
 	do_trace_initcall_level(initcall_level_names[level]);
 	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
-		do_one_initcall(initcall_from_entry(fn));
+		do_one_initcall_builtin(initcall_from_entry(fn));
 }
 
 static void __init do_initcalls(void)
@@ -1451,7 +1501,7 @@ static void __init do_pre_smp_initcalls(void)
 
 	do_trace_initcall_level("early");
 	for (fn = __initcall_start; fn < __initcall0_start; fn++)
-		do_one_initcall(initcall_from_entry(fn));
+		do_one_initcall_builtin(initcall_from_entry(fn));
 }
 
 static int run_init_process(const char *init_filename)
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..5c90ebedbf68 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2919,26 +2919,6 @@ int __weak module_frob_arch_sections(Elf_Ehdr *hdr,
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
 
 static struct module *layout_and_allocate(struct load_info *info, int flags)
 {
@@ -3391,7 +3371,7 @@ static int early_mod_check(struct load_info *info, int flags)
 	 * Now that we know we have the correct module name, check
 	 * if it's blacklisted.
 	 */
-	if (blacklisted(info->name)) {
+	if (module_is_blacklisted(info->name)) {
 		pr_err("Module %s is blacklisted\n", info->name);
 		return -EPERM;
 	}
-- 
2.54.0

