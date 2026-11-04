Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.143
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793806823;
	b=n7dCh0DXDoClnvAFqfmw+aj0nbma7h5CRPOh8hVDNZZXqaYq/xZY1w+rqESu+QoO5lKf
	 KqPw4XgoUl1lsab/iNSJkiaXmHJLVGtSAHSOWMNscMtwLC1OmmeYDP1dfcp44Imatou9/
	 dvaw3boGKxXmpsuFn2tZw44XTeWVyEgD+Rbq8l+3imzoeVtBXjAiCiij1Jzegnpxnyr11
	 7M3s63p2WUdjbVIK4SSaAHhKZ6NoKPfpDRhnIEIsCtFLNdwcPJ3M1BlM13tCKzKehTeEw
	 jaPAyF62fESVqVnx7O0q34azaG06sJqKsgKi70Ch+ca4TNG/Rp6OXv4pJEmSmODtK+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806823;
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
	bh=KO8hVHOg9q6lIBg4rQ32Kg5HWBxJeGKIG8BQZ5IBLmE=;
	b=qyBQE0vndUQuLyQLbIqjl6lbD8hClw/hecjGi8nOfoffXEU5hA3Z8vg9i6ybDD0V8Bsw
	 zvsjZGqlMV9O2F110NlbIfz1/wpdIxJ2vIZ9rG9bFtMvzmB3kZ0pIo5XUsvvos4P1B8Bo
	 qQ6ShyTxFrLxlRSchfgLHk+ljdDvMQQZakfFyv9QLQo2/jHOL+TvT9w6Th1T7HGPuaU59
	 jhc7W13P9lcCwbQJ9q4XpMv2fQt7iTkF8+I3RCRCZaMENu/SRcFowH8JGzT3VY91qOLEY
	 nHLe3s75vIneFSZDuzXzEr8fLd+E/PkEk/lwZ4Xd+ECgMn/0on3a5Xlr8u3KfaYY1jQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.143
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022143.outbound.protection.outlook.com [52.101.96.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A181606D81D;
	Wed,  4 Nov 2026 15:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A181606D81D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtFPUHyvudnNza/S0RlCU1OklQ1U/uVFv2XhkoHa9HXdWl3SVUENbIm+0Wf4VYE/NEw92fwjcqd80A4+Ryih6K3Zf6h7Iqar4tRvVpcDhalZfH+2I2Hy8QIelr7NM2SLy2yJPiY87xpLCSORPVT5wCN6zDY/tNjKpl1jOpWg+jq2p9Zn4czbls/tsnheHBL5000fTnAVcEqL2ZpKXwV2f4jKB2eNcohLo6Pf5KYsGdAeqx6LJCEBuRzs6/1XOFKGoIC4/2S0fT4IOHxH0PhVXv8MXx/EYI+IBYlf1Je/MdyOyP6BM7YE0Mt0k5A6J1gYdiUeGbz2HHU82Q9ViNmkIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=KO8hVHOg9q6lIBg4rQ32Kg5HWBxJeGKIG8BQZ5IBLmE=;
 b=aWheEuWwLWbZmGfUuV+QTbUGFhcwAjsctpZ2DkmYiDErQZ9QZGoTQ4M/wK/dcirJx0/KJVCNCwsxdCKkJyOsLQTwiUb03PxsWc4+nFAPO3RDQMmsUbx4LyGv40tqKdEBRfoKU4gGpJnb9nbO1UxLwqfbVr6A6azxz08ANCMVBEPlULuj2Pz8omJvCJl64Fj6xudzxELDDkTrL/scTU/ZlBCgbZTNmggYU2W1eSf8A070mGAdL2gpCAn8lbMPKWseuQwjWqzmJjENVT/FXgG6bWD7pRytlOFnX/jcWUPAYfFXqWaCzZHYJ6hsyIa6hSqKoZir3+LfznqQJtY+RcF6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LOFP123MB303791.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:703::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 15:40:19 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:40:19 +0000
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
Subject: [PATCH v13 3/3] module: Rename module_blacklist to module_denylist
Date: Wed,  4 Nov 2026 10:40:03 -0500
Message-ID: <20261104154003.43313-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104154003.43313-1-atomlin@atomlin.com>
References: <20261104154003.43313-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0317.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::11) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LOFP123MB303791:EE_
X-MS-Office365-Filtering-Correlation-Id: 48fd24f0-960b-4ecd-631e-08df3a89ee40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|18002099003|22082099003|3023799007|56012099006|5023799004|261022105027099003|261022075727099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261009223027099003|261009221227099003;
X-Microsoft-Antispam-Message-Info:
	1WsNH5wneLVf+/B7E/eREX9BqHknRf7G4yxsJvljfL73wYf5Op2HG7zE915etuEHSaHRLUIw8cOa3lv+mhuqq2nTRb49fmZ4uTFp9MXRENJCelL7mgYkXOs2h6WolXwF7tYIdGoIWPfqNoRYv55KiaQVb2VEAtsaN9mlIJGIjmvJdyYL+lrmXxCwuBkMnPLqr65km978lRaRXuRu0IhIDeOcP7qxSuqq1k9jt9ZtSfU5AmHI7vHUGAeyE7z6TQAJKroIiayP/gBwl7uoJDXNNROPEKBLOktsy0XTsbB1jMyGdIzvR3FdUWalCDd2pIiP+PenUY8jccPYxL7AjzSJjlghrivxQPhvllIHjI0MTpPAyc2glYqoL25zgLp9UibbbBU6MAjiDymXM8TgmHfm2expw769qHnIISoxwVBlQOBhoD8UnNGMCsf46yhlrETqVoaNI9lUU2TaQEur0g9QBADwsqqh9lYV3pqIH/EI+s/BrSpsppkMtToIJEJeaGsCqdgQyLw/xFvQ9GtNbm/E+MFMy4J+afOe7fC+s+rT5QEegxSAzfZY14jwQ42MhOKd8aIETc/QT1S5mpMpY2AGwniAHh3UYIlhczHsteKY7pL1nW+vrqc6e1efWQwWUpTLKfskydzHZzKK8VZKk2C1ZJKOW0dJQOLR+f0cAD5DG+E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(3023799007)(56012099006)(5023799004)(261022105027099003)(261022075727099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261009223027099003)(261009221227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fPUpmOfkTdoLhmXcb8MY24qnwftVbN2FLl1X7p3mCkk1i3oFmd6AH0rS6qt6?=
 =?us-ascii?Q?PQebUTBhvU8v1dUpPSuWIOMq9bu/SGZOpOUYI9ImabyNiU6aqFZYKs+I9m5N?=
 =?us-ascii?Q?WWL0jFS7aQWd+dTkCw6HQ4iAkLiSuGys8PaknGIvET/IZoq2xIffqSpuyu9x?=
 =?us-ascii?Q?v+b7nURCX0kEPbgCjv1b8d1YghGWfkc0CASVS5SO6fKV9NX53EWNQhTRjYpy?=
 =?us-ascii?Q?upMhNwDMwE0sdm9TUaN/HCrkrVw4FS7M0CdpFzaB0Ulm9P7PzG9ZVscGiXyM?=
 =?us-ascii?Q?dkZvJ8nKC/kLzkiqbuGnH6YfjBzgrN5AmsEGyuDqdE6TRCOQR/cifPI2kCcA?=
 =?us-ascii?Q?uKQhIKr9HkCar8vKB/DrF7kEl4eacrhpjTCjN2mm9WgaNDfKZTzc/sS/9hwm?=
 =?us-ascii?Q?VmzdMC1jkxPjbUuCMc4l41+mVGe4LxPwEKyADjwtM4UbQCsjOSZzkdP51mtJ?=
 =?us-ascii?Q?vlSBJfYMkSfrrwGmNlbJpVDGe8A9oLVAbZS7cYd0A4XyPmW0n6GVCBApjnbh?=
 =?us-ascii?Q?faUTrOqKs1Dp+qAbNvUn2zdfgh+BNX2UYZgmrY37SqFUadXcxaVvBoZPeFS/?=
 =?us-ascii?Q?knCXmMffP9snH4i2NyQbst4GtaVhQue7TH4vL/UWSsZgjtDA+oFdsM2sEn6L?=
 =?us-ascii?Q?05sTm8SO++p/N+cqoFHQxoDxlzMvMybEPhxqrtbh3IkhL7OCCBYey+CpYI5S?=
 =?us-ascii?Q?IEm+tcnPd9PSAXjryjDHQPzZKpN75CdtKbLpWoRR8MUsXzSSDSDFngFAo7c8?=
 =?us-ascii?Q?9Plqc9SpJYznZ6m1lhIo/4+c2alSKdkLUm1bU6TsRSN0fEgZ6OwjnuufUxj4?=
 =?us-ascii?Q?z/r+5Rz6/FHpp+80cC443rWIvh5mbog8TPrLWnuO0A/2lXJzX1Bmhn146PKg?=
 =?us-ascii?Q?MsfFBExoYHPoI0bteOEqEuwY6MbKPNC50zpX0mdR7VbVNtvvHTIRWAPrBhrR?=
 =?us-ascii?Q?Fdj9VIJpx4SKy/shQhx3CNdOUQDyl+mHSi4yqpYpU58FykRFfuTB9aRpVs9S?=
 =?us-ascii?Q?sF+932nO7Pt+ddi1ruPwQ1Xd3WyX09KGb1+pgyjQU2rpabVcW8kwzGNwniu8?=
 =?us-ascii?Q?l7G6uskBiagghG8zhY515tc9k1a/6Y8DZiFVTcqTY/7i9e4ru2fCg9RxOex+?=
 =?us-ascii?Q?U2Uy/Ele8K3TL4zfvLv6XeR+inrd/Vv/ST592ziZfKzf+NKK8VOee7vIzOvU?=
 =?us-ascii?Q?a1dilq/6w7dPW4suLpm/txZeBR7qxh6/F3CDfOrbq+0naM3rA32aBMPJqzr3?=
 =?us-ascii?Q?GOrCgCmKp6PHc4wSIURj3PYVe1e5pR/856jjU4VsEsYBzr3Veq0BXsMSdfT/?=
 =?us-ascii?Q?Fh7IOHDgpZhObwS4NPHE/xK/Nz9iE9FIFHb6YPNz2PWX6DAx/XyTU6sRF8l7?=
 =?us-ascii?Q?H7wDsKt1+rLQ+9b3Hr1orXQ/ZoNtVgWVz1ObPdS4H54YaWdypAejGnuE6e3m?=
 =?us-ascii?Q?8t+OXA960qiboTF4CYqgDukhUk21HLevwUXUrhpNHMyYbczXbe4RZw4z70D1?=
 =?us-ascii?Q?XpNDlDPvMcoP2LMFTphVo0oFbCnNR1og2Dwzb0Aq0JPaMOTJxAi0cRoY9H95?=
 =?us-ascii?Q?3i8B2XMbC1LBB+Xq2KBcA5vyRXv2ET0LCU0nUidKhhf9O1XtRVswt7OQCwlm?=
 =?us-ascii?Q?UTSxdsfkHb2sacVFHR9HljBNMlKiG51Odeh9cUmc8gR3GGeDfqFMxRiPtu55?=
 =?us-ascii?Q?0xWgc44ovxevbcNRaC8GlSPvIwSk6QKmTNILu12d3Dzz6RViI5OiR46wI7EZ?=
 =?us-ascii?Q?TVX1HNNkww=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fd24f0-960b-4ecd-631e-08df3a89ee40
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:40:19.3988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBo5GACVgXk8ZglN/j+4TXygluVp1T9VtI0vjQhxNhzLGXvSio1Uz3eJrtFxUxxA9qLq+Uh4kNp+jIAJUL5w2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOFP123MB303791

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
index 6cdee2dc4193..441d50c9be13 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4226,7 +4226,11 @@ Kernel parameters
 			Note that if CONFIG_MODULE_SIG_FORCE is set, that
 			is always true, so this option does nothing.
 
-	module_blacklist=  [KNL] Do not load or initialize a comma-separated
+	module_blacklist=  [KNL] (deprecated)
+			This parameter has been renamed to module_denylist=.
+			Please use module_denylist= instead.
+
+	module_denylist=  [KNL] Do not load or initialize a comma-separated
 			list of loadable or built-in modules.  Useful for
 			debugging problem modules.
 
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

