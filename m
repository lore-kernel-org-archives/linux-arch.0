Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7723EF649;
	Tue, 14 Jul 2026 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014359; cv=fail; b=TGcL/mVcMY8uTXzmzwJJU8VJS76aHT1ir5cB9+mXeqViQlvveMCRLf9s8du2kH8Z1wMbZ37kYmZuO9V+oi99JUFbUvIhXgJcv6E1nnS7kYwXlH+wiHqnxK6BGHvFvShIxxbgko5IjicZDzRxTkhQbQKBRp4VuIwgjfcTJ8t0KWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014359; c=relaxed/simple;
	bh=eY0jbcGBjVGviH6lhE5K7H1DUwy1e2CYOuX74KBAB7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yl+ReZzcXSGcXd39X0yu36Wz+3V+KG3fnm9q1Dz3p8KaIeEXUvXSWFd/MrmHz5K6C/Qg95CtyVeBS6ItK4bMKW9Y2Gx8YOu6O3NbkOIte6VYueVUwB+P/bRzaiK9+c1ddOhfjivOrGYnUpiQAGal5/ZMivjlNDxXVKQyunMOWhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b+ySRjzG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=THF5uqQe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b+ySRjzG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="THF5uqQe"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E2YpbP2864654;
	Tue, 14 Jul 2026 07:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EmhM0791EbYv/rVaynr8QVThERcmMRGdsSIwtjMdPDM=; b=
	b+ySRjzGx2txneuiVhV5f0twgSz1Dlzl1B7mn/Fw+R//I96fu/AcZJqSXpK6ly/c
	kt3I66zHQESvNpa9R+iio9iD3MiPL9T0lvo0bQwg8bPjb+dCcJJUy7HaNPoe8RJZ
	7m2RA+UG7ZN3kIvE2ARcuVxiLTYoQso41bILViarrX/1yxHGp+rKHcK4IZGNrUhB
	OU91LhZLdAKwAEvV2Zm5XJmi7DbTgMpZ/5ZMoLYYW1nhIjcHUTjaMkh09ZsEFeTv
	Fk7IOBZo7158cMzJALxqedUjanRyZ8IMbw/tJAhlgRqeNmCkeOhhYuOFo4I9OJSO
	oQoYc86Bx7na/vQuyp2K0Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbep33p2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:30:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E7S8lZ017449;
	Tue, 14 Jul 2026 07:30:52 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9dcw0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jul 2026 07:30:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKJ0+a4o8k32NLZr1RUAaw3AUZttH/87G9V4AtlPkLs5Vtqo5BuGCqxcqjjCo3lPH9jFiEN3DKupEfKnK/TTiyYldQkI24zYwqP5YRPxd3otoj1qeydkgQYbL6G6Z51jvtmip174Br5lMDbQ2J8qgRZ1XkynHxfiQiktgKCY9gRf0kBQY24nwnhggdJwAv8/o7tE9MVITc1/tGx10Zgf5jaIIfFut/jk7d5aWJXFZ/ExL0nKFu+RKDNGHZWmTzRbUM3CxSWyy1kZK7FWJYxokgE1Lp6A37CIFjv9l3hRAzKi7NYrRdZOhLlKmjyl56AXHX/bJA85+kL/1jk0qR3cww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmhM0791EbYv/rVaynr8QVThERcmMRGdsSIwtjMdPDM=;
 b=yw9C5r91WBMAOIbqhp7REhez/zXoTYWKCoo93ToghzQ/SF56lNVmNA9m+RmATpyLcg98lbNwF9s+3DStKVwmCyqLMs81g1nr4WgPyOmOwgdBsaKJ8KIKZ+WFDb+0zphwFppJsAd/bOxPyu4/QqFIIiaBM10KuJaIK4wO824CzUI5y4A1tyiT4OUeDeHxVWQptt/sT3wHunMs+WupV98Wzjt5a2a4cfR5AEWKmYMlTxQgG4l3I6+sKdGn+EEx+tNIY9Hmxdw3vkd9JOn4kGxL3yi7h1NC2v8RnxtXMQJICJMB7Z/rdPFfmz8griyF4FhoXtAiy6hXfVkIZyv3UXboIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmhM0791EbYv/rVaynr8QVThERcmMRGdsSIwtjMdPDM=;
 b=THF5uqQe4+xMOhX73PlALNkg8xT1Qs5TnPROkNurLG4laoPDXPHJrHwLAH+m1ky0C/CQ2xaXMlfXrEXeDPwLB8mTFh847jcS8oP1u6KDJnGDwkFiEFKLlLTaFsyeua68tw1XcEieKve71o9XGAB+UN/r9hedFe/6nWMBBs+Hbcw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6262.namprd10.prod.outlook.com (2603:10b6:930:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 07:30:46 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:30:46 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, broonie@kernel.org,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v14 01/15] asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
Date: Tue, 14 Jul 2026 00:30:27 -0700
Message-Id: <20260714073041.40250-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260714073041.40250-1-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0261.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: b2295e24-81c7-4070-07a3-08dee179d1fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|3023799007|22082099003|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ptY2aoigXmBh2TCiuXsbkxxA11oQO0jCTEmA/zKvdx+8vlob67zO5hST8AuggmI1EoGxe2DOr6qxfFZl6hOz3PQulvR1lGE7Y617QPoPd25ZPvden/kVVrA4VlKYyCkSFvAwgJAPa86rLFIXU3/B6B8SpxvjapLyuRcMSXXLLR+WUY5qo/Y2D45LuxBgEEO+dLv7yuzEHjNcxHz1xB+3spV97BLu3jIyFbBrJD3sXgnUCvCBBVaeIhUxbEVvhszrVIA1HmCvMMzoePQQS+wi6z8oxtXJ+gKdzBHkMUKO+K1hkOme84DoxPTkZhewmAlbYLX6bziTeb6+twekP8VhT1dPMznZFQaq7Ib5iTKEAjmEAIhbr/IKiNQQn/AMM4V5xa5/e7BJ2fxu9SJDJB62BDfqorr+tDBaRf95c7gPuGHT6EP5dj+GSxVmyut9HO5CMANQWN42EpCNirY7S0WATyQzR5gpoT+2zUjR3A95tqYrg7wiMDawG4+Ihqu2HwF+L6DiwxtezppZ2b0Lq2EkMQFGFG6KrcgRV7ASEM4wNyuIIrwT0qaLW2KfQtawhbjKkbAkcorlPDHSVaOEbXV8olRJ3MIhv/58yrQem2bV2C4cidUHL4KfR+4OqIs9w3FFoYkp/Fr4thAqS37L23cjQYrO0lttaNlMs7C7aTqh6VU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(3023799007)(22082099003)(18002099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ExwWsPxAAmCrsXIdmpLF65V8e5nD/8tojIilP2gGfXi3Q/og4HlNGyVQ16/X?=
 =?us-ascii?Q?StTriHvKQPuuSfMe0bkoWtLDltE+krV6ARk75wkT70LwxPeOj+/1cYLKSc3m?=
 =?us-ascii?Q?Zs+meqqnm0hw9eia0ht0gvZdZZhlWXPcqFtT01vAEkNnxRo4gv0280bbhASv?=
 =?us-ascii?Q?/IMFl2IOk1KV8yfWPIf/SN3mVcvm3Lriqza+SW04Gpz8gC/NRshQMHHeuQhc?=
 =?us-ascii?Q?k7tXah7cLbhW0uu5J299LjPPqmxZzBFPIFyreKH8VoCq/KzSf+RIsmrkaqCa?=
 =?us-ascii?Q?xyTuwE6L1FBQaJQH5JKFRU8FikAiRw6/FORDtJe6q13uq7k1pDmEk1YHIRDN?=
 =?us-ascii?Q?ge3Tff0GlARpHEho2yE4ShILPOSglyBcHY6XnXTFQzuyOXxopDCrNiDzrwmx?=
 =?us-ascii?Q?5EGPeU43W1IEl0DQZt/QJr0nAaO/Ev/JSZ+4OQNMmvDB8EB7yDqqbMPSQJiS?=
 =?us-ascii?Q?CSDRNLcr/k2azcjuKyvIAx6ZDQTsViPpjxhNjtYLzTBODDUSDKz3KZGWksBE?=
 =?us-ascii?Q?aSqeEK5JNIBOqha4cGDELWDqVGqoM5T5fNM4mxg2BYO+VbLWH4vZQmChvW+f?=
 =?us-ascii?Q?JjKXGQuo/xYmG3wMn2RncQImrWyAOVCwkszbiEyCMrod9PZz/noQhnR5rnCE?=
 =?us-ascii?Q?b3K2cTrfE8LFVO+w4GDtTewvk9Qmz147Qb62ldrYsSMzii4V0tfTePuMES6x?=
 =?us-ascii?Q?lIffSy2wC8FQ/lJ7eDpC/xQJAA/fkSYC2Z6bgEX2PdNAaxSWIRPV4OviC7oF?=
 =?us-ascii?Q?rwONZlZPbKM0Niqq0XffIXW8ZwPFCNlzbgJW+hsIWavpSmPE83dVRi2S3sbd?=
 =?us-ascii?Q?A7WoVKwotLDkgm2LO+sMPf4sv5BUTMIjfF8UCzIi3SjeekKL97S5v2+S0fW5?=
 =?us-ascii?Q?JWo5TZHAn9sIX0e6IpkgclJsvcKuukbY2KldLvQSqm5Nq2OnufzmDZCJLn19?=
 =?us-ascii?Q?iqp6cnaX3lo0gGRhY8LRe8o1lA2KXbXTdzIXSDLLx/AnhXmxDcRg6eW9/hpS?=
 =?us-ascii?Q?zwYtFGwa03yzJXSFRvbLkA/MMBjf6EkJDbApJuBCtnAljNFX7r+M4PQEJZo/?=
 =?us-ascii?Q?3IPpN2HTFJ82U3O0BLzxfI4/AvjS39xyWez6etRY/c40NW4+vKdYR+c3WPuw?=
 =?us-ascii?Q?KErabqbhg1JrrrczzQRUuxJy/vc6y3qC0VcmG59oWw6FxdQwBy1QaqXoGUUM?=
 =?us-ascii?Q?sJa75eYGHIKXEc4FCdD8PnKz+rt3a2mVWXDQHNh6xfi/bPl1iJMmUEwC3m8J?=
 =?us-ascii?Q?d1IbSiK7ZrYgl6aVNHaWlOrwkQknqyU+51ug4VATtO6dWFlA+2+3yRW7/vEa?=
 =?us-ascii?Q?OtkaSB4lUBC5dJdudl3000HyhUyJXeZBnyG71yhgggGHl1eQQXQE38dcc72T?=
 =?us-ascii?Q?5d4TTZ592VsJIw/l68WLuHR/aohzXbr7caLwaPi0xjN9PAzI3mdLXzaaLCWT?=
 =?us-ascii?Q?uUawF3XNdLP8jk+ndnbWeUdOOEp3b7UbQuHBg5lsPyUcsY9kQlTolkZMRQhy?=
 =?us-ascii?Q?gnNVg86ESqFc0YolTgg2uiPo8k7Gv5pMhPNaMLAvf5vU7Nunubxvz3NJ4RLa?=
 =?us-ascii?Q?geOg6u7COy88E3pKE1WSuE9v10hF827DHlybPyScZt9TJJjSS/JS8YTZb48t?=
 =?us-ascii?Q?U4Is2DIj5zC/skHEFDTDMFc3u1Vp/Isz201ED1QwLR3OvMGIYmgFxiC+DoNb?=
 =?us-ascii?Q?PZyd4ZTHkh70Hgwl5gEh8Q//vo70fy8yNaSINDk+6PR/4gR6U96wTz5L9hlc?=
 =?us-ascii?Q?/Ksu1F6gSlhGGmQd5PGO6HrKaZeGjtA=3D?=
X-Exchange-RoutingPolicyChecked:
	LwpbSe9wL1CBXGMkJ5HRZhyul8NHVyYf2lAEoDP3HdK34hBZIZ2SUYa3v254qmsTmj1wOOA3OA65Mn4vKvXkJajUB0mvgwlQAyp2cwYY6nZu61rIY+GZtEWL0NhiexBM3xMNyON6WKDxk0rlpjsTjfVvuAc9I9omlKPMnuUAXMFN2VK6ewjRHi+z8dkLnqIPXFwfgEanQA6QueoVzw6U0tzM8oWAQeiud4fodWIc6GQZOU9jQs22Lgp3oC+t3F10Y9g3FexZ8AKMYqRalVQzh+GHIPg2kyxoZpEQWh4uC6sax2KsHp1OHHtZhjkqGl6S7GReO/YNhg74Wb2+jZfTZg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cpUE68V1snRK94td1hHnV/R9lOGVz/5GWJ0JyEIqtuQmQt8/aj/Yz0rwj4Pv40UNdoIa/T4olSYBSeiUsiQSh4i6sCb1dnTSvGlk+7H0ho6+tvx2bytOM6fHVVXE15yhLMdUXAUyERQmTLg9druvhAJkQVzdpU+JdOoB81U2oAKwDUXjkT6M9F630IxJBbGkLPDaL6VtztJbQXZxvY6GIYyFj4MfOzLYz0YJgydHTpRoS6s1CguYKGWQTn8uXC63ZwujwKYKcFA5eDLGzhBRjkl8zGVm4TZCYmHhVDhUj5yV8Be4DRnuhzBKxvrmidmDM1DxHozXpycyPJ1i7YMPlhvF3fLD1r1q33fJqpjS7EmeL2iBpvBYLgPgsaV6rCzIKXg26q20fbJIz0WBpE+n378y4YTKIiyp5+HjoXEr4iJiOB989PVtDJ7UxvN5dMFmwjzk1XtbShM5ex3S8JT3JLprL054i9bBuAcR7aP5A3a7oO70qUEfioJ58YVLzXefv3sS7jz79calBHx+JNHnXBTRQ6jWGfRazYfWBWyGm5/VyKsyGwclNpg0F4qM6EgJUmC2sG4zHjSG1MjAd+V/+LtzfwSlhv6V8QWABABwnbc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2295e24-81c7-4070-07a3-08dee179d1fb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:30:46.5386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbNTeATBHEXcRbexlSpjmM6mUgdwQIPB/rkXwwPIhWg2Wa+KF90ubEMi/eRLRQFPY+vEHDzXOsWtP7Nu1bWm1RlO+grk9w5K0hZfCQ3OL70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6262
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140076
X-Proofpoint-GUID: gcq7SmYtF5Yqp6m7gW8c0oS69IdF7Xtc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX4pKQHvXf/SID
 WqWSqiMC8KCpsRJjcGHwXbjOWlBDQggTOsYJM7M0nF4UUbcSFykXyjWpgnePFmdt9E7mbwaqtzD
 K6ORuUVAGJSJWJPuTz/Trf2JGjkEKP7V+Uh7dcX8PUU5Zqa+yMDP
X-Proofpoint-ORIG-GUID: gcq7SmYtF5Yqp6m7gW8c0oS69IdF7Xtc
X-Authority-Analysis: v=2.4 cv=dYawG3Xe c=1 sm=1 tr=0 ts=6a55e5ad b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=1Vp-6p46HJp4oqU_kr8A:9 a=WmVTiCyuxqgg3mnwYu6p:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX43AyPiiWAz5/
 6ZK7QwyU7j4MydzEY6EMOQxzeYMN1OY6Crtr4HX+UDHrByrmjfwzQDV5n9UKXLVEpYPH79lIHE8
 7lPKGLJOgAEco4RL5OSZMsgLhepfg7rLkoNt89eDo6Vk6sBMmSag3ilVGnJmb05H+egNtxAa3VT
 SkWsBnhgNwVDBpmDfPbengRYVtLYQW0eRVjLwIS2kkemFEU7EEvEx81ob0OGTj3x/XJk0CpfNOX
 uyewH3N3OO+A3cFpSAGJivX+/odKPe0ZrjEU3h4OspAu8frZKM3RzUklianEYNtf39xJduiEDyu
 Z7/mb8QgoQFoGU5my6OJ1HG3K9f0ePXld4IzRcFUeIFTJIqMVO303KoVpb3taBcvqfroJfIGdgZ
 0djQ1e75u92puLbeV37QEu2isYVzYEX2M6IC3V7PS3P5avARPfADdvE00UKzTyjrEEoe+9uPtdo
 ZoZ0sZFBCYEhGivywCw==

Add smp_cond_load_relaxed_timeout(), which extends
smp_cond_load_relaxed() to allow waiting for a duration.

We loop around waiting for the condition variable to change while
peridically doing a time-check. The loop uses cpu_poll_relax() to slow
down the busy-wait, which, unless overridden by the architecture
code, amounts to a cpu_relax().

Note that there are two ways for the time-check to fail: the timeout
case or, @time_expr_ns returning an invalid value (negative or zero).
The second failure mode allows for clocks attached to the clock-domain
of @cond_expr --  which might cease to operate meaningfully once some
state internal to @cond_expr has changed -- to fail.

Evaluation of @time_expr_ns: in the fastpath we want to keep the
performance close to smp_cond_load_relaxed(). So defer evaluation
of the potentially costly @time_expr_ns to the slowpath.

This also means that there will always be some hardware dependent
duration that has passed in cpu_poll_relax() iterations at the time
of first evaluation. Additionally cpu_poll_relax() is not guaranteed
to return at timeout boundary. In sum, expect timeout overshoot when
we exit due to expiration of the timeout.

The number of spin iterations before time-check, SMP_TIMEOUT_POLL_COUNT
is chosen to be 200 by default. With a cpu_poll_relax() iteration
taking ~20-30 cycles (measured on a variety of x86 platforms), we
expect a time-check every ~4000-6000 cycles.

The outer limit of the overshoot is double that when working with the
parameters above. This might be higher or lower depending on the
implementation of cpu_poll_relax() across architectures.

Lastly, config option ARCH_HAS_CPU_RELAX indicates availability of a
cpu_poll_relax() that is cheaper than polling. This might be relevant
for cases with a long timeout.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 79 +++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index b99cb57dfccc..d1e9ed15bbfc 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,85 @@ do {									\
 })
 #endif
 
+/*
+ * Number of times we iterate in the loop before doing the time check.
+ * Note that the iteration count assumes that the loop condition is
+ * relatively cheap.
+ */
+#ifndef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT		200
+#endif
+
+/*
+ * cpu_poll_relax() stitches up two kinds of primitives: ones that provide
+ * a momentary blip in the pipeline (ex. cpu_relax() on x86).
+ * The second support waiting for @ptr value to change, coupled with a
+ * with a precise (or imprecise) timeout.
+ *
+ * cpu_poll_relax() keeps them together, because its utility is in minimizing
+ * expensive operations while polling on @ptr waiting for it to change.
+ * The arguments to cpu_poll_relax() are only needed for the waiting
+ * primitives.
+ *
+ * Also note that platforms with a suitable cpu_poll_relax() are expected
+ * to define ARCH_HAS_CPU_RELAX.
+ */
+#ifndef cpu_poll_relax
+#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
+#endif
+
+/**
+ * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on.
+ * @cond_expr: boolean expression to wait for.
+ * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
+ *  on failure, returns a negative value.
+ * @timeout_ns: timeout value in ns
+ * Both of the above are assumed to be compatible with s64; the signed
+ * value is used to handle the failure case in @time_expr_ns.
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ *
+ * Callers that expect to wait for prolonged durations might want
+ * to take into account the availability of ARCH_HAS_CPU_RELAX.
+ *
+ * Note that @ptr is expected to point to a memory address. Using this
+ * interface with MMIO will be slower (since SMP_TIMEOUT_POLL_COUNT is
+ * tuned for memory) and might also break in interesting architecture
+ * dependent ways.
+ */
+#ifndef smp_cond_load_relaxed_timeout
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*(ptr)) VAL;				\
+	u32 __count = 0, __spin = SMP_TIMEOUT_POLL_COUNT;		\
+	s64 __timeout = (s64)timeout_ns;				\
+	s64 __time_now, __time_end = 0;					\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\
+		if (++__count < __spin)					\
+			continue;					\
+		__time_now = (s64)(time_expr_ns);			\
+		if (unlikely(__time_end == 0))				\
+			__time_end = __time_now + __timeout;		\
+		__timeout = __time_end - __time_now;			\
+		if (__time_now <= 0 || __timeout <= 0) {		\
+			VAL = READ_ONCE(*__PTR);			\
+			break;						\
+		}							\
+		__count = 0;						\
+	}								\
+	(typeof(*(ptr)))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.7

