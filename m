Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.196.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793983533;
	b=cHHqQkS95dDbeYv+VpLiZKJff8zaX+rmE6vm/71hFmMggvqAG+gsjdTrdAdcJU1AHD+B
	 5OfNLidbvLNhFqbhTICHy+LGB7kfPPzia27PRfNAa3NQepGAzedRhMG3L+cxeqQjIB6xV
	 U9wuBjeSeXSBnOOmOiSPs0bUsstBnAED0p4pq9e0/OpRmyHoBE46LbHa84ag9rnOrSEmC
	 xkqT1vMIxZBAuzO6XxNJWcvCJ8GmLWusoueiVoC1tkBuHxI6Qq7UP2Gv6oMvWC+Fha81X
	 Zw28bgqn/vjwCGnQcCJq8b9aMxmUrQEY+dpdEgdbbeFvAjrRaHAc0X957x2Rux/g8Uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983533;
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
	b=mr1+ZeX1RJS1srIeV/d2/YOK4dqBd6i/zA09KiczTrlN7NsVhLYNSDhpnz/3d6Nfkg0C
	 vQx4SXnFVgJ2TT/3y/CugmgM8xZxdnOXe7RRUIKM7PcTXyGGrHRgEN1krgh9LFGTmy4wN
	 SVk7aBsafEPIzT/ESOF3NISmeZhJbwkLG2gA8N3Ys027ecs9x72TpGBNEu3uZB9vzPuWP
	 4yzPxJHE4k5zTuD2EPb1rm/xjqpJAvGU9YvkhjIc32vCuuqa/0HQBlMRLjaQl0xRto0Kx
	 XLVEPWpaNZI0hz2OA4EPCq/wmJWAP9lasEmUyPmAs1YKrPQGocTnwb0Z9cR4CSrXG0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=fail smtp.remote-ip=52.101.196.141
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020141.outbound.protection.outlook.com [52.101.196.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B064606A331;
	Fri,  6 Nov 2026 16:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B064606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuZk6wwP7KW9UZcitoVW5eyeFhTD3UeN6K6xihtKgI8xc2LTLfzjVhiZhQ9UyAbh/2+avoDzBrFZAJ06yB9iDzRmVsEmlf1ggFcjOMbx5DoRFyj/6xKiv3YSkoX2kKPoJKIJRuli7Ltz9mlBIk7NE2J5fuZZ7xeRksgQ1iA3EbMNo0KAFYXSNTrC6TnTEjogeO2CjeFSLSB6I6XG3rskekvFYte54q+/3lm1Oc3PE6rfSGqHannC/m0C4vVe3Udbw51hwzUY6qbSMQNVZXu614UYluJcGaVsr0xefASd4LwUHTpP5toHsytV2HKGYGqxxSXOKnrdolgf/fwW6vU4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=DkM2xNE35ry+VTqW+cDwGhBWIKN7emN3agc4i0H58/g=;
 b=cLSKTTQv1DbgTkq1sIaZ/lVw+6fykW9JD1uS9cm0j61XaNputPDXB7DUxKI5ZFGVYzDJeHJvdq0j1gmJ3vH+QUqqe63j2vOm4mt4PUTRmGl+EmxnFAyeueoSOCEjly7++8lQAeAnflCHOLv31hd7LgAKQnpBFN1RR4XqI95x6V7EOyJVOp++rkiKyieQ4MDEXqb1UIiSGJ7Pafqme9AX+vFdw8CariDqvfR9+sGOlEWlAzXOmQAFF2AgUvTu1ZLHAeSrVXI+l5UmxohjEnFR/sZTm0HB/geUU00jnm/UQEAVKFkMnjN6oF71BScLN4deN71jv1g2Vq4kpcugTWMFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO0P123MB6202.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 16:45:29 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 16:45:29 +0000
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
Subject: [PATCH v14 1/3] module: Treat dashes and underscores interchangeably in module_blacklist
Date: Fri,  6 Nov 2026 11:45:19 -0500
Message-ID: <20261106164521.116168-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106164521.116168-1-atomlin@atomlin.com>
References: <20261106164521.116168-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0006.namprd22.prod.outlook.com
 (2603:10b6:208:238::11) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: cad37217-1c35-44ee-d7dd-08df3c255dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|261102123227099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PxYtX10SwGlSdMJ/00MRGP7kvDUbv7VHvY5X15TuMgFX/G5BAGdv5/LlRa2yEVf30lPoyjH28xledmRAwXKrb7Wi8NC2phsZXuMqVFf0QeHH3xmaptiG4nJ7d/4XX0rY9J4ZBuZ53RPFMTmRbM4DalbV/O0gBIrTq1zTkhOV2Ccam3FSgQ+rwYIFm3IzCS1elJb10ZdN7AP4hxf+8ds0a28tVkc4ZZgWYhtAHd8G/zDA/SV0Qj4kY6Vf02+Tkw5sKPc85AKzAnzIhmIEj3qn3nX3gniXX1Ix688WDlRXdb9ivaAGAdkPYrWZMLanPrNqBVB5lhOrhob9NdgEv7P/ipQLdZt4f0VhmzRFO3PZE1ImULUz4YlET156LU+C7ndvCgpgVcIp+VHuWHaHAvLFKHxz6pzBmdfNbLKJI7kgw7uA/5WewPM5g20Mcm0Gv/Yz7JUrj354MuVjYZULrRy8kcNcwfGxrWM3yuIzJrOB9/9RffujP4wqqCxBSNAT87DJSocI6Aq6uLAxlaQ8rHNV18bKmTaDW2h2uwSYYsZPvQavs6YMj3AS6XcjrlAeOY5Bii41QUhkZD5cQ5k0q3maVT2La9QkWdoM0dEfxFbZSUlOMgpg8X4mBb8ZS9I27mBfceX5bC4jwwfL/25iHOlTCVTW8197pkKQTBlyECEeIdY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(261102123227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sdjZmSs55cD2YGvD07Yn19qpoNCNnL8bVj5h8ZSLZ7qQJ3slbRfdR+yC1Jq5?=
 =?us-ascii?Q?W6YGgmaAMbs7eBXCRKY2jhTtf77IQSP2VYTiEKBRaNrbrV9+dOMBcPoY3m7L?=
 =?us-ascii?Q?FsgQx9rOlZ4ZSrSgtthme2QWKZI4gNqIQ2rPhyDMBe08peBinBm2D+urgcgl?=
 =?us-ascii?Q?1AR33O2ByESE3qrazGlH3Yast3ChUFgRHPLgv2NZfnnONLOiF7PIchmKgAP7?=
 =?us-ascii?Q?ulo6bJeKMd4OnFX1wid8a0pbv3CNiiRK4znCtr2QnE4ARoTWtcaWUjyUk7/8?=
 =?us-ascii?Q?2fGirdeXcr3jI5DdSg0JvZq0WjhT9ri9GFMWOTnZymfACi88trXP2saK1bzQ?=
 =?us-ascii?Q?ms/nukibumUyOmc3ReL2NHb8hmPutHAkIctUqWerAbkkbMV9vvRtQybOS9m4?=
 =?us-ascii?Q?1msmfX1zQgWC6zIV1bdYXEa5XFlUEvDat2FnOh48YgNfcAe/Vgekhw/Z93pX?=
 =?us-ascii?Q?dh4OaRVJWiBPbZPJHuErXap1CXi7Tp+7kv25r84RuLtmWevihGSDjmtzhuv2?=
 =?us-ascii?Q?wYgd6ToQJw0us0HGWSp1QSI+3T//8uRl0/1yOpIIQckQhC8XEHywZakpL2df?=
 =?us-ascii?Q?93zb8qjwTwfa+JfcpaLfGi/j2WMjg4goGQNUuYHAgYaAIhfI9WNH70WtOmk1?=
 =?us-ascii?Q?jC+Seuf16bz5jmHHqFKf4nQHoWh8FmrJ6uEga+hEqa8xhjUMtYxk5rua302R?=
 =?us-ascii?Q?nJwhLsD5vz2LLwPpKBpFJUvFQNUBrVSTN3t3erBetMqVcihl2eMykUNDa2EW?=
 =?us-ascii?Q?dqv2yhhZ6X0hTwaglROBHmxP3ZNMPVhxSMaZ3dSKlBG34m0W2fjVQ5JZ2iv5?=
 =?us-ascii?Q?TUN1lanTU3CZ+YFBfZOdWjRr9pxfiRjZeLZ1uElZDcIoOdCXSRXf7T595Zol?=
 =?us-ascii?Q?4O/4noxeZ9CL8gvtm3ClBwMNv8fdEJBRtY2ly65KfdQTJSU7f3wZAqNEvFgF?=
 =?us-ascii?Q?3mC0sJvFrOb2Rb2yrx/6hXt6o0zKbrJK7J3vhh8OMX8+VqgtDo40n1tITL+k?=
 =?us-ascii?Q?9f5GTuOZ8ZdO4CWMLpmaQtyBRyQ+ud7pjl2tGI8BqBSd9wQdqSSynVzbqUgd?=
 =?us-ascii?Q?Dozg2j5hMV43j6WiF20Ch8F1mFoxqFG7rSQNfBuBlj6O57iMNOP0irZmivGU?=
 =?us-ascii?Q?X0FYzUFPOkRonjpL6olQRHFhXuTiNuFQ5oik9ioqGLEoOO1diUyZhWVqYBOx?=
 =?us-ascii?Q?T3khJ0IGrnoEIpP1gP9Kbwm/3XZ8iJXDeYj5P+5Lt4a4UgUtuTe5uYFXhiC8?=
 =?us-ascii?Q?g8Jz115+qyjYzh+088aqBpsnvcRXVWuPXq4wY+kNIrezII4yA+Pxhdl/0iTO?=
 =?us-ascii?Q?KrA/dtg4wnKQ9QsSfNuZ4/hn66Q3M18KwuI8KcIe9jPdLcrv+3VNDOCD5XXP?=
 =?us-ascii?Q?rzxdOWZ4V/PsyK01iTk87LfPEgPMSQ+gyUiQCaQuSx7Qd5VnhrSgQ+48Lhqy?=
 =?us-ascii?Q?522326CwlamASDoXVAUsLFgz8XaMWIjzE5dp312KElUHOVq/wYP1l9uLYj19?=
 =?us-ascii?Q?S4rkbd29Zgtgxm7kMUq4zheFegixVlcoEobIQfg7e6Fu8brId8oH4yrN9/f8?=
 =?us-ascii?Q?keDjlOYWpLvTaKbkQsqXHZ3+ojzhrnPt4T/RrQKVqATumDQNZNDd5j7GiW0c?=
 =?us-ascii?Q?ZO5QDUkZYVJUJ02rfAzsoTT0iRX3nA/NBBvd25K80HHKHbFGLar5BadnhsfY?=
 =?us-ascii?Q?39rp70kYWkrv+wuBsMsXvGVJFUr6FOjgGSYHkPsyKQWO/PQlEvKJ+0s34XxY?=
 =?us-ascii?Q?xvla9ZjZJQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad37217-1c35-44ee-d7dd-08df3c255dd5
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 16:45:29.8341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzNI61Ojd3J8e1ipIlpmUkDk7IOMYQgLqlcxfG3Zr3xVUjxv3fLjBwZmRXOZBH8kynvnpd8MEBWodoxvns+N8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6202

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

