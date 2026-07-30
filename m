Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4A83BB9F8;
	Thu, 30 Jul 2026 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.27
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407206; cv=fail; b=S6GsIAiiRjI4e+cnek4oO1jCPmyD9PS81vbtREV5jIf1GUJRRNVW5pFZv1XTK3LR/eWwo9tPfccqcIgM1Mr8D+LEUOXS/3L28vz//5vXthtXn1yZU20epQLXmd9Jt9cmQ50WKH269Pb9IUMIhRADx8RoMTW8ZxX2P+n6DVRkdSY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407206; c=relaxed/simple;
	bh=vei0dWvSA4vDN9NFvw1n+jaZ2T18Jlx6yF1dtC1TiTk=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gQlSRp5zi+b0sQOjH/0v8u3TTmlSCG1wCwZLBOZNImPzAwAct3BmtnJ289Kl1Kg3m5x7dUJniXld/1kuyXZVt7rjo+2ViWyROZiuNBg30rCUUlvcI/9H/xOcWujfPUSZftpaPldGNl2tnfwTAk0qLAdxP/Ii6XHNZhYBRhRFMsc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=I3KGM4Ub; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=I3KGM4Ub; arc=fail smtp.client-ip=52.101.65.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="I3KGM4Ub";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="I3KGM4Ub"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=sRJc0rLoy8gcF3NArSz9853A6rzaldEhaXQkIWreqs4Pz76rSuPtvxl/BnyUN7w6CVyP7Ge2OZUWzEFIGGIthJqhU+MP9jyDAMvVefoMcbcIUzRNX6Vx7E/b2V6dYQKjBR28/MkRTJlWZxy68/rL12ysH5rApRmFQTgk2+KGdn8JRi6p+Lk714qR0Pcv6mq39GmE5Ugij29SUXqtlMveWiKB9Vbm5s8jfMpZJQG358xVnRYvLPyWSw1OYKXCoDwcJCc/WL7Iz1hHfF9jcBHRLRgLfOx2FtgSEqLB7+X3lw9RO3tSS1TO+EUUWpiyBG/FRLJd5ZfhdiVodtRqD38w1Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3wZAwMMPZoTgl0+TvR5LTWocvVN0gVFmphGcUzdiRM=;
 b=ABJ1CrzgUr48o1FG28XFjvNGL6JjE12+0r7ORKJRgCdjIYWom0mdjODfLK1UWdcZ1C2PqYjKzIUGvv34YkHSpb+7HxdW3OGz9tFeOPQZt7YuFzaRw9HKGEARi/53RhKle0DNY+MgzIA5E/UMWkAZTn2ed7+M8bOfHUzSeHt/wwJi1/NhsOZXM8DNgqQkTS/ebHJXZug854AQ6870OnD30ED7bK2vUPVFHeWC/VWPjrVc0TO23Gxoh7SrJPg3nBKqetZKJq9nVUYk6BuFARoI81nXE3SftoXfPJ3LohWaOr4YLYIwuJd1fD/CN7kxbOMxToGMqBmay5vDyQBUSxDz8g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3wZAwMMPZoTgl0+TvR5LTWocvVN0gVFmphGcUzdiRM=;
 b=I3KGM4UbiK3WIJNvtMLyCLKEtgAXgD6bn0xN3RM8BZUiRELjJKB8aNg0GS0K0Zkm8DgbPZTATfeO89kDomtxbUreYjDNWfu2IAQJ0kt8rZD/6dyYZfSbFtfCeNR43NYJtBUMxXjH5BfKeE1xftNRWFhpLkvvVhRAM+3b6bPrwKM=
Received: from DB9PR02CA0009.eurprd02.prod.outlook.com (2603:10a6:10:1d9::14)
 by AS4PR08MB7758.eurprd08.prod.outlook.com (2603:10a6:20b:515::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 10:26:38 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::4f) by DB9PR02CA0009.outlook.office365.com
 (2603:10a6:10:1d9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 10:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5 via
 Frontend Transport; Thu, 30 Jul 2026 10:26:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDk6Z05YfJ98U+ROp9YQdvIgUvkAtmelCatjajEmueB0eqWoORKpIhSBuCWJg34MDT2YYcVhzaT+UFHip6u+ZDFk8Ll6OJiE5FaULhQ/dcbHjaiQXr4qMWeENZoIgTdzfYE6OYkbYmGscMVE8dMLgn4V2CxeRAiMB7O7PQ45JFDFbcnXJll0lDLF+1iflOy43hFBsVUFWFQCwpdQP3YtatJ3B/KzCxs4NZfWv2sVLI8lL7+i5J1VbrhK/D8xgDcGs1XkLch7eSwMOfHxEIKwUghWx3muEZRg0m67eH3bodkccjFs/Z0zY5G+i5d6Ia5KRdKMgLBv0RYK3NageiSCdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3wZAwMMPZoTgl0+TvR5LTWocvVN0gVFmphGcUzdiRM=;
 b=sF1ye7kIvwABa0k/uw5UtDb/io5ZKbiWz0C1UkI+KXUOucKXfwVcyW4TsIAfR4XxHS8lf3++fFrreuLymWXgiEJC5UBQu2FDNEpAE19alIoXox1cgU97AmS9AauP9zCjWyy8ZXDx5JpUWLfn2fUFaqkl7gq9B59dHyLEEa1s26ds8TRtfxtMBtasP4sJKQthSYe/URkdMuCgbBR1My4lGgXtmetVSAx3FyPTElnVzxHDYIg12xYdq9FcRhs/OdKtqrsInhPY+GQyqV5vS4IGj0QSzYpIyFFnCaFggPyeyULfuNxwXEyf48i21grm3tUkToFKBn6g3mDYs0V/iyGmLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3wZAwMMPZoTgl0+TvR5LTWocvVN0gVFmphGcUzdiRM=;
 b=I3KGM4UbiK3WIJNvtMLyCLKEtgAXgD6bn0xN3RM8BZUiRELjJKB8aNg0GS0K0Zkm8DgbPZTATfeO89kDomtxbUreYjDNWfu2IAQJ0kt8rZD/6dyYZfSbFtfCeNR43NYJtBUMxXjH5BfKeE1xftNRWFhpLkvvVhRAM+3b6bPrwKM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by PAVPR08MB8799.eurprd08.prod.outlook.com (2603:10a6:102:32b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 10:25:32 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 10:25:32 +0000
Message-ID: <cc3cbd79-d606-41dc-a83e-220ccc220ea8@arm.com>
Date: Thu, 30 Jul 2026 11:25:29 +0100
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 David Hildenbrand <david@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, SJ Park <sj@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 Mike Rapoport <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 ziy@nvidia.com, pfalcato@suse.de, ryan.roberts@arm.com,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-parisc@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH RFC 05/11] mm: convert PTE table entries in ptep_get()
To: Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-6-usama.anjum@arm.com>
 <34eed5fd-c569-49d8-bc4d-a3d4b1207fbd-agordeev@linux.ibm.com>
 <fec9e0c7-07c3-442c-819b-f9f5316cb6a2@arm.com>
 <9ac3f058-2a22-4801-8633-65635053c8ea-agordeev@linux.ibm.com>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <9ac3f058-2a22-4801-8633-65635053c8ea-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0318.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::17) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|PAVPR08MB8799:EE_|DU2PEPF0001E9C3:EE_|AS4PR08MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed62004-bbf5-4e4d-44e5-08deee2509ae
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 bXoevxLyBomTzrUcrVhun0Lz2qvSwqjhqFFv+0ABdtpcPStwD5Hf1TDhqSe6LXZw/RcSmI8TgDhUuUgRZ8IzmdSe9EwwmXnYb8gOnnxQheQPRyNeLSm+QZpL9Jyn9F2ukAQypbuSj+yOY6FQRKtildCDNSrBXYt8lQsM43yNUPSSHqfcRGjt2gbPe01TXLohTFVnQahK8mNAG3aCg8e5ATUKoB4j1boNWR5bqhE11KZoIHKyrQ9rGMLHo+utUPmD14NYZ2FeZ5LsVK4yqjha6ZE9NIfBRFQ6cbeM0Wcke0zMh5NmmncdG1DHtV3WmQlYYOBd3O9llxqeE+fPwbgprPki19mkYjuVsr2T2oveffhVTfiVHWIHobneT5i3NEKBi7jzrX7D9xRYjgT9qEY5aVcFkh/m7H3tYN5zON+LPD9KSqTMDI8orON72pqvLBPvfDcp2iWdDLy6W2PoQR/XaZ+j/kwupVpFzIC+wxl5pX7MvLvB1IeAnp4McwatuYW/vlE/E37hGQjM5FQuI3q2jrWQuXA8Usdm9xZLvsaIeiRVfq6akZTBTuKZuRUQRvRJYByjY5lNjOxXNzDgsifEw2kb5UD7kTHTofzUwTsnzHlgkCh3nnbV2DZY4orM2j0B3VJoRa7yNgbm6B1vJCVelxM1FXpCB095oQdEwc7XLes=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 fRfLvb6r8bsLj3g3MnaBsYK69jHABWYM5adlkAvFoXPc0l1et+e3sDQ3fVIRsEzSSUHvudUiLQSN1kl8DLhZgvreDww/cFr1g86SOnt7wO2FBTIUO/ZzlkT8Wvwu46XHD4O+KL+0Cg/Diiz2llOOhpq4aiE6EXMnR9Jty79jMbo4WlVoDwk7rCf0ZFgswXd0qvS4UDhThZBdUyZiw6CtADRjNgY5a9diCihtmRmWmQpuHqLJKwydC+Dpvuc9V5JKWLq1AXqkddTyT6hxcedajVUdf8dGPi6m5F3LRifURcDqh+yjXIqzzZzhIheI+Vld8LNBlcPPqqB+vdkb22xPOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8799
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	17a892ef-686f-4e19-2c23-08deee24e2a3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|7416014|36860700016|23010399003|14060799003|1800799024|82310400026|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Z1BAaOk6B9uCMw7HqCIVFa23sWZ/KUwa1hSxiZ+zIwpADynN/vhnmecI9+b7C6DFpmJ67xEAkEyLjiB9o6OSPEl4wH8ezUIcep3QykY3naEnwIxg4xPleEV/W2cWBnoIrmiG0D/Wi7RAwLiwKowSiTaFlvNdh2oqksCuZqTHhS5KCB12G8rDx0rWEU62yEJ4DlX5UGrU0s0oERsJl4LqX2Zfe5zuy4oZf6C1P9htyUrB7o7c2pDexCAPr8UZfui8XYb/U4ExxaFK/dVp3IWrow2dGgAL06mh7t7HvNAiwHfPmf+Zzql+HGuYvL5a2vSFSDu1JNzqCjpQ3hIbUPpGpGOwjiPFLzwjdrz12bVOpZ+HM4VI3tD1ratUjYqQmZE1bxgzeriMQCp8DXI2tU4jzf0jYjOTEbziNyqSXOuo9upQhlKgcTz9JhLst2wRl5NTxqkaBWSmaCT0Xh114NhpfAqJpJ7gTMgGufMAHLEjbCUSBQvEezNCpdJopO61udd8ML0JiNs/RkWGEcY9ZNOFUxy+/k+6Jkh3zcanQesE39dtNFrGdLlcIhQTd7M5/s1uCcGJWrXEBthPk59n/bHlnjh00Wo8VtRHIrbbniIceIYHIEP9hzZRptCmqm0bw+Grp4mwkRN0IjgCYIN6M+8TD/Wh4ZBHHjv64DSmyAo0IiNsoLT+CVKXOJNqVrmUFwCAtEgXXgU8hgMQIzvBb63v5Q==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(376014)(7416014)(36860700016)(23010399003)(14060799003)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jp8hMIbXZEYBINRi8OIiVYCjAxWHMFaXfKeVo6xRWmXbe3ar6XJ0MFjdSsFmetL1MZUnz047Doifpuq9kGIPdWUzBlRHWb02yz1SEdzs9MBiRzo6ZrYJKpYiMta+6R9EYpgfnerBlOBrP+O1U9KAwNUFppmcKoRyqrxdgI8DagKKw7pEaS9V54HMRUyCNG3xqM+2i0HmePDEV97XBbmN9IuMZEO4X9LY2132llfEx44J2W9a4rxE4kobhz+FIbs6IeZAChBLFUuqXD0XcQXk71PdtZxD45+nCovImRvfKyBCT7843oEa365lFiGacSFfnNapSWJZhTuNpY4qm2GBZ6OWY0lDl63lvKVoPbJ3RAZkSw9r0oOFno1rt4zdXpayntNaX9zEDJxRBiEEiDYVpS1HSr8KCuKXJojlwJ/dx5KWMhiTUVer/j29V9G+mHuZ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 10:26:37.6141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed62004-bbf5-4e4d-44e5-08deee2509ae
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7758

On 30/07/2026 11:24 am, Alexander Gordeev wrote:
> On Thu, Jul 30, 2026 at 11:11:35AM +0100, Muhammad Usama Anjum wrote:
>> On 30/07/2026 11:08 am, Alexander Gordeev wrote:
>>> On Mon, Jul 27, 2026 at 05:46:56PM +0100, Muhammad Usama Anjum wrote:
>>>> ptep_get() now accepts a pointer to hw_pte_t storage but must continue to
>>>> return a logical pte_t value. Add __pte_from_hw() as the conversion hook
>>>> and apply it in the generic ptep_get() implementation.
>>>>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>>>> ---
>>>>  include/linux/pgtable.h       | 2 +-
>>>>  include/linux/pgtable_types.h | 1 +
>>>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>> index dad80d264aac2..3003ac9cd81fe 100644
>>>> --- a/include/linux/pgtable.h
>>>> +++ b/include/linux/pgtable.h
>>>> @@ -493,7 +493,7 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
>>>>  #ifndef ptep_get
>>>>  static inline pte_t ptep_get(hw_pte_t *ptep)
>>>>  {
>>>> -	return READ_ONCE(*ptep);
>>>> +	return READ_ONCE(__pte_from_hw(*ptep));
>>>
>>> Should it be something like?
>>>
>>> 	return __pte_from_hw(READ_ONCE(*ptep));
>> I'd thought about it. My thinking is that we should get the pte_t first before
>> before calling READ_ONCE(). Please correct me what makes more sense?
> 
> I have a problem with "get the pte_t first" part ;) I think what we want
> is atomically read the hw_pte_t from the HW table and then convert the
> result to pte_t.
Got it. I'll fix it in the next version.

> 
>>>
>>>>  }
>>>>  #endif
>>>>  
>>>> diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
>>>> index ed5dba42a4f8c..61afe27307ec2 100644
>>>> --- a/include/linux/pgtable_types.h
>>>> +++ b/include/linux/pgtable_types.h
>>>> @@ -6,6 +6,7 @@
>>>>  
>>>>  #ifndef __HAVE_ARCH_HW_PTE_T
>>>>  #define hw_pte_t pte_t
>>>> +#define __pte_from_hw(pte)	(pte)
>>>>  #endif
>>>>  
>>>>  #endif /* _LINUX_PGTABLE_TYPES_H */
>>>> -- 
>>>> 2.47.3
>>>>
>>
>> -- 
>> Thanks,
>> Usama
>>

-- 
Thanks,
Usama

