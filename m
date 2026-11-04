Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.85
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793806818;
	b=EYUDcdQcYkOn8yqNuL3fHIgF7BJcYE2h/nKQMnozKvA6zHK+sgo21ZufCiuy0n7p9DTp
	 Rxo5+fLeZpEvV88MavkCQF0sx6IpBoG260Nhiszd08ule6wWuE+HET9juGMZTmVoOLZX8
	 WG8cHDcAGw/Kx1KtQPfGA++OaVPbH6aoVg27Qvy5/4EeF+uZuZhE1vEiW8DXbU9P3pbio
	 FaRQZE7txKmCN39ucsIXJt879vFrdORaRlgMzGy7rlSP35GbKD5YNsne7uAlg4lCQCcN8
	 1+L9sF4qUncTOrSyWXtb5ZJciClAFlfdfAmya1GCeuSM/xFZM2WmcjT3UxZT3DgvkvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806818;
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
	b=bdLIGwdyNCQtzztx1NBmVO10nOIFDGT245yhNp0SQMTC6x+HmddsXwy0jTVI/EqiWWEq
	 DVK1/Os32U/8AKRFjipfY8MvxXQYIqfG/SBDYwIsJ1FBC+M3Yh+lp/ue56tfEi7TrU2p0
	 o2VNdNU9EShA0l4lJZiMRuKaFKEov0C2r8nmVjlPg9Fa7cYM6IX5q0yMaUqZuNCER+TXn
	 2Mf7IRK6rzM3yVokoI9Zfcs7+r9YkENZ2PB0+3RYNjuIo9Id+tp2ffzM1keVpYZ3IgaU8
	 zmtq/Q4d/DFQRIN6FUba46V2+of/lMvNS+Gb2CAiNpf+rQVjinUD5FN7c5pccCJHs4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.85
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020085.outbound.protection.outlook.com [52.101.196.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D906606A335;
	Wed,  4 Nov 2026 15:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D906606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGaPz/5U3l1i53hVeoV8GA3n2BMSZRFLdA/TI0vY//HD8cZqx+y8FRp8KP5QG8i2yMNxJYyUcsiJJJkYjCfZVHPJEnNjy6LwMrXA5HRGmxG9VyBwD+QuWJlMnPos1Bb5xq9ZWVjhTXzJijaCFq/f5xgxFxNr5S2b+RjZrCpoA231ZPPQ0+5D9LOXDkF9sTJ4Hl7o6xjPqVuAlUop5FRAeq5NUuYaDcGALRwEU3yOrZ1u7HS2X/v4oAqMFF91dySW/haGVcr/3/RfzEkvKDxHxDwMioyfSCf3a6BtC7GpjgKVZijFWLFXB0eEhcKLAV4CEJ6E03GjuPa8AIMlgyO7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=DkM2xNE35ry+VTqW+cDwGhBWIKN7emN3agc4i0H58/g=;
 b=Su290ZZxVlzqt4GTomuYuKAgSNYs5bjlfEkK8/n8xMgCGJl5a0h+8i+KcD5h2fmISDk2I8z+vfn7T1uH8+tmUogCFLTzjylLZmo+Ei7KQJxv/jGnjsO4V3RS0qCExEYkY4nAiqDd6TgFJGgII3FxCnGi/0+sFVfaP8gyHsgHat4k9yL72BNHDnmEai9OQL5j0VR3Mvfm1SSn/FcydCDeTawp/NbBht2INw5enxGA35GVpCuydwSqtlELrzZDieU0x0ilgq2hjDdkzuZLEYp8Q3GXQ1h25GUPWGVJesSQ6p9RpVQL4Rc1/DPsGSig2+CdwjSCZOTdHfz2Jymeq6Nx0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by CWLP123MB6624.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:182::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 15:40:11 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:40:11 +0000
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
Subject: [PATCH v13 1/3] module: Treat dashes and underscores interchangeably in module_blacklist
Date: Wed,  4 Nov 2026 10:40:01 -0500
Message-ID: <20261104154003.43313-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104154003.43313-1-atomlin@atomlin.com>
References: <20261104154003.43313-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0167.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::23) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|CWLP123MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: c19f54e4-cf42-4e78-120a-08df3a89e9ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|261021123027099003|261021121427099003|261102123227099003|261022075727099003|261022105027099003|261028144727099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EFb81qNzruCxFGHv0JbYsj236A01B82SP86+w9m76dDiMyc9/enDlmIJlLNhl1HbZRZQakidy7r22QkkEJDJOus5wpTGORVCqmSj8OGGymAy7Fuwb2J9T4878jfX/5mvnU7imOPoOIgV7DwPgHOcwy+aN5NlsDXwfe5hfTjhGN90PUfPS1vVhVsAWrVGTUHrKpekyjvUPgrEC+CzrQoHrqKOpOQ3WtVemShilH3XDK2yL8IyrEZN1SZ9ARgkQCSAR8VEy7Le3nfzp2En7O1roQyYKrO70epTwkeS3gtxqm6TnZ+49dprofVdBn2Qkmw4jZoZlIP99SpM1z75B/1aZz9IlaliKwROMRmUst4aeIdv0AyiFXB1R5BZAa1wMZnsvws3iJDBpoJG1aP8kjLYO1p45jrkRcdKcIXAcDCsu93TdE63u5t6PpERehOQABjW2UAuQ4RWCgKKWWHxU099tgP73kJSHmzym69LKaXaZzZMa7EiAxXBp1CGDRTa+31dFAn4qayeP4+8Mna1fVOpyF7Zf1QUuXsESX8scJIj+GrXQ+xonSCDSaFnEJN8ip1mrmuUqhIlULicT/3o3/11TRtBGNlxtKp01Q6cd55b2GjAJ74t6mBin/SBnhdT8cc2oQGNr4X2oXCruzIyU441JMpmNlp2AL5eKu2L+yrsWAI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TT8Uni03nBGSM1ORxhyY2c0t0WXVGONPep1HzwR4SbArA6ekuN1qOtodPEt+?=
 =?us-ascii?Q?YvaVOEygUNI5Q3GhazcQazwSOm+lv0MxdGTyVP9qubAvoO+hG+wSX1DzzzBw?=
 =?us-ascii?Q?BsulkhwvSrpiUtl9yhE26F4X6QXIiHvZqy3UKKODxTL061VIvGaQjczBQu38?=
 =?us-ascii?Q?T5Pq2QlLfHbsrH8AlUefFQtOMZfHBB+qu5gFcvdrWV2y9T2nrH7VPZorQSSf?=
 =?us-ascii?Q?YTPY7VQFyZPx4IYc8JvfDsJ4aVVTjhiJBX+ttIsEW0T/VRBqQle76GkXsPL5?=
 =?us-ascii?Q?jocb4OkhsPZ24VLyW/l8iKAk3+QFr5SbTU5DUtMN5P20QuUf9ZQn2RZC96TX?=
 =?us-ascii?Q?BfDoTpkZ6C0ljzsLk7JppZ6GbFrr11oPVNFQZc7dFnpXinffvwyuEeAP3UvL?=
 =?us-ascii?Q?EfW3oeE7qeZBPPmVkUYY5crfhqgyNtDYyaI4XjLDz0IWTScaoB/hRJ0dpQ5P?=
 =?us-ascii?Q?W4S9efdD+kTzNT9BJ8Vd4UpK8HEz0DegpYT5nk7ruyvEwm6Zca/19dwHHXLz?=
 =?us-ascii?Q?TQMcKVonTLMxNtOqE5NjZ6rowcuLI5+/HpmYg14dT8BJRBZNT4GEpobkKa6Y?=
 =?us-ascii?Q?N5hFnZMUVKz0HtoA3ZKKKRfzndYH3h5UNs8ogh0Z0ZQE74dtzOcZzXRzbJJz?=
 =?us-ascii?Q?TimjtTzaSiYepiXIVWLlLW08iFiaRnQiQUZ2O//gUwNMvu+E0Jdvr38APQUR?=
 =?us-ascii?Q?lEey7WVXrg6O7quaDUpDzM5+7wDd+Z49qgdtpwUGQJeBNpF0HbyGFxtqlCNW?=
 =?us-ascii?Q?9Y7YwI9JzKn5TifDFvcVOIlG+xgaBHYmRYl/uj4C7lM7Aj738c2HkIjKBntE?=
 =?us-ascii?Q?h+V9noVWp1VGwHIhOMkrUlrDVOnRdkTrLWwRa5ey4fHfsd+rd226CVot39cQ?=
 =?us-ascii?Q?huR+Ls3H5MRTLtCkcpmREVEW8ltS7RKH8n8q/skqoEdQpb6U/bN7TkNS/54s?=
 =?us-ascii?Q?pMrwYqvC538109/7mkagG5f9PEc8oFBZDjd+mhS9OxJTkyV8eEu1sJ7GAYku?=
 =?us-ascii?Q?2MeR50bJy6UYewwyb4UrUrbjpxAHkeQ9v1su3LQEgG4M1pKSnN5yvg5xeKbt?=
 =?us-ascii?Q?2qnedI59QNaHJ77s2lxKEeIOokrN5syBdTvA/ViK8iQA5IX0L6PsyfP+TS3M?=
 =?us-ascii?Q?m9X+B+ZNClCvtFbmA68dcjsb8Gv3gUQxYqSHxVuFjbuCy45+VW4PZAVdC8eD?=
 =?us-ascii?Q?RQRwWdvQDAeHAKCBDikmD1E92sO5dz2exbikhi/+mY97hMgW9KZJW8/8a7eF?=
 =?us-ascii?Q?TRs2uSyiq1sHM/iaIWAP/J2i3HNTm4knQCqXUAm7UZZDEAe//lBGo7Ko1So/?=
 =?us-ascii?Q?yn/FyL7ZR4oWHlv6MKrU8TD2l3XyxJTEgk1tQvF07SDOueQIpVEQsnBgYQhj?=
 =?us-ascii?Q?/W3iq93IEj3snegB581ouSHsA4utXyT4i8LBMkpU+oyzdfjfkjWENPBKbjuQ?=
 =?us-ascii?Q?9Pf30DiZ+/f8kQWBU/zhv0Th2/yoYQbJ9Jb6TV2CU1vEFKR8fO7CQp2B3iqk?=
 =?us-ascii?Q?gUJ0I1AgNk4vLYjuUAHPPESK0nQ1Y1+ePTx1TI8Fm4fmWjK2WScw8dn0ym7K?=
 =?us-ascii?Q?LRiOy+nR8U+5Pk2+8GLRUgrsO02MBzzXm/lcdBTOsa8DnOjC7JYLjm0N8xbv?=
 =?us-ascii?Q?0Bkk9K4rr3zDFc+a/djTX8C/gzIwyPYrLHfoQpD8Z4fr0UIdkfeMm4mWZZu+?=
 =?us-ascii?Q?3FOstwvpOvGMX+sFXRF45KjtBkzb3VRxI4PAYI+TtFdHloVLOemW1HapNpvs?=
 =?us-ascii?Q?+/8sFJHvJg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19f54e4-cf42-4e78-120a-08df3a89e9ac
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:40:11.7628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUoHo8oEPLovaLklunrzqhEhbw1t3Hp1/nff/dUEV7hXAbymodpGk2aFnxRsJXSZMFDO8YfOAK74KRKcSlh56A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6624

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

