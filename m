Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D334C139;
	Wed,  6 May 2026 20:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100892; cv=fail; b=qqq5NDHpb+4CKnWjxmapf8cs1Fe4/ZyufXIJ17U4B5WfZrDrzCKp7XBHI2iMsGsPEei+4+n1rHafHjpoXwZgAvFdcbvxbUOrJYrm+7muVQpMbCCF5bPTvEenLe2MY8RE8J5mltDsWbgjXPQ1f1GIxTlzF/gzZpYxlPz6hh+v94s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100892; c=relaxed/simple;
	bh=XIrTgptfojjFgPSWH/5fKbF6Q3pqXULl85osBoRojfA=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=jyHkM1m+jGBDiwg1uegngHFRRXvql9rhrH/PKVlXQ1oXN5a2vWDOc9o2kf1lb9fcqBbRgIHKdb/jKvuORoTw+uIwNzte7T8mw6lYDE1uKVj2HPlytLZ6ruj4OXJ7AdWDOUo2JEye9srHgvgCXS1bApjJiyj/0v6q17r4bNDM46U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r+8ILsiB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IOluUW/T; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r+8ILsiB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IOluUW/T"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646JfcAB2641602;
	Wed, 6 May 2026 20:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Ef6f3X1qtKpHpNsUv6
	Pqj+c79f64JLkSBRvna161NSc=; b=r+8ILsiBhuZ3hpWa/7ykuxSiXAjgcaL8tB
	k75CgyFL0chATcslxaKw3FKGUCDiX4Y3m0KH0ZWkp2g3P6cg/MMqfmRxlrl6p+T+
	2ikwIV2dBTsoYLQnH6cwA+0PjcById0Ws9k4K3EWKJ8Ulgi1KESIaQeqmH0KLRNM
	RetBlA4ujH24Xq3KHNkIDf8Xk9SrwHTgiJrahlB5Gk5Iy+L61/kkPGVQdFFtqi7B
	pC7y2cFd4sIGbaqjGfKyhpswddcGLwzOQe9p6zOd5RRPvRKlaS+5glOrFPb3SzC3
	bbsrC/70SpK161XvWtJxUXVdv6UcQ3jeKcmebsrIdKKJ2daL/b9A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9e4fqxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 May 2026 20:54:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 646KkiWR004473;
	Wed, 6 May 2026 20:54:15 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dx577n982-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 May 2026 20:54:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKzi07nGeO0OiEUSp9u3o7uJHECTV8YtFISsO5sB1c5tJskddHqz2v63ntWvZMYwGZl6JF6rK3/c1GZOWjUuRsVs2PSrrwF781G6/Kkz8KXD6S/GJMzSHzwbWDBEiGEnz5myjbNdwznOXq9JO9FLcIaaCGRNtq+aKIx4jKl8/pOBFrpfdVCp714OId3A15FAtXNCLGD46oFcYmhJRviW+8PuCB3pcdC37iPC3ZR+lczDAK4j4LAonAonkskn5ihHptUAt0nP06bnNCEY8yniNq/rjFu0gYyX8yjc1JamJ6xJ/B7xawhk6QgkRWcJDGl+hfeb3I/edtcyQeelC6Pqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ef6f3X1qtKpHpNsUv6Pqj+c79f64JLkSBRvna161NSc=;
 b=GjCH2P7dhg3fOwmQtzj+6cjOTG1u3nhqhKeRmDSg/OI/f+cbH1EYFUfGeIdLWGMgYaJNGg7m/jCqhO4RKNI7Ty6+NZBFbG+39qCQy7lRIvhlBB4I4yCQvQ6lmMgzP90cKpal0rqTPvGT4QCJG9JMj4WV9hQXLHEScoWU+LABfjG1D6mPJqTc3jQKJZqQIn2qiDiCx/8Wovd4xZ1WW7h5mnh5PJkm2acnTEZh0ky3K947WRHxYorvbiTxPmqHYycxfGshREbMSMt+3yu83rpQq6PLJtmwGOXhJ066miTKC+2cEpj86RHgm4hWms70nuya+yeJu51j313ifE3LC97hhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef6f3X1qtKpHpNsUv6Pqj+c79f64JLkSBRvna161NSc=;
 b=IOluUW/Tv/9Rrgg/I6vY1N0qwwPToWx1MKhfC66exlbDrgmq1KwZa47oaeCPcyNv2lHXOlj98YZXAx39fBUhgK6xe9gqzO4uWYg4GezQ+5StQFcyizJRKnHZBga0/9bvkznBatYOgM1GN1scD0KGBuZfNSqiRJ0Xg26YYSQOqQY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA4PR10MB8659.namprd10.prod.outlook.com (2603:10b6:208:56b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 20:54:09 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:54:08 +0000
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
 <20260408122538.3610871-2-ankur.a.arora@oracle.com>
 <874iklm1uy.fsf@oracle.com> <20260506095836.216d9cc5@pumpkin>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v11 01/14] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
In-reply-to: <20260506095836.216d9cc5@pumpkin>
Date: Wed, 06 May 2026 13:54:06 -0700
Message-ID: <87o6isl0nl.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0038.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA4PR10MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f9afdc-4278-489c-9340-08deabb19e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|22082099003|18002099003|3023799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bR1QHracigCszE0EIfKrcxgfp+cvd2TRzSSfGTcQO51y14rep0C3oP/ODiIjvp/6fCUHrqyNpM6zE6qzXOs2yZRV7lewqQ2yJ00BUi2dth2J3NEpdSDpcD+0feBko3fHC+ym5p/OdX9W7kOE1LKceJv65WAOl8zKSHb+/xYONP2+xm6PX6edCVmSpjWWmjch8TM++1uZXsUKFOHU0G/QCHfr1ZipZC38iVeH1IvC1VoOmx5+PNSUUSbYnxnRMT9OxBa0Y3rhHqHLl4HKMbj0VyH2S1O9AwvuVUq+ao6+5oRxh1gsoaVCS97TGBe6iMbpvXPo+Y3+ZLOMHxQY/a2ykA4QrLWIKluT7KmbFCVqdgpvdYLmdW29pLIyGri94H/30v1a15Ftzg3PPHnuSadwqmYUPQdXW1Txn66FtOaEguaLM+NgIwyJ0WKiLVfgbyAz7tvfOxMiSSJ7w/M7tswBspHwcOJUL2RrFin1QxxsZeHcJmkdNMCNpTv1aFpWVDEPLhF+lHsOhot5B6xuNCUiNBDSS+Noj7wk6enLYyGzNeWlMLaCuHhLOcXVr+PjZ7N+liL3uTYrGiaT/T2n5Dddz9LtS2XQmndfOcbXOi4TjqdRO6T95EtWU690dLKZyPpnPLHEZlQgB7BF2rGfl+Xzwe0OKHEOpz9M6jr+OPWl7zjRHgz93L7z2Xu3Ae6qAkAh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(22082099003)(18002099003)(3023799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fenm5h4sGWpxSmzCIApfxOeEwxOQ9RVSvOwjPHc7rvY67rypJXT8w0d939W3?=
 =?us-ascii?Q?qvcSPoqvyPKPVirldcelGynCjLpwNH4avllogGW4/WG2r5RTAr3mYu9WEg6W?=
 =?us-ascii?Q?1K6yxWPneIYSg8InhWAYRJbuHAMeoO7BA9Cx56iiWEVLHO8mkY/vKZcn1BzO?=
 =?us-ascii?Q?rUCy+0cNCP1vk243Qx4Og5DtI0SwwRFRgweCjDuyU33StKMTV5iE/h7FLCCx?=
 =?us-ascii?Q?U3r7ahuUMXK6LkRUGaxDGMrmqHwp842RHUPDsriBHRR6zd/a8iFlmbjY4Q5v?=
 =?us-ascii?Q?l/O8UX60g3GCJQgdxvfK85imJMOlXBPohOC6dAP4Qi+jnKj8ofOJRk7gRHVo?=
 =?us-ascii?Q?038i1wDpWOryfnq5tF3u1W23jfc4NzPRsfvGpY9P1PDS48ZlHWB+r/rOCobI?=
 =?us-ascii?Q?iuzsuq5RLfQ7BA1XVuOtkvfsFoVrexGUzrlfzTPWXDA4rZm1fxASg1GOjKna?=
 =?us-ascii?Q?6/TPrr3gTf1SVelgsAxxdpcssDtd2Pa6TOjV8u7XkXvkNPEdLjJPlTc60S5v?=
 =?us-ascii?Q?eBvW6sDxUOUwxTl0KO8T6z/yxwzabedhRwcsuvu0qkJ3aluG7aR7dgwVVYDO?=
 =?us-ascii?Q?l6C/2UZ+9lZ/YJzyehZRq21srj+NmEoo6JLYun7F8BN4CACiZB8IJxw+taLw?=
 =?us-ascii?Q?UZkOnRFTcw3WNQ6xLNuDxQOMDJaOTplHGph45VI0xFPY0KpP35ENzdg+nhQF?=
 =?us-ascii?Q?lP5H3P8/DthpTlJiDD19sCdWpbts3mNEOCnefeaXZyE5jQxs8yzwzqF089ex?=
 =?us-ascii?Q?mxXyxnTrTPNyg4Ep93vVFIvhudgbFyG7Www/kYuDrncSo3eweqb2dF8KsjkT?=
 =?us-ascii?Q?+c8HDa0rG0VFjH3R7lUSWgErzUGuzHyTz10bQ6abYnG/kjCw5nOwqzVFWGwl?=
 =?us-ascii?Q?CmMqGb4gvfuD59FPYirKMcQHFgV/R1lBj4njXLFvn7sSnfrgVZdxC+4JGKZk?=
 =?us-ascii?Q?nl1o6v6s+WQNFm0jDeSCPxetxxv9mBRoXCuGtHhHMtdpLmuR9rXsnDbzxoXn?=
 =?us-ascii?Q?o+NTptKmxuf0y/inD4Fox9zfv+kEwh6cPeg0JeZvZxq/CdQLXXQ+aghLPEon?=
 =?us-ascii?Q?pC3lZNxdWk3cBOP9xpNUCkPUUcI9l5f0KVVtzk8bpNJ9nTqlUs5Jea6dlG6Z?=
 =?us-ascii?Q?OHx3+7pprSHycjIi3LX2fqP2Ya5eDLmDTPJXoBFCRzRgZHSWDXGhtYPLCDw6?=
 =?us-ascii?Q?T0Lr2+bsIhKYISVRiM9g0gCx5i121+uZrtu67FX0kc6o3EiGUCZ0ninBjKGx?=
 =?us-ascii?Q?ZhVh8DYfAIxz8R3nMknVaqPMtt5hNfhtceteqDg0AFTsG13mpCWUwSz1mOSb?=
 =?us-ascii?Q?XD0tyrK+JflxoL2V40KQWS9//6xoETvlsu30XIjvtr6psGD6QCDwPfAc//1n?=
 =?us-ascii?Q?idVX01aOCBGe37WlAhmLH/98TorOjdan54iWazf8beto7CjO7F/+ns+AfHLQ?=
 =?us-ascii?Q?MzzRPp1gPp79fXTbRjz0u3w1L7T8KTRTxBTE6DLJAnatJZt55NTIv6JAlo4c?=
 =?us-ascii?Q?+fQtQ3+Oy0rzMW3RA9cJwEvJ2mZqdgGySceBWAXSZ6d39NqirNeB3fFiJ4MJ?=
 =?us-ascii?Q?cxsmmqSP1QOgSCdsCKiaxC7BmEZ0/uAsLVP/9+C4KeZQua++GqHTHpDH+b93?=
 =?us-ascii?Q?T6C1tndxiToGzFXZ84ng40P2sfEWKYssyd1+ppiQWQ/1FceVUKVTxySfo8pJ?=
 =?us-ascii?Q?XmQ9P3tTqwLbc6mIU2vsxcaesnG07nXYtYJ4K3OAQmxiVGATpQyM/89G1S02?=
 =?us-ascii?Q?Ep4kXH/Abr+1HXcPLX+ZTzETlB5POXs=3D?=
X-Exchange-RoutingPolicyChecked:
	W27XCdn/Qs7ddgadUJwR5OHUstVCZu6IxvUQy3qCwYBrjk9eOdyIHzG6GMsD1b3ltHvgk2PTBoHOuYQp+I8ZwsgMsN+fPK8SETdKAg/ub4Cvy8McBRxT4H/q4Or/6fju+mD+17IjPyilib0fqYaABvlsILK7EXWtyxb8R2RBZhl7RpvHqyHOueoigy6SjJPRsyQx1Ftfaoz1V21zfUxsiXHXLMcxLuH/0W6MaiqvqbCnppPxt00cvDIM1JUWTORVwC/JnZRvsdY/L6++aJXMOTn6AtcWX7/4ja51iRHgFCsvUOcPrBqRzfR0WdRMZ09SHgghrFPjI2hqkrMYa0Xl6w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lOJRHeOEnkLc980LVUh3saUTwejpv+Z6auSNW5shX1B6vaC5+TL9VfXMLUVLzwVW5ekgdzSPZUpRVvAnl/5fVj7h1JS6/zBXRi2uKa+/49W7BAIYB5zzq9ck+6SghX3OjJ0AJn+vMFEzoOajfPfIIZANGpqkoKAGICr5+7BhksIomiCO/H3nAHfXakEKdIo6b2nltIv8DKJthVrxeCC0lCod4eP6ZlMZiNjQmGVfJzhnsan4jj/u1j7fzGgLNHaBtjtIjVIj4styFN3Mq9UxX5gAY0msSPGhdvW222KD9yNfphug5x71NxtzWQf4vEQDTONQtIhmyRd374OxrCu59ZQAwGfKfLuhM49ND5tJPgcQLSSR7fMgr7nGfvQM4f9sGMF1l5tpAuehrDBoEYhp1C/+ZYH/KUoG9KU4E4YMI0CuMqFCq2BwqhJngNsTO2qA8TOAzDiqsGZT1zJENy/PQMTGr+2dFJVU/Kgm8ld8HYrj2obsCM16LCTMatysofN7uhPfK/cRSrQAIG74k525jlRP/etAeY0QCA+4vXnlhD7BAgMFaZN/U9HOq8DXip9/QFtdRFVM3TylWNMOZ+9mYtx6JZzyYu3c1IynDtDzIxQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f9afdc-4278-489c-9340-08deabb19e2d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:54:08.8249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQikjvNnSzvQiAM+/zu4vzVmgoPShugMB3afsiED8EN5cIl4P79zlY/wFl4fEkRbbyYBrEa7IR9xLgIUMw5+Ud9CAypU5AasGnq9de40b6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2605060204
X-Proofpoint-ORIG-GUID: fhmLYhJSiSAwZ4Mn14HinBRxEXa9lLcQ
X-Authority-Analysis: v=2.4 cv=O+YJeh9W c=1 sm=1 tr=0 ts=69fbaa77 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=eJahMKN97hqspy8HfdUA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: fhmLYhJSiSAwZ4Mn14HinBRxEXa9lLcQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDIwMyBTYWx0ZWRfX0CQ/TQ73Fr4i
 GgOBgZwAihknCI+CnTccAonjuxNlqxj/s2XplLHbEP0lb6IAByIEDD7cBMPWrUNtMpcCYwbYKEM
 eltkXWOwZi9WCy7otx2pC3iBRdnGqBsqI1dBAhM9le913vDTu0CBaafwQ6sn74ImcUUrKAzDpCT
 PdtFz5pdudgWnE1OX0rCN9iCuc1jURF5i6z21Dx7zffJ/feNLgbPb1OOr/l6+8sjy0Hg2vsP4Se
 QhZRDIgvykY4jNhUHXy/VE+XNLCTYeSLcKr/k4Pfzm73CJP2w8Tsq2uUOLtOs3U74qGtQ5sVV7B
 yeoolUzrRv5HK4LEKojQOyHuL4AvgaXIvRZHpEjLzgPUq3iGX2/OocOc/kUx1D+uI9Bie757FYF
 UnefFFsBrKVGvxFt92aIl/p94WnTbAwAfs1akiOBIrKgUM6nIAbrzdaSuwyy7vbJFxJYmNw1VYm
 S7UmCQV5fjMlCiplVSQ==


David Laight <david.laight.linux@gmail.com> writes:

> On Wed, 06 May 2026 00:30:29 -0700
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>> Ankur Arora <ankur.a.arora@oracle.com> writes:
>>
>> > Add smp_cond_load_relaxed_timeout(), which extends
>> > smp_cond_load_relaxed() to allow waiting for a duration.
>> >
>> > We loop around waiting for the condition variable to change while
>> > peridically doing a time-check. The loop uses cpu_poll_relax() to slow
>> > down the busy-wait, which, unless overridden by the architecture
>> > code, amounts to a cpu_relax().
>> >
>> > Note that there are two ways for the time-check to fail: the timeout
>> > case or, @time_expr_ns returning an invalid value (negative or zero).
>> > The second failure mode allows for clocks attached to the clock-domain
>> > of @cond_expr --  which might cease to operate meaningfully once some
>> > state internal to @cond_expr has changed -- to fail.
>> >
>> > Evaluation of @time_expr_ns: in the fastpath we want to keep the
>> > performance close to smp_cond_load_relaxed(). So defer evaluation
>> > of the potentially costly @time_expr_ns to the slowpath.
>> >
>> > This also means that there will always be some hardware dependent
>> > duration that has passed in cpu_poll_relax() iterations at the time
>> > of first evaluation. Additionally cpu_poll_relax() is not guaranteed
>> > to return at timeout boundary. In sum, expect timeout overshoot when
>> > we exit due to expiration of the timeout.
>> >
>> > The number of spin iterations before time-check, SMP_TIMEOUT_POLL_COUNT
>> > is chosen to be 200 by default. With a cpu_poll_relax() iteration
>> > taking ~20-30 cycles (measured on a variety of x86 platforms), we
>> > expect a time-check every ~4000-6000 cycles.
>> >
>> > The outer limit of the overshoot is double that when working with the
>> > parameters above. This might be higher or lower depending on the
>> > implementation of cpu_poll_relax() across architectures.
>> >
>> > Lastly, config option ARCH_HAS_CPU_RELAX indicates availability of a
>> > cpu_poll_relax() that is cheaper than polling. This might be relevant
>> > for cases with a long timeout.
>> >
>> > Cc: Arnd Bergmann <arnd@arndb.de>
>> > Cc: Will Deacon <will@kernel.org>
>> > Cc: Catalin Marinas <catalin.marinas@arm.com>
>> > Cc: Peter Zijlstra <peterz@infradead.org>
>> > Cc: linux-arch@vger.kernel.org
>> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> > Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> > ---
>> > Notes:
>> >    - add a comment mentioning that smp_cond_load_relaxed_timeout() might
>> >      be using architectural primitives that don't support MMIO.
>> >      (David Laight, Catalin Marinas)
>> >
>> >  include/asm-generic/barrier.h | 69 +++++++++++++++++++++++++++++++++++
>> >  1 file changed, 69 insertions(+)
>> >
>> > diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
>> > index d4f581c1e21d..e5a6a1c04649 100644
>> > --- a/include/asm-generic/barrier.h
>> > +++ b/include/asm-generic/barrier.h
>> > @@ -273,6 +273,75 @@ do {									\
>> >  })
>> >  #endif
>> >
>> > +/*
>> > + * Number of times we iterate in the loop before doing the time check.
>> > + * Note that the iteration count assumes that the loop condition is
>> > + * relatively cheap.
>> > + */
>> > +#ifndef SMP_TIMEOUT_POLL_COUNT
>> > +#define SMP_TIMEOUT_POLL_COUNT		200
>> > +#endif
>> > +
>> > +/*
>> > + * Platforms with ARCH_HAS_CPU_RELAX have a cpu_poll_relax() implementation
>> > + * that is expected to be cheaper (lower power) than pure polling.
>> > + */
>> > +#ifndef cpu_poll_relax
>> > +#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
>> > +#endif
>> > +
>> > +/**
>> > + * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
>> > + * guarantees until a timeout expires.
>> > + * @ptr: pointer to the variable to wait on.
>> > + * @cond_expr: boolean expression to wait for.
>> > + * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
>> > + *  on failure, returns a negative value.
>> > + * @timeout_ns: timeout value in ns
>> > + * Both of the above are assumed to be compatible with s64; the signed
>> > + * value is used to handle the failure case in @time_expr_ns.
>> > + *
>> > + * Equivalent to using READ_ONCE() on the condition variable.
>> > + *
>> > + * Callers that expect to wait for prolonged durations might want
>> > + * to take into account the availability of ARCH_HAS_CPU_RELAX.
>> > + *
>> > + * Note that @ptr is expected to point to a memory address. Using this
>> > + * interface with MMIO will be slower (since SMP_TIMEOUT_POLL_COUNT is
>> > + * tuned for memory) and might also break in interesting architecture
>> > + * dependent ways.
>> > + */
>> > +#ifndef smp_cond_load_relaxed_timeout
>> > +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
>> > +				      time_expr_ns, timeout_ns)		\
>> > +({									\
>> > +	typeof(ptr) __PTR = (ptr);					\
>> > +	__unqual_scalar_typeof(*ptr) VAL;				\
>> > +	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
>> > +	s64 __timeout = (s64)timeout_ns;				\
>> > +	s64 __time_now, __time_end = 0;					\
>> > +									\
>> > +	for (;;) {							\
>> > +		VAL = READ_ONCE(*__PTR);				\
>> > +		if (cond_expr)						\
>> > +			break;						\
>> > +		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\
>> > +		if (++__n < __spin)					\
>> > +			continue;					\
>> > +		__time_now = (s64)(time_expr_ns);			\
>> > +		if (unlikely(__time_end == 0))				\
>> > +			__time_end = __time_now + __timeout;		\
>> > +		__timeout = __time_end - __time_now;			\
>> > +		if (__time_now <= 0 || __timeout <= 0) {		\
>> > +			VAL = READ_ONCE(*__PTR);			\
>> > +			break;						\
>> > +		}							\
>> > +		__n = 0;						\
>> > +	}								\
>> > +	(typeof(*ptr))VAL;						\
>> > +})
>> > +#endif
>> > +
>>
>> A cluster of issues that got flagged by sashiko was around timeout_ns
>> being specified as s64 and a bunch of potential edge cases around
>> that.
>>
>> These were mostly caused by an implicit assumption in the code that
>> the timeout specified by the caller is generally reasonable. So, way
>> below S64_MAX, not 0 etc.
>
> There are plenty of ways kernel code can break things.
> Provided this code doesn't itself overwrite anywhere (rather than
> just loop forever or return immediately etc) I'd be tempted to
> just document the valid range rather than slow everything down
> with the extra tests.

I don't disagree. In this case, however, it's somewhat borderline.

On the pro side, we get rid of some of the implicit type conversions
and assumptions around those.

On the negative, it adds an extra modulo operation in the slow path.
And, the for loop is structured a little differently from the usual
version.

On balance, I think this is a good change if only because it makes
the types a little more explicit.

Ankur

> 	David
>
>>
>> I think this is worth cleaning up a bit. The change is mostly around
>> introducing a u32 __itertime and explicitly computing the waiting time.
>> And adding a check to ensure that we start with a valid value.
>>
>> This does make the implementation a little more involved. So just wanted
>> to see if people have any opinions on this?
>>
>> +#ifndef smp_cond_load_relaxed_timeout
>> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,          \
>> +                                     time_expr_ns, timeout_ns) \
>> +({                                                             \
>> +       typeof(ptr) __PTR = (ptr);                              \
>> +       __unqual_scalar_typeof(*(ptr)) VAL;                     \
>> +       u32 __count = 0, __spin = SMP_TIMEOUT_POLL_COUNT;       \
>> +       s64 __timeout = (s64)(timeout_ns);                      \
>> +       s64 __time_now, __time_end = 0;                         \
>> +       u32 __maybe_unused __itertime;                          \
>> +                                                               \
>> +       for (__itertime = NSEC_PER_USEC;                        \
>> +               VAL = READ_ONCE(*__PTR), __timeout > 0; ) {     \
>> +               if (cond_expr)                                  \
>> +                       break;                                  \
>> +               cpu_poll_relax(__PTR, VAL, __itertime);         \
>> +               if (++__count < __spin)                         \
>> +                       continue;                               \
>> +               __time_now = (s64)(time_expr_ns);               \
>> +               if (unlikely(__time_end == 0))                  \
>> +                       __time_end = __time_now + __timeout;    \
>> +               __timeout = __time_end - __time_now;            \
>> +               if (__time_now <= 0 || __timeout <= 0) {        \
>> +                       VAL = READ_ONCE(*__PTR);                \
>> +                       break;                                  \
>> +               }                                               \
>> +               __itertime = __timeout % NSEC_PER_MSEC +        \
>> +                               NSEC_PER_USEC;                  \
>> +               __count = 0;                                    \
>> +       }                                                       \
>> +       (typeof(*(ptr)))VAL;                                    \
>> +})
>> +#endif
>>
>> Thanks
>>
>> --
>> ankur
>>


--
ankur
