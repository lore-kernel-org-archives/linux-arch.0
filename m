Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021113.outbound.protection.outlook.com [52.101.95.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AD631960B;
	Fri, 24 Jul 2026 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784857439; cv=fail; b=A4s/61d0X7om/aq6X3BqfMXXuW2tVC8TfKQ5+tfunv+uzKTe6o023QhiWvaLt83qjod8EQRO1KYnxlDT1HAq+lzuVhlJWff3F03j5MKWHTbz+cTe1W2LjHJM23ifv7+H2XHrh1ZJLFzk4r2f8Q5yy6pXY9iMjU4fkyMewSg2Qdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784857439; c=relaxed/simple;
	bh=Ef2VXZm55F7WfT9Oo5PlM0Ly/hBJJtQgNRjMu2fyPgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BBvduIOMLO2qAb24a/2fk0Pd4cyVJqbMlqX3OBBXM+7+8YJCNkJ6IlqiF6Dg8zSYjanfdb2D/ZotlJ628KsohtGzbVtPrmPCMHkL3cjT1mG8GEfSGK0FKY8/m7Wn64GNunRe0pNM/xfwJvSrkINCT0YbeAHxSLzyVmbHjfOY+V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guvYbMf1NcMCQT/f2zque+pVxG9vqMHvlHTMFeJR5V435jSDvRB4JDJCfcKhYjFwopfOunnHUmQ8bgNEsiXJNHLU/0R4r8PXgVswLEomxaXyiSmUA6kDOgwfe88FEduE8s1a5KFZafola2Oj+aF26kKrBypCqWo/jlcuG4tSLqJQnv5GaaP6eOYA0Z+sUtZW31xbbwX28gWu42ARdJpiy57y9eneV5ghTg1tzbti/TsSF6fmossJpxLrANe1qPJGIJEFo2SgWzi2IRtzcxvpoqcEMdKwrUjvL1l3IRplDRkSRO2016JRKjBOtvXnwyq/QDH2GGFx/J8uvsxTHBI+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=TWBXg+tVvejC7bFyNi92JDa1ou5sIrkCwaEggcfiypA=;
 b=RwLUc1I9WoqYGDzdy8H9Gcs/f/bDIZDeho13DZcbsogOSbhQGtMTf77ihrjT27IqhwylwEaeSVE7MR6y5QGpYzhmklYZ1OR7SYal5A/IT3wgkEza35n24ddGphIZxb1cuSoBiCSz4AigRoEFCBJ4RoXaxu8rb1bBX5rKMdurT/VWJflwQtG0HKO+yKz3WIEphUydyj0OpoykLzIPH/CYok9aiA7oKIpfX/muvjjrdKDcXPbn1taSsifyilSUAis842/LvWKfGfki648OpEwQyKKAW9e6zapYqD4/CplgFebTYpKOZ6fcLxKezUgA0Oc4oIB88WQumKk8A2Db+TljdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB2974.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 01:43:56 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 01:43:56 +0000
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
Subject: [PATCH v7 2/2] module: Rename module_blacklist to module_denylist
Date: Thu, 23 Jul 2026 21:43:45 -0400
Message-ID: <20260724014345.589326-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724014345.589326-1-atomlin@atomlin.com>
References: <20260724014345.589326-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0952.namprd03.prod.outlook.com
 (2603:10b6:408:108::27) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB2974:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a55516c-534c-4106-0692-08dee9250638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|18002099003|22082099003|3023799007|56012099006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	H8+rmoq2Ssgf7tizJPOYdHtBpJpEu2jfxVsoL4UGG+m3eNr3v94oqaf2QiKktj93uA6cFpbSEsN3zBQSq/6mL03aNd+WUFlFztNE3bGRrKceI4s5oMtKYKtx6VupQNCrYDEyj5U6U8zowslr84HImZOpnXfTwDcwpVUcCAR+pV+L67ditYkpNH09j9PfQYFfblDHQFZx2SJq+86lZ0XzqsiI6Si8o1G4faZltDUGN98qmNX/jnXfEu5hq7YLOYLQeUZgVYPgRpWtt9XNpKxQKZnsly3gRcms7DdNIYNSuyVF+dQAvvUC4Z8iMjW+bjLy8xeWb5OGdBRZ39+LOgWg3tLr7GdKEJZugjpt3Eel902AZD7+tTjzy1Pig0GK+/xVBbJVmBIlCTfhMt/JartHkdMIR9cJyV9tcfZ6hcTMtRCnVZMHRqpiKuDOd4njdQNWnYtMun16pCRqSUr/GRZ5QbgO0L1EuSDrGfc4ytpOyjoEWB3KpB8K1FdNseoddEmvRFy8UtVYm0XlyEj3VhOqFhq5pCSXGXir08oAbze4mID6KP965PAuLguzB7ol9r0ulllmExLUSOTw8Ksrc1RWQb9uiO7377tmfzHwOBjF9QbtNDe1hRbOeLmMFsQdC+G2AODPDHevdmJmYVBRQyQX7dvGVd2imEJkrOfMvXGOSDQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(3023799007)(56012099006)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?08abjnsQZesyU6WqyYHtU9tqBytdaeXP0c3bziu/CrjydTx9OcH1cDNnYhPn?=
 =?us-ascii?Q?BgFJLSXUzCEAfKRmrOdvCCuRiFuougsijODsUvU0pxfGMgpO0P9xmM7MuxOM?=
 =?us-ascii?Q?Rgc+7r+GI4ibOJWWCfOjn2d2YW7Y7CZxUMDAEf6/yPGKDUJ8ei+H+6//D2mC?=
 =?us-ascii?Q?mWPu2PVyxz9tRNzOOXcsiE6ug7feL558zTEvB1EJwAfEsLPO9ahKuRk1PECC?=
 =?us-ascii?Q?gL/a3lP+zdXwV3MyR8F/1SpU6JIHBtb4ayFcaw7JBSwPLuXPmZ+Nb7o179LI?=
 =?us-ascii?Q?oiPvCX5UmlhwWBrPnBc+KlYBELwtneW6Ntr6+AgzgqFWK6ezAmtp5159mGkU?=
 =?us-ascii?Q?7QAM+Se0gOQY4gfC0gG6ckizsPtBiCDqjRx2zxYswx71rsxfHtQU/NUWxHFx?=
 =?us-ascii?Q?8Whs5iYDaOwyVquV1Yaj1WutV48aB2qA256rF/F1BffR216l4w3489bgoaAH?=
 =?us-ascii?Q?yiheKxLIJbgI95lPVz08bsUSzH0XNordm0T2ewcBbil48cNl3r/1sKRHILPp?=
 =?us-ascii?Q?NtC5czVUQMZy4QeN0kmLeAzNj4Py3JdYl9UzoKCLfAC6oaDjHs3JxbL9SkDt?=
 =?us-ascii?Q?3auPtizVRrIK1nvSq5GhTU8othdE08Vlt11n8BPNm/xaIWDUDxXj10SkEV9B?=
 =?us-ascii?Q?jy03pStXQXpKyxE5hkcwuYjngHzZxhGn7REjadPD+ecAQy7v7P+eWz8BTN+4?=
 =?us-ascii?Q?8fZWQcH4bSGOQdua1tpiWwv1EUWkjqRs4Ux+qF4O35XbfDWRkBjKH6UY17wr?=
 =?us-ascii?Q?HWOdulH4jfbXHlww5aArjFRJO6QNVKJ87b5PZi2xXmZ4mQgOXoARa0z+67Us?=
 =?us-ascii?Q?yNTfeME9zf8QwsZHN4DY70aUMaoAQHespEWrqgclRVxmi3rd1L3mwp/Tk3kR?=
 =?us-ascii?Q?9+vKCE03PQedAePbTTETXXH1sPsGhC0dIv6Q7n0KHAxWfN8WX3ay0zLtwqu8?=
 =?us-ascii?Q?VeHICwS8g+fbUO5jBWjXZhGPt2AhfqSLNWBjB/mpFTeGXEF/YTRESwOneAPi?=
 =?us-ascii?Q?43nhfyPKFFUBQcsoRA39YozRgxgl6bTTQswsjG8weouI16baTKKDEEAHEUoE?=
 =?us-ascii?Q?YV0zbV2vDg6vwfSpgD5xm8HRC9xzLDEweNwEtqjHdlYOSfudcoZHt3r4jSvt?=
 =?us-ascii?Q?qid8jixxGKfiRqJhU192nrfYsPXI2wjFWbt6KGQS7OgherKAbIaoGdma8e6r?=
 =?us-ascii?Q?uF23xQY9vqPJvNTbbtlfXwUnTVExpkVE/QdcLiYECrdWPvZvWAWiaZPAckbK?=
 =?us-ascii?Q?vk9cJA2A6UCjplNULqtGJAYAGECKrzDDHmx8UYpbA5zCeJNNi6mhLsYPOQcY?=
 =?us-ascii?Q?604fUkefwa63+sBXI3aJYOstIzBU5S3V9lJVS+SXiOsWVhmk20iAg8qhWVb1?=
 =?us-ascii?Q?IRVwHTkP8vcnHT0nssWB6yPM0QKZz0q5De1qsm/R5WTPHEbFQU1eHBPSHnKY?=
 =?us-ascii?Q?iRExADKj+xJ608l6JdMIXgmPqvCrisdgexZ9bNbTZ6RU5aBZtCSyQqu1d3Tt?=
 =?us-ascii?Q?cM5QGU3UYPRY8VFc0W4j7dFbVmH6YsQiAt9ORUcfM8VXv4VGx/2K15aqafHu?=
 =?us-ascii?Q?P5slYZ+mTHaybf6+WczZCftTqrhZA5JyCfmlwlYCvbJLPvGbvGbBW9fWv+9z?=
 =?us-ascii?Q?ZqoKNICYy46pUDjIh1/GDLssYG7FKptQrp1XG1ffuoxRD5czDHvOE1aay2Fk?=
 =?us-ascii?Q?SabFvi6teiw34C39oK6nLX1iziRmjAZhjkPxGy1Dy/jABo3EbKhVAQLGJqRR?=
 =?us-ascii?Q?1dAZwAMYzA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a55516c-534c-4106-0692-08dee9250638
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 01:43:56.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCvA3WYxtrQf+6AInNrnVTLZWloDf5tayi2NMujExZdv9MlYJZ1hGxAiS2Q+kDAw6OM8yAAXVvYeXok/r8lx5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2974

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

