Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9082E2E7386;
	Thu,  2 Jul 2026 01:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956128; cv=fail; b=agvcV8l69DGce5wJBiQXnH5RHfm/9jgkVnM9xCkqFv1xKdPQE31C7qxx4li6mzzOCAITv1X2ni10L94DfcSwUNqjdQyL1VWTEEoyxAhwPd71lthYMmN3DfCCwVf/LnY099RYeH8U7FZIfVwNpWR9GoKed6qDA6qeG8bGqDb78jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956128; c=relaxed/simple;
	bh=DGXJpSo9uxBbtAh9m+rA5dQ9EygdHPH2M1pAsLHWgv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pgBiQXX1x07gu0r6szOoCoxtZMJsdQjL4F0OYxCwGi1WTMVyK1j3WVz/yVn7DF1KR+5n53lXhBd2kNuoEldaQlsAcJgqQtHVocvC/9uPzzcp0RM7P/b9E9yQ9MOCCh+1y9XJ68UDRpcESRU+fjKEPiSlWkKFz75p3nKDGAoQPlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pDHgAdYn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XF6Cnm/J; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pDHgAdYn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XF6Cnm/J"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661EHN7u2839096;
	Thu, 2 Jul 2026 01:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UcqDHQpjAp4Q60CSgs5vj5LY3c6xQKhHL5kbw/NnE8U=; b=
	pDHgAdYn+bjAzdmh9m+evI27ALsM+YtzZLV/EH9+IkGkFH+eJZ77VTw6aFz6Ye3m
	nAvZVeyMGLrMRDobFy796FokoYaxHbymUGS3qz0tms7qAK7Y2c9t4RYmJ7CyArXJ
	SRaOnmQEDxNbDzBOmOkw/wXiSFHGhfQwvJ6QXN1gGPdgKUe8E4s/iuqcPDVUURwt
	dBmUMZWQfYSIAG3PlIV8TPLFSSKFGlM79AjGyg0zmNOOk1pO5BYoW13Nw91KiG/H
	5I9wROmhtRrhLVPnuLTpddIamG9HTt3J3+i+eGLPpbDnyflSrbF7BASf1rDNTNHJ
	5Iw/y2toQgKLpqmhojNmSA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26p4786r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6621SCHu036189;
	Thu, 2 Jul 2026 01:34:57 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012001.outbound.protection.outlook.com [40.107.200.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f24ygbyta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:34:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaDULTv91uq9YU8tcITnW/aVJ19aQaoX2Lbdoi+x7G1cbaX3zYrcduHdkzAcQvtc8+ptTCQTXTfL+p2yNZzn6p623ze7XWBf+ljUJr62RxyJ2PnQUlVjyJlkQG5ZTntTE+Q8sjCoL4euQjPk09hQySUsMlijndoeP802qt2u1qoz6G81x06Z5KSfE0aPS66u1ByyXUFB5RItvfXPHEaY1keuS437hZr1nv84X8hI9FOYNvn9FOdZ15emqBXeKJrCv/Qg0QP0tKkMHawEIMPPQarqOU8i1FSDgy5rYkgzqUjybIhxs+iVZ/YRTwJ+SHjUatxhaY2IIYiyfNEtX/DGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcqDHQpjAp4Q60CSgs5vj5LY3c6xQKhHL5kbw/NnE8U=;
 b=d3Ccl858vKUC1TGUYflK6OMzZy7c4JJca6ZgayrEM2dbhszTttWHbS2CkW/0DD8ZnldqUH+ywLvhl8vkbNYm1T7I6dNOUFo74yMTj8EVtJrnsVqelSHKZRXrkKY3WZVeiZnqpGmGlA2rHsn6prLFIqzNDeGCKqxHxU0nF1U7lMGYG0mjKEnvYUN13z2yzYRlIMrcjP0/G357S5j3YoKgK9c8U04zED9bnSXLH4lc6q4TsY3YfwfBRgoosMIxiSnbOCBPMS/XFKGWDmII24jtVWblDSX928JtB/0lj78qz+2WIQ17davIMH5SmwbFJOLpyKI8wEvaF4IOaJ9g5eVZVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcqDHQpjAp4Q60CSgs5vj5LY3c6xQKhHL5kbw/NnE8U=;
 b=XF6Cnm/JMUE0/X088ZamDGqU/4ub5hAR8QTwWBnb6iqf7XqADW5AbffLeRx0JAfufvXqPNf6U5klW24jPqMPw4uhpgaeclrfcvIquBtKVOfamfquPR554BGw9A83hstp8dP2KqCQN1eg1rrFkfMBS61ncocaL+3tSggx5usO0z0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA3PR10MB8760.namprd10.prod.outlook.com (2603:10b6:208:581::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 01:34:53 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 01:34:53 +0000
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
Subject: [PATCH v13 13/15] arm64/delay: enable testing smp_cond_load_relaxed_timeout()
Date: Wed,  1 Jul 2026 18:33:32 -0700
Message-Id: <20260702013334.140905-14-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702013334.140905-1-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA3PR10MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 034343a4-44b0-40f3-9f49-08ded7da1dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0uvKabejVqc2ZwvwC2Pp8a1Dnuq/N16RTm/F5qS+i01N4+nnjWj+pvKw5LQuf8MW+Nxcd6Crlnq/uCkamog9nhFoGi+KD9gZqufoyY3K/7OLiphkYa3CU4PB9hELUpNpQq4fEt7i0tRxIjwQjEfsyDD1NpLip4oZIa7hJx95VZLSBFRq42ggkYanivrA+k8Xl4rObwMTVbwh76kVJZvNlAg4t1jxysGQHElCIA2qn/EPCsJjIgDpmJutXfQMY+4eEfA8oAGsii6qPOHNwShL9VdYm+cOtyQbYuG7T4nttSfNCHLZlKzoCc7sXcRTTXJwtz9piRkaNxtLmi3iPn2JWtlHq6O5dzH65n45idCUkQ9x082/tEyu0msuh9gBBdDA4JFwNhYz5rkqKVwAkKwJvKzzStEq0wYYkfF9EjLSLtU/cU8/NjvSQi9n9vD02b+KrSbee9xoiBBe106/LEhT2YMrSpzgSxouP6CZ/oo01IIqGRDNAGirFj2ldzjz9XHKWKhLGFYuPjymmVMlDpSvlrUJsg3LePL/CtPssF0bxG4Tf7YzNiwPXUqDJWX/TA/KVvOgSIl8ZOEQ6naHJPbWHBuwrFwkQxQhN2LAFvO2Dri5zV1w334CiECSBBRSUfgBsZ7AVtJcezH8DZSA/yrMkbFQ05SrWg7v7w2a+AR26dg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CKvCbGsVIy7HI3VhoOH9vQfCxw6hyUWJo2QAebi70uBZzxrbAp+BlA6cHjV+?=
 =?us-ascii?Q?6pmHrZA5YbglwhoHpZ5D6hn1TrL7c8xIsdCe3kD7JSYoPYBTgrLujwyMmrrq?=
 =?us-ascii?Q?MupIXsQ44prLs4jnQpmYTmdsmq0LZo9Ak0KgulN12h10Fhjf9v4mUfrhydIz?=
 =?us-ascii?Q?NjPYLZsrTTdN6P2Hgw9fuJ2ms90oXTHBLdsx+wAPaBFhkiwmrcdHDJatraeB?=
 =?us-ascii?Q?5HddX44A2ywwYObmdDn+28djcnW0NjLuY/44jMMQLFcc1YzZSUcYtLPL62pA?=
 =?us-ascii?Q?Y8la3VkqUouWxrXPMhDIvuSs3B1ZtkHwwT0WnSSBNk+7JYNx/ZCPoukoRe5n?=
 =?us-ascii?Q?LajAiWOnNyeM36AsKYD5kNreXoIjSEXTJ6Fg8T0RfnVggQdE7STcxybQvs/8?=
 =?us-ascii?Q?lcvbyqfCVskUq18JxGqNkLFXrjVNNimrXar7106A0YKCP3QQDl7uSmFxap1m?=
 =?us-ascii?Q?L+9yA++ZUbBrmXCvqFns3RXLK8PcsysXDhNo8Yn2jTjqvQtAAvSzBdQorMr9?=
 =?us-ascii?Q?SnyswoK++/WFGj87rfGdR1e7iZI9szVlGPYGmS/P8FeROosB4BLXHpF9Wmz2?=
 =?us-ascii?Q?NECPv3HzIpUu8cdYxKfo9yhirPXMk8inVLJ37ELv1OgWljxjTDqkvzPkA264?=
 =?us-ascii?Q?kvDF0i6dqsA3mbJ8KfTfMcJeeyEBYyIZvcHkwst/mVaUBpyY7obNSyj6FyYi?=
 =?us-ascii?Q?bLiGQ2xBy9whcxs20J4VnBAtnocqxm05eZTkSC8DYOU7PCsDLDfx1KLkc4pd?=
 =?us-ascii?Q?TwOBZjbdzPaT6RjyL9Xpfmok9AqGeGHab699cEyuRJO0wcbsa44DlbH8Mk8t?=
 =?us-ascii?Q?cdhMKC+LMzYneRs8UWzGy+/3T+VILZRSjsCQVe0d6xeJCYkYrMGRb4flp3l6?=
 =?us-ascii?Q?IZtAvx0GaeIh4OLclQ6t6AtyG9HYfQ+ICJN2fsUjz79LS8XAx3NG1R5rlNkq?=
 =?us-ascii?Q?OglnoflvEuv0LsGThUrThg7WnxreRW3JJTM0KwVzCDUFtUTrkfxauyouL1qN?=
 =?us-ascii?Q?/YG8dzeG3n1MOJ1bGqkx1VlrKxCTzb0+CizHBAFAMQ9c+PUzDiCevOL81IeF?=
 =?us-ascii?Q?p8itIJMUdCfzPBsde9LeNaS3jehzrTrmoMMTlZWd4l4q6QXkJ6Y2Z2cu/a5u?=
 =?us-ascii?Q?KHqMm2n4q37/O2E0CsY+4w1A9/df2b/4jDmpCOE4C2W5AikLgiCwHpUaWfsR?=
 =?us-ascii?Q?tGBE5qo5ehzPWGkU/zecE138SPY2Nv/Sc9VMrkCuSjTr2zet3p876cfRHNyo?=
 =?us-ascii?Q?erR70H2XsxJoYNgc6VKSKeuciQlNUvob96+muJTurg838p7fCREo4trnY33J?=
 =?us-ascii?Q?L7FfQ5y9IXDabEhbHuUc7OWZgKhsNKxrBFM7M0LoWxAG9Ps3irtmbNr6CUNJ?=
 =?us-ascii?Q?SzYeEmWZAQ2qK0W8BAWh1g+AAlc8txHx1SRBCxmij91dosV831CTKh0uZLrA?=
 =?us-ascii?Q?0Rb8RkBAO1glYTJR7xGZCEDFWS/gZb8HX8JflNwn/iaKgEtqEkH5STpSo1U3?=
 =?us-ascii?Q?bUmXrTmXBNxl3FMhtN+Kq2Evv47oRTNlbQREZqNJqfcEYxCyED8HmAfTbPAh?=
 =?us-ascii?Q?354ciBilNteEd3RD7ualJNEAuEZ/nNf1/eXft4UCbqHNc0kU4HR4nOMbF9XU?=
 =?us-ascii?Q?bNOvyyQBC8JStbr9iE1xND2pMkigtp3h/4tiEg3wMPM5pxFuK/S+XM/wsA2P?=
 =?us-ascii?Q?nqXQ80AMbk6nULb0qfsGjtc1+tX8uBI4vNQo3kmLjg8TF7YXuhuQUeYDf6/R?=
 =?us-ascii?Q?5Mfj16ES546aUN1AvzunTVevb26Zuxo=3D?=
X-Exchange-RoutingPolicyChecked:
	s0JznwFVU+7GDHh237DvnAZxXcsiRFFMN3z5KEnDjsToPV5rCxG3AH7RqxiZJfgYwTgFqGhYxe3NmlIfhgtohvhVTQ6EEQJu5JMdErwn8RjbjIoTeB0vCiOmmlJ51aN7cfAC6RJohJKF9nijBRivp8Xh0L7bi/dZclWGRK5h1eSCx2ty7enaej2BZTOATtRM5/gxpeX4Lb6bs6ospJaiWBOu0KFsARdjdg7MAldOecvSvvXBxTwbmNgsrM2aFE2Tmb+JVhNgyDj03ZGyj2Y5fULLKzUW434B/v5M8DbUPc55c/B/5hHUkk6IH0wHkb14UypHFe5u3HVuuqUg5k6WdQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kI7OMGK5jtsdxOV2/7NEAbaBy3EqnMCEexvEfQsYOebICA7oObQayF/fdc0cYaFhj3Y7GbEsnsVlWzmx+uMUyLtnpzrmdDUcU/9wb/Ad2u/UGE0z6Q5DQ52io0X1Sm45VDXdFPR8DZyo29GTtU6sVYViIDwdoBFFOCebnSuyxK9Gh5HLZJEIloh4hQ6+2IzugCrG3Q9eMiBYWNQrtjiBNbbRKp2uEvZGRwcZ87f763NQS/zV7HNp4bFP0zR6xER9kPxRUWWMAFvjUOxvtvl2lAGIdpV16+JprviOntnOJm+ySEyQYEN/vQrFBpaPm2PQ8LM1mnWpVwMwpOGXiTlz8hHpNr8gxG8PSgx5QJypMIIWICBxLDFqR9e/+T9xCvkAJA4HL8Yu+77F39M+nZsN5yGEwmXY+ie1/jiYlLC4w1BE+DUOwZl8UtyXcLU5BVVhctnJE9eYhqFXodhMmrAKvkTAhM2G4YwC2nED4GgQ4ibDSes/Alx97mqxO6U3SqpeMxa5TutycF/KnKZxKYXqcWbK3uPuG4Ia7C8N8tXvft+56hp41s/jDKeQ1B9W3+msv6KVPOT1OhTwDyHcqEBay4tJBWfUkhdV8Mb/uevZWPQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034343a4-44b0-40f3-9f49-08ded7da1dca
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 01:34:53.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jCoZ4NfcnPxrOCwzIg2Aov2Jmch9IY9fWQjpOX1w6BmktVRojlqYEuhGwaZnkt5AZ73+7m0hI5t26HvXxYc0ZJE7oEnLc/amQ99iD6DnV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607020012
X-Proofpoint-ORIG-GUID: SCHQcmDXcZzBvTqmoCKqXFkYbiDoSqs0
X-Proofpoint-GUID: SCHQcmDXcZzBvTqmoCKqXFkYbiDoSqs0
X-Authority-Analysis: v=2.4 cv=DK6/JSNb c=1 sm=1 tr=0 ts=6a45c043 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=bb9Fw_vXVJAL2FTmegcA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfXyN5E1Uv11uWZ
 oyak9R8y4aJRIhW+ZbIwLjUihzys1L6TEKRgUnbnPovEt3xJh2fPvE010BDbBnh2Fq4U/XHe1i4
 BmEVAzNz67anG3BybQcuFGXYDQVOVrDnsCH3z0x6VTyd/IqtO4Btd6wmmD5C6xpuzjfeQ6m2aC+
 rY2m5rXKIMgMM+Wze7z0cr0FAFaQSCRYIUzMGyfFJxfp2QzbIdavgXSyhBOkxQEcZ8yGg8q9UE4
 zlmGcPEarnDKbSXzNo9UZ22b3xqAcM9HbszvwE9+LWzI9OYsh/TTmEZq2zvnzSELtLi4q78mMYX
 MLjFQyCDSv7m6iL3HgcMq53PrO6QGIvATTDs3thcWTU6Ni+veBBjr3L2V4/rQWsXJwb73fkRIYl
 X7SvwpwmsW+1J5YkOLen6n0S4XNHvHPL1uBmTd1trlNnKGxnihlzGD6FO9NFGf3QLllo+Jl2P28
 15Dgd0zZDqcpWEoN2Og==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfXxhuYJk3LE//b
 C7l3Jv9PhXG3Z57jaZL7T+myqM2ZkrTIHFPkc6MISawD9WI9UiFZW/N/giHA6+5UpENGqQXRmpb
 5r8PILj6uEWTUmtR5fkE585C9L/jYNRGgGKUhBs4W2vAt/KT1Qvx

This enables the barrier tests to be built as a module.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/lib/delay.c               | 2 ++
 drivers/clocksource/arm_arch_timer.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
index c660a7ea26dd..dfb102ce3009 100644
--- a/arch/arm64/lib/delay.c
+++ b/arch/arm64/lib/delay.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/timex.h>
+#include <kunit/visibility.h>
 #include <asm/delay-const.h>
 
 #include <clocksource/arm_arch_timer.h>
@@ -30,6 +31,7 @@ u64 notrace __delay_cycles(void)
 	guard(preempt_notrace)();
 	return __arch_counter_get_cntvct_stable();
 }
+EXPORT_SYMBOL_IF_KUNIT(__delay_cycles);
 
 void __delay(unsigned long cycles)
 {
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 4adf756423de..91ab8552ead8 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -28,6 +28,7 @@
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/ptp_kvm.h>
+#include <kunit/visibility.h>
 
 #include <asm/arch_timer.h>
 #include <asm/virt.h>
@@ -897,6 +898,7 @@ bool arch_timer_evtstrm_available(void)
 	 */
 	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
 }
+EXPORT_SYMBOL_IF_KUNIT(arch_timer_evtstrm_available);
 
 static struct arch_timer_kvm_info arch_timer_kvm_info;
 
-- 
2.43.7

