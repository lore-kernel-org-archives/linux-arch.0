Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022088.outbound.protection.outlook.com [52.101.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731792848A7;
	Fri,  7 Aug 2026 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786065986; cv=fail; b=H7VS+DErn5Y6XtoXAMuXj4kzf1AnEbg2Xqe5E2KKM7WFVsELhKwlsVwxY5SVNBz4rr/5k7oO0S1zZf+RR4RphVNQxpghQk+eNEqnYEuEJF9bv/p3fKITQTK2H/lH8guIYk0sKkIVRiyEkrRZ640wxV1Nbed44fdRC6akewzNI4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786065986; c=relaxed/simple;
	bh=ImVhxylc66HaNhGJ8iZimEfvBYGytgvWcibN8s/M8io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dQ2qCn9wIJDgskxp0Gsvd0kFt4G3/Krr+rhLYoRNf7iFiLf0/bG7cw36SNm9bf/NKJtGBSPC9fZUz0yuv3ZbjlEeDG6npv/hHKyEPvPg4jQLyMt7lPqhHPUVv7TjGv0IzSGgF0d0r6uapnwJ73U/WiDho4/WJcja7bX/akRn4U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIrtrhGRRPYoIvRYxnhjElkDCluX4XBlJudkbk+xSnJDGouZHCnlWdcxxA1NQBdza0iFzqbC65wp/UpF1U9BQKaIyyLsSkkxlmkUxiEsP9vzsdPUc4Q1zrH/kxdTxo0HzyMqaDAw/u2WoyyhuMrxr+KLHRa5q2cLzQYrqx7+nYapJ+hQP99/8q+R+rKgznMpHrGf2kuL9yAAFJa779IIkZxRLjMzPTK/BkfndIo6uIHAfMplHLHxFQJW1JfW4K5VAxg0NfuS4OQNzBI1r9vov0txU52FPpjGo6co3PRZLalfP1yYXoPVWicNcseFqyztPFzas/SzrJ2fojHH3psKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=0AFnfe52hbVxL0t88LiVjX5Q4Js9R0jzoIXJ4mWkGo4=;
 b=IHWTi1LeKzk303UOJz4IQm74IQZtxPOYCH2POKk5cW/2JKr8GWIzrokwBfyJXdpWBwf0o207w+VzAVhNJdjpIHDInBohfctJm+ChaZGz+45O+TM5NNY0ehA8Sm4lWECzig8ySn6v3+GSkf7UfaOVsSlhRSrkWRiLmLCGYxcV9c8/ymq0BmyIjTZFpn5nEvAYhuPGsuACM8LgJsFVA9mtrWZl8O2DDKPkGXXF8FhXY1xdPCoMx+GjJI2V0KWstzpFRPAp6lZZRjcwgNVyu8SLufgCdkTtAKVfkPm/kM7C82P852CrzgS7ZsXiC9JDzPdMDYDWxko1//+Y1wOxtG8LCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB2825.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 01:26:13 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 01:26:13 +0000
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
Subject: [PATCH v9 2/2] module: Rename module_blacklist to module_denylist
Date: Thu,  6 Aug 2026 21:26:01 -0400
Message-ID: <20260807012601.360452-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807012601.360452-1-atomlin@atomlin.com>
References: <20260807012601.360452-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:408:fb::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB2825:EE_
X-MS-Office365-Filtering-Correlation-Id: fb94f421-3b1d-4844-d1ec-08def422de43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|3023799007|5023799004|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	7GQUggOSgYlCoSyoX8NQZ5nhw6QbhHWM+0Mpw58pcb5aBOGukAjJj9HwjmY7UnWmMdmSksLU7lQOJP6LYJyk/MxwuDvfbQasq4dy4rVYBTSjqRxA5fInvYFBvu4dZWKTY28OlCqYnDf+xDnwycujId9h3TqdOo+9LhtkUzqMcJjST4AAPWjzVZgW5i56pdKS8oQ/hHbKgezvvV/r1ZbMkCgPRM/7UsvfX2UCcqESWEUlaUAZDvrTVf44/HX6cJ01bSm7uqIB77MV7dXx+5SVZQhwZKj5yyL1h8rEPKwlGj00rDcT3CXnEi/iGq2SlUhqQ/WvPg+r1d7icH8oilwGugZ7A9dUd0txyz1o713gtKlwpt92Lexi+qBEv7Kmwg3cS2yQRXGNYNF8bVm6KcJCagln5aSUJAelSoKVItDhJDrsUI3vXOl6D23jdHMkLecRcQVIGPZzlNmhVgbSx8GIGzXDeDea8MA3eK7JWSYXXXiIQKZy6fB8GLh348btjt3hdXWbXNKPIGm59iLbkG4Qz7u+GGCHUMLnrKpxiKH03eydoMXgxaZHvkvUytHpOdPPo16iiKpdcNqDf8ehOj9PFZy28OnJlshWnwA26KTgSBxzuW1a2nPdCA/swhPB3mJgoZKLoE+GlXlUWePx3xGczLXSZ20uFP9A5rmoap/+ehw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(3023799007)(5023799004)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QICnhBo/HX3fHfNWTfTEVkbilZodeTuUz4vuY1q63j34TF1FGfd/751FzHqI?=
 =?us-ascii?Q?xEL3r+bEAsHttlQ8gHWpIUBM83WaMS8P5tghtSEv5WMTuxLQn3YE0WDikmii?=
 =?us-ascii?Q?j/nZyUsUwKDl0PK3xyjieSLi8q9qfip9nz3R8CxayPq4+qloW2xG/1WWVbQO?=
 =?us-ascii?Q?1EcSyVPkukuohlk+A0SUR/gZLbNala+qTLhv40kH6Rx8Eiacq1fdehhfME79?=
 =?us-ascii?Q?CEiclGQboVsAItsM4vyupeqPjcecu6iZ1ivNUssYter2LRIWG517oz+qGE3x?=
 =?us-ascii?Q?pg4DFQcKPXVdCc3NCUxKSDNbDY0fgcjNrFhRp/FvpAHjjYY0ELLpPdjO03/9?=
 =?us-ascii?Q?0X0nuC48Lq8PygMJ06uX64AGhttr4Jp3uf8Cw/gMYnZv9yYJX9laJ6Ppsheb?=
 =?us-ascii?Q?W+XnBi1Hjo4L89/G1c5eEoohJxlJr4gn8mk54OiMstFaOfQY69pbumYHxoP/?=
 =?us-ascii?Q?Qf6EMXaadWgUypfZCI6cEyW3kRFV/M0Em/bfFJfp6Axxk11IUkKA6zwKT/bR?=
 =?us-ascii?Q?aF6ILHvighqn5KfYgWpiAe5JV8QWqW2JgfHK/7KTWQ+5zy+E1riAxS0tLPuK?=
 =?us-ascii?Q?6WMFi3ZWZ6JVbZRlrtg56c9gqzKw8WTzj4olfl40rzZp1Hazk02VkNYDAZ5O?=
 =?us-ascii?Q?hhGfK6gbjcAwWXAn59BrouT8JW+1nE7uBH8w6gyoL/2RtqXicINIdMh9aqje?=
 =?us-ascii?Q?inykxDpU5tr/y5OLaCUk6MQixxjNhYpMsDTTxhwOgUP15WB0HxO3ES6ZGUiC?=
 =?us-ascii?Q?XPY1Hf3KRp9G8DJKvp91zcuOs3/dfi2fBc49Hd7HRcayaVIrhH7BUjMOvmaP?=
 =?us-ascii?Q?4/yGlbKvmvx8Ch3VudVwvJiFwgiRfc0np8a4nfcROaSi+ezdjurNYHFeqAft?=
 =?us-ascii?Q?kTcVEIKvLnpxp3nX0nSTt7LuX5oPcyx3OMDSL7Ozy2x3Gwhnawk5ejIoEMTq?=
 =?us-ascii?Q?l231wfjh8W3VYu9NEBH2FPGvQSozwwk8OZfVPscx/Im6nWtSUKMnTA4bu1D4?=
 =?us-ascii?Q?3uYp4734YSNtXzATLmIfzqzLKeYKxMEuQuzONov29U5FQwAuPkdj9kv6Bb6q?=
 =?us-ascii?Q?Ez9FSJZRoe+z960LIIkH0OfZG8smRRqYBq+X0hdOrpTJpOXx9jM7PaDhLzEY?=
 =?us-ascii?Q?Ylbqb3UFey2o+5HBBZTey6QubDRBiIHDzb+WBJwObpiXeU3qgfOyEa9iiE0c?=
 =?us-ascii?Q?v6u8ItM3lvRsClv63kmPs9XL6RTdDnlXsDLx7yJBY9R+D+hvF//4TJ9cNU3R?=
 =?us-ascii?Q?4s2Y2YfbSo9tq1BRi/lD8aOiaaGaXgCldmnaR9DPnNSLMtuotV9/IhuM2YeS?=
 =?us-ascii?Q?n+K/NMrGeyBvcmTxrWRH53ElwytRrUAiYQvOfyMQ1SMkSKmBVmgCsS6IQPfo?=
 =?us-ascii?Q?Ovsv4Im9MN6w9yzMbwWNloTBJAmrXHPU2RPP/wbNvVjhM4gXhEKo7RFvDbix?=
 =?us-ascii?Q?LlkrmzhoeGFQVkynn4z0UVUr8+/znuHvujO+I3pbmcaZ/Dv0khDvBWimw1BS?=
 =?us-ascii?Q?evxTgy4rF2h4l3d47Eg9FTu/p9dDD7nWhK2cW1475OVp0hAA7+QW24gAB16x?=
 =?us-ascii?Q?J7QNSw1Dnfzg5l4mn47H5iSBU+kqIozIzy+dxMWQezyyHEegVjYd+j66wCCy?=
 =?us-ascii?Q?vv90m+fbW/vsxL5GM78bpMs0yCDe/60V+A0i9RCFEy/pnkWPD2RYGomNdf6S?=
 =?us-ascii?Q?EL7tbtX6VNU1eUqZnpOIB25IG5x+iA/Ip4edHAAMXWbWotpH1/qvF+pekOdZ?=
 =?us-ascii?Q?PBVQF22pug=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb94f421-3b1d-4844-d1ec-08def422de43
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 01:26:13.0054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83KVm790Jl1n1YXQnsb4hc3+sxNzMXBf6KrqIJOwE3/QTO3EdXorgPWNygsskRHCS5dlMemDzT7ncHCRcUOZXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB2825

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
index f0af821e038b..91414cecd84c 100644
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
index db1b63b7d876..bd7862234946 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3370,8 +3370,8 @@ static int early_mod_check(struct load_info *info, int flags)
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
2.55.0

