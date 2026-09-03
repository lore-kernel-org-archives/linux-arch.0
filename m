Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020115.outbound.protection.outlook.com [52.101.195.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F53CA497;
	Thu,  3 Sep 2026 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461801; cv=fail; b=ZKSQ+Le2M4/8aVnIjmapxDBl2g4Uw5C377qio+kPkRM1AQJ4m6fUqdpmsGIK02Z69kdJItZiqGMYZXFrCSQ81/XQAfKZTgAUp6O+xHgfC+q2xB/Tb4i59VqwbjyVxvnffxTAXlheQkDyM4EwlosCVofNOrWwY9xgmTNdU1YQaIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461801; c=relaxed/simple;
	bh=VLt0WkacrY20oeeXnmgZ08yMBEq1vzFCTf66b5DhX/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uFakRBEogP9TgJznjubQ0onQcVYa4Ua2CcpjbuwE/0omnBLfO75OjzpT9s5SVDCtCk/V6tNW7HFxouSgeZPN2sJmlxeMzEPEHNktMV7mYIUAV0JwSKn0JaQbjPvllKpS2SsPGhqM/82IjUtj4bKDZ41vmyFvSsCTDY8iyvV4k/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rP0mZ7WqHn7738DGEzuVn6imKTvIs5pd98VJjMVzp9uspKhUotAVMd0n8x9VJ13NvnVOWqVGW9TRYX1HA1vP2v1nC77z60B9JJXFHssBnzKoSANPcM63LhmnoAwrPGKJWJIWnPlOoM1ig2AFX35BfjEJZTIj6XUMgGU/5rgdSJlGQg2tIdTiNXptzn6T6XPZtXqVCRFo7Qx30aoCn+hmULM2pABDPiYkvQsYbV8eaZmzSFE2GLAlPNyN9AxuY/PYZZQDX9pPiUVL/3OSAPbKNSBW6wSNQjn09bgu//jV7MeureIfLXoGYfyfulowf4BhKyr+aQgS/oLdKDQRDIQhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=uJP9lvnMs9a1IgkCNpfpmqe86LM1QhURs/FJIoBTHSE=;
 b=GL5rkqvKT8H8HMd5/S1iv+dh/xiBdV0we2pDda4WpHuGVl6EZtcJFyb8lAU4B7MN07gjEZVjXPMbuPBDB3eGyemoInHvads7VNMjy4qLcFDIfmcpDMSfzuooSFNEtJ7m66FAecaHiKkeMHnAdO0HNtk81Om9HQCUpeiOOTKZSwKPNGmkxfahaN6udyn+x1SVGF7/8pNkCmquETERnENIYtFjM6dt+R8bs3WF3a1sssISNHdHVSh5QoRo5lt/VCmnN9krsXBLLw6MvGB2w77VlAWRxzBV6tv3E59pxOP31ZWQBV6MCgtgAqb6tT40FCBGAJOM/ImPKjCC+HDd2LMCnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3048.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 18:56:09 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 18:56:09 +0000
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
Subject: [PATCH v10 2/2] module: Rename module_blacklist to module_denylist
Date: Thu,  3 Sep 2026 14:55:57 -0400
Message-ID: <20260903185557.183224-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903185557.183224-1-atomlin@atomlin.com>
References: <20260903185557.183224-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:610:11a::27) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3048:EE_
X-MS-Office365-Filtering-Correlation-Id: ce64611d-8cef-4744-fd83-08df09ed045d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|3023799007|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XBb1/86ALB3c/hYWBxgokPu+Rs/gUwdlWyFilDJPeQoXm9m2HrR1J8tlleN97ichKBe2l7rBQrTDjPhlJOUSZpWpkIggfeJXuQc+Z1U0GXrfM4fHplPd0hQ7Qg/jIz2w/+0CJadILDG/H8WKVOWaL3/g5TPbH3E/Q/dBS1v6KSalo8IwRwdNHzAu4+VrPy+uaEjWZYXcBYEOGpgQcy810PbK05f5y6IxIWvKF4GHrPFK05WgEgmUitTAfv0R3TfU4uKqWWXSvSPpuTm9akTJ7PJ5H0bFOEX9uiGZVG5Zh5JS2KPbFterJyQEidb5uCsBIK9dsGr/4MFZ/4OGTIZGsABkRJBsnaFiGQioyKV39fJCyNXTgozkQgCiLZJWjgGDppdY3fTR4/aQ5Ta2XGTq1hCHPEG6Gu+QSUZbSwK9ldTKaYKObPCeQM7UAnXY7OMDO+0OKub6xBSJ/MdW2Rm3fFiOkU9pSXADU/4b9LCxFYOfse0LS+CFw1k2t2+kf7MTkWlaB0TPvHRgvguuz5fBMevt+x78Fy+3EldYaDf4RYGfQ5PfCkoUkgH4EJCRoslIBSR0KFxSIruM9AMW3i0uTfAbY9SmTcE4VTOojC8XYWbWxfgq0a2KW3aYHQw2vUeiQOE/BO9rz0ajjARfDZ4pu4AtUnvzzqHPXhNsebcJTcs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(3023799007)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A2zR1rdj0W81eUWyvJdDsF+S7IlvMgHSpCUZpROTkb3Gly1+kSlaZFqze1WR?=
 =?us-ascii?Q?5a7QY2PLIzZ0BU0JrAlODnF0C+bwOak9WjGNtDSrGv7y8ogXpO8eyOqg5Et9?=
 =?us-ascii?Q?63odWC3T6mITbZBjH8qpIhGLWc7YGQvcyOZpRNFzaKJlqK1n6OD80wL9UFaY?=
 =?us-ascii?Q?xXVmCXoU5tWWjmhsbbGHkVOMR60tbP+0KK+Cw2zRl6yRgPgvGHOtkaKqCJP7?=
 =?us-ascii?Q?oOp6Raua/IohNldFgVhgwvYWileBfU4QGcrcGRU/ujHOS0qMIeOWcewqldtV?=
 =?us-ascii?Q?nc7U67AsrGg/9kC0vuza3iuVdRksyy/1OSQZAMNV+x02H7MBGHRKAQux4J85?=
 =?us-ascii?Q?GD+we7eMOWAOkPbK3oFmwZ92BSD3QCNRt8EYk27+675L/3ZTxNQHhRJj/G51?=
 =?us-ascii?Q?n7TaY5E2vS91nW7a9uA5qExLO7aMfkYkIp/h2b3ys649MpGxpM59qfTbeZTw?=
 =?us-ascii?Q?eIwzLAWZg7WEt3YyZn6zVvfpJPwj2GfFza3XLI0IMy/ZkkPTPwJL8U7OAIVJ?=
 =?us-ascii?Q?9gbqefMSDZvIWl5jxzvgSfFArKy0Xm6JRFhSCosCHwMT2HtYUl33QP6PmRLa?=
 =?us-ascii?Q?1nT9X8YnpZ9jnbpSsr2j7RrTXemA/W8Ei7l3HXVc/EySORR0di6UUT5AWM2H?=
 =?us-ascii?Q?gbsJSdnCkX/zNrrhBfKfmUnkBgnW6ZVKEZiK4Hn3sCLllOSQGsptXye/iXE2?=
 =?us-ascii?Q?U40pv3JZ1qJh55T3c3+lQER4qSnb+axMt5VXKlGGc/reL5v4tPFtiPdV6jtF?=
 =?us-ascii?Q?yXY2oWgOzJM2Nmfepqfd/6/mZ4Da7LHSCgK0mLjontkiIZkGZgNzq5zhD+rM?=
 =?us-ascii?Q?qfBCnxW4MS6BarGdaNLY00vUqM9RyzpOf/1MkW9nLGBY/J046u/eFjcoiiRN?=
 =?us-ascii?Q?BSkcMW7stYmQ4YcP5U90pg1QgKvGVyb0Y67mC/GGXCLjpzBDr/uj/XyEfhwz?=
 =?us-ascii?Q?+H9d96yS9hE0Tb7djyH+5XBkNeKCFhQeyUlY1v+nYXDWStkZmAKlnd58ajwk?=
 =?us-ascii?Q?Ilcxa1FlhJlQoQ3qzjXIYDfoJYtshVXrYBwdlL5SY9f0b69ZVoNxK5wiwBol?=
 =?us-ascii?Q?R48QB2+VVWj1NwJrGI6x/0Gw5wpzjX6ByMD6fk8uhWK71G2qnUWpAegYb7RA?=
 =?us-ascii?Q?bf9Zk1x1RzTtuwKBirWbtZaselUp6B+qauu6faUR4otXquiW+jvKRnNaBb+o?=
 =?us-ascii?Q?4cjm7bpa4cW0uzQfPc32M+y0aWTzOZrQgJsZvqLNHoyl43AKroNeYb7Sp87j?=
 =?us-ascii?Q?wfDqFpDiDDGiDzc1HS8yBq/Oy0lF7P6gcC+UYHV78nEIUb5L6FPyxft2zXIR?=
 =?us-ascii?Q?OZ0Yj7imnRb4x/bj1OkzPH6ZLM4RHWzNeXGqd9QcJ6ophcXrtFAwHkYXBMT6?=
 =?us-ascii?Q?NedCuo/TpHriIlN7o3qjGUGGsfldaXITGXczCJ/m5Lll/PZ6ALAfEQ8NR3a8?=
 =?us-ascii?Q?9nW8bmst4YhTIR1nHYfqVFxqMtxGUj0B3ZWQKZSKQEwmrDdYZY/AiD5hPJqZ?=
 =?us-ascii?Q?mDqwpcAhp1H3rnFXHi7aJr+mhFVlM3LJYKouQxIzJLvGx0d3jFV2B6lgzt3L?=
 =?us-ascii?Q?SSPdzf9FtEe8ogyLB3r8JhRNRkWeQg4vJgNYgNRSUFQdrAwsnqKZ/1HlEoX/?=
 =?us-ascii?Q?lhgkqopWfNYbeYmV+eBKrC1o3ZCf1q8Jg2hFgv2jPgtBYbcgzVaiKwnh6uzL?=
 =?us-ascii?Q?Y8JXF/XXL+nLjrFhAkXrKS59xd3wdN4vT6Wu8NUDMFURIJxeTL2BUQ9d7T9l?=
 =?us-ascii?Q?0A/RVqijbA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce64611d-8cef-4744-fd83-08df09ed045d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 18:56:09.6723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUUELNeQH/CZgg/G0QoYjmSPR8G3AVU9SgfvxBAIkUqREsnkjcxrmHU4qWeL3aW/ULn034qS6nKLsCzlgd7ccQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3048

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
index 68647ff4bdd2..aae1da11a592 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4232,7 +4232,11 @@ Kernel parameters
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
index bcc54edbde7d..39386a18285b 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -879,7 +879,7 @@ static inline void module_for_each_mod(int(*func)(struct module *mod, void *data
 }
 #endif /* CONFIG_MODULES */
 
-bool module_is_blacklisted(const char *module_name);
+bool module_is_denylisted(const char *module_name);
 
 #ifdef CONFIG_SYSFS
 extern struct kset *module_kset;
diff --git a/init/main.c b/init/main.c
index 0ee3b23bcd2b..aedfe858ae9b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1347,17 +1347,17 @@ static inline void do_trace_initcall_level(const char *level)
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
@@ -1366,7 +1366,8 @@ bool __init_or_module module_is_blacklisted(const char *module_name)
 	}
 	return false;
 }
-core_param(module_blacklist, module_blacklist, charp, 0400);
+core_param(module_denylist, module_denylist, charp, 0400);
+core_param(module_blacklist, module_denylist, charp, 0400);
 
 static const char *__init get_builtin_modname(initcall_t fn)
 {
@@ -1383,10 +1384,10 @@ static void __init do_one_initcall_builtin(initcall_t fn)
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
index a9fd6aaedc69..1a58313649d9 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3381,8 +3381,8 @@ static int early_mod_check(struct load_info *info, int flags)
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

