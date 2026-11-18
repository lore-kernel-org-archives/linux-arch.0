Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.72.47
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795038565;
	b=sXrYlVH87J40y4vM8mASSKBIb4bRmWe9O4k6HPS8bbsi5BO17j9HwZTtR4/hu2+87TmQ
	 HWjAEyGWlL59t0mZzZob5tofEYgUGfjFBMb566g+VKqsr9373Dl5lGEjvifO41NVE3z5Q
	 2cxqJBOrKyw+9Fl2UTqcraBIlHlaf5T4xRL95rzyi1ouQE/AFtAIMPmpovyh1CV1GAlKi
	 0FJcPx8kursYSlracUKUJxZtAc55C7RXb6GyMOGkWXBVs/L0OMlRnLpoN3xV5j7LynLRl
	 MXFFmzZQ6SPXF4hCzownKBoIB46uVfdct5zUJBjhyhBezDClxKqbkQhtEMCPAqCiE0A==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038565;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:Cc:Subject:To:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Fv3VJjpEWYvS7/LP0rPxB9tRVxo1/qO/1eP1hB2c8ng=;
	b=t5GS09m4mnn9i1X7NnpmaWCGTHnorFoS/XncE0aFZR3p0ryilSra8YvKhBKazbsJOUnS
	 2kzq+keEvNY7pGoD+6qhpVS8L67YlFFzpysgI+Xv6nQ4KvYGbqBi+HywtshshoTmtU7Mn
	 VezEn1T0rkuEBSq1/NWA6D91i86DugVNSMao3nwadnsAn3/SxdB9DZsjFtJweWvAGcyEq
	 JtaSQB3nub1HuxiPVI2zwpxCqVyQe3MtwxWb0EoISSC2A4U7VrXZisqkQTjciYai6AQwX
	 Zs7cVinK/KRmBJG1a0tuvGyms3iB6WrHmRkOUfHfFYxJCSotmGIOvU9uC4YJBWUrqbA==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=JLib3Knl;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=JLib3Knl;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.72.47
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013047.outbound.protection.outlook.com [52.101.72.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA166606A31C;
	Wed, 18 Nov 2026 21:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA166606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=JLib3Knl;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=JLib3Knl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=R+FBNCGC62bBP6QKjPGlOEk9mU8VgI8Ckh9XdcX1+b1h+jpiPaWTXVqG5ZBwHwWu7XLUKummkG4NBzj90x41QwHuucWmoFV+fRHn+e1qHCz5g2+uvf47aJpW6150aD+o2NLm6qwBbSmsVLpkWmnnhaOdZEK/P+79haMDLT0Y/ew13mzetTliePKNMfFDfzCCpL4gUaIwLVnrrI7UOnKORymgfus0SiCGboqTJ9k+xhfBcVqY1KRPXkz5dIRcV+8Cq2SZgYMApNaAf9/918fRL0hb1XWkcdwQ2E/OQrOitGN7EJNhuTV41Z0DRsCDivBaF0NWtuW2uML9/9HFFlAdUQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fv3VJjpEWYvS7/LP0rPxB9tRVxo1/qO/1eP1hB2c8ng=;
 b=qH/EpjNcWBxKKR+yEajTgaIp75QR0c3PgfHcPFsViQUc966Kl+Z95gv7Xv9m4nm3Ma8kXYElHfNqRhfhGSaoJwo1yfXT3VuTEqxPCHOMnVZ/klzkIOnyZEwvJhHw42ai6/IppTF8Eq01Wh+vMjimNgQou470lQmfiC3hxqqFuG0VBuOuRv+oCioaXqTmXXWBrre5GuuLCUD9mslfSo3gD3o6nlRAYFdanqIc+iTw9Y2Shy7RxWjb//RwV73GP4WdVgbun6JAphrb2qRGS5BEbODhQwSOV/Wwsrbqta7zAztnKxbtGvZizR9ELkoT2JwsECra+c2Tw6J3ZLd+risw+A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv3VJjpEWYvS7/LP0rPxB9tRVxo1/qO/1eP1hB2c8ng=;
 b=JLib3KnlPZn1VqS0elIkRGylf78JMUdTQYNuC5qrcnY805Fp/UODt1vdqX8+REcO1ztkuwNpdgMyrG6/izvJLDBuHBBcClbSAO9d5KuN0PMUqBmhl4VnnotkB8w00qhYzRqPGNYfM5oinkvY3LswPZDsZR532eyBzz22CYztcrg=
Received: from DU2P250CA0028.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::33)
 by AS2PR08MB10156.eurprd08.prod.outlook.com (2603:10a6:20b:64e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 21:49:20 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:10:231:cafe::11) by DU2P250CA0028.outlook.office365.com
 (2603:10a6:10:231::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 21:49:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F8.mail.protection.outlook.com (10.167.242.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Wed, 18 Nov 2026 21:49:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2u19dPfOrn9LA+bPT+OloTtq+BBKpXoqkLubqtGY1z68I3GdE1D7X69uS4iO7wVjLiN6MzoAPbHqYpXZyqUhnQCoNsKERJiDrTozvYHxgboBFUaNbdO0oa7Z0ZmY/M6dOnvAZf0lAMp0/HxvOF3UhrLgIbCZ//Q+S9FH+o4Ao/uCCwlDe/jku30oKnaivoG4eUKFs7QYApBSS0Xie08B7AD8S0P/V1QfYhz+ZaMHuwNK5uP96kbZvoOmY+FUvbHIeq/OqRr6zFevc/N0GXv0jrK//X60yQsxZcl+JMwMr0/IdzvneiRt6QMjp6DJ1+pzH4Ml1Qx4y1GX753j4v3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fv3VJjpEWYvS7/LP0rPxB9tRVxo1/qO/1eP1hB2c8ng=;
 b=UsQwJ/vmiyoTgdHZO7Nvs5iMhuBjkE4JNa7/QlOeys+1JoZRQu2Kpb3pwKbioexAM6Suj7jRe+hFxgJfGn8E4Oyp5HriOTkx4bkA0EiE2/NRo2zwcNx/UNLi1Xv/5wlUDPwQQGIlFh3MmrUblKG0Shge9LwR6sUt9i+n1J5kDEou4zd1y5e5HIrWqnDhxpSGhvtlu/4kwN/YB9XoZqA4UEy7Kl0Iv5FeTRpIvE0Zf93J+LpuYqDm/Ho7N2Bx2WpIX7NFCDPcrl0rzFmIb1Ip4g4BR62+1FKn7Cp8yfNB0CZXCSUTz3NwUf/Ms5S825/9Dzbw66qEHFDEsZTLn3Ambg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv3VJjpEWYvS7/LP0rPxB9tRVxo1/qO/1eP1hB2c8ng=;
 b=JLib3KnlPZn1VqS0elIkRGylf78JMUdTQYNuC5qrcnY805Fp/UODt1vdqX8+REcO1ztkuwNpdgMyrG6/izvJLDBuHBBcClbSAO9d5KuN0PMUqBmhl4VnnotkB8w00qhYzRqPGNYfM5oinkvY3LswPZDsZR532eyBzz22CYztcrg=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV2PR08MB9229.eurprd08.prod.outlook.com (2603:10a6:150:d5::21)
 by DB9PR08MB9828.eurprd08.prod.outlook.com (2603:10a6:10:45f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 21:48:46 +0000
Received: from GV2PR08MB9229.eurprd08.prod.outlook.com
 ([fe80::4dea:4c1:9d33:db7f]) by GV2PR08MB9229.eurprd08.prod.outlook.com
 ([fe80::4dea:4c1:9d33:db7f%7]) with mapi id 15.21.0615.009; Wed, 18 Nov 2026
 21:48:46 +0000
Message-ID: <2a84fa4f-655d-4c4d-b6ad-b2ee9d37d972@arm.com>
Date: Wed, 18 Nov 2026 21:48:45 +0000
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Zi Yan <ziy@nvidia.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Samuel Holland <samuel.holland@sifive.com>, Peter Xu <peterx@redhat.com>,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] mm: distinguish HW PTE pointers from SW PTE value
 pointers
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <avtAQCkvRr1xkxMF@arm.com> <5a6f351e-0a68-4bbf-a9fc-5bb39d8439a4@kernel.org>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <5a6f351e-0a68-4bbf-a9fc-5bb39d8439a4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0368.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::13) To GV2PR08MB9229.eurprd08.prod.outlook.com
 (2603:10a6:150:d5::21)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV2PR08MB9229:EE_|DB9PR08MB9828:EE_|DB1PEPF000509F8:EE_|AS2PR08MB10156:EE_
X-MS-Office365-Filtering-Correlation-Id: e49d3fbf-58b3-487c-b17d-08df45bdccb6
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|22082099003|18002099003|6133799003|3023799007|261028144727099003|56012099006|4143699003|11063799006|261026140227099003|261102123227099003|261026121527099003|261021135927099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original:
 E/y3NBWXwZW5kX8KKqp07dhXrq33EFukUT2JqQQblEhxVX4a90MV5/qbddmuiwXFWBsR9ecPG/LYYd1dC9eiTj8NC75RoBU6prAe+FY5m9wNjhkaATYEeUfU7t2bhs2y5P2wG4U/f7Ga8X9QYncd1PZ91P/MITBD6xSMdd6f6o6HgeY9N58CUn8JG8pjVlxEb6h+L+q4PQ2WiWDlWE6ZiYru2dgoQq1jMO3WG4C9zzUDoVIxA3rIBG5KH4ujdlx4c0ZPbMpENpP657FuiBHRnLwOkEOvv7EwHy+qqe/YhKCM5Eo4enDBpaorzMVk3r2kOefJ4k2VL/znoq4KuuX++NUptVodxBLlTrRA9hjDYygtOZimJ4bVaqNTk74+AokLqBTGqHeEFpXZQRgC1nhTNbiCdmYhO3pECP6zFaWevjbqMh+yh2wXma5mRHqEHnxRXclQlht7jZ/2wvS9uCxz40yrmkmj8hcuAZXAo/1mnfiGgBiMSYQhYXPEim535bH9NJX/RvshKjOvh9aoeleTQzYx6lYEPJtBnDp26Xv/mhhf79nxJSn3zpffgAWffDn219gJr0E8+mZucBGL2aq96cC71VUUHb8E5B05QVI4UKpYeFXzaZncadHRgyqxSF5D36kMY2s7t7I+S4Vvn3sWucu2U1wRwqs7M6CYWK9Wn8c=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB9229.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(6133799003)(3023799007)(261028144727099003)(56012099006)(4143699003)(11063799006)(261026140227099003)(261102123227099003)(261026121527099003)(261021135927099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 zUftiiIUt6TqgahAzA952imQ2i9aF59Iw57pXlwMtRBJrKTR3zOFUkHFlGn4ueXmdybDVM9IiyP1m/v86P8HNm739pe4yICDqrf7G0wnVEuxlfZ/EZ2O1J4UjkL08eaeeixnffoEoQSHiUj+c4qih7hufbVqcozurUOXifkthv9neR0U7ogcPcM0c7ABPQLk4I6yTh+L2LRNGVKhfghqWZcb1OpSyzFdTcWoDuDU3STJeSH17nS8aaV2KKFNEA/YjVetAkUckRekhEeKObxvDBoqKLEkhv12vbTxukmE49ONyiPMhBdlp2kiNFSaiBWxK4ZyT70rbpXRQmTTWVIsSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9828
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8a651e6d-5b94-4d72-d4c8-08df45bdb8ff
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|14060799003|36860700016|376014|35042699022|7416014|22082099003|18002099003|6133799003|261009223027099003|3023799007|4143699003|261022075727099003|11063799006|56012099006|261102123227099003|10067099003|261021135927099003|261022105027099003|261021121427099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	2hV7WztJQVWh+mBG5+JfK6fR9vbo4i62lOggvBoxwY6nOuwJcWqKfq9W9+EAh3MXOqZYlrh6XiNawnytaJZJR4ji+/tp4HdA4Yq0YZJwqX9moKQMBeAqVK0LdpnGABSIJllrKDd74gDVA1deUFUR0X8PD40n6t1kiAVUYYSCiQ7tjgC0qS9d6AJkQIEfQkJJCg8IBPLJH4k66PlwhRKOhziqucXrytn5qzfDyMiFRfZwhD4d5f7N5sLukSSI9cUcJV+wdro5nqxgh5ob30+WtrwQ8AQ/kaByvpqA3gzHgxZDT7pvzAdW6/uV9cUfBX/0e1GZV4eBNyFUZMwk/3padY+lO8uSOawuYr2kt4FYoYz/7MN/4+xZA8YD4TSQW2LWkX6siofY2wMZbMgQYcqkIsnyvpsaM5/OReEol330atKz4V6hx9vjsqvqxamSHvEpTV8wnkNODVbxZwMRviM/PXhsG+hyYSt7nIYWOS6n6TcwYf6h6EQb+TtFyBEgtfLq8eynHGVo/AXz9Tk65vM/oo7Fv+BHCwOiY/rd/XyR7PH2AaBhZ2gZqIzKkc3fLArTciVvU0hjkycUZzeCd+UBQ1BnEE4pBpFWL67ig6bUif+UtXxZHVTNGMjQpQqjVIou3ftV81pQQGyGsa01qf75XlGeybbZ6pCi4Hnpx7S+EWniRxChQlxb3XicfOyMiaOfmjurJKKnMnQYsee0freIFg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(14060799003)(36860700016)(376014)(35042699022)(7416014)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(4143699003)(261022075727099003)(11063799006)(56012099006)(261102123227099003)(10067099003)(261021135927099003)(261022105027099003)(261021121427099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o4QX4L3hCZKPxRoKcgmfPKytdMhBuDRUTuMKs3aTQttd6+tg53+NzuZiRoemL3grqLUMtGw/ZAwZfSn3SNItx/ijA+Gguf2V7Xh8oSyOZ9FtN0/Y+y2xqkhFdovJ6+U2gWJuYH9/0HclpTiorxIZ/qbUBYJoww2JojCRCdkh+ipPqpbH15E8XFiAdZ516qbgzNjUyZn/Fc7MWNvwTrlWXrUIWZTzFiAzDinafOAhvA/CJIXllaUiCiJ2kGum0vbuJteFkxonaof5D7kTnEYn66wcpOkEvsWUwmkFgWEAk7dubvx1QeEPbz+PAJJxa2mDJE5IxMHB+Mp4awe7rj9w8TYWSezwChK4D1fsulnEgH5J9KblGTi8xH9YonaSD3u5yIxaPDpDGBWcAD8gcQE/t+xDhDSxntyP7GGrbjQgAFlK1b0O2Xhk17+825uUQhdy
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 21:49:19.4303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e49d3fbf-58b3-487c-b17d-08df45bdccb6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10156

On 16/11/2026 6:18 pm, David Hildenbrand (Arm) wrote:
> On 11/16/26 18:41, Catalin Marinas wrote:
>> Hi Usama,
>>
> Hi,
> 
> David here :)
> 
>> (trimmed the Cc list, some lists reject it as too many recipients)
>>
>> On Tue, Sep 22, 2026 at 06:12:28PM +0100, Muhammad Usama Anjum wrote:
>>> pte_t currently describes both a software PTE value and an element stored
>>> in a PTE table. Consequently, pte_t * can point either to a software PTE
>>> value, often a stack copy, or to a PTE-table slot. The compiler cannot
>>> distinguish these cases. A value pointer can therefore be passed to an
>>> interface that expects table storage, while table storage can be read by
>>> direct dereference instead of the architecture accessor.
>>>
>>> This series begins a staged conversion at the PTE level. It introduces
>>> hw_pte_t as the element type for PTE-table storage and converts generic
>>> MM to use hw_pte_t *. Software PTE values remain pte_t. Interfaces that
>>> intentionally return a value through pte_t *, such as install_pte,
>>> remain value interfaces; the relevant parameters are named ptentp to
>>> make that distinction explicit.
>>
>> [...]
>>
>>> PMD, PUD, P4D and PGD storage are deliberately out of scope. They can be
>>> converted in later series after the PTE boundary is agreed, avoiding the
>>> PMD-specific cases that made an all-level conversion difficult to
>>> review.
>>
>> I looked at this (and the arm64 counterpart) and I'm not fully convinced
>> it's worth the effort (but I won't oppose it if the mm folk decide to go
>> this route).
> 
> I think this is the right thing to do to get type safety.
> 
>>
>> First, I'd like to see all such on-stack p*d pointers addressed as a
>> prerequisite (e.g. fix pmd_populate() in __split_huge_zero_page_pmd()).
>> If for some reason we deem pmd not fixable, I don't like half (or
>> quarter) baked solutions just addressing the pte.
> 
> IIRC doing the full PxD conversion is quite big; doens't make sense to post
> these on the list and instead move stepwise.
> 
> Agreed that it would be nice to get rid of all stack usage first.
> 
>>
>> Second, we could add a run-time page table check, at least for pmd/pte.
>> Something like below, gated by CONFIG_PAGE_TABLE_CHECK or
>> CONFIG_DEBUG_VM (untested and not entirely sure about using
>> PageTable()):
>>
>> static inline void pgtable_ptr_check(struct mm_struct *mm, const void *p)
>> {
>> 	if (object_is_on_stack(p)) {
>> 		WARN_ON_ONCE(1);
>> 		return;
>> 	}
>> 	if (mm != &init_mm && virt_addr_valid(p))
>> 		WARN_ON_ONCE(!PageTable(virt_to_page(p)));
>> }
>>
>> You already have some coccinelle patches to make the conversion. Could
>> we turn them into a coccicheck to detect new uses? With LLM reviews like
>> Sashiko, we can probably catch new uses violating the requirement (we
>> need to document it).
>>
>> LLMs and coccicheck won't catch all abuses nor does this series prevent
>> one from declaring hw_pte_t on the stack.
>>
>> Once the above are in place, I'd look again at these patches and see
>> whether they improve code clarity and are worth the churn.
>>
>> Maybe an argument in favour of these patchsets is future dynamic support
>> for FEAT_D128, we'd need to separate the software representation of a
>> pte from the hardware one but we've done this before (arm32 non-LPAE has
>> different representations).
> 
> Exactly; we'll need this and go one step further and disallow any ptep++ to
> instead route this through helpers.

Agreed, after the current series, we can easily make hw_pte_t opaque like the
following (or in even better way if we spend some more time thinking about it):

diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
index ee4eace5c3e1c..9898c0613e170 100644
--- a/include/linux/pgtable_types.h
+++ b/include/linux/pgtable_types.h
@@ -7,17 +7,38 @@
 #ifndef __ASSEMBLY__
 
 #ifdef CONFIG_ARCH_HAS_HW_PTE_T
-typedef struct __hw_pte_t { pte_t __pte; } hw_pte_t;
+typedef struct __hw_pte_t hw_pte_t;
+typedef struct { pte_t __pte; } __hw_pte_storage_t;
 #define __pte_from_hw(pte)	((pte).__pte)
 
 #define hw_pte_val(x)  pte_val((x).__pte)
 #else
 #define hw_pte_t pte_t
+typedef pte_t __hw_pte_storage_t;
 #define __pte_from_hw(pte)	(pte)
 
 #define hw_pte_val(x)  pte_val(x)
 #endif
 
+static inline hw_pte_t *ptep_advance(hw_pte_t *ptep, long nr)
+{
+	return (hw_pte_t *)((__hw_pte_storage_t *)ptep + nr);
+}
+
+static inline hw_pte_t *ptep_align_down(hw_pte_t *ptep, unsigned long nr)
+{
+	unsigned long size = sizeof(__hw_pte_storage_t) * nr;
+
+	return (hw_pte_t *)((unsigned long)ptep & ~(size - 1));
+}
+
+static inline long ptep_diff(const hw_pte_t *ptep,
+		const hw_pte_t *start_ptep)
+{
+	return (const __hw_pte_storage_t *)ptep -
+		(const __hw_pte_storage_t *)start_ptep;
+}
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _LINUX_PGTABLE_TYPES_H */


-- 
Thanks,
Usama
