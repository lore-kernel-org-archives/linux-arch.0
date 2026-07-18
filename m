Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020115.outbound.protection.outlook.com [52.101.196.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF45D30D407;
	Sat, 18 Jul 2026 05:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784351645; cv=fail; b=R0AvVtaK1q8ajD2RrUGbi9p5789sl/7su1OLB4/VwodMvXQkcJalVJAVI5mw92JhH+JDyKE3Fqy5I+iqPm2Vitl8R2LFJp10O1ACPSaIkxDkjSOprxch5+2TjjCyUb7NADxDZ3NIWHmb54EpFyym4pktM/A8GogcaXCa6lnHYzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784351645; c=relaxed/simple;
	bh=tWktfqG2tyx2dDEqopmx9waN1Y+bUb8xcqwf8L6d7pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FNucvIU94E6Nzyvj/rLEJ1fwtxT41uU9SwN4T0bDMGS/6gEMA2EtSm6B12OD27/OVSE+UmwJ6CKC1EbfltFDnbULh/3FHT1JPWma6Kxu4d4WRmQFYZTz4Nvn8L+QmZTL4wj7BafUYw6+9/NXMI2PGqvUY72zG4eKrHGWXnD2GF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HANDFct55WTdhVF3PbQc4Kv//8mwvEplatUlPiiNtUiQofrreZ6WxTwFn8P8n+UdUFwXn6vzYjeXkkH/UUp9qg7YFAQlZ8CJ9jGYkYBLjcacb4cUcXHnKoouZi2grI6E8qGKY8A1Is0SlzI1p364blyjy9BKwJxZkNHib4Dm/2PBKeyeqC7s0cOKJUfrQb65bUbDynAB5qGdbSjdlJbO/KgjEEf+srwd80fbbpBx561DSVLJXsfIlLPx20AtDw/ScUWPZbeYlx0X/n3/e+0oFkVuc3+p5qPsP0SirDrWnTcfIoKHt2PcpmAgAy/ypKNCj+QijsobN0GtCv7J3CNy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=yJRbX4fUta37diJhH3l+N7s6MslBGRrx9nnOLXs3QB8=;
 b=HyYO+jcJrKAoSTEp8xXTl/N/VIwhfVkhuK9djLE6wjXwTFOoA/eC3GJ0JEoXh081ffK1iGRFy2GgVph/DGGjZsP753W5y/U2pE9RhV9CYdjeT4Pfj+czl6Pq0a2n8ZFCtNY5zBdZSgtxwuRXFsco9VeoSifE5KgoCn+HcIIz3jUSeZgkH+s+gN7Ap2vFavQ3P0CE/ecqDLZ0WfCuyfuqJLx6nOVvTrb53687/ct181w2HFyT+ZK1+8zTFpVJzPyzkJeHe8Y0YC7hs2PdOJov52yDcozsr6A3qAdNcK8JzaEjuKgfuC8ALKnm3ZmJ/p1rIs421o2nbT3VGQRgIlHsGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO9P123MB7540.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Sat, 18 Jul
 2026 05:14:01 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.013; Sat, 18 Jul 2026
 05:14:01 +0000
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
Subject: [PATCH v5 2/2] module: Rename module_blacklist to module_denylist
Date: Sat, 18 Jul 2026 01:13:50 -0400
Message-ID: <20260718051350.344772-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718051350.344772-1-atomlin@atomlin.com>
References: <20260718051350.344772-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:408:142::33) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO9P123MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4062ed-65b0-43fe-02a2-08dee48b610a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	7lqhd7Tt7SshGuBuD7yt/n+zeEKe0kS1HEQ1upUhOGlZjBOGrqECPTPw4MD/uamDCJnRCvW6C7tnlOUJwSVcwWI3Xp25z71vBuDiig6t3p5S7ySg7ZuHWVRz7Y8RK8/momwD1tL5Vgc1n6fActMP+FAsS5hXXaUc0BQyQvbg3GsEZYJe6bXz+EkAyN5KBJdpf3Cd0Sf9HADUKFHj55keidB/I+w3k95Cs7HZp8j+4sqP52L3NyS0HqmhLqJo6WJh1n41cbRyUZp8g2ir4GrGckukzlwvAdfcnvDi1VlU79eLhW+1PEfER8v0LJRGFWzv4KVIpmKDTN7Asg/VKu20k6HRcOhDkLgFDd9bKHF5M3GPs8AKFwH6bb5ueZRKqpZ3ECXEjkB3jpZrUA0SL52GTEClID5nVybAO37tILPsgMeIk9wku6fdQH+EN4EHIP4ognuIXjcGnBG61faQK7WNhu8wWO9MX9fN3nNGjS0vDbgP1PtKCL3//8LsgeyUA+E3r50Y16fHZJFl1iZXkaF0rdXIbAF28jFNclkKrMiRaoloBf5TmK/fwnRzBJuCJug+5IOWRbNqjeXN/IoDARCPX+gqGSAMOmZIFreY8HnE8DJdZtp6rs0Zf0MZocK8Dn8ACoeIT+Ov35+AQr788aEGI0BNPUZiRYoJ+bajF3kQYDw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d//4FiDVYqUjxyTHVwtI5dOt/FTotzKcRPbTdEA/w3Xtd9MwE1CBDlmeyU2h?=
 =?us-ascii?Q?eobwWmEU3MWbDGg8GwUj38KDV54Nxk05CW9Ll0zlTXGoy+BE1tssDsFn7iw/?=
 =?us-ascii?Q?miUAn47T8pPvp4YvfoUsACVKXNbSSh8S6PgFhN54vCyKfor4ARCvcetwyv4d?=
 =?us-ascii?Q?ujYbSe46xpDbW5u86bLomQqzh5bFotTHoyuGCtbidr+evqIz+PAYidU0ewSP?=
 =?us-ascii?Q?/0bUxFal4a7alSmkXHsxOP9l2cgCf0Z1C1Z/253b9f5rEvJqryUt1V5i872O?=
 =?us-ascii?Q?uiQdUH73cnNVSQwuRC+7KUCCeSqXFiGsIdlgSJNwwgET/ok+yw/NrgbErAnc?=
 =?us-ascii?Q?9WdQ0QVNovOtYNaj8pDuCcXXGu2wyAwup84jcFdwm1Ag9vc9pfsdfj9Xe4VT?=
 =?us-ascii?Q?4mzNtHMzpqy6BOBG6OB9kMuAR0Ch3j3+ABUUuME8Iw3w1SLNQ411juYtycTV?=
 =?us-ascii?Q?1WhaP4HXkDGHhmq0Is1BoE+2fvfRHjXzfQn1oy+CLcUZE3YlXjLbSqtEy6gE?=
 =?us-ascii?Q?mJDIzEa6PyAwoID1ilFPQmWT5NWCTxLUy3EhI3aViM6wgNNdrsYH/MEeSbQ+?=
 =?us-ascii?Q?dK8J/6hzVhBUmMT48PMRGZN4Y73CGLFbPJEXWgWGsu3mLnc4uF8LIQS5korc?=
 =?us-ascii?Q?3T0dciJvmyzGGb59KPhuKAyhXUIivB5GURlsCvcCzC+ZCjJtxBYvRPiYgZ7Y?=
 =?us-ascii?Q?rkhtFv1Zkw9i4lHLcmaOQj5PfhC6VTGI2QPBzbdinN4fvuVVch0vyJcvBBJK?=
 =?us-ascii?Q?tCdCNx9w3Xq+7bO2XR8rZ9w1OV0JbOiIZG/3PXChCKSHY0rEY0zp4r7G7GuY?=
 =?us-ascii?Q?Wy4BSKCzZAfVzgexNTrgXd2Ac4onxCM+S7Ey0/mUbndhGSffGgenlmdwW5JI?=
 =?us-ascii?Q?xvSFu+8Ix6AZBr3JESmXD+tVxSEaFJQzx05oD5OY1RaophinJl4wEBV8FoTT?=
 =?us-ascii?Q?sREPbvBSUZZB4andLVEKN1cNimR/Bv+XVMJgHR/dFJE5SE0LtLgNKuyrnNq3?=
 =?us-ascii?Q?3lVwsrkMLFbgpsD2d/63oBFCQrH4Jx2kCbI581Qn5xKE12UUxx/WetxBXo51?=
 =?us-ascii?Q?NlO8D9uukhWyhx/Axk4t9+zfoio88KmoGUWfktLyuLWTeKLhYul/l/xW7uOO?=
 =?us-ascii?Q?azp0PVWQWTWEMDDmnqd88uZlnwUtXLxnTN5U2Fn234J41R7Im8uzXBpZnZxf?=
 =?us-ascii?Q?VnKrlFm0Vk//GWCyl2sDX2AScwN7NidM0ViQbg5sSJ8BdtMGGg9VR4/2ed/t?=
 =?us-ascii?Q?Kbg1MnBbd4XsAK9I8d9dBtINcb8WoYoNYVbHNJjBdiTP5ni6OAD2y2Ay2XiW?=
 =?us-ascii?Q?wYE+4qwXA/NKSqLZWNoeSHtFtwAeEVlO14kKy06NQpbvCbkJR7adGZqe4CxE?=
 =?us-ascii?Q?4L0OYvvDvcAIxENkXQ3sEhW8v0/3dTiy/4XxxAFa4kd6uAbmI6PsX68eugci?=
 =?us-ascii?Q?QJX9kRv6ebS9DScJ4WWHcfIGjeXOA0rZPFptEv8KFun7/GHFPmeTLhKObUmt?=
 =?us-ascii?Q?d6JbDGPGXAF7ENDxMuylsmXkUJipFBTv/BblOpN/cAkxY8YtfYnH4F9uBe+E?=
 =?us-ascii?Q?1VbGx9U/YKz/kn3Nx6Ls4MuFVEa7vZLoMF2d6VqONl3RmEzABKUFO1Hsu/7b?=
 =?us-ascii?Q?802Lr55e7d0dMqMsv0Dfe8r/Y2CtWFzSSlSI9AErHru5I3PV49mrzIzvjR8d?=
 =?us-ascii?Q?NjqgMqFuxHy/jQ/iZJNn20ZNsXmYCyddBGfZx8ecmBSDcbe+pXDReXG5CebJ?=
 =?us-ascii?Q?5lUL3pXurw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4062ed-65b0-43fe-02a2-08dee48b610a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 05:14:01.3684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNO8KdeYvM8jg/xHy+iFIaa051KxE1N80HfE3jw3g3V8Uz+RlduXDRttKZkpAUUWNJAsbD1+/7bg3dPUbE+A3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB7540

To align with the kernel's established coding style guide regarding
naming conventions (i.e., Documentation/process/coding-style.rst),
migrate the internal module_blacklist variables and helper functions to
module_denylist and module_is_denylisted().

To preserve the existing user-space ABI and ensure backward
compatibility with existing bootloader and automated provisioning
configurations, "module_blacklist=" is retained as a legacy alias
tracking the underlying module_denylist infrastructure.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/linux/module.h |  2 +-
 init/main.c            | 17 +++++++++--------
 kernel/module/main.c   |  4 ++--
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index fc1525e8f63c..e83ce13e6db5 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -884,7 +884,7 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
 }
 #endif /* CONFIG_MODULES */
 
-bool module_is_blacklisted(const char *module_name);
+bool module_is_denylisted(const char *module_name);
 
 #ifdef CONFIG_SYSFS
 extern struct kset *module_kset;
diff --git a/init/main.c b/init/main.c
index 0cf64d19b43f..18291e9bab41 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1337,17 +1337,17 @@ static inline void do_trace_initcall_level(const char *level)
 extern struct initcall_modname __start_initcall_modnames[];
 extern struct initcall_modname __stop_initcall_modnames[];
 
-/* module_blacklist is a comma-separated list of module names */
-static char *module_blacklist;
-bool __init_or_module module_is_blacklisted(const char *module_name)
+/* module_denylist is a comma-separated list of module names */
+static char *module_denylist;
+bool __init_or_module module_is_denylisted(const char *module_name)
 {
 	const char *p;
 	size_t len;
 
-	if (!module_blacklist)
+	if (!module_denylist)
 		return false;
 
-	for (p = module_blacklist; *p; p += len) {
+	for (p = module_denylist; *p; p += len) {
 		len = strcspn(p, ",");
 		if (strlen(module_name) == len && !memcmp(module_name, p, len))
 			return true;
@@ -1356,7 +1356,8 @@ bool __init_or_module module_is_blacklisted(const char *module_name)
 	}
 	return false;
 }
-core_param(module_blacklist, module_blacklist, charp, 0400);
+core_param(module_denylist, module_denylist, charp, 0400);
+core_param(module_blacklist, module_denylist, charp, 0400);
 
 static const char *__init get_builtin_modname(initcall_t fn)
 {
@@ -1377,9 +1378,9 @@ int __init_or_module do_one_initcall(initcall_t fn)
 	const char *modname = NULL;
 	int ret;
 
-	if (system_state < SYSTEM_FREEING_INITMEM && module_blacklist) {
+	if (system_state < SYSTEM_FREEING_INITMEM && module_denylist) {
 		modname = get_builtin_modname(fn);
-		if (modname && module_is_blacklisted(modname)) {
+		if (modname && module_is_denylisted(modname)) {
 			pr_info("Skipping initcall for blacklisted built-in module %s\n",
 				modname);
 			return 0;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5c90ebedbf68..e6d9c52b9786 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3369,9 +3369,9 @@ static int early_mod_check(struct load_info *info, int flags)
 
 	/*
 	 * Now that we know we have the correct module name, check
-	 * if it's blacklisted.
+	 * if it's denylisted.
 	 */
-	if (module_is_blacklisted(info->name)) {
+	if (module_is_denylisted(info->name)) {
 		pr_err("Module %s is blacklisted\n", info->name);
 		return -EPERM;
 	}
-- 
2.54.0

