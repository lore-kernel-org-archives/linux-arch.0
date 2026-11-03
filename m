Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793742152;
	b=Zztqm0DeCVEgXrk7K3zLiebXNhqquCDCF2HpQ3OMJ0jAqJneL2rFDmbgQGjzL/AKeiYJ
	 HB7WTmWh2OKYf6Ir5XECb2HfddyKs7HtULvg4dzOqT7DvoYHaqNH3nrauOfnB/TJMbFMb
	 dHrR7zE+PzEqmyClZBWM6ptKUlP/czwi40EgKg6tWGUD2gDoZw8DA1yZJYL+/z6AL59kA
	 76IGiJdEhTLj0Wdiz/kwTpGHaElV9t9qnq9uFnMAjiIPOgVhHZRItHpuMmmgfY5Rw25mS
	 fw89rei04dWanmOmLpJK5oTAOadGEcXZI+V7vTruwM9w8qB8LKormaVwNTHP1ZvxASA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742152;
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
	bh=DkM2xNE35ry+VTqW+cDwGhBWIKN7emN3agc4i0H58/g=;
	b=yY5Nxc+LYEYCyAXhuWIyQUN8bhWLIC+UntA27cUmgvXVs751p9kvOpoCzi9kOS2tJqWp
	 JuXOzjaNVCMry+hk2AIjLvOhDu8hiZP1Rlf/RrilGk/yH6II1hs7mhz0jb5iRFJVEUNUX
	 /dDVD8paBsVeK4kphGMVtKAwQtvsZfn5EyhUmjQ2lz2PstDbf9iwgtN+f6c6JI5Zm7jIg
	 1dj4alt+TBXxweD6pY8UygrJYmo/XPPVI8JxsPuU+zRQ9DyumOaBYnVWq8dMEh9OR4/jX
	 qgliF9XgW9RzoaHRcqXfxTY/5YhrKaz5iV+NKGCBVZlePfSmnbwo/oCpSO36LH9uwdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.74
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022074.outbound.protection.outlook.com [52.101.96.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19654606A32D;
	Tue,  3 Nov 2026 21:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19654606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGD80ZsIEGNGmzbYSsB+mdNMonMu5kv9Hjhj6lnRY036XaHFfr8XIywMsFkN6+WYMYSNan/nDrq4xaPOg2cmjCydc+lp+ZGDfEFzDzJX6nkQi7iWLruydw7wz/GxB975V/8Gtqz9E3KUTYi1FvBLjweCk2fyJUPzMYS9kddGS/vvgwEWuSgOg/FWeRFTlgVYqhogojqg2QBqQa6ZpyyI2iO+e3ovviC8EhVnF+e8VCfUOH6fojKmhv/0t9WW6aXf63QYSFw6iboTKtOHNVf60oZ8uZdK7mUy4FxInSduLogqgfzsHQJWGB4Hz4ivMUI0ZMkBQ2vz1+RZ7rjVhnaJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=DkM2xNE35ry+VTqW+cDwGhBWIKN7emN3agc4i0H58/g=;
 b=u2Ymu6oypmm3RmbFuD95k1hXx2hfxqRkC//lfW3XvYGX08WkMBIZLlPFJR6RljlYY0COfiNhc+t4TIVGq/3B6cG3QivRegX5/H5kC+GffIm493vHMwO6veDCIEKKCxjKoDzFdbTNBY/AqoeXK6gBubK/mTLP2I7af6Qt7AvcOQgUiAiBcvi5sn+FOsVsl8efx6zbYi5S000lK7aAdbahzHNH6WpI33ImWImkM1zBHWpZov4e/ZtMNYUZLhRybaK/BnXXA4PhoRR6Gi09PIQ1MEVD4H+6dyRuvR7Y8r5nPC5YX4rKbQ3RuC2ASgrAuhfURHO/SyGqj7Gl/HhXMmrqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO7P123MB015864.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:604::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 21:42:30 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 21:42:30 +0000
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
Subject: [PATCH v12 1/3] module: Treat dashes and underscores interchangeably in module_blacklist
Date: Tue,  3 Nov 2026 16:42:21 -0500
Message-ID: <20261103214223.32598-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103214223.32598-1-atomlin@atomlin.com>
References: <20261103214223.32598-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::28) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 0adba0a0-b20a-4ec6-b1fd-08df39f35cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|56012099006|261021123027099003|261022105027099003|261102123227099003|261021121427099003|261022075727099003|261028144727099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YiHTSLYtO3fPz3FPQ/FAe04DCy2mSQbOsm0ytQVLVyRYTbfUnQE6igjwJBgXaKEDZUQqz+m/jhgMaDWp64SOuASblC6d/qbhYNowbWWPcjKyE5ooDQPIJVkJNZaQWUXsEOUGMdR1qP7IyJ/aq792FH7AUrVOrLD3DDh9EOSxFVsyPsCxTbq6Rta9zI3QrCMm8npgEhsCXOd+GRfq9+HVXz+C4eouYjHNHHiFylr4ZBNzxEIULtl7hL4/ISaqy9DT07mnU4s2UPZNMEkTit4PRbnPrwbRMJJiy+Vyk4c4s42iblDbKqJxcdrZGlJUt5s3KnyBJwU31O7QNWSRFLfOg6O9D1C/EzZOuXy2cqwYrjuzUKNIR2OeBox4TZNMH6jfv5Nubn5UV/vkRHuYN9wbOMRiYdGD0bAH0DLztyGdRO6IpuTj7Er620uPDVXiN5q2aFhQbXfcrbJWDN3K4FqTsu6pcH4B5dG/JM1f9jWRca+maKbrpsofdDOWXiqYqIyyChbzEhT1I+ZFpaFAurq8FSXFlLHlPBKaADdagUTRxSp2NmZWUFFE3sSOl9Z7XZ2wlkuph7QxKCdHcEmJAwE2naRa/Ywa+vTkUbWB6EThspmLfsUNpCBPjp+5smAUsk9S4Ule+cRTQwVUDp63A+12zsd5p9vCu2hLElGlY81gYbk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(56012099006)(261021123027099003)(261022105027099003)(261102123227099003)(261021121427099003)(261022075727099003)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SVwzXSgPos6pOc4IL4M018JU9WjPGU7Tgvqze0Ip2myuJa8PP7Zk/ozbI3tJ?=
 =?us-ascii?Q?PmdS3/ka3Dyz4L5j+GeWmiVuP5cAACNKEAdf6Wv5RINj4aJ7Lj7jtohB3z2k?=
 =?us-ascii?Q?MCuipzUPi6tjQC/aKtQHf2OFxjkXFjyTglM6FbENhIpjzrDxsmUbE1tGCrXX?=
 =?us-ascii?Q?OxR3BDvL6Y7TEba+4bBAIgAUIpylnwu5uWgSTV6hrnHwD0KPV6ocKc9+nJIS?=
 =?us-ascii?Q?QbtRODAkYkJZR0KdzZJhHqharPvN0OME4iFZl1FhbXadU+6/XyjcjxBnhubk?=
 =?us-ascii?Q?CCwhCpFnJSEjDlP0pY9Ub67cKR1vZkXwkAULjIsTFCdSF97N55k8bd5JNUHg?=
 =?us-ascii?Q?I5pTT1WGe5eO0axTlW/Nc6bhP0qr2sw11vpiB5a4DF7vDm27cM8hP2lV/9GT?=
 =?us-ascii?Q?bwCHeqGDHCj4u2xtWUz2sIZKYY8NhzeEuNVJTY8FZS8dBxuGHaSitubrBwsO?=
 =?us-ascii?Q?XbKHBaglWdOyQRTrwMcQHnV/5rtcixzfRC7Htwj7OjUOXbtxDhKnsNpdLhR2?=
 =?us-ascii?Q?UOKDq6YieivM+9LzCJ5CE/r1QS+pi2h3vUrUNW1sfmKsJf6zwzy0x/khoXqL?=
 =?us-ascii?Q?zC1LzD2CczRoZEW8f4wCt8yi6v2Nu5zTrDHFymGw0mYLKE7xQWi+KTpR4VOT?=
 =?us-ascii?Q?Gi6X0zQk3OxGCte+AKNULMmGqZBmKP2yuNJNyp5C3OiGu847YRHKVTU34Zyb?=
 =?us-ascii?Q?seFPRfdkLSXoZsrRw5CpUgHlH3OYjfXyz1AVqSomx8wn3fPYq4GmBkjwFJLz?=
 =?us-ascii?Q?6Fv1Gp98G3K8PkUvqD/VA+g9qJD0lc1piaMK8RAXYkjau4UDKnWnwEWLzqp1?=
 =?us-ascii?Q?eRMw3EQBW5A8eZzWR1Fzbu5zFSGtN0CTD8H/2ta/MK2908em/8aFwW7VESx/?=
 =?us-ascii?Q?AYiGl4U4iVgDWPG0jLf5LB4QnvT+UzZqyzIeity1FrP4KRuFH2wNTdkaXsah?=
 =?us-ascii?Q?CrHz71s4+ZnlqYfnp9SIdHk+HZJE9JCCTKoavZvD+HBdnNepsw0hUxZR4/J8?=
 =?us-ascii?Q?ei+SxJIilZiejdcefTWWar2EqlnFDGBDmoHpv6u+lQumVK4dAJTsh+dOYPF4?=
 =?us-ascii?Q?t9Zm0uIjHRIgthPNjimvo8jlH6V1RH+TY71E25hw/sKTShyf82kvxSeKsTLd?=
 =?us-ascii?Q?1Hax+gRGY1+0ZMnODCsbC3mu2KY+0918EdkcUoy+InpxatpZ/l5Jvwh1fjSJ?=
 =?us-ascii?Q?8ZGSiDv7hdkfg7hVXMjQDSORNIdK65kZLIhndvs8m49WvLZIOWGN0Vz8lz0H?=
 =?us-ascii?Q?wvbI6cHNJLAvuORsjlIqMGzFYv60C2+3D7Pygv6Q2YN4rXZiMEc4JrghGX9f?=
 =?us-ascii?Q?k8r9xoXizPILarcS10p6GcVffb9th0mffFOOTFacYChMe3SASQ1Hlqc6WmY3?=
 =?us-ascii?Q?IRcMivGbkhq4BTtbwIMdxBrP/DTzlqz6qb2oSf4AU99Ty90VeC/CAG3HhxJM?=
 =?us-ascii?Q?7YpZ67Dt29EY58WEq89ZcQI4mofLsWP3OCsAaJ8N43xEjAqjVQf49clWVlKo?=
 =?us-ascii?Q?TigpH8M4lyGZwKc52k2WQSj1mDGTnpmpXAXeu5ZVYU8gKVPS6WwsQZeM7TO1?=
 =?us-ascii?Q?raNs/l6Uuxkyx7k/zliLKSiRJJ2UC7M9iSAxwPSORz5cK7ikJGZKZdSr8Orc?=
 =?us-ascii?Q?j58ykjUJffeydbi5l6w1F0XUFQHUPlEED29L/XQJMVOSYUeq2oTFrULTZAe6?=
 =?us-ascii?Q?vk+xjWyGynuDaRKlv4Q6+ILjH4ebx1lnpjkSa90bppWzdPs6nNkgruxxFQIJ?=
 =?us-ascii?Q?9TNFwS2EJw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0adba0a0-b20a-4ec6-b1fd-08df39f35cc5
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:42:30.6972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: If9fSQFxEVGJccExWuhWW/6R4xsysVDIIxoWFxZnL1eWkBftXgcUAYaBRsMSwcvX1U1XlqYvZIPqYM+SxwmT+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P123MB015864

The "module_blacklist=" command-line parameter allows administrators to
prevent specific modules from loading by specifying a comma-separated
list of module names. The blacklisted() helper checks candidate modules
against this list using a strict byte-for-byte comparison via memcmp().

However, the kernel build system normalises module names to use
underscores (e.g., "my_module"), whereas administrators and user-space
utilities may use hyphens (e.g., "my-module") interchangeably.

Because of the strict memcmp(), specifying a module name with a hyphen
on the kernel command line (e.g., "module_blacklist=my-module") fails
to match the internal module name ("my_module"). Consequently, the
module is loaded despite having been explicitly blacklisted, defeating
the intended administrative mitigation.

Replace memcmp() with parameqn(), which treats dashes and underscores as
equivalent. This ensures that module names match correctly regardless of
whether hyphens or underscores are supplied, matching standard kernel
parameter and modprobe behaviour.

Fixes: be7de5f91fdc ("modules: Add kernel parameter to blacklist modules")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 34e0204ea37c..6b1604018cc9 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2958,7 +2958,7 @@ static bool blacklisted(const char *module_name)
 
 	for (p = module_blacklist; *p; p += len) {
 		len = strcspn(p, ",");
-		if (strlen(module_name) == len && !memcmp(module_name, p, len))
+		if (strlen(module_name) == len && parameqn(module_name, p, len))
 			return true;
 		if (p[len] == ',')
 			len++;
-- 
2.55.0

