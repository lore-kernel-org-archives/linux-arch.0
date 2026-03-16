Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92490246BC6;
	Mon, 16 Mar 2026 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625072; cv=fail; b=Rs2TRd7PuE9dpw6KVPiVqOSBtbm68VEI5jp6iDMWpZcHX+gvNJ2u7UvNyHXt42ZCgSzgifR9sIMzvyia2yxx0BrajhD0B0S+p8zhRc45DehICiX01op1Yu+10UkVwGuCdjEMCgaBjqFaQBm4sSPPYCbvCp8gaqBpdhHkyHzTRZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625072; c=relaxed/simple;
	bh=tyKyeS/2jLpr49Q3e1dU8wpSrToIlZAHNWmT99aDwP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mfQPFak5Vnu/HcnnWCdwBjBoqdYSUc0MpbqzpiHf7lV8QER8wg3mZuO691wG/BcnuMwOwPlksNDmW61YfC8ern6VBhqaJvNbl+kW9UjuKrk++W1jcGhYgk5rPZ4Oo0Gz23hjOMgtaka52DLy7sMEYgpLB8lYXBBhpN/9lG5tpaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eMAmDcZt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rwlJit0v; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eMAmDcZt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rwlJit0v"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FMxlkZ2838188;
	Mon, 16 Mar 2026 01:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YyobJUMrCqoQpiemBzB2+HPq7GVYfYiMd0Ms2zfNasw=; b=
	eMAmDcZtQ2gf0nK1bo5zf/JblrGTYonYCvBCC6NMmIA0yPM8Tv1ubbZi02igtHZc
	msmPkfJj67ReJ5ob66UY6BHtLENJNOHuIxf5JHnJZYRYimTr0FmO4ssxEnj5gQ1d
	hGRcJFhtYNXSPa0wjG4DAeRurt8ZvQqXr13T5TRDneHwAx+IJZ2k1kP7Wi3vkkdu
	2/VDIUFwulQ1nvoYoa10xJcCQ06aG2LcvZKfHSz7GhNMiDBURbwuUThGMWqo2+u+
	4Eh4vr8rrg8fV1BIihop8dJe4jLc6YPa5ldrRs0Tvmn+VzeKHMfp4g8Ns0sBq23n
	HnmUogmnMRqvGxzJj/GmZA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyqbsb1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62G0L5ac031891;
	Mon, 16 Mar 2026 01:37:15 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx480spb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WauHMSWmibC02Yt+xmnkT9ZFHX8rPQzqtaPmK7eEgqscAkiYGBUzBJLWUVWd6uG8tsHfjg8Cda9pcO7z4f1bsMclcd0zG533giHByQelyOlC/h28ZMRUwNr96/tjfDntw46PafVJ47aSxoJXYTO4D50EzXcr6M3plB6+JJhucAin5eIeYrNeprnB/FQzmmZMWJtKponsfpCuzHq93Ek63vhBawch5wNzgR898WBCzkdcvEEIIl3WiXGu8HqgPrI/lSBSzq+KI4fctluE+WLBMY4K3gBkBSSqYJAMhxAoJHYxeN8r+B5gcwWy27y/xlXS1uWTpqbO9qbXK8zflpDaRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyobJUMrCqoQpiemBzB2+HPq7GVYfYiMd0Ms2zfNasw=;
 b=Wqy/t0lj6/+64dzPXGL5T0w73fOfuaemXa7rVxnjP6aFoTrEGQdjucxDGHa3NKkBtASahKyqc0/0SDjMDSKVKMfHa+elhJCVAj++EcgiSh09kdtM4X0Dnvki02iHHHZS7DeocckUuBaACxMehPpvpy+HuJlGCVQyKsn9L020/Cc5RyB/85wyBnkv98TuvZRQ1MhcHOIQm7mPzst617K+hEvsyQgryRT+VTrtXfDRBtpc7EjeIA2/+htz9Nt8UeNlrhUMUkgEWY5TERKOUiM+pKdYSfOkggRZFReZpBCyoQ/PqqVw33H3h9xR5oB2odCn+2I3/FytwSgkw09zrt6aPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyobJUMrCqoQpiemBzB2+HPq7GVYfYiMd0Ms2zfNasw=;
 b=rwlJit0v+xFPkv+HNuBD4SjwZO+2FhaCqOoZ6Kc7+p3l//LayN0W/hMHn39MMcvAhw5ZU890VjZVlcmXUXYmm7i6URd4oK93p1gCrqiJGSoiY3H8aknaHV8BYQki2FuvJw4K8DObxlIbZRCMWzwlxoUUZ7wy7Jo0QOI+QM0G2oM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA0PR10MB7372.namprd10.prod.outlook.com (2603:10b6:208:40f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 01:37:11 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 01:37:11 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v10 08/12] locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
Date: Sun, 15 Mar 2026 18:36:47 -0700
Message-Id: <20260316013651.3225328-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0252.namprd04.prod.outlook.com
 (2603:10b6:303:88::17) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA0PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: a9be1839-3821-4ff9-e713-08de82fc8b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vQS1/4puVO4wFtjzcR6FpeFcSEF9IHxQF2Hg/ZqbCwCw+Irj4z0s9RHWkWKMFTwsRS1e7it0DnFRqIh7szjnAAG+vclJMLugWMTK07TSjYBSWsiwHunx8K3rQWXd+BjtQ4I991vhueSCJENFC/ccl8573cQIk+OxCIFpnxDSkEwBGdQ/c3LtxuXvmyArkCMNmBFs1H/pDHIAQucmxUxLOP+q+OvjM+vf66Dr2h70Ew9M1plZwiyF/SCRe33+y+1nlNeOnJ1+Sh98bn74vkOS3KyzlgJsggydeBszFXxG8iDjvqz4BaCDNVqCUBOpeFNHwzdOyTFOb/qSaN9whRpv4hVfAi5HpyTfBhJNiW1wBdAHAOEvruqNUCXl/A7uHGzp/YwQ6aPW/doVKvNf4ONfF2kNTJ10XnBqHIPPDKVboL2VHm6XzWHgxVEGrL/2F1EexHgAZMLmOPKWwCkFfSMNXhZkMhdaC/BBPk5U9GsSleQ015V5ybaX/7rM3OSw69i2h6FhM2x/9L4JhitRueIhMj1YU1pIq+L9bMEIZyRoyF6BB0Q69RU+8kfsHD20JTeKQQZbu8UxQEZ/I5Z0NGpEHx7iFx894qZ0QL7bYQilozp6h18uoG2r1vGVf7JbidhOK8R6ss6xfcjHpDe/mxhb1HhsDWy+eo0zgEXbkSZWQ+BpJZCJQy018+et3U4puKa0PhFBkm60FrL3wQQq8l1Bl4gfkA3LRPTz+AZT2+kBRgU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WH1h6WTJ/hDKScRRURShqjPumT6DyasfPhMWLM6r8nBlMeZI1ejgDVZ9JFIR?=
 =?us-ascii?Q?y/LHuMyj4pFFNd/hsrBpJ4+Vp4VPrkzFAITue+S1NpN2PonhsMHf5SQbgyvB?=
 =?us-ascii?Q?FdYFTfdJm9njRwbv7Nsx744xtfDVrDiNUd3LOYT7HB4pAgIhGunslPUXtwwn?=
 =?us-ascii?Q?Tqs1+ymOQCKaPEb07+5sIojjJM9rmsEDCH0k33OcrzDBag7kesoQPeIBNkhT?=
 =?us-ascii?Q?onqzYXpaRZjrE86HIQPhSQulyhIVuz2n0qWkNnU9MvfYbU8WhDN1XFQ1MTlK?=
 =?us-ascii?Q?pN1qSgFZ1fJjZ+wUxwdWs21i91M5U/DfJ/3pDEOgpb/jSa12wOP1Dmw2AtpB?=
 =?us-ascii?Q?2ixyWt7NMVRUe04T7wsVQ7xsLrHulp6WWumIjEwNNX0+QCA1m3m+0xvHeR9O?=
 =?us-ascii?Q?Bpq9tCktkHLJ/seZal++BHvLgBuwmNA0K7v0JxxB8qRgKynNBMIVt2k1tMaZ?=
 =?us-ascii?Q?m7FhJjva2F5LQ4zLiEK9HZrSQwb8bS2Duj9ekInbEWwZAbe6YKV5h2yMQrmh?=
 =?us-ascii?Q?on8zftXGGNo3IzMo0aq+TB0Bi5/C+70H2eGWtssA0Iswu0tV1VpDlcxuXkWp?=
 =?us-ascii?Q?nn72qZXDdUmAt/af90bjaGMaS2aU+x3aCtpNI+PrWQSF47urO3AW9nHRmi3s?=
 =?us-ascii?Q?+Z6gRb2BF7KLKrHko5FUS4yvvCEQqO2Y0qNVjpG2Cfp5I9AzmwUzimDCJyYh?=
 =?us-ascii?Q?G8sRQeKZz4szc+R1A8A4NfkzkJvvNp+Opn48VS/u3Foi4GW2eqR8LL494JAZ?=
 =?us-ascii?Q?HXwry+faYyxvZQdrNXyOamwcZSIqaKSEZG3Q4CiN/k29GnlShfWpyci3KppW?=
 =?us-ascii?Q?6j+76CpU4PKOk9Z5pUXisCbKtkCFauY+OIkg1yjXPqviMdavjbUY11s0jLxc?=
 =?us-ascii?Q?OWyoq4i3KMu9U+VUZFP1P5dd2CXpXOewk0+p6VycG1PaQs6Lye49qewCfoP0?=
 =?us-ascii?Q?MTcWxbsblNpLasQxEqc8rzrAl96baIJZvVT9aMHqJwAqJ5/7ILWB3DsWVlBP?=
 =?us-ascii?Q?UALKpabBya01fR6Q/tgWtZoZ92KTHX/YBGgEvP8d2mQoWPT83rEabHsPjrBX?=
 =?us-ascii?Q?2sXQD5ljsO0aBUvdqvCoWMvv0xBa0pfcIHPrb7SAUfK6e5aHOHmcQ2oznuNJ?=
 =?us-ascii?Q?ckeC2bGolBYz1EF6jvRIHrrnljXjHvd2s309f8mw3I9BH5ICBP/T+cXJFgJf?=
 =?us-ascii?Q?rCEPKPaTCGk138B6zqpJBboivQeIA4SvaYV2KfuJCztOA5jjztnVUZX+HBtg?=
 =?us-ascii?Q?A7qQpx6yXY4hQ3TdHY6yskaXl55wquMmhplFi+IkzqXrx5FfqRPmPR4ZF29c?=
 =?us-ascii?Q?od5z0ccdrvbv4D3qrp24se1PD7UTR78Izq7Jid/vv4LM6lDIlVcn5rpb5/Nj?=
 =?us-ascii?Q?+TSXLYV0FE4TYs543RdsXqQpx2R4PC5waeH1GRLJL3Nb8qHGD6LlaeEU5P9T?=
 =?us-ascii?Q?aqqY2LO4x4zPfkRAu4ylpAKfR4YIfYfzrXgQn53fXjvg72RC8oxF6mQ36ef6?=
 =?us-ascii?Q?uTaleOVgrV0xeZddfYa5Zn4yo0GIw/suM3TcbEXaHSqD+k3bTLbYAx3R9pUy?=
 =?us-ascii?Q?xZSUSM5qlGMca5PN9lJUjswyCYB26tBzE+xcA7GA9c0CqjUBosdn/UUBb0Kk?=
 =?us-ascii?Q?0kcHltcpSExWjawgwF+07XD5paReFPvC0vPRkll1sNK/6nAnjYanX40+iebw?=
 =?us-ascii?Q?pA2753/XGqPc7mM8Ab4334eYl3pEYOtg1nnI75bigK2tF0H9wYE2WX4JCmcl?=
 =?us-ascii?Q?2Xe+BdeEAtFr7N+7RtqimrwpwsLhe3E=3D?=
X-Exchange-RoutingPolicyChecked:
	WLyqB7mQAxRtxZpyYLkK2Ol3e7ZyaN3sxZB9/SyIilW/Tu+o6XGxp4HavWjA1YYUSEuekjqaL0N/WxbadORCS1osv3FT6vYXF/YhKkk8FWYIithDLOjqvgAOKAR5yloK9tFCGLdd8FU5NtCgeYqcrd1CeXTJFojLsF96b3sLe8bebl9+qKFACwQawGNWNJoDnoVHiCFC5qF4dKJiGu1YJsb/PZ6+xaGhf36+iiKYuWo5afpvufwrtyunxnTMiU+c+Tfog2QY2POKnp9n6sC83+CVS1ukQOr8T53BGXSyNl2kr+QESsvABthE+Alnwnpcj98yJ5EupWxR7K0yVofVqw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	atFY3jYCUo3gxnpQB3sov+tOkY5l6BpnDLftzpkAr/SWtdTKZs4UjOUaj606IXH87vYknnXHm6nq247izuwHNVnjvZ7EyxRjdeXaBOPDBFeXq1JDpkggrGFtPYwQ5EcYrG6tS2qcboLzyMoCpoJFgURJhty/dB+V612I2aVVLKKGkSRr/2/ieFVd3ls5veEeBBYjNXM8puWIZ4+catHS7ITBGlU08XQLE3/0QIH1C3GUlmYbQEJ/U3lDv4bInDgEY2hEAUC935OK9rm5xo27ov+mj5PSWLLziVbvJGG6jDaKkJCcpaBxNiomKUAUUNn29xEXM7tei98S/tvmZz2mwOmwMfPJvmHyPLG90sR3Zfl52chqLAN27DyHZF9q7fP46yfPOSyk8u4ZMLMQPPTekkyinmHgVof89Xd15KzagYDuInL2o0mHr/w9hI/AykPbAB7xaqSzB/jRX9GJfCBY4Gkng7H1JExc8W9RX9MS7dZbmwt5UsSo2gvIGwl/yJiNJp7EwbdnNhenyY77hnDYkHckupO3Om+zQY6cGJTMeN0J8MNSOFyOsQA4mKWNiWdo3bABxxH/xYdz+8BcGVadOMQtrz/nQJplzDJzJIT168w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9be1839-3821-4ff9-e713-08de82fc8b0d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 01:37:11.0952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGsZG3WP3yNWPFtQWs9+2ZTtT+XMgGaCN0ZV9src3CJQxhjD7HVnSGzqKnkvmqVSEtgBPoafAjzNPTuR5PP1Q+DwToO5t+NO5aHI6bLrXeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603160010
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAxMSBTYWx0ZWRfX7vNsQAx463W+
 3l3u42SMvgghRBFJso4zxmnjBnOZv5enKlHo5C2qvI+OZgOF4kQPc5iboDNy7uQJIxQbcSBY5/l
 xHlfVgFhdN3pATCKzDcVFW+d4zMcfxd9wzkqSJzyFHpITBllFLDpo5YDoP0zXP/q1lo1HX94vbk
 0ZMNHvwEKIwahyXr1k1Qz+JTRutoJpDDkGnHKqQA9jLwI+y+jHppe7tIcmVGOcq8W0RQID6liXw
 FQHONNYTXBMN9by5ku8gucRGqqdjlC+QCl8KExaKSMiYaPtR/4a+rSFUlzPGhm1J4VqKUiKmHdL
 D4aX+W6PSs658lX071ZmNsZbDUOeKqbKGYwkm7iflHgaAW7Ia5HLqvq2LIOCSdhToug1y+X97Z4
 PbcSQHmpXlcgH2veXDl3TV4KCQQk4MiPZ+eJZDaUdj1khuNPfdcAsRZyfL52WpSL4iHQpyTbMHP
 ZzBoS+aU7PbAgcj4zqA==
X-Authority-Analysis: v=2.4 cv=J8WnLQnS c=1 sm=1 tr=0 ts=69b75ecc cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=LKnZA62imwlViN-40TMA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: xai_2jKbTuXxz2vQRKRVbfeQtQyASuol
X-Proofpoint-ORIG-GUID: xai_2jKbTuXxz2vQRKRVbfeQtQyASuol

Add the atomic long wrappers for the cond-load timeout interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/atomic/atomic-long.h | 18 +++++++++++-------
 scripts/atomic/gen-atomic-long.sh  | 16 ++++++++++------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index 6a4e47d2db35..553b6b0e0258 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -11,14 +11,18 @@
 
 #ifdef CONFIG_64BIT
 typedef atomic64_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
-#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire		atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic64_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic64_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic64_cond_read_relaxed_timeout
 #else
 typedef atomic_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
-#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire		atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic_cond_read_relaxed_timeout
 #endif
 
 /**
@@ -1809,4 +1813,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_LONG_H */
-// 4b882bf19018602c10816c52f8b4ae280adc887b
+// 79c1f4acb5774376ceed559843d5d9ed1348df99
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
index 9826be3ba986..874643dc74bd 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -79,14 +79,18 @@ cat << EOF
 
 #ifdef CONFIG_64BIT
 typedef atomic64_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
-#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire		atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic64_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic64_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic64_cond_read_relaxed_timeout
 #else
 typedef atomic_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
-#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire		atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic_cond_read_relaxed_timeout
 #endif
 
 EOF
-- 
2.31.1

