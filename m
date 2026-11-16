Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794817535;
	b=huO0syN76J0MC4C3f0c4B/CY5S/Oko1oyLkP0xpnzoChb5cLwrpiZgZlKZD2FyQEHPjF
	 adm4NyINiQOKl/xMLzIXbEeKNbxCeSEvXquMcrdiewsBwW1BBL+oUNqq7eJvUYI1Y4FAc
	 HLW7cqu8ifbw+jv9Tef9ZszVlZVT+p3zkeYFDO11jUAXt2NaEA4ZnklvJuzLfFNnYToDr
	 s7cjefqJ5XX0/z3NdZ1MsznKPSwkwlaNVisWULp25OS0KrHMe8jMSINVvz/hHa4RpRqhY
	 OajUwhTAixhk83jMDYbqm1mwBcS9Ubk8kOWE2lon7QonsmXMDjzuBlzNVZ0N2omxQVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817535;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc;
	bh=bG7IS0+DlsJDdJK+HpCtreOVmHKL5kvun+8qCcD7suA=;
	b=JTu2+SFGM3ZoGvj2XJs4bQn9eDj9DHye+KW+LmTrKADY+lIoUTp3FzOfjtUcbJ3bBhkT
	 cSqidVju0BNk8W/aHJ81Ls2eKb0iEYloTBRYYkz+XsreIBE3o5YfmtznAT6Bf6/g0Rx+N
	 +B2WKURv02q4h6Y/G+f9SQGqGvR0L8oad+6WHjDWesy2Lgezortxrtk7Vith6+ebQXg57
	 1uroKd3Av8Kn5ERZYFWcuWka7yj6O1uGyZW0rL7NaC8CVZ1N34paWc4yvnzb9ojndR5p9
	 FxOxOP3OVHtx0WPIU4+rOEbsFWBlDHE9nENdtdS3hRrQbqS7H52CRk4Vx7LPuxzLBjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=eihywTz5;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=WzHgk02k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5644606A331;
	Mon, 16 Nov 2026 08:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5644606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=eihywTz5;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=WzHgk02k
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFNbPjj2432219;
	Mon, 16 Nov 2026 08:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bG7IS0+DlsJDdJK+HpCtreOVmHKL5kvun+8qCcD7suA=; b=
	eihywTz5Wc6bi2v4OFs/Mg8ecPEYjzSDQI05xURaYV0NL8yFZ0/QH+9VHlfwC781
	iISxMQblZiFvXcdjWxHNvC0+d/zEwYYHSSd8o4kqe/jGVxwLUv0+DRkmRzqq3RD+
	aRYu8RK949VigicqRr7vnpaht7n0YPObwNt7piX3EMAfdO/IC3F8xpBkIvC4WbJf
	XbWOtjUv2CfN3XL7Tov/RIc9+pn3ft2J3osY+TPoXxYSy+xh8SLkJe62c4Bqyyg2
	LQssvsTbSc5cUweSggRqDKk1dkz+M1S690MAVvh1UPjkmOhY/SyxsSTBtxe1HoZg
	C/Qw/w9umoBvOCWuf2jEXA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxejbhn7c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 08:25:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG8HRSu2181695;
	Mon, 16 Nov 2026 08:24:59 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hyv7pmb8t-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 08:24:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3y1jrWpGlDRGbssN+uGBtI7RdfX6d/ULPbymQ1Nsql6NJ9ZlqM4OlmlgR/HpbwtE+7/tjNBk+R9JG4xzxxvES4knTSdcmJhtwgDZXOzcVSMP2l5loj9rqeJI73ngjBpFfnLAkMoH7rLGt74lL2Q0ElJJZGl/u8DAItII44KSiJ257y1AQl4yYwS9N6TWwsEVhzZ7d8UzYCtYHFgBaecAJRo2q6G5RyLtuG4Pi7aCI9Z5YaAOloWMW6tefXVatXsWLmESc4vLyiNQ//UKPwj2Q+oScHEPOhGJCTeEKHv4XQ+U/L3UDIoZLhWJJl51f164OybtDzx3Us09rqpEFmKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bG7IS0+DlsJDdJK+HpCtreOVmHKL5kvun+8qCcD7suA=;
 b=eHRxytJuKcumFRXeA9d/b7ekQj9qmCo1XTP+e//9kv3sJZhD9xpPcEqrOuYI84dQfx7BhwXQT2cVJweVHg3D+fPhm/qk5zz4M3HDPrwZrAZ3VBSieBq+CAlGzTaEo77usvyaYyMtsYn7X4wv8uwpA656ml0Fi9cVMC1uBGQ1hQLcmFApv+v5h5LGqfLWYzux94nkWZpxiZ8nT0GvV3e0bZtZYWTaSnT0cCN/qYfLE4ezGZBwa0OWcUhA2/VGsemZAtdsUKkPApxiyEAhMcPTOfvWYzUSKcDUsAEBp7Tgu/AW/jWSlEvMV1QDAQqHArgleiHhbtEpss+xf0UVqkbGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bG7IS0+DlsJDdJK+HpCtreOVmHKL5kvun+8qCcD7suA=;
 b=WzHgk02k2bU/CGIjhjFNns7G3AwCbJ9Ir6AeiCz61LrKX+iOsr5HNOpZX091B0hVQ1uweBGfEgzJlpHO4zMmD1SjpGJZAi5s8u8CqC0PukBAEIMiKQaAh2BNZ4ZNzdr+ByWO7d+bmKZDD8RbyKtoprfxBvQQzX+D/TW9X+WrWaE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB8216.namprd10.prod.outlook.com (2603:10b6:610:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:24:55 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:24:55 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, sahilchandna@linux.microsoft.com, cl@gentwo.org,
        ast@kernel.org, rafael@kernel.org, daniel.lezcano@kernel.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        rdunlap@infradead.org, david.laight.linux@gmail.com,
        broonie@kernel.org, boris.ostrovsky@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v17 07/16] atomic: Add atomic_cond_read_*_timeout()
Date: Mon, 16 Nov 2026 02:24:28 -0600
Message-Id: <20261116082437.66739-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261116082437.66739-1-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:303:b4::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
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
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: 106b7ff1-a96e-4ffe-75f1-08df43bb1862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	jE6LygjPYP88yc5NQL+vk0l4kZLDlqClg2mfnU4bo37FZmW0goZE5jYkJgk532EDpRezMKaLYwNHdcul57M7uoJb9OtAwg3mnPdY8oG6e2fA7F4ISqDkvugqoeKgVYk5vrjhQSAGb6FUy5xWk+UKEyFwcRE1pqLD3clH+tFMejpLewXYaXyv8oGPsaCUPUMGhIpnohnX3ddumC5wS6n7hJ9GT6VEb/hLSQZNk1Rn9Oesnflq1Xz/zMrr2iYwYe4w6vWxsPIjQ3ipn2OhZN1oBrc2KrsGFR3bzwRNzrwoXMw5xkDYLfInjROhzCo6U4ztak71KIhckRcLxdbxHBkvK04NIKTvfUylItLI5aZzZaBb9NssWoXaR7Xn8D+DvfXwlPO0Ligj0LziW2mD7H8799WLZ0GzKy7EqKDHBDdlz5D7macE/c/Fc4u7effk1x3O+Wq8Zk1I3W/LN0gIbEwy5V06cQcp5i00XisgBacbCEtSqtVa/7C8akFu0V1kCKHkcpnHiVozbcgJt/OItG2fSziP73nwUCJyMeL3n+W1XawwEA7Yq1kyd2SBY75S/7ljV94smMkvEDB3w9iXpfS1UtgdxLG7+lYb3wl+CDpM0NBiqmnW6y7NSU3Y7W5gx+OZT8dzL4iwJjabjj04ZMaAk72gfguLiuLDXmcLPK23jSg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261021135927099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nzGnydwyFacWny3Nk7SDZON98m6pXw5S/1B/k7mhAJs5Y7gYIcJ+qnKQU7y8?=
 =?us-ascii?Q?yK347XIyLIpq0yczrQaJq1Ms/u36XrAGz0gkH6xMIoV5DF0M6eWQRN6SSH23?=
 =?us-ascii?Q?imRKuxefM34qmgeSeeP5HTxN9jdpJV5KvvjOWFVENno2eB40zFlW63oSUwC9?=
 =?us-ascii?Q?nLxMxJk0kIKTWALNaFKGVXFGxD1JIB+6coh6y5LfXa0MuDGQduoevebJJVP6?=
 =?us-ascii?Q?cLjLpvGIEOFCX3SJHALcpgAh38PyJrBGph6Xd+fiA2H21WHtvqfTyoKdOKmv?=
 =?us-ascii?Q?8Kw9OPxFEsgTM2S+Y/MGem1YWf/erphDne+lAHkreK6TUbI2W0ZSCmy3aLZy?=
 =?us-ascii?Q?t9MRho7/rqsuP7W8K1b8eUUWl35Pmfn44id4eysTNToWVLFAnqePqjfzNGUT?=
 =?us-ascii?Q?2ZxIemKSSOnDxgzR56NyKDZwv+TADNOqV9/L2FmTUQ7Y+8aBjwExfkDFDCRi?=
 =?us-ascii?Q?tizY9M5hxBzkF65PJoY4cIybGnqLzDFKS9GeOSVmJ+R2mzR0timZWMqBgS9u?=
 =?us-ascii?Q?hzTD0fmfzAZhWXV67ov8xXgFjAjMlJ50LTBKpah8bv2VHNqbZ9lWjYwOFDX0?=
 =?us-ascii?Q?MIFFATI/bz/Lmvixo2ZeGdXt+UrH+7vdvo9SSj1428Ksq5Yz0eLkCFeAOIlI?=
 =?us-ascii?Q?dsasgosz+sSzlwedz3exDU6zcbMAkKmbtZuWnipRI5QK1l3QqmIYuB6VBU8V?=
 =?us-ascii?Q?ltdMIGA0D1xCwlgrqhxcZ5Td8OZB/PM9qHnSIHkZG8L/6pE+3ObHDkgGaarN?=
 =?us-ascii?Q?CkGLDGjBxgJbrrcAE2BP/i7sxVvZYz/3ShWF9QDvm5+nSxki42x52cMmBjWL?=
 =?us-ascii?Q?99U46MqiPcbVq1+SDA1owe+yAm61bZQfw3HE3E3DSFg+BF6ukI5Z+fTCC5Xm?=
 =?us-ascii?Q?kaFfoGEYEXswB7zw0klNP04mfdfyygrVxa/1q4zKRFic1ZNcNoEobIB8edbt?=
 =?us-ascii?Q?u/Uh6gMDaRoE2S2rrCB1djnU+0VRP8XpPUZr09HWZS6aTbU2jWupEByZ+mMe?=
 =?us-ascii?Q?+7Nox4qf35B/BulkoY8yo2Lf6bwDHPiLRo/kekd5GkwqbiZ/LnBrDdJWZ4Z8?=
 =?us-ascii?Q?o5vLCXDFSVWPvewXWK6a09ck9RkhEtpnH4UMrI8S8wRJB8khcio+eT2myLDF?=
 =?us-ascii?Q?2ohSkNU74BShEisZUOeoArdyNPRpFcgFuhyFMVtvF8GjU4Buabes81wLwpmH?=
 =?us-ascii?Q?Rflk5JDJGVEgStYpE3wVEiXfelbNMAVLrCsjZAra1p55Y7aUZwhrTkeo3dqE?=
 =?us-ascii?Q?o5s5vP/A9TlrQ+Cm3eQp5gFqga0BXQ+RPB3iGwA3fULr8AWQzdjd2LoyZX4u?=
 =?us-ascii?Q?+avnErq2FMs80BZFC/FNXwqJpnlUR51ioEglDdLR94g3sN0WU9XBtlGMKmpc?=
 =?us-ascii?Q?rIR3NZedd1fWBtEOnhwOCVPWOYlH5jXldxWZ1XnCH8n3jeubnWLBrrG5OGn5?=
 =?us-ascii?Q?56/uoompm1WZqJmHGtIyjRQpV/22ek+1as9co56XnN0j4XKfXAjbxYxclmjg?=
 =?us-ascii?Q?xBumI7YxFij7GWcGgobvWLFE2ZAZueABZ5Ld3QTemONBp6kUIiJU6TeHnSx0?=
 =?us-ascii?Q?KOmKCc0f9MBXNUH8SyT9TQSjwF9ZftetEFGT20rszLAtB6A7MqpF+1s4T9//?=
 =?us-ascii?Q?Cg+WVu5vhQ5HPfF+UX9Ex7RccGLPmjrygEyA0s0rHEK9NdjwIG4b1kdRxOXg?=
 =?us-ascii?Q?VTcVYifuiq9sa+K8FpGto1O7IQRzZJ4+pL2AwOZPK+fa5Mt3l+ZFoGDL7iHx?=
 =?us-ascii?Q?hPJicH/8YRadFYce+mbV45mXYjL4BAw=3D?=
X-Exchange-RoutingPolicyChecked:
	fgpfHTiqV2dFrkUF8W+oO0Hp9o8A4rSgqL9AJ/Rjj6vEQwjmq4KptkUOdo7JQI/N7OOZMS8k636YDJkX1LD+jpHRjD+rVIVUfZxR0Npqet2K7TsyDHLFn9TL8gg6AWrH69BgvSzhGslPDTJJc58cAkyH3ZssqcEKMd702VQv1mbEKHmSfjSmWOnsbmwicDKBxlA7K1IwDpjg4v/LkRu6zb4e1ak40Hlk64nHWXJqNTOJu15NUmL52qqGCfnOs6QM81KjsKlxHPEGtaiOehYQc0irh6PyjUgA982SBzTncP7PJ5e8Em5i72SgFJPYUVfdafv5j/hXINYeJCLP2RAJgw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vsRVurlg1u/8hKyZVjeiLlW1dZnYU18SFijC/IBc7nrFBQkUlLdD5pMkg0ufn2Lg1SOexcNtLQpQYjc/Qf9J8g+uZAnGma1aUHQd7rRlurakhiklEe0wF27DreIxTEp+wdNHsT0qmAF9/gUGabyp0xswinBXGl8lxQ6mKjHxLVdiGo/r96LMTvOYh7DnFcvPBltP3qcmhTxgwZTQ03WgRg/rMNkNwrMsE+SxMPsgFX21B88pkhko6LLtOcsSvWQrHPYrJEefU8mlb6kY4/jO1L45Z9vt5KKM3B/dH3lFzQWqnlm8LqpJ4uzL8BNiYfmJ2CkDNmrRTj6mO5uFdycCDxxy73Co7pjOItEcFdgWpoTtmUcEDNP3ejIK/z2oA6BWvi857G1GafN/M7DVT9R16K5PKutL62elzvLcLAQJwKafktY0tu42bZL0YjW0Qqb+ntIrvTdeZusLtamTwIXL3VIu94rf6aNAl3pGEJpgrs4SPJ0BFRMjNDiNxKueOuxQBaphaJZWzdWRCebbuY3XkdoF9yPrigZicC+h83JASPLsICSVxevG3gyLWyD9fDxH03LyxjaVL5BbuNZ5fmkimUZoTSSiu+qfiQMWCpGWP70=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106b7ff1-a96e-4ffe-75f1-08df43bb1862
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:24:55.8001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGha39dfHeXhsdP8jm/1AHR5PqDkijdHUe2zJW6mqHz/HFiKLEBMDYEEpFXBbw7hbxuVwsjSWVqnktjzdEiAFxg+k+ncddLxMpz/n0FgZKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB8216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611160033
X-Authority-Analysis: v=2.4 cv=NrtE4MdJ c=1 sm=1 tr=0 ts=6afabddd cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=vggBfdFIAAAA:8 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8
 a=bAMrUmItZINb0xDQqvwA:9 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 0TIdkhThyhurEgP1WG_LHvWfniVr26UY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX5hN1SO7HUs7Z
 UzkU0QOGBH3XyZxADA3RxMqOPSg0DfRnTyL+mRzilOoIpW1qHSd5hfyqFPlZp83mPe2ZdfJ/XlE
 j8+EyALUHh0glKYTxZIdb6Tf1k6PX7bLny3PoqoBig9+svQ2+P1a
X-Proofpoint-ORIG-GUID: 0TIdkhThyhurEgP1WG_LHvWfniVr26UY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfXyiFWdcGw1uCz
 J0OPDjPRg5xuSoP7/H/IQUrbxVnRUu8HdWhTrAaJWmPXFzj9IzwegdthIz2Tqe9K21wM+2bPpfx
 RD+EDIJKDIfM6VsEOPRQUBs1rr6aHSy+DBoxIReu7o+NuXcc5FmusH8SpQOmwQxHqhy+emxm2if
 NNE7qmQdUbTqO/lU+6Y1F/+ZOh+AgYhNSCHll+wJdW6/zO6JY/sa2ZPc1NZ7nMqCItKfxNjpzTi
 zRQYYv3kSCDUvw94m+XWhnarPBkRNVXeBsfUEC0Gz3Yxd5buoXURqg9CCq3LaCRJzdsBk2Qkk81
 fYCbNuK98E24irENriejU7HCQ4mWyNzcTIofSzXLIiTNn2C+OjOwO79EO2FCEeDlOqi4Qf+bkjN
 eP18SnLpvh8qVImjRRQj3gc07KQGqQkBSucAfs0330bmtxc/bmKro+ejG3qyFd51QEXcxIYAEXA
 gPBzhVmJpUIsLDaWMPg==

Add atomic load wrappers, atomic_cond_read_*_timeout() and
atomic64_cond_read_*_timeout() for the cond-load timeout interfaces.

Also add a short description for the atomic_cond_read_{relaxed,acquire}(),
and the atomic_cond_read_{relaxed,acquire}_timeout() interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 Documentation/atomic_t.txt | 14 +++++++++-----
 include/linux/atomic.h     | 10 ++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index bee3b1bca9a7..0e53f6ccb558 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -16,6 +16,10 @@ Non-RMW ops:
   atomic_read(), atomic_set()
   atomic_read_acquire(), atomic_set_release()
 
+Non-RMW, non-atomic_t ops:
+
+  atomic_cond_read_{relaxed,acquire}()
+  atomic_cond_read_{relaxed,acquire}_timeout()
 
 RMW atomic operations:
 
@@ -79,11 +83,11 @@ SEMANTICS
 
 Non-RMW ops:
 
-The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
-implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
-smp_store_release() respectively. Therefore, if you find yourself only using
-the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
-and are doing it wrong.
+The non-RMW ops are (typically) regular, or conditional LOADs and STOREs and
+are canonically implemented using READ_ONCE(), WRITE_ONCE(),
+smp_load_acquire() and smp_store_release() respectively. Therefore, if you
+find yourself only using the Non-RMW operations of atomic_t, you do not in
+fact need atomic_t at all and are doing it wrong.
 
 A note for the implementation of atomic_set{}() is that it must not break the
 atomicity of the RMW ops. That is:
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8dd57c3a99e9..5bcb86e07784 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -31,6 +31,16 @@
 #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
 #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
 
+#define atomic_cond_read_acquire_timeout(v, c, e, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
+#define atomic_cond_read_relaxed_timeout(v, c, e, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
+
+#define atomic64_cond_read_acquire_timeout(v, c, e, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
+#define atomic64_cond_read_relaxed_timeout(v, c, e, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
+
 /*
  * The idea here is to build acquire/release variants by adding explicit
  * barriers on top of the relaxed variant. In the case where the relaxed
-- 
2.43.7

