Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793983541;
	b=AiRjxfFCNvgeKp2TVtVFQmOel+6wpyH/fh073LU2unvkpsKhZDQscaVDnz2kTXvFWAJC
	 MUiFhKFqsZ8eZcGoiRjNtUKN9zzwt9Kwg0P6K5j5Lc9Ev9tY0GxDCdZqYaZFEOlrhElLC
	 PaNyike79FUNqWNp3ckYOnBT7sDlHXXYj6XZTBHb1rnCrVL8ObsmDrPltylsK5O3P6Pb1
	 vn+I1B2laOwOX98jp2zH/WU3M4B8qLlzT7ReFfeF5cJgYTT1jR5AIiaOliq9hYiFvpTG6
	 PUym/IvW7bq5CEAmMWWjLUcYNRJCJ1UGIREAEAmLlJCzpiO4SSuCeEC6SYxYRmibmZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983541;
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
	b=D6RAlasVmeKDyWs2q/MAxhAQasm5mRl+CpGy1zd8E8tfUqnhMfxMxkvvW9tMz09DD7rG
	 +JxCZ2vCjUk0wbG6xqusaNxM3vW5wcTU+vBuFVEKPnxtvSr2JJXGQMMskOrSG+WXmlswy
	 nYEobnYFIl9q+bClJcIhNPsPZvPj4y15It98yKGIyG4GG+IFX1HAwgrw2F6hI4ZeiZNHV
	 OWrs6J4HcNdue+zP58NlxOt3Looft9Mn63KeG95zhS/1XfYssOuCzVhXRmQRvscgkl6ab
	 JM5upB/JcwJMUzPcyZdk4J92nR8e8iBDChRJ553zTHVACpP5/DwHhbf0gnW6Z0e/qyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.141
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020141.outbound.protection.outlook.com [52.101.196.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BED606A32C;
	Fri,  6 Nov 2026 16:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0BED606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBlClP18mgBq0hWQIvWEe2Lody+BXvRnWUo59UE7cuFEbVK6ENpwUGBRpMW8riVas1mH4n7T6FnPsYw2u9RPgYiD2Rgp36oXLhbLoZxyt3EST6oN1muY4NYpwGUyjDPXq4YfPDExyxQw+ESo9l3/rnbZftFt38v03TLhFvo/KZRGeys4W1jX70Ljd4ABsMlkKRDUYu/8qtTq2atuPYiQeFomcK217KkvVY1mVQPhszkf7D49cMKoMB4AfNiQdcd2+NdysgDF1k37C+7/nI/xfdwGIYRCqricGp2XsznTpNLtWYRlP3o126c48jZy7c55JehI074sXVaU/WYCP8gmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=KO8hVHOg9q6lIBg4rQ32Kg5HWBxJeGKIG8BQZ5IBLmE=;
 b=ElSAErt9UHJNMnnl8HqxLy29xAywB4RwQSq1S/JlsDxnny0zQTBmPN10GZu7qAOc4OTUKi6TMPno84dHHB4rjtVLTFvmoDhDJe4WRAB+gX3XbLTHFc3roWXIZtWH52s5OL0BC2yM4lJWCWfTn0zk1tQHeDSiaXyJsX4YGnNbfnEDI8twAkLWHemToC2W2SVIKQx48rlhBf32Lzf4Q66ZCZLdFz5bjYbjAr6nrETiUiggjqT+x/SujeLGiASc9fRcgLId5xS+kw3eVFjCaNrfyVJHiZgV9ohI025R4CTCEMZLLY33KgyjkuAFHK8SxK+mdApQyxBEh9ZmkYpTF77+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO0P123MB6202.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 16:45:37 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 16:45:37 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: jpoimboe@kernel.org,
	arnd@arndb.de,
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
Subject: [PATCH v14 3/3] module: Rename module_blacklist to module_denylist
Date: Fri,  6 Nov 2026 11:45:21 -0500
Message-ID: <20261106164521.116168-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106164521.116168-1-atomlin@atomlin.com>
References: <20261106164521.116168-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0027.namprd22.prod.outlook.com
 (2603:10b6:208:238::32) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LO0P123MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: d0055060-45e5-4155-a5eb-08df3c256226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|261009221227099003|261102123227099003|261009223027099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|5023799004|56012099006|3023799007|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	w9wvAv7sL3vA/f3gLYOYY5AZbfCC7MOGdoYP43ohI9KqQRfin2zjiatwyrjgolYlXTWfP0NADJ4bYfl81NAM63XQUUbtaIBJQBPWfEdzmsCYEwhfJ3s0/m0x/1WFpmKfOiqwg1DQvY1ES/uPMWIq8DLoapTj95qUjsgNeuhXlpSRdLJ6zENuNXJVQ2ry+jBVlxgWm/QQ2Nr5FUvw/HN7KvHa5hl9V5T7TauiF+xOyQykUVaREMUHOsbV1CyQVjPnlTn8qyHBomMLJYYRFk+M6ubeg4oO3V4lDyXfi+rq9aIudy1X9/Qinz2JFF3xsYSH2vGFxxJ4WWWhtcdW4POUcg1cP75MQ6i+8EvMdXK72/0NI+MItkiCNerai5q8POxktIebvdgeAXNXWtBhFGm3dzi0Za5yldmESBkLyBliMMXhKIfQNMSi2WwW7k/fw7+rHy/5QMI6ePtOp+aXf76M8ku2jJitO4iaGyD9Hc4et+GeBPKx+o8tzupsdIlXU37TbcUptYpMvCAHNR+Fb1UHJk+l42Hf0tszNmznhK7lcA+hZ+WxXCI36KL+jYo/5SAcmOloJru1KN1j49ul+3Qu5m/BzLJznExohG4Kr38bVttR9ZmnJ3QitrOzLdvPB+JwiJaQgjijRnjfVrZEnxqbo9g1W/RlKSC0TnxjTsJ0w4g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(261009221227099003)(261102123227099003)(261009223027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(5023799004)(56012099006)(3023799007)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jw+IwjaEs+UfdPVH26kqyDjYMRUtG3aEzC53AhqiODKpp6VSptLuXUpEgqwi?=
 =?us-ascii?Q?shWXdWgkbvrAD9VvwnGz7nlCp2717593xwlox7hsYef4aAxZC0RjuvftmD6i?=
 =?us-ascii?Q?64yF1dxTu1SckPrUckhYZQTLqCZluFEJsuVxn0UJxajQJQGbd8IAB+2oBahf?=
 =?us-ascii?Q?vyo6Tiwknj8S7SIjQtaK8GwKykPM2EuC0yw9PHElFncaoNC4/Z3q2xApyhw1?=
 =?us-ascii?Q?XOcSc9tvLqLSc4mKoU7GJO7ZNFSIlntWsHke8shm4qaTlllZljrBoVzAoYqk?=
 =?us-ascii?Q?upv4AYZA44108pR8w3ubCirRQADzvnMXlTinQ18OoUIq2Xg1B5mJxh69ljoC?=
 =?us-ascii?Q?Uww97sEiB6jXP4XJJlzJoU2qYQ9/JxBFcGwWByvNRuani3S64gP/6PlD8CJ6?=
 =?us-ascii?Q?u8urSypGmXiXURsQjJ/AiE5dCpH7IjQXceCVtysvUJpaHG164IhdHmJv4XEm?=
 =?us-ascii?Q?04PG9wHxLRj6K3J7sR1szu/Shf0Suc9b2IFcr+p3G5qWN7Qqkjy7Obr4FTVM?=
 =?us-ascii?Q?h1kne95M8UHtoXPciKnwbKbVNxAGeW3UT1Bi5O/LBn71qVfurvXHQXPrmv2f?=
 =?us-ascii?Q?Uaw/JYJ7YsoyA1ylLMDh5nInfRSJ45mr/XtSttu0K6CFVI4Vk2K9aq451zaK?=
 =?us-ascii?Q?VzqM89dWrRAhkOk2wLtyebGuLOg19vJrjyrUeA3Wqkzv4tEkV0qKsS6DDLni?=
 =?us-ascii?Q?nZuQtuuISp4kK0Cd8nKAPLOk3POVen72uu7ScsIv7+UonHsqUH2UXomxFprP?=
 =?us-ascii?Q?Hf/dRthDEmyJkF10dLp0I06xO1JBZ7599Nr2Raz+RbK5u3ZGlGnyu/C+xtkB?=
 =?us-ascii?Q?bHDedxoXgxbVB7av79Bm7P/wTMKkdKpDvDiI4Lq/+EnTaleCrg75trIsnEUZ?=
 =?us-ascii?Q?nn32ccdpQXsr5z4ystt3ii2L56GoRY/W8sexFdgO3ptTkkjvTviOLKcNYP4B?=
 =?us-ascii?Q?pCxxE9D6LDDkFIdNzcZ5U3wtxZ/2RbEjV1b5ov+fcGI+0IC15mts1etM0Q0R?=
 =?us-ascii?Q?X9+krjjPJX/YHU6mdqYsrOmVOUC+vdIxgXhNE6GJZXXAbA38Qdyc/ycQBeM2?=
 =?us-ascii?Q?MAEejK0XumvHp8QwYigugsv/NV/T+qraCrubtPgnkemw05HPH+A4RAqYYurB?=
 =?us-ascii?Q?0gYbmtx5JR/VG3aoy6N3hnBkC/3y0YV7IHquhvUfjkfy+D8+mJVla/r9ML8T?=
 =?us-ascii?Q?j5qqbB3wH6HWk4di9PPucae8cv6eGs8o+9hbj/f8J0hlHOJ0kTZR5eojg25+?=
 =?us-ascii?Q?GZnVSljVD7XwUVRsT6Xh4GCN7TsL/YNRGgC8ri1zn+vUsbJmqBJuOiyLmOj/?=
 =?us-ascii?Q?pYgGwtbb8Djt4nFBm8m6DzvIA9xU9K1RqGdB539dRxP+1MEN31KRFRDel/rB?=
 =?us-ascii?Q?prycVHFPndU96UBh8Z33EAW/LGMHl2dYkRlkUzyHwnZ8pnv17UhTIrY7dt2M?=
 =?us-ascii?Q?6NVSfMQL52QajH+VAyQA4bjSBMivUHClAc/uHdLpYIR3x0Nar9JRedrmdZXd?=
 =?us-ascii?Q?4kYWxH/CpC4zkEXWLXM6aBwMPquUnNuyn5PXTqMuRa7GTvBqgjh6w9/qZLwL?=
 =?us-ascii?Q?wpaul5qg1jrtP5TeMKXiwuKe5INdFtdUmBIwgakdnh0ll510BTwhv/aIDN38?=
 =?us-ascii?Q?GiEQpMRjNTCaiVMVmvGeKfA71LP6KyJZfGEzwogrIPB9Onb3zjyyqPpJeKYt?=
 =?us-ascii?Q?TKZfuLItbBnwA/s4SxB1jPaZ3R/QyZ11nx6q71H3kRIauK0gL7gfNh59GCQU?=
 =?us-ascii?Q?pB6pFNioIg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0055060-45e5-4155-a5eb-08df3c256226
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:45:36.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdglgPEkOk3WHTdJ9oteyfEVREMNNJjf/VQh2AZsAk4A89y90PVPRsX5z7PYoHILxyyC1fdcEHo4e36jX8sV0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6202

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

