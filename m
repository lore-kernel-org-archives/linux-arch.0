Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E9537AA83;
	Mon, 20 Apr 2026 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707448; cv=fail; b=QVFnwtOLKELwBd2FJlj5JQyUlbNgnl2+mwCZI+FpIf/mJaYtxMLlnpXgPCnVsqGlgATD285lAWPSuElFFrBRKTGdFH+QWCfDJ/fplCIqaKWz8IeyEgUKPbeU2Rtrk7RbjJiZRmfo8H+x9zdpki2s0SIQB22vheDdZyP4gFnNgk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707448; c=relaxed/simple;
	bh=4xxek5r2ZeHM2RKSlieU7dGPoQieRvyFsMgAbdMOrV4=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=rQk2zJeFVPDEO4WR3pXeOyxjsHMz9k9hySWIDoJs6FhWfwmZVH7rVAf3xzY2mRIFxcR4ZFyihagf0Yhb4pMkxPp+fG2mjsmEQ4tIo3cBitEItt1HuvJ/c8N9pjic+0brAih1fKXfL6Wv7t00UAt/KAT4Hy4fPiUCeNqQcNEsj9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qihapAjy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yBpFWXFT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qihapAjy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yBpFWXFT"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K8QOXo4115877;
	Mon, 20 Apr 2026 17:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6DokXHkmeMhe+itenk
	5MVEhtcIYl4FtHXWlz4sF3Uxo=; b=qihapAjyKvg/G07jziwN58LtJ/0b6tOnIA
	WiXPJtsqnMU9Idn8IztFDABQoe3SM8NqPTYdC6HdLBlZfJx90b6/vowcAfk/yyT/
	wkD+Z89QmIYrckJKctatXL10xDM91E8KfT565ydo/FRvh9hNnPJsb2cg2VTFjGkq
	qeyVWpetbKWugHloXEBK9fNc9ms22e5awIi+uq/qa5Hbp3p4jT1E/mxM5po586X+
	liI4Zf2L1whTh02UklPZwlotveX8DP/XENw8VDKaQ/G6cXSyl87YzbEakIp+uDhJ
	NJY3IsMdX1///enYyi+gfdLR9yWW8we3DipUd+MSJv7oIaSrds7Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dm27vurb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 17:50:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63KHkGeR014348;
	Mon, 20 Apr 2026 17:50:14 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dn1aeyvju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 17:50:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNr1eX5xdmM+7X9TxoMVFuQMYvJLjZGLzx1yd/Hv5nWELaJXl+N7e7+OYIoCCK0nFGH+Fl4cNndJwC9+2vcX+z3b5DqXHvn0FuPX7TJ43FaHXYb9RVgDbH/sKlBZJvjsLSEn/eNPlrnig+1m735643N7X7YuLRgp3vPXzkqGo1ECl60Cpr769PTzKWHEegbFeXvP/CacOHdf8mjovvU7L/eG59Smi5EsYz0aY4NSFvUulQwIVRqlY6RPR3MeB967KIZEcj6iSiyxFflylDm4VGyg3vHnJ8oVlXQv8RuKCLVT7AO3wEtO/F7mty6shEnejsvRtzZyQ3rm6YroYOdGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DokXHkmeMhe+itenk5MVEhtcIYl4FtHXWlz4sF3Uxo=;
 b=faP/QX+WlIHTIrzxMHspOdjrLKVJ5x6nAI8MVlCGKZgWqRugFtgXWDOisYxRZghoPeuS1fnRCM0mXHOFGdwWzakfi+cEi1ltZXkeCn6ZkOdsHnfHOXuV/lcVi5wQc24+JgWG6ynvCPnIUm7MuO3O81WIqBgu61jTmeGODMROgRD18s7P36JDYkuCsjL+qIDIgcot2ARKuq/gO3SYNB5YCPijlcltxaFjdU2CeBHyRK0+EUsISCt8ccUbl/cC0M4cZwdpTiC8g0DLIv6EWW3IBEWVDI9bn2YywY4YYwKPGQX5EQYL54ligO4TZJBDH0t9bnQ9BhhMg1qIXv49leyBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DokXHkmeMhe+itenk5MVEhtcIYl4FtHXWlz4sF3Uxo=;
 b=yBpFWXFTykOkljWOc8ofR/4LSkmh5ezO4yBFfswV2v3ZUNwbIZdVKpfuyaC6lC9Ylk4KZ9dT2tw8FHr+WO4zdRFUQpWZqOV6fYhdOk1BDUdbGOMCC6P4aGoVVPfVSkgU6URI8YgM89YIBNKUSAc4AmT+kPS8g3FDZsLJo/Bb7Q4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA0PR10MB6746.namprd10.prod.outlook.com (2603:10b6:208:43e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 17:50:11 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9818.033; Mon, 20 Apr 2026
 17:50:11 +0000
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
 <20260408122538.3610871-13-ankur.a.arora@oracle.com>
 <a374b23f8b03f850a874d46bc78411fb99483ca2.camel@amazon.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: "Okanovic, Haris" <harisokn@amazon.com>
Cc: "ankur.a.arora@oracle.com" <ankur.a.arora@oracle.com>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
        "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
        "david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "memxor@gmail.com" <memxor@gmail.com>,
        "ashok.bhat@arm.com"
 <ashok.bhat@arm.com>,
        "zhenglifeng1@huawei.com" <zhenglifeng1@huawei.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "cl@gentwo.org"
 <cl@gentwo.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "ast@kernel.org"
 <ast@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de"
 <arnd@arndb.de>,
        "linux-arch@vger.kernel.org"
 <linux-arch@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "peterz@infradead.org"
 <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "rafael@kernel.org"
 <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v11 12/14] cpuidle/poll_state: Wait for need-resched via
 tif_need_resched_relaxed_wait()
In-reply-to: <a374b23f8b03f850a874d46bc78411fb99483ca2.camel@amazon.com>
Date: Mon, 20 Apr 2026 10:50:08 -0700
Message-ID: <87mryxh67j.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0399.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA0PR10MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: de5fa316-7510-4311-c81b-08de9f0544b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DrH4pgB9VgIUDxfTwJGH7sGG8zEKyogpEiPgW6/VT9zPPypBDaVv3WrkoDDFN7HDQPz0YoNPFCiNIuGLM4nv6hALZwmwV3did/rIbKEbLvvy5VB17G70xBci3t4uM1P6OItAD488k49g5n4jx+m1CiRTRWuAXMxmEPO3YoxBlzV+HMgWqdfmvbKp6d/pjyIdC3alTZnhlI4vxCHN/JheOeCPgoFXAp9a6gu4MmVTPnWF3hmTHlPO3x61NkVKIAmamRqV50NLeAOTZg/HoQa/3Lvp9albcUAOOU7rxZh/Ok9hX59C1MAo9wKb2YmdXpjMSn4i1IN/jaHHDFKXY6gDoSfFFeMAtCpvSBtRMIk0xyWS3ommA19RjE98YW1lcLydINLM+av0suGp28xSKoVLf1Tt5zJX02F/BgPsX6QHh6p/X0kAp2KxKpyu9eBQINLXng5m/VSJnXM8Hns+MNFO9BkEGZC2YVmSTOX46I6z0ZHbMa8ylwp+L3QmLuY87+LtyBMgGNgE+OyxYQHrJF+OHaJfrRHpvoRtt2lhr6gpuL21umM9p5YPddU6CFNJlvMk3GvfRBB5R8sRdSm0t//LEWwarj+LlZHdTT24teqOzsAIf3+1KyAzFnPMuHsu/Ffn0H+wepBLs+Hk46OKSmrbMx+J9Y+yOUuESN/1cRH6kfPMDp5dgC5yCwpbI5HE91gmZyXMx/sxhRSDl29QRwABPX4p+B3IOBKEaU15W2XhLlY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pwYd84bbJwye+h5iq8TMvzQ51istcuqYyx+pUjhcSyPHYTMRshgbH72Lu7GL?=
 =?us-ascii?Q?HGUkGeegxsf9fnNqLh3Myvi9Id9nU7cCkO04ze+/HekGxiXeTURE2UTXlkyv?=
 =?us-ascii?Q?pfxvAAabynZ9TX8qjfp7tqy+eTGu7o69PtttiphWaI70LpEFCioMOVFSqR61?=
 =?us-ascii?Q?iC7/n0IMdVgxw7ILIe848g8oioa59wwZFIYFAjk/LRHeynQ18F7QyTJaa2mU?=
 =?us-ascii?Q?fn+pxeQDIgeY7XMjL/J8xZHmqIe5/2T2ZTH+PcPjy7AAdm5+OUaWQKKob4vj?=
 =?us-ascii?Q?xpbEBf+OSxzUpjz9J4TTbu5XL3lmG5+T/V2Ro0Q1TQxmLU4wPkx0MW5fGSJA?=
 =?us-ascii?Q?/o+j3xoXyqvxu92rAhpyc4o/S0g0liOzDpOiV5HBZxVGB5NL6LCL9mSwPKI7?=
 =?us-ascii?Q?6KXVWmbH09S5YQnWXCRymK2S01MBgjHYmkYJk49cdgd+SxT8bQH+TKM1jAC2?=
 =?us-ascii?Q?ZWbArtVNlWsO/PLM7ZwH5ys/M9QQxOevDtXHSpQUIZxLSt9/mbGRo1SIoodZ?=
 =?us-ascii?Q?seHP+pEjB8UFFIfwbkxlqkMYAEF/3jhJ84SvVo16FshLtUODMk3adQVZI7t0?=
 =?us-ascii?Q?H3prrF9D6Ha+9ydqlMCGbYs2FJmkl4wI8eikbDJyzN9w4Zyq5HyjxEy55aOH?=
 =?us-ascii?Q?zQm9TVqgYox5kCzv96oAF3spIx9AJNhbWXjXnm30Z4Qok47d9Vmv7Ib27Gxn?=
 =?us-ascii?Q?PLk1oxP7e8ndIEPvCeHutEjDX4wSqhWQ/1iNNUe+g4iiBb0pG1aj+1qDdhqu?=
 =?us-ascii?Q?P1l+6Dc33e3weOUzMEStfjuv4ZVncIRfJbclIfBwRVSQL5DaZpKR+QO3AiZb?=
 =?us-ascii?Q?q8NtTkxQXwUwX2B72c8BCHKGyi7mJ+1Z55N8/vbxwtofthbeNuWv96+7y8ob?=
 =?us-ascii?Q?GnoqExDDNVv5RU4PCrMu5e3dIgM6OPwJCe1XbViuzkoyml74Jq7PVqMBDHYe?=
 =?us-ascii?Q?2MjXSBNj4ZuzgZ7pMTvucAqn+sSOPyqoDlfV+9Q6Y25k76GOBY4Epv5rGptK?=
 =?us-ascii?Q?kBBSJqGD3zpBznVwGcVIqIiaucPAKDq0qsPhwDhQbPvNoTP5NG3rbeAiyYxn?=
 =?us-ascii?Q?7lBXMoNUhPfVFuLxihPAqBoSgRgW0Je7CmBA4ZNrFrGG9cnvYPmpXHxmbpkN?=
 =?us-ascii?Q?oSuOLAt3YMrX+lMYZLsXFk0urLuoFQvyCug+oyPO/TVLCubKp7clAecdF49T?=
 =?us-ascii?Q?/sIxfllC/t1gQD9rcb06hsHe0OpxgKnIWDB2FiQo6zdf0xqoI3jyTwRPrD+r?=
 =?us-ascii?Q?7gZS/yWeyy4VCVJfg7TMNvysUNX7cFuZxUfPSGu+/EVhI+5squYMgGTCbfue?=
 =?us-ascii?Q?7PLmGQ8vHCtMeq0JXqIsFgGUV7WqF1+fe3k++QquFWe36rrHcPxq9yCl6vZC?=
 =?us-ascii?Q?9XD1w12cedF8VRKGIEOUZf4McWEe/XZ3UR7+5aj2UfS30D5jyK1OQhSDUngU?=
 =?us-ascii?Q?QclzFQLdLy7GTLf50G522UxfjjxAg8fkzTacJIuh0aoUkx/7dxbkBfHdVJIf?=
 =?us-ascii?Q?PrwRnN6mn1vzquxWuaxT5mtL29mxv6MPjVanut8d6MzYNpRA7nCwpxUZhXFV?=
 =?us-ascii?Q?VxcxARJidDlK9mSZqKkY4RpiYXslbXXbZXlP7Md9ZgoJE0rFQNRiOnP5Zqbt?=
 =?us-ascii?Q?SBse4TWx2sYNOZ3H+/5bQ5hcum24JgM5/JvPDuxpdGV6AbL/xgnACX9UYv0y?=
 =?us-ascii?Q?7cAppOwnugaDZeb9Lkw/vbUfAD9f3OZ8XOHkQAl0P3FHee5Vl1fWJFFwPOpQ?=
 =?us-ascii?Q?7tEQOel+9NlhQWpuw0nyunC6FLX5YSk=3D?=
X-Exchange-RoutingPolicyChecked:
	ReTjnFmsU3tn2qIVc3n+zHXHkMNSdC4QfkmviGy0k1MlqDZD7PZCFVNuGBRJkd5Wk9+Z9j+Z8Ey5rcBrBKktwqIDwxw0NVVuBY5VjPBjLcoHVDW0388PkQYWCdl5iAG4LKTcAJxR0gMy8KbUl11ow5u4mNgeaa86XKoziMaUwpXphlS7GIRkJ4nQGT1PiD85rmFRmLAK7975W9iober39O9s8G66O0GUjQ6KTiufWTm9B56Ahu0W0jA816UO/AvFO7ECY8+y0zQdHSRT9WqlBXRWJ33m44GDuLBXevZZfaCJZHfmBgq22QrDJfLqLBCy8L85VPT7rKo/7KV7HJWdcg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Sj3rdCNiE7ZT7JVy6DTzxXUquZMk7gwNxn+peQezfjb0VvCbQ+9/CNOJzRctjOoU4Xjirp+60gs118cTM0/R5TyM7Hl87T9QwV9Znm0O9duNQa3j0KYwPUF0zETBL6KmN4GA86447gMAtbmufZFF0Fz1jM4Psfh2dmuooDAXyi+0Yc6qG4ifA+xBzuhpSXk91kPoY5ljEPl1E3mK6mooYQP5CbaDDMNIb0d4bPzULlLzSGAX6cZUqGBuTvSYaBawM2tqeuoDkdekf9ytHRw1dwaRXsZ0BnJ1fFQJhdSiLxBP1HXntchldRfrj/K9jROZyqdAxqKfpka5/OiSKb1QDGcETvHxscPjTe3XcqXFYEsjKe+GmJ0MMxbUkAHzRYa354mPoeKSiSmmC4Jh4D7wQQMgjbfa6G0KWj2AXdyeOTrhWRJTXYVFVRDrBtH//y4DDaZ2ke+5gGAw73JCMR4LNLeuIkCy/K222CCZrs9tnZ1Gd1xaPeFE+kc0uvc4+/LU/zdCfq2nAz+DXRKB5FCIYSvr0MPId4zpSBkW85tnfrQRgeA4bhpZhoEtlOxybTi2jS2Thi56vpMiR+SEJMvhaeRMgR/DgGenYQuNLgezTC8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5fa316-7510-4311-c81b-08de9f0544b6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 17:50:11.1428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHn0dPRH4SrDa4LjNGJWim9b17sJxtDLWsVvO13zD4HVfzSHHo4Me46o8atoOPodGTmrNSZnMd0WgbzKAGB06KWtwsOZfngthd5IUH1oNHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6746
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604200172
X-Authority-Analysis: v=2.4 cv=JYCMa0KV c=1 sm=1 tr=0 ts=69e66757 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=vggBfdFIAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=yPCof4ZbAAAA:8 a=JYbUaWRF6CIYmkw5t-8A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ifoEyjSHvigigX-Qp3x3BJ0lZp5qAxv5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE3MSBTYWx0ZWRfX4z/Ls8GbDv9S
 uYj6UuEx/XLJHscKWw5d6JkZVOzvoG/JiEIwfMURqhv1lJat+eMOjLwD+Lh2AI51S+6Ct184ExW
 rU7d7V1Qz9vx80Uu7QdkpAYcslIGf25Dzl7s9PxEhVBiORFX19Bz1yVfd7C3XEMCGl9no8MGVSb
 PsVL1/hvHgOdQF/4ee8TubJ+SIKKU52rn2A2jOjy0R8oLEntcWqkO0MNhgjM3N8g/sA6985s2Rb
 XNrAShYqHaoDYAnZbFRiVVWCQjGzZPIutwGKYKHmLm84qwjGKrrw/3q7vPOe+cHjltdMsH3Xk//
 r1Qp54wL7zRZ+D4mERHByj/+R22Bkt+4dkL7k20SoPQj/0d10BwiOui+qwTF830csBBEwhM6uCE
 F/g5n7TU/WcmbMj4sRPVBd17p8sqEBUmGnL8hwfllKr+PjpV3TVkW+zKoob5GpA/AZJvUa0PWlz
 MPlNAbCs7REVLt7KkLA==
X-Proofpoint-GUID: ifoEyjSHvigigX-Qp3x3BJ0lZp5qAxv5


Okanovic, Haris <harisokn@amazon.com> writes:

> On Wed, 2026-04-08 at 17:55 +0530, Ankur Arora wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>
>>
>>
>> The inner loop in poll_idle() polls over the thread_info flags,
>> waiting to see if the thread has TIF_NEED_RESCHED set. The loop
>> exits once the condition is met, or if the poll time limit has
>> been exceeded.
>>
>> To minimize the number of instructions executed in each iteration,
>> the time check is rate-limited. In addition, each loop iteration
>> executes cpu_relax() which on certain platforms provides a hint to
>> the pipeline that the loop busy-waits, allowing the processor to
>> reduce power consumption.
>>
>> Switch over to tif_need_resched_relaxed_wait() instead, since that
>> provides exactly that.
>>
>> However, since we want to minimize power consumption in idle, building
>> of cpuidle/poll_state.c continues to depend on CONFIG_ARCH_HAS_CPU_RELAX
>> as that serves as an indicator that the platform supports an optimized
>> version of tif_need_resched_relaxed_wait() (via
>> smp_cond_load_acquire_timeout()).
>>
>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: linux-pm@vger.kernel.org
>> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
>> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  drivers/cpuidle/poll_state.c | 21 +--------------------
>>  1 file changed, 1 insertion(+), 20 deletions(-)
>>
>> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
>> index c7524e4c522a..7443b3e971ba 100644
>> --- a/drivers/cpuidle/poll_state.c
>> +++ b/drivers/cpuidle/poll_state.c
>> @@ -6,41 +6,22 @@
>>  #include <linux/cpuidle.h>
>>  #include <linux/export.h>
>>  #include <linux/irqflags.h>
>> -#include <linux/sched.h>
>> -#include <linux/sched/clock.h>
>>  #include <linux/sched/idle.h>
>>  #include <linux/sprintf.h>
>>  #include <linux/types.h>
>>
>> -#define POLL_IDLE_RELAX_COUNT  200
>> -
>>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>>                                struct cpuidle_driver *drv, int index)
>>  {
>> -       u64 time_start;
>> -
>> -       time_start = local_clock_noinstr();
>> -
>>         dev->poll_time_limit = false;
>>
>>         raw_local_irq_enable();
>>         if (!current_set_polling_and_test()) {
>> -               unsigned int loop_count = 0;
>>                 u64 limit;
>>
>>                 limit = cpuidle_poll_time(drv, dev);
>>
>> -               while (!need_resched()) {
>> -                       cpu_relax();
>> -                       if (loop_count++ < POLL_IDLE_RELAX_COUNT)
>> -                               continue;
>> -
>> -                       loop_count = 0;
>> -                       if (local_clock_noinstr() - time_start > limit) {
>> -                               dev->poll_time_limit = true;
>> -                               break;
>> -                       }
>> -               }
>> +               dev->poll_time_limit = !tif_need_resched_relaxed_wait(limit);
>>         }
>>         raw_local_irq_disable();
>>
>> --
>> 2.31.1
>>
>
> Hi Ankur,
>
> Tested atop latest mainline d60bc1401 with the rest of your haltpoll
> changes from separate thread:
> ~10% improvement in `perf sched bench pipe` micro and ~4-6% throughput
> improvements in mysql,
> postgresql, cassandra, and memcached in under-loaded configurations.
> Tested on AWS Graviton3 and
> Graviton4, ARM Neoverse V1 and V2 cores respectively.
>
> I hope this series can merge soon. It's been stuck in review for more
> than 2 years.
>
> Tested-by: Haris Okanovic <harisokn@amazon.com>

Thanks Haris. Yeah, I don't think there are any open issues left on
this.

--
ankur
