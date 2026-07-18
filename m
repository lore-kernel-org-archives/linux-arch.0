Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020101.outbound.protection.outlook.com [52.101.196.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC0B2FD7B1;
	Sat, 18 Jul 2026 05:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784351641; cv=fail; b=XJnyq9EhLK78h+g0dfV4gYw3zLwoTB/ua/yeYJYWMMeVXZ2OgrrwROxE2ZVzQ2wIDnr6MuYHHy8fnC4d6uTfe3mGQhpq7qJY2OwqQMfTXUo8tniZMJShdDiT+6aYikMI+DEeSFYQCPTNDY42QZ2SHQ4fj9i2dH2kWf3WiyM7BWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784351641; c=relaxed/simple;
	bh=ywqMUsd+i5ZCEZlfmfau22E5nz4v6fUbTQ34xVcYAm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VOYjrAH7nKtm/8QiRE5M2yXpNBJjz6WbpfckEhFQCcZX32y5jEZZFvbnNQ3HIG84rRYuspRTuq0ugUYuGJWLq0yhqG1Vi/enJRiJek5JDYEchox7hq2BAZUUz3XjCtZvFrL8hEtlowNCkaPG++Ba2Fxl2k79xiNMBEq/dpIRARs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muR/IYJqb1l3leNykgRPkex/CbnAfvT/z6E6XyTA+bn22L1rde1a+fSn1RrcibhSy5/lU94h3cT+b8z2ALJqGSW8Svs/+2T5wpF3Qk/pfh49ayXTAzQAwq9bBHpBjG1yciTewV8GO3+VdgIvFfi2cXut6zahLkSRGqgY8yj0bxxKEYYdcQ7EUYIPmvIs52m2M8u4RQWToD8pTdQT63Aw5Ru9+uaqKVtemgiOYVv2ZSRvSGNxiA0mJjm4bpUefPuRVNJa8f974bDn1RcDDGFSk4SX7ysXOi0Yqsv3dDmx+qbVWSFPeo3IgAVDRMPTAnxYk0VyCDABsW7S9M6LjQJpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=/020N/NbjJOFCBVVipSTGzHDNzrxACQQrcDtLIg0CDY=;
 b=BfmIihoq+AhVDunVpdjlR3PTy7xZvqbKNoK7be9N66WTg9KhySNOdellj3FUx2nux1028RMrbGgVtlOpaqt4yMla7Av1pTS60YEd6QKsMqydxLGFi4w5lrnqAK8LtLd5GjKCn6BrZ/WV4tZhn0K2sVi5XbmhMCGTmJlOFA2Iz5F4dUlL6pQNdLUcttqlkdmmCdGhbqrwZZubc/8HuWJp3vFEyH0O51yjqeG3uJj+qcP+gSl+BZngHhoVeKT9Oe7THsKRvgvK+qjGcg8h08JLZbmPsIZ9N0YvnFnaMNe6fu8Ey2CKPvXMpYHdxLsHVm7dx1DORCjsC6MsiaP+RrIqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO9P123MB7540.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Sat, 18 Jul
 2026 05:13:57 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.013; Sat, 18 Jul 2026
 05:13:57 +0000
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
Subject: [PATCH v5 1/2] module: Extend module_blacklist parameter to built-in modules
Date: Sat, 18 Jul 2026 01:13:49 -0400
Message-ID: <20260718051350.344772-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718051350.344772-1-atomlin@atomlin.com>
References: <20260718051350.344772-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:408:e7::32) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO9P123MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: b46dc914-cc99-48ea-b777-08dee48b5ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|56012099006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	2JX7DfWNruIt1gCQtrxsUQl0K6eiTk55cG8BCPf3Myv5D/MtIbAFTOND6ffHTMDOUuXLHtZym2GIXnhOW03V6hksJ/shx47z1SudAf8ixcupzyYQRQauFmNtyWBEa24tEiydZDdT5FJMlBdoZMbZvgVa6u3HkoEf4MOqY38d6gmelsJItSKwxixo1WxK89BoXCGfH4uR11mUfUBFX3qpijGzWKeuo/oXOlOce6x5J2Y9G9zH7UFvy7PlmwCVt+5gXsfUS6RH9taP797ec4obuLK/W664mbZIMI0xjhZ2Ji+SH1Zsup0ssm2+F6HZPIWZUM6IYEvRcvCYqCA2HXSet7eGVpHsN61Zx1j6UmNy4//OPButXGRS/YGNZOZTcPSw8Pjj2gHHdwUei2EMQ+iM9Hmn+Nug79XzYo2I/9RMqtQ/fcXvMwnfPTsCem+CM9bXqmG7m6pax8YzyvHj7dNjjl0mcv5s8a0NiIhtjtyj74yvHGCPTeMM3vOmsTzB5SK1FE5xH6iTUgbXIYDZCPWVaEO1oruapfm3IKYykB6seHqPUgf1eTAK7WocB/NBxZKKdDdMgpDoXT85HJ47PYzyVcVcz7dBsCccdVUMcLXcQitg7L4vHKSWlCy8n4Gm+o06U2IDc5KvZ8PQWxyFq8rZMtRn06GlEskjWfvUgO0Ebr4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bZVvrN+AaslgdmyI/V49SpTPcCV9LG7/qufhUwlZcAZkstVIAAF0Raz+sBuf?=
 =?us-ascii?Q?j22R/ywh56MT+X0CZqh+2As6fOTE2k1j/sw6kWxAnNirgJMkSv9FPYOoNTOg?=
 =?us-ascii?Q?32RAaYgeoHusYtBTX+QADd4kXOhCqH0vG37vi84upXH9HiAMOuUdLkeLGDHW?=
 =?us-ascii?Q?isI/P29ZAJa3QupmwWK18Dyl3inWawebl4Al/wk9I7HqOPGa1527AzCQ7j82?=
 =?us-ascii?Q?47SuqG15M6C72MiJSye4i1DgOmvo5wFUDu8KH+6/acAaNYkqt6rIqlBSjdik?=
 =?us-ascii?Q?e0w6eYc+SW4vmsN0OEUiHRpPc3yAqQszNkn5R5xPq8t8kGM5UaetmRu50PT5?=
 =?us-ascii?Q?/aTKOIfOixRlv5XQfh7Sb34YWDsgSrQf0/nG5/LZWOSBTG1UEQ5pn3GZ6spe?=
 =?us-ascii?Q?oh7mIK3srAw/imMU9rd1NFFSjWpQtir8Qk3RUzarD4G5i3IYvP5WA5aod4Wz?=
 =?us-ascii?Q?CW06gtSWcyTsRoAZSZfy5f91yZIoKvVvIMv5Olrpy5TGxYXHncQzy4Kfo1dg?=
 =?us-ascii?Q?VOQpyAlSkaIwexXaaGNVuTimSRfznG0ded/j3/OIWhgW3I2qCpFRufyzJHzf?=
 =?us-ascii?Q?SvonPqrzzZnETdnMx10E/N1ciU9spJLUKiuZ/7G5DXcrwQ7tXeoTU+ZTGwQd?=
 =?us-ascii?Q?P+U7o1pS3gwMpHC2WNf5+U+GQlN8OXWUkDu16h2X1OfIj5iL+3FwbGP1fp0v?=
 =?us-ascii?Q?3XQZ7VYmtzRAiwpzrz9fCIADqJ9Xqej4axSOE0mxl0P6vW+emcXjwmxMx/6Y?=
 =?us-ascii?Q?GfitKlNQgwFxjv75kDBrBHVCK+Fp3XJkVEOVJJ3nZKxj+jaCPv/9L9Kjd+6r?=
 =?us-ascii?Q?/WxiDmIVWLPYLgrLd4HaygvJdB1FvS0FRAXQSLm95pSUuF17ApgAIkNtHMO7?=
 =?us-ascii?Q?csL9fvdq72synyq/SFv95uVbBnjuUzjGCD9fv7rtZJOgCA89qYjKZsm++ixN?=
 =?us-ascii?Q?24MLexD9z3ntet5u0IkvwzC+RGB7NH9mu6Vl57ihu3VZO5AMcEDYIFfkUO1B?=
 =?us-ascii?Q?EEiYqJvEDStyRmq2wloj+Ewc+0E6hRuvPHUB+az922OCfuxbqC6FnCZE3x7i?=
 =?us-ascii?Q?HE7Mx7fGjaNxg1m7zMrujJQGXSuv3wcPj7rGurwBQwSm6MqVpHZQL9IFPkof?=
 =?us-ascii?Q?lRbz+6rSkn6IuhWOcGrF5xDxxcluLJyfGmDK/ZjDL+8yy/4tdbek2A+YeJXl?=
 =?us-ascii?Q?/xCiT89cgXphZWffvU/49zoYGDyjYZFu+rT9/E8p/QTuFUWT2rDR+tXkysHy?=
 =?us-ascii?Q?KabXK0u6YeaEML+md+824ITDWERkCGzTVgzeJgJ1uLjL2/ExPkUwONeLYay7?=
 =?us-ascii?Q?x0oJpjNnaIwn3UOOAJ29S9d6WnAYK010qu28ItDmp6YNbjhRNYQLfcOJAv7r?=
 =?us-ascii?Q?WD+u1ObHhpy8AWUljQ/m/kjbab4iqjh7nAugY9RJ42azQSKKm9U6UdTH8i8G?=
 =?us-ascii?Q?DUIYcn7XYN51t+G/MpjYSPui7asHAdBfHHtE2gIPM9DkbBXXnNZ5nM3tlWRT?=
 =?us-ascii?Q?tfQSAcjr0BLPE/sxSvucmx7IkSbVgeAZTkeZilId2Dm+QXRyIFKcAZXdnSRc?=
 =?us-ascii?Q?cf+nwuy7av7MzieksK+LoBLDHY4sAsjmfqY2Qmci15TOh1bl7mmbpnPaS3XQ?=
 =?us-ascii?Q?Z9/DQPi1y8OjsxYA8dFkB5phuBvpGUnJ6HKvVxfZa68NppHtVI5IUos8qevn?=
 =?us-ascii?Q?CYVz2RqEQPCnDs8a0oCsHNOIms3DPDbrUpXlG7JEL78e2euKhjdbK8HRppEI?=
 =?us-ascii?Q?2NG404Ix+g=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46dc914-cc99-48ea-b777-08dee48b5ec3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 05:13:57.5854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNOfiC4eQQ3oIwae/zw6MX1FXfD5r0qIy48z2o4YNohg3fQDLA0nb+U9P731Fb1Fe7EBtn72dDv9ygyw4nEk5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB7540

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

During boot, do_one_initcall() cross-references the initcall function
pointer against this table. If a match is found and the module is
present in the blacklist, the initcall is skipped.

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

    2.  Prevention of UAF (Use-After-Free) via temporal boundaries and
        performance optimization via fast-path check:

        Because do_one_initcall() is a shared path invoked by both the
        early boot process and runtime module loading (i.e.,
        do_init_module()), we must prevent loadable modules from
        attempting to scan the ".initcall.modnames" section after it has
        been reclaimed by free_initmem().

        To ensure safety and optimize performance, we employ two checks:
        - A temporal check using 'system_state < SYSTEM_FREEING_INITMEM'
          inside do_one_initcall() to only call get_builtin_modname()
          before init memory is freed. This allows get_builtin_modname()
          to be safely marked as '__init' without risk of execution from
          runtime modules.
        - A fast-path check evaluating whether 'module_blacklist' is
          populated before performing the table lookup. Since blacklisting
          is strictly opt-in, this avoids boot-time lookup overhead entirely
          under typical boot configurations.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/asm-generic/vmlinux.lds.h |  4 ++-
 include/linux/init.h              | 24 +++++++++++++++-
 include/linux/module.h            |  5 +++-
 init/main.c                       | 46 +++++++++++++++++++++++++++++++
 kernel/module/main.c              | 22 +--------------
 5 files changed, 77 insertions(+), 24 deletions(-)

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
index 40331923b9f4..74d2306497d8 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -271,9 +271,31 @@ extern struct module __this_module;
 		__initcall_name(initcall, __iid, id),		\
 		__initcall_section(__sec, __iid))
 
-#define ___define_initcall(fn, id, __sec)			\
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define __initcall_fn_ptr(fn, __iid, id)	__initcall_stub(fn, __iid, id)
+#else
+#define __initcall_fn_ptr(fn, __iid, id)	fn
+#endif
+
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
+			.initcall_fn = __initcall_fn_ptr(fn, __iid, id), \
+			.modname = __initstr_##fn			\
+		};
+
+#define ___define_initcall(fn, id, __sec)				\
 	__unique_initcall(fn, id, __sec, __initcall_id(fn))
 
+
 #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
 
 /*
diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..fc1525e8f63c 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -86,7 +86,8 @@ extern void cleanup_module(void);
  * builtin) or at module insertion time (if a module).  There can only
  * be one per module.
  */
-#define module_init(x)	__initcall(x);
+#define module_init(initfn)					\
+	____define_initcall_modname(initfn, 6, .initcall6, __initcall_id(initfn))
 
 /**
  * module_exit() - driver exit entry point
@@ -883,6 +884,8 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
 }
 #endif /* CONFIG_MODULES */
 
+bool module_is_blacklisted(const char *module_name);
+
 #ifdef CONFIG_SYSFS
 extern struct kset *module_kset;
 extern const struct kobj_type module_ktype;
diff --git a/init/main.c b/init/main.c
index e363232b428b..0cf64d19b43f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1334,12 +1334,58 @@ static inline void do_trace_initcall_level(const char *level)
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
+		if (dereference_function_descriptor(p->initcall_fn) ==
+		    dereference_function_descriptor(fn))
+			return p->modname;
+	}
+	return NULL;
+}
+
 int __init_or_module do_one_initcall(initcall_t fn)
 {
 	int count = preempt_count();
 	char msgbuf[64];
+	const char *modname = NULL;
 	int ret;
 
+	if (system_state < SYSTEM_FREEING_INITMEM && module_blacklist) {
+		modname = get_builtin_modname(fn);
+		if (modname && module_is_blacklisted(modname)) {
+			pr_info("Skipping initcall for blacklisted built-in module %s\n",
+				modname);
+			return 0;
+		}
+	}
+
 	if (initcall_blacklisted(fn))
 		return -EPERM;
 
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

