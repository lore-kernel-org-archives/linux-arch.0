Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020099.outbound.protection.outlook.com [52.101.196.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B08732F764;
	Sat, 18 Jul 2026 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784401296; cv=fail; b=jKzDezmGEWq4OW46Y9dWDTj+GxZa9BM+uHUkGMbEu+VLyBdB9SpgprsejQQhqalnNGZ1iL86ciMc10iVvWwS9tTNEaCghV/VB75LviA8PVkjj3z6xa8BeY9RLRaMhkHd2Ch0IxitjyhODOrMCWjOBXVcAfCt96IIGVEQ/rNF6Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784401296; c=relaxed/simple;
	bh=PF/UGNep1LT+YyYX55aS3cA1M58JdyeyFeT0inGmeYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d+l765z+sR3epEy6FfmPXpN9b10S9nKmVicbIRww6cHyKs+lEwmz5KkEqq5rbACZg24BupSbFS0B0NZsm++7wGOURd+DOJUhrxS+C/ImyLwhvMlPXO+7QASnOthMrEWKgq6EsYJzdowphdl1y8SBCkbk/3zC5n9g7IEsaxX9+wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JD//gdHl82M8TdRt3hhKd2WbLNL2w0JYIjJa/FPCE8yfXI0D7M+8TdMkOhiVylbCqVadPxKgmWB21MGDtAtt0aMc8PwgWbgiR4SHMoRnligqsTdmMisNPEdD3mHKkGPsMn2GIEXmiYccv1iX0KNqm6IRKAVP5tIozICF/ycXaXk0yZHxbk+IMbeq5GCEnaq7ZEJISYQ1FxjT+vvF+Lztptk0cPvvtV6Pmd+mtHYnW22jGJk//EVlVFefOU7H+eb9Yk2mgpeNKRRAScYUwcHo5iDV50Z1zK7SioovJxfGvk8ouyxtNZYSlOdmA48ASLIOxKfOjEgH73hprky77IFVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=QCpCDiZhdg1QehV14bV3TTSgB7fUMW3y8fFu5d2Dkgo=;
 b=JYdvugsMtpZZhAczE0grUF5slbwVmiX1JSZL1ZG4h65QlrMOqaUJhHJdkMjJXR9Q+NudieAws2DBgFwwlCu9NkWZ7V+ZDBSoQVg5F/yfqHsE1hS65BZtMJlzpzImbKslX0zQk1U0rB1KpCMMkVlGOgkhN6pbYEhDoUJh28NkwVvIdrVTXKCHNh6DNMQtYboCuhOkkc78j79bQdwSknNeEmi48mYvo5mk9Ga+KwCFvRNvdmqxYxI237Yao2PAK+cmdzcFTsd8rNJZCIQINGo1hAQp/bT1uULPS3slrWAxo4h2linTHvFp0Hern8Loa6t061ObLG1Qv9fP5pQVRTuTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8091.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:43a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Sat, 18 Jul
 2026 19:01:32 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.013; Sat, 18 Jul 2026
 19:01:32 +0000
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
Subject: [PATCH v6 2/2] module: Rename module_blacklist to module_denylist
Date: Sat, 18 Jul 2026 15:01:21 -0400
Message-ID: <20260718190121.378314-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718190121.378314-1-atomlin@atomlin.com>
References: <20260718190121.378314-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:408:e4::26) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOAP123MB8091:EE_
X-MS-Office365-Filtering-Correlation-Id: f9df2e38-dcf9-47e5-5708-08dee4fefb2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|56012099006|5023799004|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CanCqIHZTSK2ZriRf7vQtq7dWMetkX7ROoFDPmyjqOGsY7hfDw+tzs7IPsyW1gKgDi7cysM87QX8Q9jr5p2Sm1IYrCpRoSkGoP+HSmVO3NiZvWDE307v95WYTceUzO8XznM8xjq3BpM32LOLo40WTgUnhKL13ic36mw9Uf40uqApZbB05kgo+JVXBo+S725fiEVJq1WJ+FHE8+wjPXqaayEqe6iZ+7h+ttreuBBfl2oKJfBxQ2qsI1f/EF5mc5moLfQlPZG1g8+AHs4uu34t2lO/SDB2XSWq3SPOC2E9AhimOxrpmOQbRWaffqMyDd61hkVcRyk0SVoUW4rFs5GyzFf4Jz/2Hmx7oLQtKWQguhvv5lbYo3+n6Nd5NE+SVad9GKVWtsCeaONlII+B/n1rLTPj6yD6162m+nvQIMtYUTLCScyHwMi+ZP4Iyhu0Ics6irDSn4jAPC8FVYdfRGSnaJDDkbvzSORoTqMRm0KVp4a29LKkvmeTCp8D2uPKwaT12NxSsTKJayvgz81z+tenLU0yHLSwXoqY3YEroocftL542SPFw2pBA/6jv5O/UOIb5bIM4VqJZV1TrHILYmPeAmRJ0/lF9Ef3cCstp7pS7N1H6AskiZGt3GNZ9NGcz6T/e4FDVc7Vu9uxJ1nMmHiCVr5k3/Wctv+pXag+IbsYdbY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(56012099006)(5023799004)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MXyoncXmlMVnGK5YiF3qqtmXxNYWIZBHxfMc8odB43WalRKqQ3zRd7pqOM5J?=
 =?us-ascii?Q?MhBSTVekk3svmPHYky/bYTmF4GCg0gdIlsUY760n/40F6d13cgs72sn6Ug5s?=
 =?us-ascii?Q?ggXNUwHc7AgSvSZAcdJUy2V7jB9Ut+kHc+xJwuq1LajqmjzEkpFud/JEgP6l?=
 =?us-ascii?Q?7SQrhJezZIDYoaWWad4dE476Tcszg1KoiGRTlFZJYZmHLpgzF9W51nC46HPb?=
 =?us-ascii?Q?IpTi+vcXfhLIcJLQ9yeA8eKSwMA7k2vV0Wfd47Q8WNj9wb9yWs2BQqXd4rZH?=
 =?us-ascii?Q?hCAVkLrsTJNcsTXeDDlTW/jK273n/Ado+ytLVRpSv8airm6SmFQ5IPmtP0sx?=
 =?us-ascii?Q?WqbQlMFM0Y5+a80aUu8zAHMHIwH/AEoVgvS+hWCOLA8XvosDAnuo9hpCilfw?=
 =?us-ascii?Q?K/APQHl3L1mwm8t5OMVqtXn0RsZHFKjdeFrMOmxqmvV1EGNcHjp7LW1ySZNQ?=
 =?us-ascii?Q?d2PwR0KXAoqDKlBRVXuxjMds6SSfcrA+Ec9wc1Ikmtjp9tweumLIS5APoXdV?=
 =?us-ascii?Q?pd2uZhihx6BipMgWjBCBex07t0o35Cwn0i4GzKx55VWFf/6UiRhbuRMNass9?=
 =?us-ascii?Q?6bZCcC9IXVpgAsNRUvvROJfKUZgVgrAYJEubB88U5SkJ3hhyu4mcDGKXo2PL?=
 =?us-ascii?Q?7G1zoW/0MWFsuKLCUMq2W6eQf92Lp2wp4qK4gQBoWtg9o83YnrikQtNd560C?=
 =?us-ascii?Q?Gz3jxzU8WKcF+rnu+nBwEJMu/uUay2YVcleBvIpJwpnXL+SZEDsmMWQ2vpzH?=
 =?us-ascii?Q?77v1XYjhJ/S38LNnKkojuwqcnyQWFi3zkQx/iK4KJ2KyyBJ16aTyBLeqeHSt?=
 =?us-ascii?Q?F/9nVtXQrGm22FBITXOuQPttgo37SsP7llsi8mevPoN4apFiwVoyzC3DmvHQ?=
 =?us-ascii?Q?07RoNrzFrjP+HyTI1zz7HM0WNAgLSujzuW0sOYpBDlYOgwqauLMF2oI+JjcV?=
 =?us-ascii?Q?BiINaArQ8MkWMsU8C0uRr3Sscrop0DfANotaHnDnd96pHEIM2LvvcEP+RjX4?=
 =?us-ascii?Q?QAswdglM8BBzm3KV2HLvmqzpyhemoqBGMJyke6oPmxGB80hP98I0LOKRoPwH?=
 =?us-ascii?Q?ddIfhH/uumRnUlzI40+rn/2pI+q+EpoZLJ9Gvq8PiRLcc9TJTqDKHAd7QfVL?=
 =?us-ascii?Q?VEVGoWQlGf+AdOEQviM4iqacQZbGCyNi75HB6NNEp1/tq/XJXtoTOvpUieUQ?=
 =?us-ascii?Q?HDGAvnbgs5ggGWdSgezLWhdFEWSCPJi0l3n4w91yxhc0/NRKVba7wxQlacQI?=
 =?us-ascii?Q?qvDiqLFvP8FUNBLeB5MaqtHLcP3j6Lbfue0lbPe3JjE9o9j0455gTs9rGct6?=
 =?us-ascii?Q?VQfM6//VZsdHfHIYtZiR/WNp44/WLuPCOc2yZ9kqpHZRZpU3qDPx+D58h9Fe?=
 =?us-ascii?Q?XW48NYk7/FQPB44uupIrW2goRJQPNGX8EEiJf4MEqmpx/yJcEh3lzcmyvDQX?=
 =?us-ascii?Q?ou9z0vdKWeKqmKaNbs19aOgjoX5lxFfsmwmdJ9EUG3pcgjCoBbynXtM7YiS7?=
 =?us-ascii?Q?2Gcy7fbDEqsY+fDI+n/VCsuX8wmEWiIfu8oOQeF99UVg5TjpUcj3Y4jtQ/GY?=
 =?us-ascii?Q?LZ8Gh4mEQyTyBmXsMXmnKxNKRTGOpEJcpp6TC0JBiFr5svXSJ/LXhrpU0iad?=
 =?us-ascii?Q?t9IuGt3dLWImMqIQa2gnsc17VRxI0QsaapBTNMJUJDB7tPHthM+cXqB3/Fc8?=
 =?us-ascii?Q?acSYdo/CLkl4/CS/ffkVvaAk9G+Mjf/cJME6SkeKAD+NmZrBOvd0V8RLRQ+w?=
 =?us-ascii?Q?7A1YfLedqw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9df2e38-dcf9-47e5-5708-08dee4fefb2a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 19:01:32.0936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5MntzOvOOAU1rs4j34cHqNWj7yBM1rHqLIqeTG2dYGVkuVp6o7G9rQPKFqOn7Pl3akd1XvIafIy9CV8LLY08Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8091

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
index ee6d7db212d5..de1fa1b21e82 100644
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
@@ -1374,10 +1375,10 @@ static void __init do_one_initcall_builtin(initcall_t fn)
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
index a8021039d44b..bf6aa98d8d36 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3372,8 +3372,8 @@ static int early_mod_check(struct load_info *info, int flags)
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

