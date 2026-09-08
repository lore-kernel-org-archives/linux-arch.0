Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022131.outbound.protection.outlook.com [52.101.96.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873373B8BBF;
	Tue,  8 Sep 2026 20:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788899573; cv=fail; b=tD7aBK19f7NE/sm20tFYuhlR77fItDSjw5p50bxx6fGY9izrS3USdP35D67DqR/+pU0GHlWG/XdMkHbB2HMQtpwhNEXDW2BFiTRd6UrkOfPvWIVq+lV24rJv4EaFX8hstBTktomj+zWb+DkookqTtrpT8H/fFi+JT4yqrn9XZog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788899573; c=relaxed/simple;
	bh=tyF2Bjc51NZIe6k7mnwP81pviDAy1BucIJllUtKQGDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ULuS9bA5AQJC8/VQMorj0IR/80Qt0B/ZLbeF63XO1QTog2+X45u7cg6X/ax2hNW2oqsGpQnoP048u54NtJm3Mz1nwOG/uPNGMF3LUxB9I4oCIhmBl7ZgA0AvO1a2DUP1TKBnEbBO3Hqfa5cOT7977myLZTz6u+5IpP5M5wS8Baw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8MJxS9QzLQbawI7o690I5LZR5nGM7KbZZZ7eOtmlDHxQl3J/O8sJiUApPT+SOcZ4NRyVxoJLwXjz3HY5dRU7MxeB1w+CmCm0gyzqdhMgyjFXXordXQ22Juc26ZEFsmN3X0f+YBkGOTQ56zow86WVGFWYjdGtYAR8Lp/XIXe/SmXihnsELfSxrYEABOftWXgPb/nzN7uj0esCKsWU2RNrP1AWwc3b3T91nIa8vazl+lhO4LhZtv5uAyoYjdnUk/gpjmuSEjOI15IKqERrN2ntNY/XHsQu8KKhgKkJgujfwJl+W9185FoRqOiKbd+gPfb0Nv00DV7s/1YHJzIGrsPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=vDN3Mv/ICYouKSOhaOfwsMY0CjSbDzBvFKaCtP3kvHI=;
 b=isCqK2iSdLub1YuyI36uHjSMV+rYibw3u90KY6wuu3d5L0qSd4B9XKuldxG5i+C2YZiEAfe5WI1tdOpW9aPV8HtIfAIZJteXpw4ToSBqv04EMhSmT4HwGTwUZX2gHiVKn2ROUw3zuxYXCWEMXPtWN3FwE/Zac6/+Gnteuz8F5jcoS7H+wumxrle5rX5IhgqxHFn3yw3qPIizTv2CMiOJnvauYhU3puxenXZH3qRgX941nv8f/mdizDvqGJ+n41sixylphAaSakfHp32aK0VaHBfdpkK3S0MlpSciKkVI4V4WWYI41IF+dMO6eDqEIQmiFIhDqyEr7ZJDbP3nxLBcng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO6P123MB7126.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:32:46 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 20:32:46 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	peterz@infradead.org,
	ojeda@kernel.org
Cc: akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
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
Subject: [PATCH v11 3/3] module: Rename module_blacklist to module_denylist
Date: Tue,  8 Sep 2026 16:32:30 -0400
Message-ID: <20260908203230.401020-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908203230.401020-1-atomlin@atomlin.com>
References: <20260908203230.401020-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:32b::12) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO6P123MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e501e68-b6e0-43a5-dc78-08df0de857c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|3023799007|10067099003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jBrEXcM+PcJLTmNsUZKav9Ylyr1d6JGCyV2LSJ/a3pWjLNOOeYEkkQs/mrINFsNm5NvPcznp3tw1eibKiUnFgB/U6W/v6tzat1MzVgyivDMHl+IKscSpSoWQIUpjzUB9ekmwtzwbNAQSr/CRFc6/RIwFr+eWOQJgtlk7OupHpHmIAlVtrnNDPTwg2gvtRyX0S5VIOfEG+LHebP7Ytvnzb6T7BXHLgv2WiMDhYX5fFBefOSPdeCpXfazyk7+CMGHsThDP5Yb6ROkEtYbhq32dkyyuII2dAlNIhXOoks8uAo5Aid7RBK1NOVI+LBlXrpRMruf3HWJSZEXIb++WNREyDXqI9kR+6kPsF+8CUZa2Rdep316x1I5/sTOon19dvdHn4h+KlPhxycwa4CfXS/Nc9JxczSwRpq7RzJqr8DWq9aPua7WYBmdmyQV5BLRbjXiydSpIxFZ3Cj9sxlQ5qBBWIghRSYTUUB5PMPY5O+TQUoZ1tVGJwZJWpYTb+vaBPVkXiHQ4RbBCeWGi7Prlde4yvLok2OiLz4U0j4HxN3sV/AmFkUUILGbS3lzYXuY0RCK2qGJNsvlwX1XeefxlV1Zxy8flvwOviXGdk+vgNi3LilHegv2f9o2KLYBpTiDrtSvgoG1kns+uVXZduP4lcQp9KF36daeoQFiXA1Hx10i4WQw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(3023799007)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IjD8/gWo30royto2cidsfeHyJ3N67kRce+0u0FnN6LWs28CO2DU/q0chTTyI?=
 =?us-ascii?Q?36Ym7lByH1WcBmgRkr/kjjTu8cPxMeEI03L9hG0RfL2vlsddc9JYQf+Z3iQS?=
 =?us-ascii?Q?DVto8E03sHCLpVybTaKG1C+30AASNk2kcmrKurGrm6uRrcWrc0i3wrYu5ICW?=
 =?us-ascii?Q?icJWBzBl7RVhHadgy9pHssoZd4Y/3AzK+ZNt3MzdCM2DLMxa1toFBZoMra8m?=
 =?us-ascii?Q?WqYv6VTz1QYeh/SET9rCfWmHu+zPKBFks6QV3IhlTndJlj+mFz33sgTG/NDU?=
 =?us-ascii?Q?mmmU7min+KCNpwZXInoU3ZDxa+L1OSbFPh+g6Dea5dgJBulDemdpDEvQQmAn?=
 =?us-ascii?Q?9hlQJqqxObUUE71D3CCB2AXTW7IEgWQfAPZBeTUPv0xrl92RPq5/nt4Huwqx?=
 =?us-ascii?Q?beYGRoBIFAumMEAUNL8Bb10DRODMkhkO06HC92Og6k4W9NzVgmUplLQvLvYj?=
 =?us-ascii?Q?yDjGnzhKelT+bWrZDkDW2lUTITejabrNS5S68y82VWNZPlnTwU/YhJvzT6ak?=
 =?us-ascii?Q?kO0RngahL3igVkxH3/Ti5QHYQwK4ug15f0dAx/R/h7jGdUHT4b+K+h5odXmn?=
 =?us-ascii?Q?SAcm6/VOPmqpwWdnECd+UM2vOQR9scVoMdl8Ixcr7NC8yJpvVqY4ejnQr9Ul?=
 =?us-ascii?Q?AyYJ1w96u1YgOdF/GhBGSKQoL/vO2LwVC17kZ6zgyKi0xpv1agul91190KDU?=
 =?us-ascii?Q?9oSKv0Hk4pYhxqXJosDUDksZHkh1/Dg8vasLUh2fVPmtLRE2c8DbJrJvHOAM?=
 =?us-ascii?Q?yX+k4ivc7uVJcp5XichTNclbamRV4jutRghKQ0dTujYnW6U5byllAwwxjQoX?=
 =?us-ascii?Q?xY7AIakm6wzMulMrT26yy3Afw7sRahkWxWtrpEBrNTiAmt4YLtDBDogykXxG?=
 =?us-ascii?Q?4o4OmmXXleK/KzwYt4D2QTIr1Pp0NAOODbrYRxm2EqVVqF1kDzjEtwnlctbW?=
 =?us-ascii?Q?KgxRJBrRzwqWcGaZ9SvAdRHcDlvrITNhr1a4L2jACsUB4/3nWkqi/cT25ciT?=
 =?us-ascii?Q?vf2gJ+33Fng79MBG4KxF4bNLgh0lV9OaKvLQryqpfrPbZP4ck6I4cbUfZxx6?=
 =?us-ascii?Q?kdupcnIt/N8mrUch20D+93No10CsLOnwflrYNJ88rP1J2CIstAmVdkomkEBo?=
 =?us-ascii?Q?mJZWSw4Skm1+kwblx7+OS2EefZzhzNdFxB0d5Ks9HgNvOgBxUHa+kURw7kmo?=
 =?us-ascii?Q?7+bNG1NYeyB9sRhMNUljZn36eaHVyFql3s9tFTsoa++c1OSMkD68YEEDqKUL?=
 =?us-ascii?Q?7hD9IurnYcCeqY8RB9cIx7ojtFd3/7s16mb/vkBpYYU01oFrX0j9aEVY1ZEj?=
 =?us-ascii?Q?pBk1hZStArWcMVIEThAox6z8eyKnBrSGx1Cts39Ttla3h2ExAH/u8r8df68O?=
 =?us-ascii?Q?aybN4ZwGb2zRRDKZINF2xK42hr2eNYw7V7GNQDORVZDPgoM/AIEkzn/AKVyU?=
 =?us-ascii?Q?6AUiyD2LGdCmFoKM7SEpf5bbuntQ6bRQFiEBcNAL1pnrF/NarFjAG9dBsQmt?=
 =?us-ascii?Q?EIayIpaN3AgjhoIelXLXgU/KBrR/Jd67GqKXhMQgJxv1/rk4IofRudmcINGW?=
 =?us-ascii?Q?nn2hgkW535v3s+LQR7JVUyxRqGRPWzSWDcNmPfuF+J1ox6eKxxB0X2DuVQYW?=
 =?us-ascii?Q?yGE8QGvnfZZfuzJG79ZN2+sBZo12tdKNI4PpcZmrmGzewrcuCEbWXS1ydIAJ?=
 =?us-ascii?Q?4rhgSK2uQUh/hvGR+vs82GwVDZyLna5UK4Pf5sZiY8gYN8UKPDn53GfI/cRx?=
 =?us-ascii?Q?QMCGkkbjhA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e501e68-b6e0-43a5-dc78-08df0de857c0
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:32:46.7453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efJm8iufArJIqNmzEB0GohRDTdVk62xuroh2Uds/sthCic1m99eVEVbpHqDatyiNQObk1vV7UZ9kaUkTb6pZJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB7126

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
index accaa8418aa5..8602dce328d7 100644
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
 		if (strlen(module_name) == len && parameqn(module_name, p, len))
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
index 0eb5700f9f73..9eb31dccef98 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3382,8 +3382,8 @@ static int early_mod_check(struct load_info *info, int flags)
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

