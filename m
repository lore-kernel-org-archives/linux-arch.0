Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020099.outbound.protection.outlook.com [52.101.196.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1A32B116;
	Sat, 18 Jul 2026 19:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784401293; cv=fail; b=ffyDuXWxf+Ah1JEjN6d4hsW0dm3M9WCsfgQfWtyW9lri6Rc+w17JECwki2OTs4z6i9VZsQJgVspy6WbpnxMqapGyGXIZVYAn6hBaX3kn+dr0i2DqDiMMsZ7E/ZuGvR5ikrHGsUeNVOs8l8T4+PjUac2KRrVCWaozcJTNqQXLsvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784401293; c=relaxed/simple;
	bh=so1dlDgyh5SgvuE6lXxmZdBd4YUCra3ElpZ/PrqSIOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nGFum6xZhlo3OQsJ4OpBZHSgXoLAtNpok6J8vr7+snQskAK918/XK5z2JP0e/AZznD9Vpn/ozQy3LmG5zfYFbukYBHjYx8nQ0fg1YlgKTwYdkC7NDZ3aZUvHmkLpaGIc1ah1hlnuQBCrcv/bnaFW6cYtJlLRPl8ex5XeKzAw+W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3mXyKC5uTZxHtN9kMS1EvIOzU/vfncBT/16WRMsAwzcbcPt7q2uDUesX/9W1mOUiaxpDOSqPMl0bKSwe8XZ3lm/ClU6689rZgv9dYUcEcyDG39JBcOoczwADjhTGWQT/kqzIZZlfMHVqbCmUg57AAM1TuSr9LfLr6OBma4+frN0K9kHkf7w2h2AcK5GTy8bOd7WxmHsvl2FkMIEKfiTrJhdlpy8DdDDeS9v9MVWsS/uZgBtGB1xeHat2Um1AGgO/GlN0iVdruB6q/0vSm+3nESZISfINusCdKAQAQZ6jM7QTJZhQPd81Trp6FhVh1AYu9zdm7goSPGBs6wqbW5/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=4CHddH/+Pc0J1wem5XVEGz1kZ2zNER6ZJw7ezQGZxK8=;
 b=t7HmLI4l/XEyitrjcn2oMYvjiDEoFNsxLDh0excmCSflFHb4088KiITGz7Hx7yUB+8HEoraeJfuNZCcz1zluJ5bBdTLB6pBtbujokV/uXOZeuT6uxM9/Scugrp9vw/SX5TXX9KPAkflFs/GYa6OJfhqidgiH/DjTOxkK1JvXK+T+zQxJvqoflEzZRoRiKXCqlDFO0Wql61h3OrXf/2IkZOyTZs47bG2Kk9cfwgjnFLbEuLFpzX++x3dmgKQkxj3O2xn8hx0SMe6F4fpOiWal8olLjI0Rb72QUpB6a1N099j7Khyvsg144RJ0pUj3qmP2YIOpOovDEspHjLsjg74NXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8091.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:43a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Sat, 18 Jul
 2026 19:01:28 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.013; Sat, 18 Jul 2026
 19:01:28 +0000
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
Subject: [PATCH v6 1/2] module: Extend module_blacklist parameter to built-in modules
Date: Sat, 18 Jul 2026 15:01:20 -0400
Message-ID: <20260718190121.378314-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718190121.378314-1-atomlin@atomlin.com>
References: <20260718190121.378314-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:408:e4::8) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOAP123MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: ac39209e-a718-4c7b-e286-08dee4fef923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|56012099006|5023799004|6133799003|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yJaYvRvxpUHfYND/p5KBTC9xe36Ah8BQeieYCTZ4UCNeh5Ec2B2WLzY4UeVmDKmALfiuxBEvNNx/tMMmoF9GWtSlb3SCOapNZ6z6VeUN564MtFWPTKgq2Kze5D8EEuqo78+Vpf9rxpCuj9esdcABcWaUnIwhQ+h2Gn6aONKE9t9DQIu7k9XK4aHI6IM1sk9QVSNXWJIuIfwPJyQx8ZeaEDKbseRyF7z2i4AUZS4AAHtDGqB323nDbmnJgLyFg+1q1vTV2JeLITM0Bz4TCzuGjfCRzbAh+4I+JnU9AGSgVrmfReIp/5hTMSk7pgMb6pE34Q5LHiu4eXj5Avur3bxsbZU+rbUZljakIeNBxUEHWNRreNlEhbGZL7BAckm5HwO+lC/xnSnt+wqcEiUjIOVxn64oxIsij5vi7HQO5NmNUFIEWKmKiRyj+bQw6Jbf5UD8Flo0zkTbjTgO3wub5b7rsoE8kARAFR0fU5fCFa6cWbATZfCOy4NhS5wd53fZLfYxg7cCN4lzwDYL0Y5qz6guuW8/mbrKXDSzPRqxVe9w+Q4NWry9vRfdXeocSboxEJhqWs2UpHG+TTXkKpBHdhtAljS8g3b7eo9pdSFVHNyv6oP5W42Ud13eeOZdtyXkgV1ayKSAIRgWMZ38AeUNPvEOFGqZpGO7fO9uKx45w3LLDRA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(56012099006)(5023799004)(6133799003)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/s+bkOv7Lgf+3ROTJ7CzhEeLEXzryLWdxiya3ggTcnK5XjBxpHyeez3+2W5q?=
 =?us-ascii?Q?DxfzotobL9cjPlzLsQfeAbDxPO1197ICN0/sPDOFNcb7SBlFzpIrQ8JPnO6L?=
 =?us-ascii?Q?ocB7wkDFyUZKB2VPNwwHU+hcXD0UW9kFrhaRGn4AVu+oD9OZMCLodmOw/5kq?=
 =?us-ascii?Q?/tEiv1cGp+tU+GvAfwCxPw/i6/m7Lc4xUDhE7OEjbuF5hHAWXDHxe6REyVnU?=
 =?us-ascii?Q?1B2nnEZj5OQuSp2TUCDQdv/A2YTpjhxnPBZxaudT7FdUNdUPNYWURDFv4IaL?=
 =?us-ascii?Q?RxW1fBbzz3wSvq8TZ9be2k9FTisx59XAbFV08n3E0fqo7r1LPPOXinJXaJVE?=
 =?us-ascii?Q?lIJNDbvSE2iTbU0e2A3nn2X75y6s88DpEbeQu9TLZ+U9oXBOZYcNMiTLYQfA?=
 =?us-ascii?Q?NBXqL/gcYXCdsuCj+73bi9PUWxfGnsuQf9dRuk5nk3t8QfthmEwRnrp5klRN?=
 =?us-ascii?Q?aabgb/+3Te007Z1sk43tolPD237yG8FFzbKAaYPXJdYiAGbaOvKuV6tC7bhQ?=
 =?us-ascii?Q?/YAtCJYJHFVF05hD0QXpMyUcWuiKpjYVzUCSEV5jMnnvAnzRgILEesk6RSgM?=
 =?us-ascii?Q?0ZDFG/n8aO0EfCJDWfgf/t2221biaXIpL8POEjrepmzIdo8lF5XtBYryQ4W/?=
 =?us-ascii?Q?q+MTU6DLhHRKSaDGeM2OQGQY3L9cMfqgaKimtZe/DXU2sLP178IFy7BxC1mj?=
 =?us-ascii?Q?QuWcoOXbJoK0H9cTSIUQKPP0r2N8RgtCDuWfepmZahfNLdqyQL8WyZhQH0cG?=
 =?us-ascii?Q?eXOl3xla9ydHdWf/1ZDSK8jRujDYFj0d/QpXIAopVN1VzDtlEA+nBQKSrWz2?=
 =?us-ascii?Q?odKuuODAcjhFZdtAKgr78oIAvoHLjoGr4QXgFL9vbAwcEX8OrQmzncOdmtsC?=
 =?us-ascii?Q?Mu1GD3l1uTAAQ8NsA8IHNx8NvgpJwea4cYI3xYaw39LXaGGPMhSYAUc2IgI+?=
 =?us-ascii?Q?XWVW5u5OPDElrsMN4V64fd3HC6hvn/xu5oK2NOLyA9+bWd0WQP4bZ3bvTCeJ?=
 =?us-ascii?Q?FpEAK0CMcf7JSHFu7NKWrl5dlNWmQvpjNot1yZ4Tbrwd8kG79N/DKnlOkRJz?=
 =?us-ascii?Q?xxipioycg9YHLVbDuPVoxV8KEaRb9SqNlQdO+X6RKSIPH+Mr8GDb/e+cNWPG?=
 =?us-ascii?Q?MhTo4MHEKMQxI84ioJ16tfv+plnB6I3FsuzUGp614WeqbguoQ9/tfR+l0Ve8?=
 =?us-ascii?Q?1YNrtUigC7U3/qkGuo/Xjwdhkkrbfd6/0VyTuk7sFhIlGkEaNlzOyZuxWVXd?=
 =?us-ascii?Q?I2VQmCkVq5in64VjP/Bt66SniDFLUszJ0Blq7gSR+5u+X2HKVnbHp9abgP2f?=
 =?us-ascii?Q?A8AFhJNsIaOeIKvdQROTvyMDjsT8MVGuXPJvzCmZGk1bVl3lwRLFhimB9DcR?=
 =?us-ascii?Q?TPei5vNfTvNv1Lx2VBwtJnNAIdRotBlQs2IgPc6G+78IaAIQsEPSW2PzEp4U?=
 =?us-ascii?Q?IO3MCvrffZZ1zXgsxlr/ypequyn8lmdOzwS1UJ5dWoc3z1hmPTuiH9IigKXH?=
 =?us-ascii?Q?0/hMqNGvHEmg10yddLKVU5Uc7ZDw1UIy0VUOJberUb02BzWXZHHPjO7oytSU?=
 =?us-ascii?Q?t9GtKdPKeiUiojaLZaXUQUs4ueY7pv1IY1jMhqzbvNmvydQj1YMAWeqhetVG?=
 =?us-ascii?Q?jQ+GposUTW5B9K+iHkZO9bA3WDkhxSLqkeUOwxVdWv/cvNhrAq8kr6twAWZp?=
 =?us-ascii?Q?prmNKjef0GS3UPsf4XUngQqV4FxLjzhzS3i3uBWQQxVKYqzN92lMxMm8rXhu?=
 =?us-ascii?Q?yRMK5pyFpw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac39209e-a718-4c7b-e286-08dee4fef923
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 19:01:28.6945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yt+1RVIvbuB4UcFhegxsVte6G5L05N2xsfh4t2/SBfd0tyLRsB1XBT88YRWoCV9726CABcEohb0tzTFTI0lDPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8091

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
 include/linux/init.h              | 23 ++++++++++++-
 include/linux/module.h            |  5 ++-
 init/main.c                       | 55 +++++++++++++++++++++++++++++--
 kernel/module/main.c              | 21 +-----------
 5 files changed, 83 insertions(+), 25 deletions(-)

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
index 40331923b9f4..1cf163715264 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -271,7 +271,28 @@ extern struct module __this_module;
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
 
 #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
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
index e363232b428b..ee6d7db212d5 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1334,6 +1334,57 @@ static inline void do_trace_initcall_level(const char *level)
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
@@ -1406,7 +1457,7 @@ static void __init do_initcall_level(int level, char *command_line)
 
 	do_trace_initcall_level(initcall_level_names[level]);
 	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
-		do_one_initcall(initcall_from_entry(fn));
+		do_one_initcall_builtin(initcall_from_entry(fn));
 }
 
 static void __init do_initcalls(void)
@@ -1451,7 +1502,7 @@ static void __init do_pre_smp_initcalls(void)
 
 	do_trace_initcall_level("early");
 	for (fn = __initcall_start; fn < __initcall0_start; fn++)
-		do_one_initcall(initcall_from_entry(fn));
+		do_one_initcall_builtin(initcall_from_entry(fn));
 }
 
 static int run_init_process(const char *init_filename)
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..a8021039d44b 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2919,26 +2919,7 @@ int __weak module_frob_arch_sections(Elf_Ehdr *hdr,
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
@@ -3391,7 +3372,7 @@ static int early_mod_check(struct load_info *info, int flags)
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

