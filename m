Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020097.outbound.protection.outlook.com [52.101.196.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7B6350A35;
	Fri, 24 Jul 2026 02:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784861280; cv=fail; b=H/lJ4adAEEtzILnFlsZC2tADMJUl+nDLzGFvjVdd2Y8ypvpFgE8gnk4kBHtGvdM9YYrmu5jbGiAQj92Ps8ML/ITBb23yfiTWAurosSum/ZW0FgOqnBirjkYbDy14TkoDx+WUlhAav9fyuaHqEcC6Ku1FWkzG8ByRXOiDtdYZJ7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784861280; c=relaxed/simple;
	bh=Ef2VXZm55F7WfT9Oo5PlM0Ly/hBJJtQgNRjMu2fyPgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qgvepfmZtFK9QHPa5OrJrGkRmQWTUOA8ztXidU5gsSPkMGaeM/X2RQnqRkDxpI0i/pJB/PdrXsLn7lOQR/RE7HXuObI0GSE49Fzweu0iYJT/X/a1e0rfKPBNN6Y6tS/5eLQXT7eVf9C+NGKLhAx367hNgU2Ky3OIK1OV6eUnYHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQrGQemizReQ+LhxZGtGnu0nxJjiYfdxZns6Z51uUnI5DRd1opFYvlbwgd455t7hqxMXed+kC7aleqxmXdiCwACIN5r6QypJOlpHkWgNvUUqUiy2x+cLJ0cK0v75Agv9AsNFUGd3HdSbuclvOcvanDDpFr7iPPaQRrsugemcamfeds+fsDQwVf1SPFt2CMEd5rvTrPXGmCYCFucdGoIF1nPYbjU5raUL00TWPi8jdB7matiqvIGK6Jfo6qTwlkA7k1Gp3BWCbaGZrTDU21h9/DMGj6G/Wqh/LC1GQSde4y/RvCcv3UOrmFp8LefZCYgOwy4GDNR3d3CcfBsdgzWj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=TWBXg+tVvejC7bFyNi92JDa1ou5sIrkCwaEggcfiypA=;
 b=lZh2GzHGCCui41fTpCRYkKxDScEO65qeL2M+HJN//1Cy0ZHxJLaUOzO47kLeRNOx8EIh/rcfS2iqS8eHowXODt7fgI1Nc3uX8Zq37hEPGNj/wI1mo34YMHw0S7OV0ZxM/gkqrqS3AoxVDM+a15Vlq94CF3yw1328qjTVkwHyR9YuTER+0C02LU+0MCww/hTqF4ZAV79xIeJsJL/mq3Regjik8BfGN+LWLuwT2cKmLFHhIPw8Mj7el+yj6bJ6iyetq7NA+5VlqcumZ/e2DsgOwboz7EqFc0B3mi1uow/Ygqz7zilxSvF2KUcV6mmm/3tgYSZGAkmlxhBTHXZ3HmceBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8488.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:269::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 02:47:55 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 02:47:55 +0000
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
Subject: [PATCH v8 2/2] module: Rename module_blacklist to module_denylist
Date: Thu, 23 Jul 2026 22:47:44 -0400
Message-ID: <20260724024744.616286-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724024744.616286-1-atomlin@atomlin.com>
References: <20260724024744.616286-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0328.namprd03.prod.outlook.com
 (2603:10b6:408:112::33) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 043eb8d8-6e87-4ee3-9a22-08dee92df6ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|56012099006|5023799004|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	goLpEpNEXfm/LnWnoxJ/ygQpnCXNjgVgVhIPW9gnDy5n/avC047nHTSy/wVfhJsasIEsbqUViEs8rY2LSVOCS91PSj2FFiUWV3foTEPCHbeFf7NmpqRDeESdTjUmrUjFGVRQUcTd+J4B1exwyLNlr4E/zf8ezeldaLRc7k/tVOXMCN94/0mMJqji0wUi0oKuGYW2G2cLCjdNOHBKSiLFVpMb9P3ykKKCjUyXjYKsjxAJm35dmCB+9g28wUlNH65lsbOpsWTTlJpttgudGfpaOpXfLiYCId8bRffZrLAiLKSyWdQV2vz777ZSonWIRdy5m0sIFDyh3ixyIBht5nlR8eNDlKMfnfRkC8HtZOe4hwI0X3av3Gl0eB4YMmR2IwYV5Qq6q+5MDeXmM8qGIBF/s1HoQAhKGsCBnsS6ZYyNvMSp+rKlcrSB6uk/jtAreDjznFTXcPMOMbnX7aJQISSSwu6NnIiZ1nf+aSXw6U+wEyQiip2oeH4UsEwQHKnpsjXUiFM80+MsHJiMdyOHxjtqiuVBXwwKuT9t3sVAFKsXJpcXFuf2cbxWpIDVIILJ6B9YU+TmjqS9byJhPSxjMpFU7dDBAC00yYH7YWlqJaeo5vGEZYE8ee3888oycv7fdF4oFIoolx8sj/obMvSQerZWu35BL+JY9D7Hv/QY5Hs2chI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(5023799004)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qlmuaTxcx0TBfIm8ddeE0ZBw9ebcOwE/2amCJ9P4HIfIjTTpvatKEwNmA92f?=
 =?us-ascii?Q?o1GIAMxQjs89VIp3E5lBUmWH8+N+Vb39lahc7/gTJyhXPfaZTXsj8xctNYc9?=
 =?us-ascii?Q?uSWhlkT1PigcNVh3pJXKckAzipvHw/ZCr17S45jTGktD/9ZJE0ofzjCOAEQc?=
 =?us-ascii?Q?0TSNMNl6pGB2QpE8v4QieHU27lPsmx6ZurVmZQzQjfMgQZNHVkoYE1AGX7MH?=
 =?us-ascii?Q?mAXxvTCwJ4dQmy8RGV0c316wF8mUbdlCsV6olz0FyTchLx79TbwpLytIcLCl?=
 =?us-ascii?Q?B2rVSaUbb8TRonJTvG8d6BBCa5MPH4zE1dT45nqajFKjiQb5kjV0uEsj9tUt?=
 =?us-ascii?Q?oDV4GX12FzVXHTcJj38uNCycwgOsdgbxtU0RMB2yJKZjCDlWUUTm8KU2il7d?=
 =?us-ascii?Q?RYj7vdXiVUuipucgCVsVZQ7shrypzqMOkiNSeNA1EpjrSs10NTEa+6QWu56H?=
 =?us-ascii?Q?5M0OtZ/BEDrqCjQ6AXrF3/RvhuygaNwfEGlqZ6D70KoaXXJCujEcjCF7OMxO?=
 =?us-ascii?Q?vmf3kw7JmE97sBAXBAxslqniq/zpGHWsQANyAuKIz9NakJv6YQedQnv7ZQhD?=
 =?us-ascii?Q?Bogx3VPthkZWEdn35QQ1UwJdHHkYZwhUZjPD0LNuDY318krwAT/vOZFLgLSr?=
 =?us-ascii?Q?nApUul1BAqOZxj9JmshP+24VTElytkUrM6eBRndJkZxq0n/J2BJsPU2tMv7t?=
 =?us-ascii?Q?Wah7LMqj66ZUnkEVKdL3bSUltzHGCxcS1qvyO4Lx+APhdBKUZgkoZVEUTvDZ?=
 =?us-ascii?Q?R02YHlNoN9gSvpALfFU41y8P++bvErMKiS6vQ8JMaslNRs7TK+mQmntrUizp?=
 =?us-ascii?Q?TGTJR9o6R3swZzgq0Qrn07QQGqxdUU+P6zJDym3s9dsIHh674AeNY2igiZZo?=
 =?us-ascii?Q?CaM5kk1HOFKDFPracmFWhM1GXv2BhpjBwDjiLsMeaCkBJVQXNfDfG5in0Xjy?=
 =?us-ascii?Q?AZub7ul5Y7NHo3xPzCXOppvDMPLJZqW/lsfXGxrZVEQXUAobXRAd+4zw0ViZ?=
 =?us-ascii?Q?Aom5Acz2WtLROgZ73a3Lgv49x4fbABjc19egj+NxfqBmuOx+CwX9gwvCKosQ?=
 =?us-ascii?Q?N1LEXKuGofCqLIxhROkpKnDYIGZ+gpRRcyrj5HleVm9WUlrfTixmHE0MqylB?=
 =?us-ascii?Q?MyVQ/M+3simqXMVAvU/3zbjmyqmLs0jqVKbynDoDYj/ZoaGyiTuvzT1VCFyn?=
 =?us-ascii?Q?U5yMteZGRMhMf191GVkDTLFNphjUM2LjWCJn1So4wHEZ+YPvhQqaZnNUCc2S?=
 =?us-ascii?Q?PqmGAYHgjRIPMMQZ2thRvpMOS4X8b9zoBBvQzDknIOKC/aQiOXnSkjGEA02C?=
 =?us-ascii?Q?vS3N9SyImlgrrVihD5ljaB0ix+rra/eOjwT38VJuN5t8x5TKaUVh81nTLHgf?=
 =?us-ascii?Q?PAMvCN1iOkJocEEuCA36zg7vpwBoatOMiY3eel+53y+0LqHHWBSrPYk5zBvA?=
 =?us-ascii?Q?tfABWM6GNOQq9bWz0x3x504hpXMdW0YIP9uOTBFyJUJloFEb+9aOZIQ6IXm+?=
 =?us-ascii?Q?LhS9EBtqMau0NGhQ860+5vpnNAz32CF3nLzAHNYZEWINxUYaJfPe5dJLc+Rx?=
 =?us-ascii?Q?2tPLvYlvvKRvouKih3n2P+58iQxusRfU/YrTYB7iyAZGa+pgQN4chASU6tTi?=
 =?us-ascii?Q?b/PKfwUUr8tH/TrFqPkFONdy2528y4IUr7fSSlLLr1nRIJNMyoAwAMhtI3ze?=
 =?us-ascii?Q?/1FtzGkzRQnBuqExDwJ7ymgQJSjuXKmioyCggeuCobCREdBi9JH4pDbwfqpD?=
 =?us-ascii?Q?9lcrI6WDGQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043eb8d8-6e87-4ee3-9a22-08dee92df6ad
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 02:47:55.6139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRbSXtSixwqFcrLMCtVY1sR4tXYvbDk7BCF6P6Me6IR4Ewh9VGRzLZq1I2ZmfaVZ6so35DeYfBMEnqXXmkSEHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8488

To preserve the existing user-space ABI, "module_blacklist=" is kept
as a legacy alias pointing to the same module_denylist variable.

This patch addresses the documentation by marking "module_blacklist="
as deprecated in admin-guide/kernel-parameters.txt, and documents
the new "module_denylist=" parameter. All internal symbols, such as
module_is_blacklisted(), have been renamed to use "denylist" and all
log messages now use "denylisted".

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++++-
 include/linux/module.h                        |  2 +-
 init/main.c                                   | 19 ++++++++++---------
 kernel/module/main.c                          |  4 ++--
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a68003c3599c..211aa16c53ef 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4179,7 +4179,11 @@ Kernel parameters
 			Note that if CONFIG_MODULE_SIG_FORCE is set, that
 			is always true, so this option does nothing.
 
-	module_blacklist=  [KNL] Do not load a comma-separated list of
+	module_blacklist=  [KNL] (deprecated)
+			This parameter has been renamed to module_denylist=.
+			Please use module_denylist= instead.
+
+	module_denylist=  [KNL] Do not load a comma-separated list of
 			modules.  Useful for debugging problem modules.
 
 	mousedev.tap_time=
diff --git a/include/linux/module.h b/include/linux/module.h
index ecc4db15ff4a..37a393af2b7a 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -883,7 +883,7 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
 }
 #endif /* CONFIG_MODULES */
 
-bool module_is_blacklisted(const char *module_name);
+bool module_is_denylisted(const char *module_name);
 
 #ifdef CONFIG_SYSFS
 extern struct kset *module_kset;
diff --git a/init/main.c b/init/main.c
index 3747ccaeef42..f1da8e780cb4 100644
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
@@ -1373,10 +1374,10 @@ static void __init do_one_initcall_builtin(initcall_t fn)
 {
 	const char *modname;
 
-	if (module_blacklist) {
+	if (module_denylist) {
 		modname = get_builtin_modname(fn);
-		if (modname && module_is_blacklisted(modname)) {
-			pr_info("Skipping initcall for blacklisted built-in module %s\n",
+		if (modname && module_is_denylisted(modname)) {
+			pr_info("Skipping initcall for denylisted built-in module %s\n",
 				modname);
 			return;
 		}
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5c90ebedbf68..0889c1a6441c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3371,8 +3371,8 @@ static int early_mod_check(struct load_info *info, int flags)
 	 * Now that we know we have the correct module name, check
 	 * if it's blacklisted.
 	 */
-	if (module_is_blacklisted(info->name)) {
-		pr_err("Module %s is blacklisted\n", info->name);
+	if (module_is_denylisted(info->name)) {
+		pr_err("Module %s is denylisted\n", info->name);
 		return -EPERM;
 	}
 
-- 
2.54.0

