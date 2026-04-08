Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F83806DA;
	Wed,  8 Apr 2026 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651258; cv=fail; b=CgRy15tHhSMOEC2Pf+WevtcPZFxEaJQrGlaWmH7ThZd6J1qJCk8LYyR9VxmYNI66v8SyRXuf00I1OBHkgY3LQqUQTLVyAHBegNbyCcy8xcIDDd4Px/pM29UpO7+TpVnDPuxl7Tb0jogJpx1feUkZNnr82MGIyzjllf00hJK9Y0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651258; c=relaxed/simple;
	bh=8dG4wS8IlRQPAQsGk05r56CV1kpHBr0zVYXB8v6oJTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L8BT+5sWOmUP2xXA6nNkhk69uZtajzBzsyvnUdnjGJ8gq1532IU/RAMQ9/AtlA7kyJZGwbB73xcAvx406DaBt5ppMMp9PdkB6fcVWq5++K3QlpnoZ0dcolUFqUouHbVqK0gke8uRPVBlmmKJmTuiNJ6tSjU/X5hS88VcwUqwJ1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ctMtvSwq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aadBpxDb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ctMtvSwq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aadBpxDb"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638Aovbi2719080;
	Wed, 8 Apr 2026 12:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Jv5eACUEK6cT0sLPxVCS9b1EbxvU55GTImTUklK2Pxw=; b=
	ctMtvSwqDjLpVMmK1JXxEp8gkRpSyt8RoBZYyYU97XSCRXt/65OJtk0kKnmR0dTR
	ILGKurnzwuKelFxETv3PBv+taEavlntBzwEt9y+y+5coioECIdpf0FHs0ITsdnUR
	TQQAA3oAfqK86ca3SIrOhLq9bPm3rtHeCzk5FEwB5dQaq1q7X96xxjTuQJe1bBjy
	H7o1iAKTRcZuXzPUBHF+0Dv1Kj2AwgrbVEWwjj6d5xcpirWdYifN0ie+cOmd2XI2
	jtRmyvTg5ncZfeGPMxK/CLXc5z7wr4forDa32xQPN9lBTSzFQRQljYZ+AjBcECqH
	TtTINZm8EDE99QoO63nfYw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqaudkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:27:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638AO3vU006969;
	Wed, 8 Apr 2026 12:27:10 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011064.outbound.protection.outlook.com [40.93.194.64])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmejqnnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:27:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h39R6AsHg1My3qhVBxZWit3VJZKIR9it2H2DsldKIPLtah3j0Ybe/Jc3MuLKXmhwfZTtERpdbAmbJkeHpuMACrN6vfh9c0ho1YUa9D4T3aemoL+qiAhsNNHqP00x6SPmM1Shebo8WYicyjUxmEkXjBALddEycFF1l7ZklGe9R68ZInAqWZAw9lGMN03rWyBI2Nr59hh6px301ySzlHzd0MfY7a1YMpnQ6ZMiRHYyprhAed6XE86Fx4s8McnsBn0KQo/MNp2LRCQEPE6Qf1gCkm5X7mSfUhFYGaBiT8aB7HiBfWMjTwum2KdKqKb4SJlBczUVUvrH16yl4Ni1Q5+YIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jv5eACUEK6cT0sLPxVCS9b1EbxvU55GTImTUklK2Pxw=;
 b=DFawSgmCYCfVSVNlvh+ipyFQ3NIP3iODynlXH0nG2l1Sav4bRQ4Lheo0YLd4dXMdbMuJ4nRKNURQKFujkWQCe6nmcx8kHCr/pwZL8kDftMvErgPbh/o+huoklCVAPpcvSKlm7ESfXIWol6slrPofOaL0r7QA/DGlTwc3fWnJEe0mamsyYATSBWhsNHT+kz+syn3veBGWysF4XEsltSn/eK8ELHqBoE8+a0gljJ+oREUmwlWBWG932FV7oUYocx5OZwzB+zbBJeqQqzd9bKcE2//jQdngVx5Z3lo5fpX81rhjn2VbEQOSFCEW4p6f/Af3r9sE0xaUkEoNiQTMBtwv8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jv5eACUEK6cT0sLPxVCS9b1EbxvU55GTImTUklK2Pxw=;
 b=aadBpxDb+BhW7d3Q2yV690qmoJqZxlh9zrynV/tsZPw+n4fxLMVEt4XMu7I4tqSyX96FE58XLyrK1vtnCMcfpcf1uHYtQwvWNHqJLpYUqHh+fi8Ip2AQjnfqyWYih6elw8cA2AZHaekjiAqaDx0gdlCNMBS9HZI9Q4aF+Ims02Y=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN4PR10MB5574.namprd10.prod.outlook.com (2603:10b6:806:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 12:27:02 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9745.034; Wed, 8 Apr 2026
 12:27:02 +0000
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
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v11 13/14] kunit: enable testing smp_cond_load_relaxed_timeout()
Date: Wed,  8 Apr 2026 17:55:37 +0530
Message-Id: <20260408122538.3610871-14-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN4PR10MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: 4945b781-94f5-41e4-12d9-08de956a22fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	A2DEj9jAi0tMLdTnZB26f8cJiInfuuKEw+KLtdjgnCplUhFLbaCotySz1QTHMwyGRapBRWpmEOo8k5+CblDquaA4bLajA1TsBbNXzTE85/xf5EBK1zywGkmrH9hT8RnDjVCWz6aEMA1fAAT/02+LHnW272g3PGjqUP1r+FTICfvOJ2HmtjG4pAymf4iD/cttQsSA3AbsD/CBj3yt7mH87i3qBfGc2iTCviXRK67DixfgcjK5cGkJAPsx3fbZDJlm8LtAyirnC20+7FYazyJPvmQXtHqizY5gDQSfrpTi6ymiZczIEaW5SpqCHWIW864IdQ9uL/BcQzUZH3ivo1wX0Sa6R7uRb1lcOC71hk2Hp8IHJCpRrPvMle1AvsRT6KBpvkARtl71peIn1Ibzp00E+a0zq1JQ4ywmWdPPm6PkyEJ1FPO+EAY1WwC/KvoI28g3kEhWU6RfHKpQXaNEKEvSEEXuWM4B6IkpouA1VjQuvnTvmRmjulA7CInEVsLZ/sozP7g+OMmVF89+lGSe60ODrd/9Ow882VFmUniRaGngCms3XV2tf4zdBB0zHIUs0KM+9DbU5XMIJm5wAVsL3osKd0htgXghAsQnbe0S+cJ2RIGwP7uJ/Iq4ezDJ8sAfgy3KNFISRSLhWrzto/gVOWGIFPO6UvYXfyZTS2mtT+9YkT3qyVFx6Wn2avEM6UHVNDlGZ65/TVYg8TTn7+fOZn8dBWo1ppUi+p0A8m8woMyhVe8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6lAi632n5fsMaQmW5xqCNaQOf2lMycfNDsT5SVrnrezQshQYgAITwzTExLjn?=
 =?us-ascii?Q?nNbBmDj5N1MA+4AU9zM3rf5GT7PccrjRwykD8MQPzfBV45xXaxq/izgjBc4l?=
 =?us-ascii?Q?3mWquEWbO/s6hrQcALwJF03e0srFqQ7FzJzhlQojHQUSvDBVXLJ46vc3mdRr?=
 =?us-ascii?Q?AqndzZrBmJlA27gN5fDX+YmFJP+3zt80uIDB1MwY/KuB9UX/BCsknWiIwH77?=
 =?us-ascii?Q?BdtqmCRV6Hr5y+goGbVBYyWOX6XCskfYvzaaSwRnDVD2AMEmqWQzEhCnN0q1?=
 =?us-ascii?Q?TYKq+v7r3m2Yuiosvs9oXDnWlbD2M/62K5lMvy6O1PvddRuF+ZqqhvEmDxGY?=
 =?us-ascii?Q?SHq5Hd3FPsUFqZU+/sPObfQ6IBVcsCAALL5XNZfnlqTjEvW2s2G27662LHiy?=
 =?us-ascii?Q?zTw/JbIGlQ84omkHUCX5zcqZ9wqCzODlTqQVpViE5tcQOwI9AIoY3FbCqc/e?=
 =?us-ascii?Q?cmwbvkGRMNTUNdgLcr6n9s0dl0jCR6jTKQIaNJBjsP34AfKyHV+ZkBK6ixvo?=
 =?us-ascii?Q?WBjeWOwXiB62TmJsdgH6LxqgVeGKlgBGxpuM6efH9r/05xWRnGQP3ZBIx5zN?=
 =?us-ascii?Q?opRufh/d0KPjcs9bX48gUmrvadfApL+PuqOTxqRjcMKD7Z/K613UVdhF386K?=
 =?us-ascii?Q?MjFuoXKAiBoW9ha0SOQZ7TU5UKS+t4i5OBfokW5oW1+sCB5J2ObuybGji5jV?=
 =?us-ascii?Q?nAvTO3Hn5JNtUrg4bZTVSjmUILnrsjEBSB6JbJf4GmyA1Y5GlaIgCxM4K9RU?=
 =?us-ascii?Q?CspjzJW7Q8a/emni/HDSapbrXg0/c5wsRBfw9fNbDv2Jz7SWfpxblbnWOtI2?=
 =?us-ascii?Q?2TzAnHeWHh/O8Ink6XDF1922rL8xJtQRwChvVAQ7Mb8i0KfvBOFFuc41n1G4?=
 =?us-ascii?Q?Qq3eDdMOuTtOOtwBW+5K1m1W80yjhW+UdZEgSHYGfNkjN+6Cn0P5MsPutNgi?=
 =?us-ascii?Q?nJ7WSsAAsWGyxPyLUAB5PShV+xz9hh6Hv+7xSTjab95Vx8uzuNq8sJTyH5Or?=
 =?us-ascii?Q?E88jSdSC1w7jRzYMCKOXqVMnN79OM84cGJS7MjKTwZ7qNZt8yHaasEQSGzjY?=
 =?us-ascii?Q?5Mm/rC0NpEsC7Zxe6+SA6254mog8oK6x49jv7S7BSq3OGznkj7i/8jYAz231?=
 =?us-ascii?Q?sEoHHIibRNpKxFrArIv9Bd9JQd97qkLh6OKz+02ZN3erz5TC62F2OdkIi/l1?=
 =?us-ascii?Q?92J1zCYWG5bQ1OtdZ4sedP5OspN63FUp4mnVmVde3UqNZT2jUrjnIQ/HfI96?=
 =?us-ascii?Q?ZzngaAktG6kT+0gIpEPdQg8dWcgRVJskdFAdDhqaZ3h5JZQ3uD57e4yOzvtL?=
 =?us-ascii?Q?HHkvecO0uzlkVlqDTXLQXGp8W30OCPeFMtQOR4npz1WHMtncpTAwolNPIxjm?=
 =?us-ascii?Q?q+gxPqLKQLmh94QrQOR4uIrQI9OS3qKPkU0YF6ZLwiOYFHNBselte/RYA0Z5?=
 =?us-ascii?Q?YfJ9xf/RhzRdSLH3aqoJQ9Tn6BYkE+PT/UfDOvvjjBoA0dWnudsmS+B4OSJ9?=
 =?us-ascii?Q?IGyCAlM3HmRkJNizZYKqC3qUaTcqGDIekef4DnG+Alq7wIQR3bGDCOyqWUQ3?=
 =?us-ascii?Q?Ap0nTXwPM58i3ONhJIFsqlz37YoYf9vS/ibfYylL+Bka7Ru042D5fUr0nkrT?=
 =?us-ascii?Q?KlgM9G0qGHf9K5OP1lTu1W8cixNs+MUMD7B2l27KFY2IgPQru3Fzx1jm9/3v?=
 =?us-ascii?Q?AwsXVEWQh7u3JsItiAJdW4GY9+jZT8KevhHAE0pNjSg4WEXaY/PbuOIg3q5m?=
 =?us-ascii?Q?d7p70h17cOEUwZH5LF+oOHbA4MtDtIxxY2MOnlAx7TezUWH3bPwNzbvLi9AS?=
X-MS-Exchange-AntiSpam-MessageData-1: WTqHDSffD/MxP12gaagYxMnmLPMnonicTWY=
X-Exchange-RoutingPolicyChecked:
	GFQdCamHqZ0LREZdIjYdFBkX9oIdmETfHvo5t+1P6yraaWNPzbV8Pzy65T45UxGB56YFSEAiTm4N/1H8nx1kFgBiEDiKiyp/RQleuQgU8PiWqklFyi5eav6hbsk5yrbWe+AZG6NBmBwLRlFCwnO5wFkRcjD+Mits4Xe4PsOKzpS+BobeJDxAUMBmUBPHpyuMXf15f6wedym6r1oCRB9DTjDnctWCk3iiLTYLcS9XrW6PTYCr4KRr/AbMPGt9jjEEQSqBUImC9RkpryADIbGoduPP/BPJJvhdGEoYtAZ+yFnbY9BsrhlSauDdokn0KbDSorJhLM/YgNakixuikL5v0g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lZiorEnbV+QOdUMqe2wVE697l79O1IKpNQlMSWNZgI5uX2RqBvwYYGpHaq6kh2e1vZn4X+2/GQ9P9t3FiGvWwL7bPUw3Xv4tdHBV+e0sHkgdKE2nmxBAX2A45dDcn6d/RDQPt1QsFkrmtUg9+5ObEEzLmS1bAmJpRE8nFsjt1haSduQnVPuwsNXMJxUDr4VWBAnpPVN/bPzVWFk+P6/PK+Xj/ppNCm558Ga3p72oGE2ZPI06eEJGGPafOEECjvAaCNAqN7lBjcdVNnVZXXl7ysI56fYT0JLvRlTNDJlFaAgHCQkQjft1U1xAat3zNiQDxH2AsrrE+SiJSUCdIHca20PmhsRVwC+MkfqhxGip0bh1BoOUgrfJHiDvKI+U/ni8dzqhljsmQNm3N/HB7m6yieeO498OUUGc5GudvH5NpM7AKxAvNNWbRAKMarosoHFPCclbX3xnoVyn8FxSC1heDap7zClqsYI6ls8FZ8pGIFfsy74TIQZ7S6MmrYa3IWWFOdkVMtwx7KsJ5uv4kZpfibctOuYA3aKDSsA5mGPe0U2ZXtYDYUigzEQcsmS6tJnUBb6Jr4Df/o5xo6VdeN7p93416wGjp0lF53CQotZNxtI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4945b781-94f5-41e4-12d9-08de956a22fe
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:27:02.3056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dg/KAmM92TJijGBAgIMNd7Yx8qNbOChw9mOwobA0wuH+yvM+A29R8W1m1kASkqyQHU0xByf4sH51lDuNsSK6yCOhqBjyeFAei4xRQNJKrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080115
X-Proofpoint-ORIG-GUID: spyLMEPrEnrGOSnJEdGJ5JOfFV5ILG5F
X-Proofpoint-GUID: spyLMEPrEnrGOSnJEdGJ5JOfFV5ILG5F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExNSBTYWx0ZWRfXwIcQuRDi+Mql
 d9y5kzAMAkI7LwuUNFJBydAJBjd2G7JWGrNZfqE+Q2qRLv1KTCVMk0FRlCL4slU/GsF1kzYkEvj
 T5GAdVxh0QHiAj6qSh8WJAhgU0tgLfZiQKES6m2t2jn3QQDhis1TEjSFx3F3HShSXWgGle14oLY
 bzbV+nbuAJR1fowva+Jx3pRbTYQiCG6tHtwiAHcQrT/uXKZO1xUcar5DdBINR8zgVnBS9cQQ+hU
 wJ5CRQqTrP31PoG61Iy/H4Ou1XCBoacw25oizg/iZSs2CPgssaqw00pP43zLhTuyMZmhCS0pctO
 hyvexSk1Iw5BBC2DdvMXu82Bm5C0vl4x491lys4cQg7v358RkOJNOLS0cXLD29P97SfHLkArw81
 fvBk24u9zwgHPmqU1LLVFP5X6K0eJUJubovTLLjP8o30+JvfAKqFCsbnOdlvhPm8Q87mOjDsT7L
 iNb3CejLYmgPfrdbEtF/OANXBOshNt1e81pIx5uE=
X-Authority-Analysis: v=2.4 cv=NZXWEWD4 c=1 sm=1 tr=0 ts=69d6499f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=bb9Fw_vXVJAL2FTmegcA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:13825

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
index 90aeff44a276..1de63e1a2cd2 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -28,6 +28,7 @@
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/ptp_kvm.h>
+#include <kunit/visibility.h>
 
 #include <asm/arch_timer.h>
 #include <asm/virt.h>
@@ -896,6 +897,7 @@ bool arch_timer_evtstrm_available(void)
 	 */
 	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
 }
+EXPORT_SYMBOL_IF_KUNIT(arch_timer_evtstrm_available);
 
 static struct arch_timer_kvm_info arch_timer_kvm_info;
 
-- 
2.31.1

