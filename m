Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011021.outbound.protection.outlook.com [40.107.130.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE276394461;
	Mon, 23 Mar 2026 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.21
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277703; cv=fail; b=LEATa/UsqEsxr1olM/OotulBQbrmFtan+KxBPiG7It2kaTNewS0nGdq3bzQduy28gIgP7z+64V4jaTOgaTX8MHSVN1uhw5wUSX9hLd9ZG9oG4jkvnnwOJVFYkYSEp2PqmLt7WgpgGlOXVsqSXLsje1l8geR0Ds/1+u5+BYmsZzo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277703; c=relaxed/simple;
	bh=KDVDR9lyxoM31T7MUp/ahK3wjmf0xLvfiRcvhMpMyQQ=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MpIP79I6Dpbx24OWaUuy9JlrQGreSV/sFsR68ZfBVMpHAzAnEhZ4NTf7dM7albn4KMnMRyMs9xeF6uQCgbwd509qoAlvWlGZkapmTY1BKGH5I85dHdt+zUysigIVcjTRYQ3BJ1GIRfPyVAXp1qoQLWXOaIJT2OITI6PqAvl0KH4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hon8fwPX; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hon8fwPX; arc=fail smtp.client-ip=40.107.130.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hon8fwPX";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hon8fwPX"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hG+aoRMJgD8k80Y5LGsdmqKgjEsD2btGByOt0Fm4+/Szf1oCEl8/v1f24ImCjLg0WpaOG4pXmxmk7XtoPrI5QmKbWbKroX/O70QsIcleFalVJ+v11/56YjTVi0LvOmyb9sWk3svxbqvoUUXoSCY3nWtkxaIjhg0PENWmUYXv9iHN4+ggLKFgzFze7JHn7XAsgxv00ECNol/rfzMJ0H+34A6x1GZQruXN3+D99Tc46Gfv/5q78NlLKk4ScYdK1pjh1pMn01Lq1Q7xgZC3mHPO4ammqXuXLVRYkZGVk0MyvohJZIEzKXQSZoq8R68UuB+78zpWyKFJiJoN21kGU+6ZOg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLrAGODkaZl+ESdrzxSwjJ3YZlA0W/q2ToBG1Azq4bA=;
 b=uZYn0HEhuguq6iWaISVyBYqkFMYpZ9sB7Ye0xDBSAEx2JHNUirJWGqp1GPXytvCxlmJGdSOlF2VHCQ4/JY0Io270o/PAFbl2Q8qqSyUqasiKfNCWci8PDDTmAdSs/FikHexAXJcZTFgfkTv/3R2w1er4xKWsEKWVdjy04JV0bA4r1olh7E7FRbshtt2UopfbGTubiDJ8BAJ2zij6twt8nJ6+ZY6jaI9/v5uzYPCuuioRgBg5C1nKWIZM0HeqEfi6s1kQ6v5DsYMV86PLQY0o3yd2cwORthtR9f3VnCGRBi0hSC4Lw+ubEtH5nqFopjGeh5xrlhTKPgslGbxLcHdJ+g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLrAGODkaZl+ESdrzxSwjJ3YZlA0W/q2ToBG1Azq4bA=;
 b=hon8fwPX33viBWPvhLL6XGXS6whB1BR8WcL9dNXkGcBSNpChUqRul3Icj+dIg7lgov95fXw1WBnu97EmYF+gwq4kVhypnKCHP2/50Ebwls2duVWqKqWjQUA4ftSHRLQVuYXBRti7UIfadHjvxkECYROEjCLMR7OnnrEho4ZPPcY=
Received: from DB9PR06CA0008.eurprd06.prod.outlook.com (2603:10a6:10:1db::13)
 by DB9PR08MB7399.eurprd08.prod.outlook.com (2603:10a6:10:371::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 14:54:55 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::f) by DB9PR06CA0008.outlook.office365.com
 (2603:10a6:10:1db::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 14:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Mon, 23 Mar 2026 14:54:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qz2cYzh1x8vOVREy7IL53Xw513kJKrQOR0ZM8uwLB+l3ecPk2PXMJRafPrXvLEbrjxe1bwj3uAISbRYfYNbeS0fVpxD+g4QSjjSzyRM2kraJ7QzGAtxXNDmA8kDIO5U8tu0Dx7sllmHDVzxlB0dD6J/LgI3iIS9q+PIDz0QaumMTFov3IdZB1QkiWX02/zNTTfFfHLWZ5pEfDKJ4x/QqxbLMFiK0NM+/esw2cAvlR1Srs7Q80Cp4hkjMiN0ouJZx9SuTQ6ehtilkU4sxxMu0vawqIdN++e38qdplrBk6DluVkor4i4PrnHGRj1t9qCsygrOtY6aT+nCsGVF18PmdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLrAGODkaZl+ESdrzxSwjJ3YZlA0W/q2ToBG1Azq4bA=;
 b=aY44/PA431PidT7ORUJBsazfeAd9kdzgrlFV8aBbxuMalZIOhUNTV6IRjsEOelMqZHCLTCGNdksdHWDBm8ygkaO2lBfdn376QObf4vSubP4ILhVgUpagXrsxh3u+3a/nxfXs/2TTo3Y8+RGrjo7R7jth47TEC0vKPzLHooeMFcOfXYPZa81dril4CU+o4W1aQbcXg5UFXTlkjLjC71Li8fPKSFApIrqxpHNiRr0wiVpMI1gsWrF648Af/JPsJLyWCH7iK3OG2gjUQED7bHFxZa1jqR+x9HoRiPUwFkkXEfx9lZ7A3ZMgpQqy0wGDBTJ5ft4gRNBN9CU4Rzv8yppLcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLrAGODkaZl+ESdrzxSwjJ3YZlA0W/q2ToBG1Azq4bA=;
 b=hon8fwPX33viBWPvhLL6XGXS6whB1BR8WcL9dNXkGcBSNpChUqRul3Icj+dIg7lgov95fXw1WBnu97EmYF+gwq4kVhypnKCHP2/50Ebwls2duVWqKqWjQUA4ftSHRLQVuYXBRti7UIfadHjvxkECYROEjCLMR7OnnrEho4ZPPcY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3414.eurprd08.prod.outlook.com (2603:10a6:20b:49::10)
 by MRWPR08MB11706.eurprd08.prod.outlook.com (2603:10a6:501:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 14:53:53 +0000
Received: from AM6PR08MB3414.eurprd08.prod.outlook.com
 ([fe80::dde8:bf0b:1dc:2a2]) by AM6PR08MB3414.eurprd08.prod.outlook.com
 ([fe80::dde8:bf0b:1dc:2a2%4]) with mapi id 15.20.9632.017; Mon, 23 Mar 2026
 14:53:52 +0000
Message-ID: <4ede3b3f-e815-4b50-aae1-ef4a6d69fe15@arm.com>
Date: Mon, 23 Mar 2026 14:53:51 +0000
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, Arnd Bergmann <arnd@arndb.de>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Andrey Konovalov <andreyknvl@gmail.com>,
 Marco Elver <elver@google.com>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Peter Collingbourne <pcc@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan.Roberts@arm.com, david.hildenbrand@arm.com
Subject: Re: [PATCH 0/3] KASAN: HW_TAGS: Disable tagging for stack and
 page-tables
To: Andrew Morton <akpm@linux-foundation.org>
References: <20260319114952.3241359-1-usama.anjum@arm.com>
 <20260319201057.05d57006408a2f77342eedc2@linux-foundation.org>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <20260319201057.05d57006408a2f77342eedc2@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0091.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::6) To AM6PR08MB3414.eurprd08.prod.outlook.com
 (2603:10a6:20b:49::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM6PR08MB3414:EE_|MRWPR08MB11706:EE_|DU2PEPF00028D13:EE_|DB9PR08MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: 8452e464-9d4b-4df4-e5f3-08de88ec2563
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 fB8Q1TA73lVsULADYjBVa3idVyKfuY3rIaM1YZv3L4K6Ba34ST4TTu0FS66TSWMJTPlnttEnHy3kHbuyspHJs4zgn/1C3ueFVuu59P51Etko8lu33+wUoOSqpurHpMXG/C7DL2w8IR8r9/Vl+kWJW7X7QMzVXFcrq5FYNb/Lb1VHjucQclknqSPBJGcRfZn7wypqDiuFuvVibMpKWgIxPuGhgUxGqRJxDPBMi7aOjvbQz8ePhLnX8/r1fcS3uI+vlhUA46HY+5fdxxs7RNRMtGmjAQpv/TmfpMgt/rDEGTfOcTFzG2Wp1C6Kzc+8EXHrCCfUwC/qK62KLSOCnceiNBxxdRwrqBTF3QCgi9jCkQYSjUy1GN3+MQwOkGBHLuvv4mwTvTMVR4Dt8DbR3bQgu+kGhHWucH4MNc7HlPFOL7vD/ncPKf6UjHC6ajx1Ma1XwSzcT4LvGgP+4MkNFyiborPGjgz1hSdTaiWudZSZf5NFHWHldWWLzdVcwEFaAKiyoczM5UuV2mv++NQW2Cj/njIhjauWJh/Raiy1V8uuqJdmSLRMeiTvsRXlGqBEtKX0fwt3cg4eQRAmm5R101il85Jopb/GZ+XqWizyTvnXHFLRaUalko/HflcttgKUD5yafY38woNj0o7w4qB/lrdzhs9r5ComGtcFUthq/FmCPbqFxNdxfXSYhf2pdzeAu10u
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3414.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 jz9Q23+D85hm4dkFgZk1spt1JxGtQsDsE4nC/1e/iOHh/73oEFLc1Ed0XzpnpmNjY6a8UrlnnC0YVxP/F0o2q6ZrdIm91kUfZUcdC9FLQoCJKP3UCzY73fmL3vxT4ak7SzAznt+qUYORxT/2rjGsIsNRDvW2YP5c1cSclti2+cLN9V/crsZEtpx+sPpiR2u36Lri3aWzFo6hTjPMm+EUW8yU6LGGc6zm1PjP+IfPZHUGs5vL4vUsWG03ds+1i3NZqo/nx7+jFDB0uxCYnYjoCxHSWjKDJFPxblOufii7cXsAAp7D9URQUHDQRqCv55Jup73oVySfJbqh2cTGt3xcig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11706
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	97dc1f8d-406a-453f-6114-08de88ebffed
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|376014|36860700016|35042699022|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dm5nFJAjbwkg/bnFTcW23Oje0sqob14654mAvUC/DBwFMBwHKX0aKgmB5b4JMqDj5rn21QXSAGMPnrQ7YJP/mDW7CI4ufbh6mNyvUhQZgWPKE2DfaRaQ+jT0wCwu83IJ0L6txWVczg/rjhqUWpCVUA+7TQ9RfmMHn/jRsNng6Q0eeBhrzBWQtgmqJJxPD3UUcx3ATjKkzi72R3yzmbfVNxlykmlU+4osd1v1ganIwgrUfMBGOD8eeWVqLQ06PRSJCklTtLMCu3ewevypfsz3BnZNxpVlASr137zPRun+Z3xQChq6jrLM6Pj9Ztk165nucHQO6xmFAHJjFhQ6fXqWpBHIAKSgbTSijOs91dERW42WMQEWgUcsuQma/szbEihbycepxMHMy7AxTtJEnDR+0a63yBT2Vcl8i/cmTx/cg45wiA4py9IA7LF0+aK3Tmoctb3PJIdip1i7ao6fHgWFlcNOVEkhCVotMH+HV+MNK4S1yP+DcsFTqpIiVzwNzaCcpzvHG2/zOs839OXv388fOXLEjScJpdOrihOBoaXiv0nGVsS3prt+UgygbQ662tWxJA0zc9QwA/6/+yBPubMFowFGl91rIM9Dy92EJ50IbDa8AhSbqO7Zr9YxJ15X0iBsS9jpD+Qfnhybg1FXrcuK8MAWRl+qrI/87OHIzk2GTnLCc1evRkUpVRwmfChqYoLaQ8BZjzavs7rpQJWXJIpPNTNHfxe6JlF9VT4kpTd5U8Q=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(376014)(36860700016)(35042699022)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CX1hQpquMuuUfWXfH+uQF/ykvpqt7Yz+8qd78pSSK1fqL78IlYySIbttkocjjuiQaNV2wTvChH6q3Dc2o7oQc0zBgK9oAS4OBYvvYIh7ksHdyA4PHjujUXmEcwrsaTYPwySNMKkyhPdhuNcqFx3VLZA39dlI9yFBM2ay4jZxbG7vj+BfGiJW8bk8Q9cJuFGW9yAWRrNADY+DLVCKKI96tVKEfUelM2109VMfCjtpVTW2euUZXiI9Is7dcCgUscTl5SMSoVrLfRDFqi2c+xp9AaVlcggwr6NRclC6LOFbb0OvuK9WxxMlwRK0b2VgZdmrQ68chMYnxyXbp9+7yTNsOTtjNPejqUnHDvnGda3X2if/AtC7e7/3RsM2wJ4kbbtC78AJjxOihmYq7YknaTrkD/kgZYQ6sgUZsDJi/cMuRKBrS7ew0W38RjxezU3RS64n
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 14:54:55.3172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8452e464-9d4b-4df4-e5f3-08de88ec2563
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7399

On 20/03/2026 3:10 am, Andrew Morton wrote:
> * # Be careful, this email looks suspicious; * Out of Character: The sender is exhibiting a significant deviation from their usual behavior, this may indicate that their account has been compromised. Be extra cautious before opening links or attachments. *
> On Thu, 19 Mar 2026 11:49:43 +0000 Muhammad Usama Anjum <usama.anjum@arm.com> wrote:
> 
>> Stacks and page tables are always accessed with the match‑all tag,
>> so assigning a new random tag every time at allocation and setting
>> invalid tag at deallocation time, just adds overhead without improving
>> the detection.
>>
>> With __GFP_SKIP_KASAN the page keeps its poison tag and KASAN_TAG_KERNEL
>> (match-all tag) is stored in the page flags while keeping the poison tag
>> in the hardware. The benefit of it is that 256 tag setting instruction
>> per 4 kB page aren't needed at allocation and deallocation time.
>>
>> Thus match‑all pointers still work, while non‑match tags (other than
>> poison tag) still fault.
>>
>> __GFP_SKIP_KASAN only skips for KASAN_HW_TAGS mode, so coverage is
>> unchanged.
>>
> 
> Some questions from Sashiko:
> 	https://uk01.z.antigena.com/l/sS6fsklhbbK-vAbd4-t3S20GiqcWENbKuEm9JdfcHhXGvSkAuP_tTYRVNNEFkNyqNy6Th_W67uq4HpyPCykcGaYKaeMj7OPiFdbYLta2AQ6H4~yy59q32QAKn-zpc1DtUKnRNXkTGRIvJMOH217hIWTkitNDDPLzALLhD6vG1MnteYIid8KfwK4pfDahLHbmvBU1WWp6d3BG53WUdBJ4ONjb2PDTe4JdIvW0uWnju-HL5hb 
> 
I've updated descriptions/patches in answer to those concerns.

Thanks,
Usama




