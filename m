Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021113.outbound.protection.outlook.com [52.101.95.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40835317173;
	Fri, 24 Jul 2026 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784857437; cv=fail; b=N3DEeyVRXxplpfbliz7sWsnDEaCJ4vJpZ6AG9nGCLFFfH/4XlAezfnUlRZf2FKL0T3rUyNrmY2otCSN1WJnaarqrtVAwE5GHK0SgFRdmg8hivVFdWAEXqRmpcf1fn6pLFGUa2kIGjzVrGf4hQ8U2yRrjy0D8ulzFwd4O8V3jUWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784857437; c=relaxed/simple;
	bh=jb5GT73RCmlVPr4ctr/5ICOcdzRgvJNPIkn5cewGoZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sz6d0qexQhSAPb7apzK83hczBcMOSPrUB0kvyfX9I4hr9nu8AeiJjs4qzQQ4M/CrV9C8WZjM8O0JskdTTzZWKTDY8XPzMm5g/x50DXWSxSxOsJSfapyGGW/xjK59Rb2RLD/bH9T5e9MKKxNzxqy5an/Tt5jLkDWhtdRSOdxfrM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBdDbInpmlFcuGzFyMVYYg0iohhmyLz33YbXXA26aHJxX6pk9EMR2HvAHib9sm2gYMP520IPhB2xCJJyZ0d0oWapXZ6Gfh7bOQwpZ3NWXJ40s8CqrCBDUZseS/smQ9qOcIcjdGon7IfQJ9DZOVbozsk0h8R52DyIryh5gDTer62kBkKXzqHwZfu7bd1FzFLoX31DS2tpt3Nlr5Rm6+2hGQLs4FEPEEC5WwC/5fl4nBKnsKpRrEupCA2W0BIp6XUTrUcwccpMweHw6kbhEti9lN3je1tsIcn5GjZShR/SeS0cWS5lR4CXB64lnLHz7o94l1FaI7//J8LyIxQOnx1KUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ApQNd9h9XPCRC9FR53n2CownNGs6+BA30U8LEdSV22M=;
 b=m7GQXsPrBq7hDJym1ESeYucc/5GmVBXezXauVHq+6Io/WpRZ2cNVt9R0moYjLtPTGPqDLhR/9OtsXhOqIuYLDGaCVPcSbCsrplgz1xuNeFMTzQJc/eQA+/kBPN6H5VErbYCIvSrw+5wwQ8r8/0mD8loqDI3fdT8DO1lH0DhFCv0XoXgOclvuABWbrIDUtoovgdsBRL8o89pPbIpVU+wdYcp3w7ODrPjPdGRb4vwiZJxWZQI+oHPcLx2ltEv+r7hl9jCtJAc3iAPhZ4fLmuLEcUrkB1QZgd0HxhIR2to2wOoIoBYoac2coXDR9VHGP6W0F612YgN+Dq4memNh0xHZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB2974.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 01:43:52 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 01:43:52 +0000
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
Subject: [PATCH v7 1/2] module: Extend module_blacklist parameter to built-in modules
Date: Thu, 23 Jul 2026 21:43:44 -0400
Message-ID: <20260724014345.589326-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724014345.589326-1-atomlin@atomlin.com>
References: <20260724014345.589326-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0089.namprd04.prod.outlook.com
 (2603:10b6:408:ea::34) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB2974:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b41c759-705f-488b-22aa-08dee92503e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|6133799003|18002099003|22082099003|3023799007|56012099006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	3niiDOCzwT6PV8gfXsK+Q5tZv/rV5wDJ/H6UFHuHf0cikImNoPc6wN+r211BLeE6IlrpqL00drcTnG7kAQDJVBwe0FDhYGJL7WRkKNT6qkmO+iQXycNiW6nK5GESq/HTfYGi0pDSMKfxUGYq2yQORF/VsP5qBvU7KS8nuES0rCZ4v/K+fmWij4oMGlVmJZu5PA5Bkc11qXIzkHLbPunRw659QLTv2Vz2rW6Ttrt0jHw4r0umHBS3OEaIWppuvcqsgtjG48I3Evtq1bDCelXeVkPzrR/dSx7Gfr9SVGsUvzdwojp8qI4aW4p676hQt347YICITbeVLeWzw+Tcy3jWdpPDuJk3OMi7z7BTNjrLVFWztNT8ayB4YaXpHJg9z/6OIqCOeTfwl0Zkudja3sDsaTVW0NiYR5ScqWstc6yIHqRNRzXnel5uzQBUqwQniH3xvo0k42lcrR0ybSqPMSPHSkTrN5tU3GPM043P52Yeo6rriLJ3DfVKHU8wxLHHlMC5veGdS0UHixzXXl3bWyBeAD/c5CkQy8dAQ8Yh0QPuQHuhnfIeuxtYNhdN/kTyUIrigFjqZ0/TDO44IZQE+RgG4wRKS/aIH3w1ysExrykA5C3SJ23cRnt0ZPUxK03ruKFdWMLdX6Upb6kia/sNsW+eH4JcZDNF2YAyudlXLknbbeA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qy9NVsi4kLa2/fcaIqqGq2ly9inol0HIB0vE+AzeWROQPd4vvTxcM2Mx9GN9?=
 =?us-ascii?Q?5SZgoSiZgD3epwrWlM05W6ye+lSWV/25YHKbo8Sz4FPQCjVcxSVX+jPp6GXu?=
 =?us-ascii?Q?5ge2I/AGKPSmCYmFzUL0k0yN4BVFmEzztfPefnYtLXGBjuz/pHwoMJ57uCVA?=
 =?us-ascii?Q?i40LuEpYFHNzJAVHHZgPKbIZsCzHPnIRLQIiPnidgDfLtH2Ze2Fs2ocjnbk6?=
 =?us-ascii?Q?BQZ4QNpQ7jAlyoLoS3BsAvTWNWHsfYhESKaBOt8wL4s/CzSDSYXlnzzUfGWi?=
 =?us-ascii?Q?WVSQt4+8uxx5yzJgEfct2DZ2haFOGNnPMvfO0qaaziJ7KLLoteq8T1CQIQqN?=
 =?us-ascii?Q?WVlcA5lRRhAAC6g9qjxuQYQIy9JpLGaEJ926gz/2c59gKgQHEaC9NBhrVZOn?=
 =?us-ascii?Q?bCHTjly5vJvxI8bOt2muoNzpt7cQQHo9oloIEF/KXexZHnC2V3Dc7ky9Wv5N?=
 =?us-ascii?Q?SmVCCuPWLJJd8XQbROwVsspPlP1QgrXq2QMlmfJrj4wkUdWFeuyzSPprwN9k?=
 =?us-ascii?Q?iwsbH4k00OD0N/1qqffw010mzRqlOzW3ruXJo7va7TUzADEWukBkDgvbWGCF?=
 =?us-ascii?Q?UQWfq/sLIz10AXN8G9vVJMh6Asvw16o/5X+hA2pE+NDKnbYFQ+khdGJjivzP?=
 =?us-ascii?Q?bZb3zTlIGWRY4RpjIaqnCNybxrMdNKff8tumuop37UPXkSDBOAirY2jvZGVD?=
 =?us-ascii?Q?IRv8wC0YwanGoDTz+5W+OaoAz9gXIvOp+hMCJ/b/i0r8E/A4DZ9CPLcEMQJZ?=
 =?us-ascii?Q?/iIMruiSIAD45k/5B0YiZHQFEx5L6UqtHiMfQK0Y4Y2JDIqWEXZzdh6lI0u0?=
 =?us-ascii?Q?J0ComEWPFkfaAShCRHjw/WONYhVtAP6zshosMO1m+GQ5JZ8wFB7E8S7rEJ/f?=
 =?us-ascii?Q?9RQIqF29WKt17Xz6HIgiN0OwQzYsp89VgTtBWRUGHgxn1SkhRtcn8V6a7Lfz?=
 =?us-ascii?Q?hRXaSXI+0xxOL//SzEF6Mhd1vA7Ybisds7TH+18CbIxEOfo8wSy4Dtfvg4ki?=
 =?us-ascii?Q?rKRCwpM+zw12k0mnJ5XT2yVI+uTlE+xhYDggX61w9lHZDWIXKOQ60JOkGfUf?=
 =?us-ascii?Q?U4ITd2TUTmABkgQKpw052QQxOF8Fkf/Cg3pbfwQOmJ1LR0M7lyr7C/OLBW2p?=
 =?us-ascii?Q?AxF6BlzVBS8aXT++RUJtt/gKjlGA9+MFBobNVrihK5HeSj8G5FnY8W0Onm+1?=
 =?us-ascii?Q?nbgMTtZH4mB9FxoLXEpJuZIHJCjZbkTt36f2oi1PZs9pekUj3aeJtlA2a9hE?=
 =?us-ascii?Q?i1HJ8WesQ/PWfyR5amiNaV6oKJ/MzOS3oDp6VI3JSamAg+ohQgGo8JK+bvAc?=
 =?us-ascii?Q?eujMtz1uWB5TZ7lHz2PhJnVEKZLM7T4O8JdnlIufLGfucPJnncGu594s/QC+?=
 =?us-ascii?Q?uaFvnlNGgsohF7dgZFyySrUW0rvb6kRVpnoBI7NDgOGCPsOsMPdrucDKfFT7?=
 =?us-ascii?Q?u9OCKywbQDztcLW/6jH5X6QvqIcF+d3ihuBXf6+8LkqdPCHsmv9+6asL9Fo3?=
 =?us-ascii?Q?XGL1odD49AbXrX7EldZCMfxuNSkn3EZKAJZImj6x208d4vjlg8Qif22DmRey?=
 =?us-ascii?Q?r+j2g9gURGa7ZN6kbc6oW0JtO4ReiMsA+z7h6JwQJZ6IpxjmOfxfq8EEh2uC?=
 =?us-ascii?Q?3+smbqTaGFMWT32+zn3CcgxOFmho/T3eaQGS0p61SdlaMW1ru5I9DUXBDVSs?=
 =?us-ascii?Q?mj3I4K+TpV7MBSLZnX8RTl44C4pGrt/aazuMoHByGBKsPe6qgNuLFiVdBwUe?=
 =?us-ascii?Q?n/lXFOczKA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b41c759-705f-488b-22aa-08dee92503e6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 01:43:52.2961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3nN57RweVJPsfx4nH1CSa+lLSrheoRXWi3reTuz130C4M+4EKEEfnMxHIXgrenYA7OQ/y1dS6shbV2W1S/kZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2974

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
 include/linux/init.h              | 21 +++++++++++-
 include/linux/module.h            |  4 ++-
 init/main.c                       | 54 +++++++++++++++++++++++++++++--
 kernel/module/main.c              | 22 +------------
 5 files changed, 79 insertions(+), 26 deletions(-)

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
index 40331923b9f4..46141c263ef2 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -252,6 +252,7 @@ extern struct module __this_module;
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define __initcall_fn_ptr(fn, id)	__initcall_stub(fn, __initcall_id(fn), id)
 #define ____define_initcall(fn, __stub, __name, __sec)		\
 	__define_initcall_stub(__stub, fn)			\
 	asm(".section	\"" __sec "\", \"a\"		\n"	\
@@ -260,6 +261,7 @@ extern struct module __this_module;
 	    ".previous					\n");	\
 	static_assert(__same_type(initcall_t, &fn));
 #else
+#define __initcall_fn_ptr(fn, id)	fn
 #define ____define_initcall(fn, __unused, __name, __sec)	\
 	static initcall_t __name __used 			\
 		__attribute__((__section__(__sec))) = fn;
@@ -271,7 +273,24 @@ extern struct module __this_module;
 		__initcall_name(initcall, __iid, id),		\
 		__initcall_section(__sec, __iid))
 
-#define ___define_initcall(fn, id, __sec)			\
+struct initcall_modname {
+	initcall_t initcall_fn;
+	const char *modname;
+};
+
+#define __define_initcall_modname(fn, id)				\
+	__define_initcall(fn, id)					\
+	static const char __initstr_##fn[] __used __aligned(1)		\
+		__section(".init.rodata") = KBUILD_MODNAME;		\
+	static const struct initcall_modname __modname_##fn __used	\
+		__section(".initcall.modnames") = {			\
+			.initcall_fn = __initcall_fn_ptr(fn, id),	\
+			.modname = __initstr_##fn			\
+		};
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

