Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022088.outbound.protection.outlook.com [52.101.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3845B280CE5;
	Fri,  7 Aug 2026 01:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786065974; cv=fail; b=G0+lBZScaNGPATudEo6s2FXgIScG1FpnN5yV8DBql9i0JdZ8GB8s12RDKHmY7vv7joAbSrWMNIq9TLLcBNKxWmmGNJDAc5MFaHUxU/GBTdfsE5+eULbbqRIcY1OB6z0OOKSPzNYwy4KwzMJkJo7MvTJnA4HATTpKKhjlx094dbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786065974; c=relaxed/simple;
	bh=cu9mh/J+V/LRdtN4vKX/7HnHq857SbvLIqR//85gggo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nuKaFFXaZjyxzDdtDO8pFHAO/Q3uFX2FV5CMkGQ56/fN5yyJEIiXjD8TNeWs1/AW8d5zALqGHvp+Vh3xVX1fiewjbFf3sdpRrP9wYWpj6DmZ9qN8F62c42NDBQR+zIxEska7jrFd1ah1nzs72gkONSm3DI7YDHWU+b6GMuOMvdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjqcoDIGiQuZZo9Uiz3pXuWR8Lc6d1801k9udnNRpaz7KbBUnz0wkoNKPb1vVYBYfsSD8vhi+mZckFciJCuYmp8LZK0aawNmDAVfeMenxf5btdjsTD8xjNjuiOcqBiXOqwW5Tg+gHoBfVMBqKnkLAo4wNz+6g16af/qmhbZMqd3g6zVYYEFGP9jwUQJ5Qik9lq76kebnlOoJ9si1A1r9CqZyHOTYkFo8r3g3URCTYorS2aCxXuEi5PYDVKD60l7dO+OE+Rinyux9vMf8iiSKHv0TxT/AyE7uF8hmWIK5xobgTiA6lX6nx+WOEpVT9ZIotwfAbcKetwYEaNCm5xvlMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=iqYHJcnJngxIJkEeE03S7dfyXgSH1ySl0elKWYJ53FQ=;
 b=V626XcR0oUpwf8SqbK7hd0tR0f8pKfdn5mBqdzlRNXgns85bOohbwRUGzUhn4GJs9W+6LA8ZMBkJZnKIogV1EmdxRPNwAdiLi/8uFT03Op2TERmVI4Ka4P+2Fm0c9hD/d4ObPIRR04D+amzY1770I1wd3UEf2O6kejCh5BTaS02WNIC7bnYk+GCZFaDcrhEyE2wvlhqTByxPyE0nI6Xb7CEezrdhkun8ZD2IKbrH8DC9lDbzcBk6UbrcKLHMVLy6L0vHJ15ZD36EkK6hgxhh84bRXNTkPWVacz62jrKB8dVlkTEEvTngifWYkkIcUJJmSkOp38LJS5hX0c4saH5lwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB2825.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 01:26:09 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 01:26:09 +0000
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
Subject: [PATCH v9 1/2] module: Extend module_blacklist parameter to built-in modules
Date: Thu,  6 Aug 2026 21:26:00 -0400
Message-ID: <20260807012601.360452-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807012601.360452-1-atomlin@atomlin.com>
References: <20260807012601.360452-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:408:fc::25) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB2825:EE_
X-MS-Office365-Filtering-Correlation-Id: abcc648d-8990-4dce-e3a9-08def422dbef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|3023799007|6133799003|5023799004|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	7dMhx1UQa0kUeM1JXMLAcN26aIOtfRujGNpQd4HrXoYZYDsQKhqia+AWCqkzlTV1vm86+HYvc1noJvo02MlunbGkAk2n4Stch3kHujcKkWCZu3GSGo2vqIQPe6vT4pUMX7GHfJvEuKdcNMXHc2eH2CBRyawiQIzFrlOSrsCFpXpz55A4VYSrHOdQu7ZDYMSTH4T7zzpZFKELForatOUKqyL5GQXKg492mbknL/dbudp8LG0qNBB8GSpR7BC1TAp3Ovaha93kCxvKKRA6lKInSFRmdRjMa1u1XRoEqRaA5qnla73McgFH8VPmLziMN3JYn1rS8ioTdnPKh7MO78x2/vktfoCWZlX7GJvoY+HbB5pQMoXZBJvKHMtW0gSmp0XcTcvEAdpoG2pE3aM006G3W12S3THLECcLTKzqqqwmLwdvWYQyUlS9suerzKKgeIk4od9x463Jg3GtwESy/iEoEsxfr3l7jUh3pIbeJjTVuv/e6xZLohgzCyEtBwlwpvISB33agxO/vEBsz/L9FGtI4JOPQeyg09zOWBQU9ECCVxBaq/Bjle0lW436EJPYnRO/cnFSbV+inhFHzYb8x/08q9HSKk1xNcDg2ycWD0CG1eGjc3zjzjnzCNszS6VxlW/hqh+mHx0St4Q/16PCHtXuemge34fndYDWUyt3SdaWCD0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(3023799007)(6133799003)(5023799004)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kVCH2EfsDXuDW8bNIsk2tJs075GQiEe8Z6h8M4UExLzKaBNRHqvebfsq84w0?=
 =?us-ascii?Q?G29Gu5FTANp7IvrYVCDY5yiYGwb1bm0mheukyuOGg7ifVpiQ67COEYIjAZ2n?=
 =?us-ascii?Q?7Iel4XuYA9pNAg9ao8VWq+CmS3nQk7/56vAzUwtB0QetSkl6GDug3QTfrRQr?=
 =?us-ascii?Q?RNI6NUAckFA07bxNnlngY7sXKN4Sma3+u8CZf63b2Hr8pBRAupOU0yyCm3LK?=
 =?us-ascii?Q?NKZTrC9RuT/g+hJp/Qhi7b9SQnwyMHNEFEcnhy2bcIdaMR0pT4btVv0PIrRx?=
 =?us-ascii?Q?/J5BVZF5loKRwGm7YbKJ+hSOLGFWqcod2e7h7+0xzagUSErOrU271W8hgMRk?=
 =?us-ascii?Q?w2wsDNU8CdqBKLcp1cAYUs7OtXbh3FhTZgwFIiikSLmaRLT44vcCbJPQ0XG8?=
 =?us-ascii?Q?2sv5mM4KgMxlQBgmnaak8QetIIYqSSwZMNJgmuXjHhQiORHC+AFvQblw+3N/?=
 =?us-ascii?Q?0GjsmbaBNYpqY5ssE+YoGX+I/qIEV5Zqyyv9tKNicnQZkXKnPUXGcNsi/FYm?=
 =?us-ascii?Q?otjDjvz8Qg3wrViK+9FornAJ8yrkvS7ZxeJht5qOmMi7aG+2rUTxlXXpqdZt?=
 =?us-ascii?Q?hO9wxTVNN024pVpEAk6iKl2NwIuy8pE/QmaGzn/tIY1JVImcXNedyDYJ9c3L?=
 =?us-ascii?Q?/uGDm+poSXi2FY8ub1DTULib8LAfBiSyR8NVvlL7Hze+BAPmAJXG0TnzjKSR?=
 =?us-ascii?Q?hfSyPeqNX3wsd0KznS3ANiUAha80v83ewU6ucMoVAS9lD4i1Dhxi0zO9E4Dl?=
 =?us-ascii?Q?8y7uI6ZW74kk/rI2oMYsXP6aXu31vONg2u9LHCjkqDiVLchoyDloGrj4ZdlJ?=
 =?us-ascii?Q?6mldimE82nn4GfwgAjYu1YkN6lJEHvLyXETQ0XehcGRZIzrtolxJysdFMErG?=
 =?us-ascii?Q?aBmOaLn9nNro64YcQEcNeUz3nn0KDk6Ad94jnYZEyMVRGuqaitkGlbUDdXud?=
 =?us-ascii?Q?S1FoX4t6t0+y1/fDLcPIcWveIl5C5A3FuY2HatPaRvkLWUkuIhtlQ7co6qJC?=
 =?us-ascii?Q?zUiSGMpJElJNkjsO5t7Uphws4B862K51CZiKjlJyIPv8Fis2K8zpTqLQ3CHa?=
 =?us-ascii?Q?WcAR1rMgXaPDmmoI4sd/fLoghNHyPvIjivBtw8wxem93f2A3yspEM5z8D3ko?=
 =?us-ascii?Q?d1O5KFPC3EAZ+lHMmxzD9BV4x6Se5xQsLfxhDHCPbAJwPiU43lE7H06uQ+jx?=
 =?us-ascii?Q?yLUV94IaGjq7/KGR/onXH87SZkBjo9yQBSYF3sJ8imKgcVwuEHbZeOWHxd9q?=
 =?us-ascii?Q?PPx71Wv3MC5M8m1WWDrk5pyhigO6Uu02pDINgSHO4vAtbrI9H/f7XhJ4Cs0l?=
 =?us-ascii?Q?IEk1nvbG9MfGMUvvLysuQed8a0MJkBTsHwrOaLd7QULk5SSPDLnyduKMis5u?=
 =?us-ascii?Q?OZ0CuaFBV0Aw6VOHZI7JsC6O3UvBTEO/WXKV5HB0zqPPbtdOEqvX8YukWNPC?=
 =?us-ascii?Q?/1lTm5Y5Rm8ypQaXHb3LZcJtYOfSx63U2laIKrL8giWzohyx6GE3CktZapB2?=
 =?us-ascii?Q?w6CHKV+v/ylQXpuxMofFRxdzqJq+6+Z70fgZIkJ8XaLpSs5hrkPgdZBmosnl?=
 =?us-ascii?Q?yn04xGzQEE7BZkPHH5F1B2qE1qmU12ENdLXFUwWkV7Y4kLXKdxgEdRrbjspz?=
 =?us-ascii?Q?NcdS0DdA+EtOtkGg2l0XqL3Z8GZv1a5bejKmL7kggAIMhdimZy4WjMeCu+tQ?=
 =?us-ascii?Q?xIJhxXA+l8CV1oBJEenQookwxyo2vEyKlPftujsOaQ+AxBa4iADJHkCxB3to?=
 =?us-ascii?Q?0cXA5jy4EA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abcc648d-8990-4dce-e3a9-08def422dbef
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 01:26:09.0748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QaknZACwmC627spCkaIA/PIfLJj06jG1WALsy2iQxjjkDy37ZNa5YE3O/fj5e23AIYUDdzVCqVDkkBjtRj3iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB2825

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
---
 include/asm-generic/vmlinux.lds.h |  4 ++-
 include/linux/init.h              | 24 +++++++++++++-
 include/linux/module.h            |  4 ++-
 init/main.c                       | 54 +++++++++++++++++++++++++++++--
 kernel/module/main.c              | 23 +------------
 rust/macros/module.rs             | 16 +++++++++
 6 files changed, 98 insertions(+), 27 deletions(-)

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
index 40331923b9f4..c32814d27bac 100644
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
@@ -271,7 +273,27 @@ extern struct module __this_module;
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
+#define __define_initcall_modname(fn, id)				\
+	____define_initcall_modname(fn, id, .initcall##id, __initcall_id(fn))
+
+#define __builtin_module_initcall(fn)	__define_initcall_modname(fn, 6)
+
+#define ___define_initcall(fn, id, __sec)				\
 	__unique_initcall(fn, id, __sec, __initcall_id(fn))
 
 #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..f0af821e038b 100644
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
index 46dd8d25a605..db1b63b7d876 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2919,27 +2919,6 @@ int __weak module_frob_arch_sections(Elf_Ehdr *hdr,
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
@@ -3391,7 +3370,7 @@ static int early_mod_check(struct load_info *info, int flags)
 	 * Now that we know we have the correct module name, check
 	 * if it's blacklisted.
 	 */
-	if (blacklisted(info->name)) {
+	if (module_is_blacklisted(info->name)) {
 		pr_err("Module %s is blacklisted\n", info->name);
 		return -EPERM;
 	}
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 06c18e207508..13353b43b38d 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -479,6 +479,7 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
     let ident_init = format_ident!("__{ident}_init");
     let ident_exit = format_ident!("__{ident}_exit");
     let ident_initcall = format_ident!("__{ident}_initcall");
+    let ident_modname = format_ident!("__{ident}_modname");
     let initcall_section = ".initcall6.init";
 
     let global_asm = format!(
@@ -590,6 +591,21 @@ pub extern "C" fn cleanup_module() {
                 #[cfg(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS)]
                 ::core::arch::global_asm!(#global_asm);
 
+                #[cfg(not(MODULE))]
+                #[repr(C)]
+                struct InitcallModname {
+                    initcall_fn: extern "C" fn() -> ::kernel::ffi::c_int,
+                    modname: *const ::kernel::ffi::c_char,
+                }
+
+                #[cfg(not(MODULE))]
+                #[used(compiler)]
+                #[link_section = ".initcall.modnames"]
+                static #ident_modname: InitcallModname = InitcallModname {
+                    initcall_fn: #ident_init,
+                    modname: #name_cstr.as_ptr().cast(),
+                };
+
                 #[cfg(not(MODULE))]
                 #[no_mangle]
                 pub extern "C" fn #ident_init() -> ::kernel::ffi::c_int {
-- 
2.55.0

