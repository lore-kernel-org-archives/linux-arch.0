Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793742162;
	b=wsbXQcv0vbH8skRkaIOixXuNu1CfFdkj3I1ZJo6oTLSnWNcmMpoCSy4A2vklcgndKj6i
	 JErXsqFb7ol9mmLk+N0w6j3fM/DRVDVN0dEKCMHlVsnOsrSDMu1Yo/BZf+qAQiY23WF2A
	 HPSfkN6lh8GUcKAtfYTvCQCsTuAdrpL2x6J4761nnJhGgBVFclHkXn6yy+uw0KK/E/mC4
	 MdkIwzfKfyD0AS6CgdwF/Mxj4rsrjafVbp39+RG6rfxWyQTvqV1djbSyYTgK28zkayhWv
	 a2qno6/wfNpK05NSXUuB/ulmwCBCFJvU/dw1RRCGDANKqmlOs2H93p+/TikEczLzAgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742162;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=J5XOkgrqrDe5f0dLdcRL+e/u4c31XOnBDbYqDv4L9Lk=;
	b=urmWfm3FbP2Up+B2UBjKbR15g5B4SZ9/Vj0S17FfB9zdlcz014fmmiPKpP4oEs2B+Wty
	 NxuS5b25kwslOzKugL7/FIoUlhisAbSlHCh+DnpUmaMuvXhH8xgDp39MTokcq61rf9eIM
	 tIsifx5PktfdFgoXcAZpeI0bT9uiMqEFp5Fjtt+uR1tkmlPllIrYDYBPSjE+jFnu5TIPY
	 Hin+aKgaCtznz1fpqli+dL39knsnDNKmjTD7V79VtCvoyHF4s6USnux4fW5PcHK3JWBKd
	 +pLGl9gbbjmFc71X1/AqnQ6ZB299XSpsOAvtv086h4WHelFQdLsKBd6Diw6QEcQryjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.134
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022134.outbound.protection.outlook.com [52.101.96.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B30606A338;
	Tue,  3 Nov 2026 21:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95B30606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s66VTP2QxT6AGaluTbAGSlunHTDS92nr3g0jVtXhajwh0+ofJJYA9EVrlSHsL+toD7yQyiX/2x1aAbInwEvNgvApZBFMsqCpwtkATcnKnpph4KaQZS1nonzY1tUDQ1cGT0dMF8GU9eJBXSGfv8yL1+CgJYczxuAa8AcaBfkw6M/jnXiqihRS0nfyQezAbpyZ57pGbUdmOVdgYuCQ5TrRBUEKHPKNxZD0qzpk5YazcFgSak2IRalcegbPhH1xdSmb80lxrgHVkokz2TaiuElK9pANXSWJsVOIj75owimyrXvSDRTFjvkpUbV0Bg4tFYWcBKyyESdQkUKUTZ8vGGOEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=J5XOkgrqrDe5f0dLdcRL+e/u4c31XOnBDbYqDv4L9Lk=;
 b=ddGdKtg7k4MKnluSbOwUsYDTzcQi10cNyH8ACGAKWE86Fuss0ARNSeLyCxv3s0IBRFuDoWRYyQ0g/5smS7M0HrSzh9gb6gVAYkfZeitJ8nkFofhja7Ey7ku5f2sWMp+ghFz7sFxuVKABZyfOZ8joVbdPU7LCBKbWDlJ1K7xwKDPPDcYV6TyN33SPBOLyj5GfKABrDGlFqFN114tpGfh6m8bjeH9bpAAmZmStJqMdC+fwUn3g9k18RURftHLE7Er1qDKsY4HEwPj9M4foaupp9ory1RFMR09vbbetn1MKEQEmOD7Z82cv1jLlm/lcDTF3JSUbjz5lQi+QQse45HeNVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO7P123MB015864.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:604::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 21:42:39 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 21:42:39 +0000
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
	mproche@mail.com,
	nick.lane@mail.com,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 3/3] module: Rename module_blacklist to module_denylist
Date: Tue,  3 Nov 2026 16:42:23 -0500
Message-ID: <20261103214223.32598-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103214223.32598-1-atomlin@atomlin.com>
References: <20261103214223.32598-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::13) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LO7P123MB015864:EE_
X-MS-Office365-Filtering-Correlation-Id: ec400088-f620-45cc-b73e-08df39f361f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|5023799004|56012099006|261009221227099003|261021123027099003|261009223027099003|261022105027099003|261102123227099003|261021121427099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	gih/8gYGDuSL2YZan9PB0LMHll23rfyBpUGKrxvCHYQI6b9Jd2UH09aoG/azKJ2mFcVYDdN048HXLxJvbAWNX2zypjsJIP5qVCoowKzjKtC4SeK6xG3XymakHQU+IOc/dK4T5zpJXha99rLzWYGI6ioocWkhAfH/sGLB6vM97BJ818CL0AYK5PlT5VqtVtYELBvhFvTuiUdJsR5SQsmB7li0hozbonIs9w6c0nT8YNhHAPoyMqZ2g5hAyK/ip+X0wkRaC8oui1vugiLem196pO6SaEIgjdnvYJFfEXjLS4x7m2Fh0FEPIYFDMV4Ytk8Q4ZDjTRxbq24fFvS0zAoY6rFgXD+MWFm8v9YnMuZBeQr0CuOInSGqSMRJESH8us+reCDCJ9ZMsFkN3pj5ijJP20dO8i0lt0IQwNPsngbgdFFt6cZ8BNrJ+iAQB2bkC4lf54ONUJpw69wZSnnJ31Oh5YwDwThG+PnHu2bf3TwWiluGLHUgF5vvIx/8+DOK/9Z7NsxLe7t0K/Yu1GMG59ViMaOZxPHKRDB+S5xMkxyjIx0RjjYbmJnWlqlKRRNe3NP0xVP3bkMqIhgGTblCagcPe6BSMOFbpQm6iuKKGhJJLiTfC3lYttGUCGCPl6r1IHPoR5iRyiI0Tb4jcLeOmW4CxqR/7sticwVvkIkaCPKoj2A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(5023799004)(56012099006)(261009221227099003)(261021123027099003)(261009223027099003)(261022105027099003)(261102123227099003)(261021121427099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KIevDlagsINANKzXzBCwiv/8jJXCgiSs2mf581QmLBSsrpA2prh2XuwpJyNY?=
 =?us-ascii?Q?FHH5kcLMMYQDSbjfzula9U6TB5P2/19rnpeGSWCteWc7TN58GsRzkcAzZglO?=
 =?us-ascii?Q?vszsK5StOD1Nglx5V4XJJhX1KRIi5dbqYeVQ8OyAvxCMJ7DF+hG1FJhzTZAd?=
 =?us-ascii?Q?YVv8ZuYp0vv9Is6NroHKbD/0+ZKcO/hj4Ql30MfX0z4eODfXsvpLysU8YaUa?=
 =?us-ascii?Q?OEZbwAPa03SLWrrj69xskcw3RiMVcHfKopsIw05Rf+iUjPHTZxFgBBTv1ZOV?=
 =?us-ascii?Q?NET5CC+/3tSWaPpJ4dvPYY9wblKpRT7hwQBfRF8HwdkpwKGlNqZnGGebCCXu?=
 =?us-ascii?Q?uzoOGwqPU0sZDMe3xHi3RX4nxEdf/IcH4++yUd2wd2k5moSnP2/rOaqUw1Z7?=
 =?us-ascii?Q?YYrhHxONO9gB7COCMu7mWFohMb8ZJcO0JtFz2OXoSHeEvfZ5qz8XKn6nGhOv?=
 =?us-ascii?Q?AKyS8hIC5+hD9tWip6hoTFbLC5eL138EBMU/kz6kI0UooUzxWniXRVTP94WD?=
 =?us-ascii?Q?v2RDW5esvIS2uhmOIsj4PObeWIaK2QvfZzcZwvdIqdNoXdmBVPH6/nsc5EY1?=
 =?us-ascii?Q?YmOdNZDP6Jf5/hZZ/C7pcDXyt6R5BWQV3T6es05R3afycBwm80inFEGNU5ZD?=
 =?us-ascii?Q?LgOBW6rEe9REFR4syCV7xharjheKfVIQCiESNVBOF9QiCpUVpUDw7rb0gWxW?=
 =?us-ascii?Q?fX3yJ8su9g25uyfX0QiHLb09BERJ/8t1BtIcTvDI8r6Yg0ypg1SvLeRXLEYb?=
 =?us-ascii?Q?A+L9FgTUw2jZ6yICzGJhFkv6eMNREezNrYnui3va9V8Ps/rQ2qYLRLrUPVrg?=
 =?us-ascii?Q?HjZZQvPOKvolL74xyNimJvL6I+vFw72O02S+2WFRNiEU4tNHZHfqWriehuJk?=
 =?us-ascii?Q?BeivFijNlWhoJ29cjCR8U4rro8SGcr34knITWpxLHvKGsQVBpXhRJTbHfXsq?=
 =?us-ascii?Q?/TcgeALJKNyX1rrMLnD9mpHtQj/tcjh+uuSYZ/04AYR3MSi3qQcbvvd/neqO?=
 =?us-ascii?Q?eV/c5YN22oYaysQPyNDWSgeus30GPTIzCgtfC0xZTKqdBsYij2tawPLGkWBg?=
 =?us-ascii?Q?qs6qNMsg9yvrxLi4DSnchxgFKqU79b4WyP1IvEJ1N1hSNFjpifdpRLMU7b44?=
 =?us-ascii?Q?0SVNl8y18y2tTOY24CqeBRlIR+vY4iOJ2xkV15SmrqjCbbp6pCUwhoGDtmnb?=
 =?us-ascii?Q?ZzLj7hiJ3W8tsSBCD6erKJZzluvqWM5+iq/F1oY3nqhq/piP7JClcRKH6btq?=
 =?us-ascii?Q?AJ/ILx8KaoQVRratI9kYfyxrKgFRfuq2UQRLy0wpi0DvgZjUYXowxxMt13tg?=
 =?us-ascii?Q?PMzvyMpqFlhZ2BaABMG8VeONOiABqC5Tz8JDs1EtfTMyZyHs8o5ZPYfmm0nD?=
 =?us-ascii?Q?//mEhX1UMtKCHRmkf5KeTBOCY9LxuJ36sNXwKFX16tPos0qPJbmoPG5jPtKS?=
 =?us-ascii?Q?v4JaKF/phKyucLxz2UCpb8DxIfKNDyGleTSdvdIhC/2aMZ/6snc8m11lcCas?=
 =?us-ascii?Q?fNmzobskP29eaP8Ugl8IkYkw8s6izrbiS180dGEf+6DTf5k2css+FSlI5wXM?=
 =?us-ascii?Q?sYvn4zkUKciK4qXLv/t0+Zuys/+b5cQCTNGVZuWYH9RdopruWn7GsPTkiAK5?=
 =?us-ascii?Q?28Ue0W0io7bD2dJx5E5xLriRpenwSbTmqbocvuxnUESrr4CzsTwqM3WR6Zkg?=
 =?us-ascii?Q?/QSMaeP4f/L6JLyFSFu9/OmO0xIjmrg+sbA2L97qWHw4JYeMyiEKL1jxjPoM?=
 =?us-ascii?Q?2x12F1T3uA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec400088-f620-45cc-b73e-08df39f361f3
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:42:39.5103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmf6JZQF7E5EEjqSSF1W2FDVdZ3KjtMp//cMcm/WVh/rNCFNi1TooVbvNrqF/+oii2Fm22YHZAXvsDzhKho+Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P123MB015864

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
index 0b3c140babd9..096c65d6507f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4226,7 +4226,11 @@ Kernel parameters
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
index 98196204fe27..0fa43723429f 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -892,7 +892,7 @@ static inline void add_taint_module(struct module *mod, unsigned flag,
 }
 #endif /* CONFIG_MODULES */
 
-bool module_is_blacklisted(const char *module_name);
+bool module_is_denylisted(const char *module_name);
 
 #ifdef CONFIG_SYSFS
 extern struct kset *module_kset;
diff --git a/init/main.c b/init/main.c
index 1302fa71a733..70b5642da3d8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1409,17 +1409,17 @@ static inline void do_trace_initcall_level(const char *level)
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
@@ -1428,7 +1428,8 @@ bool __init_or_module module_is_blacklisted(const char *module_name)
 	}
 	return false;
 }
-core_param(module_blacklist, module_blacklist, charp, 0400);
+core_param(module_denylist, module_denylist, charp, 0400);
+core_param(module_blacklist, module_denylist, charp, 0400);
 
 static const char *__init get_builtin_modname(initcall_t fn)
 {
@@ -1445,10 +1446,10 @@ static void __init do_one_initcall_builtin(initcall_t fn)
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
index 1787c8784aa3..f52af42f5337 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3401,8 +3401,8 @@ static int early_mod_check(struct load_info *info, int flags)
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

