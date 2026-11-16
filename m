Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794817528;
	b=L0JEg0xjF5dH9lGWVGRs4GVZekpuXwGHs0F/F6y4fi66hZ/UfkgKfqWsgdUJf5gI/CMO
	 UwTCR8vp0X3O6q0lLq7B0drjP9orr47XUMMpuG0mNPzXofL19x0xnJtNFiD6vKeq4ZBhn
	 A4bJ7YPqxUv1bMQmXcuYJczIGOyBfQSya6XXti6Zle7fLMmbVteE4UvkHHBISPf7qDkH1
	 o9DPPLDZf8QrIA0xw1VfJItwD30/utx8LyOXXQBNfxGgyAPgbKwZWP0M6S+CYEmB0Xzgg
	 KNnJ7SqY5sFVSEEpCISweYAGzpcCkKorFLAA1ANrO1FCAhIYWX7ShK12fvvQ2Ij//OQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817528;
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info;
	bh=onACKUQNBQ5DiX8ntKRgpPkXcw8B090QxIjEegvMe4c=;
	b=cLDishb6NxIEL4vVxbIzYs4ytPQZNjjXK4LRnYhp4D8g7Xi9tPIhKCstJkxM3bWrykAg
	 aOJUa21FPik9EEzQbVmQrhpl5bybIFrZs7FSTI4aMQQks7pukpLhNdgT7dzGQtpbe/zML
	 paQ8ZzedsTxqI02EliGVLA0dBNYEcHhVpnWYDSIWFaBPsGnDw5ID8LfNEZK743Yq0Y8hZ
	 U9rmHEzAPUTyPJ8Sp61yAJYJlUxg7r3dsi2FAioQWUvKYtfosxeg/ZJbm+fHW1sIqZH8n
	 9/O3LhAxU9Jild8dGbNa7N0qLFAfetOrv54Fhz5gPA1qleSAxHgZfvX7uUj9mc26nUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=oR4PjI8c;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=yi0rG2a7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C674606A32C;
	Mon, 16 Nov 2026 08:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C674606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=oR4PjI8c;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=yi0rG2a7
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG3RJSK592736;
	Mon, 16 Nov 2026 08:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=onACKUQNBQ5DiX8ntKRgpPkXcw8B090QxIjEegvMe4c=; b=
	oR4PjI8c5U8nvEi18wu9xe2B8AdRZrSr21zuLVvsSeqrRl11ioacoHxkMCT9DNXT
	eJ1mbUR70c0QGVWNLicFuhPgP2q2ZxZJlivB2PZy1lfdrC3TKP/fGTtDkNlZ21jm
	Nnb/ooG77Hy/XFldeS+1G2CB+wjXpKHa+4BKZnSgsMxMQgIo83WfU0OopGWhBAWL
	q0nTWDCclUe8MPKXNdcwsOPod1yKSpWIteATjSbf4aLBq9sDq1MNlgrDQxiTYXte
	R7fWu6czKbS9z8LjkgRGUpr1L1r5Y7Votr2rr47a7xIp3tkKez5ChUxsCmKPUVTi
	u0SzHeYYyw7fK4iPOSAFkA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxe2e1mw6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 08:24:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG8HFth2181692;
	Mon, 16 Nov 2026 08:24:50 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hyv7pmb65-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 08:24:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JehASDO/AO65NBqoru5o9plpLWe1Ac/iqAbmYAkNCRYATPsbiedphScx747ldLmMgb0ej2/RnNQr9QjV5nyQ8KOACobQrlXFLYkyey4K01ev16pkouqXZdYBPBrgJPWqXVpzvOV1vjROxABIA8E7t69XPHCrmmZVmREPFpDLPDe5Nms1Y5J27cM1EJYH0trVabU1nP8fYbktXjtkr3CnDbomgtUDCA9vDQmzt2yTuwJiWEHG2d/jZVsfmUvMtAZJle7m4stJ8b4KmokLGzG0iHHny64gONO0tExCTfWvpKoC95jIVShWKG+/z2T3/iXWCNRuaKioP7iISJpzaZz0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onACKUQNBQ5DiX8ntKRgpPkXcw8B090QxIjEegvMe4c=;
 b=mDCZwuRkb/V7L+7FWkpL6o+TSirkO22+3qTL9pEf9jfhTonBy3RYRVlrKw7Nvk4uDf0psNwuPb6FSEKoVlhvKtSpCuQHbnFbgw7i0+WLf6gpFa5lNwRJA1pWWIr+aT+7kGUZRRNOeVlJwsXg8oOeVBYWmtIEwpOv9YMUN+amYv7fGVZK1nfSIQWWz0KWSLz0+di+8rw7/9jyMFrTtMe0xwI7zXyeeEt2T/6K8cpuA1edM90LAgh57SQ6cUs59OcvgmeC3UlHZhix/E9uzjFIYd0KhIES8Eyo2C42WC8GatYVrv+V3INRKRowv97zPp43JTfyWMbR0GOiVQ87qxhCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onACKUQNBQ5DiX8ntKRgpPkXcw8B090QxIjEegvMe4c=;
 b=yi0rG2a768LGX4XSuMD6jyoOQYY7aC+4/n50u7QTjElPt5010icg5pq1xh4qXa+88gsVZv3JkMjuxDJfTPCwppDfLU+RmdCq3YgWi24Q4u7/iVnXK3Ai55MF+nLm9uCK/lAo0LJS3i2gabqfJpZC7uBUYS7uXoppLrZ7ATuVSTE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB8216.namprd10.prod.outlook.com (2603:10b6:610:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:24:47 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:24:47 +0000
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
        Christoph Lameter <cl@linux.com>
Subject: [PATCH v17 03/16] arm64/delay: define arm64_wfet_deadline()
Date: Mon, 16 Nov 2026 02:24:24 -0600
Message-Id: <20261116082437.66739-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261116082437.66739-1-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0242.namprd04.prod.outlook.com
 (2603:10b6:303:88::7) To CO6PR10MB5409.namprd10.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 84c3ed59-38ac-4892-2849-08df43bb1340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|260925022911599003|260925021911599003|260925021311599003|56012099006|261102123227099003|261102130727099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	MAyzvs+SaiEjOuj/W5p5e/NnQqBnEtMLt7DnZrZQZrUhRtzcHJNs3AvEEhKHV9VBt2jZ0bOscSiRoGek+8CfF1rvsv7PTb5hTmoPSMyHgR0wAZcgWJ3TtIouYCF3WnPAOi0hH4XAOymkdtMdC/bL4tMDVxK5nE1gnOt1b6It8vko9nHaXshlDtkwcU7p66eoj7Y5MjzsB83raUUmmpN8Oi/DvpT3DBzJ2npzn3LinWkTFbK3+InzitrnztBFG1vwvb+dWuj0XePBiH9Bwhy4FcolwbgfkntbEtB0w2vDonB/bH29mrVlowZe3jz50rQBdJDLnrUDN7+AUFc9RJlYjNbGFcv++lmZdU8sn78NJ7HnKdJyGB8bHubWv8UQxVc5dHVYkDiFehCCBe5VgxhVk/HZoLofTk2jPXVMZA5E7TmbwmfJqW3ZAs52TO1aTi+d3IVpvzcz2m+oFXewjAzlB+eCmhL23uv+AMmrCc5udbPI1h8fJB2RP0AgNZ7B0NK1JC/UtXqj+8wal7gCE50ym7B29GE39ZwoC4VkhZ+L9cbCHv6JBs6IMIOSO0LfKRsCnt1qRwS2sTZa7sHo7o34jCAXgtViRfRyztIfLnzSrPb3j0t6gasKvegYdImQWAcuAoYwpj1nT99ko9/N4z42hpWWkdp91XkrSKpaSGDsh0k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(261102123227099003)(261102130727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vpig/u+IhbVTaBhnTCfYkmN1lekf3lt5KiUru4nBXMFiR1VHlYaSOj/k/oep?=
 =?us-ascii?Q?0qsZCv4gDo3ONzhcPo3uTg1nwLpgczCnXTseooEuF6mF6+RJD/1vPbUk9Cxl?=
 =?us-ascii?Q?GgTcbZGRw2WeK6anglqOfMteYau+H8pSd/Odh3pHsu8/LKcYoZAtqJ2qDccU?=
 =?us-ascii?Q?2spUD1r0QveIRA48gL4JOGMmIYQ2PNRjoGxFSsqlgn3xV5j9261KIIWOnnJg?=
 =?us-ascii?Q?6JZzwjrzW88rHtzUUnvuTsrZYUvEl8W2qI/Dew4E6x2jtaL+wjDhtzanWvv0?=
 =?us-ascii?Q?vgdtGaZw7ojVrLJ1nyHM7ZgMv03lR9Ube6jwSKbK0kfGQOlj1K/PDlayKTmC?=
 =?us-ascii?Q?kqeqJxgVnZCYI3o9W46f8LKfmtBM7hQtlY7IwYAvFqdAA513IU7IWR1UhUq9?=
 =?us-ascii?Q?ZurSqVOSiBm9uQF8l/5vnvKejwkFb3WpW89OOQrX/SgCyXJnQVRDI7Mx4tpV?=
 =?us-ascii?Q?pqGPekuRvmRvzo/XznBWXgI+b4ZDMtLn67COTMaaylqySJW4lzEj8DXmN9cO?=
 =?us-ascii?Q?R/iu4XwCikqGZsbnOeH7xbZOIZAH0H1I1vdabR2ugfefL1EuHZKahSshLNyl?=
 =?us-ascii?Q?TdM2UdqlWzUsIcA2jI3s3EAxSkrIaIQ6Z2cJc5l5PKuunh8R/4oJ+et8gPp+?=
 =?us-ascii?Q?PN+47aj77e1Vd65mEmT4SfFzwzzFE+sZRyEWDul/MaQUAM0rHjVxE+2fubhP?=
 =?us-ascii?Q?Usqq5yhhIHYCkJplIP8D1G5rK8dLStko7RZWsn/TMOJxR/t2AzT3M9S6s1QF?=
 =?us-ascii?Q?Tqx86GQC+AjoWyAxQy0JxZSfxx5X+Tf+VdOk4/hJUKZF6HgOZHQzhc8zN3it?=
 =?us-ascii?Q?D1jnxWF+bXj1bg83dGEecpY0ASyGgZjcqJzESNPg8IBla/CU5z8uZTG2cB5U?=
 =?us-ascii?Q?nvGL0ZCHs0a5L7cgedHF9gfxPq2IOklwpycz+l4k8WrsrvJOpG/G1YlY+8qW?=
 =?us-ascii?Q?MqBzrwLYw5aodvht69Kg8GKlE2tYIuC79W976lAVzIX26ARZc/ucDVjNyoxu?=
 =?us-ascii?Q?79CWSjbnJtBYehNf2U3XaHfsCPKqcOfhhTrlqwyLhzphpz4vnx9Ipgf3m+fz?=
 =?us-ascii?Q?MlPSo95or3OMuBidF1l5NJoJAvZvyY3kPpZCOE+Y/0J/fdOzE1Q4bbrU2TBj?=
 =?us-ascii?Q?D/65qGQlDmPJQwGBUSF/17hXUqZgOpVGgPZ6M3WpoCRx+asBbE39qPKs3r7c?=
 =?us-ascii?Q?bopJZUOFm1msAJkJFuxYbEmpC8YpHOpPxEPrrL2fzncI6ioav1mdvRsYmv3B?=
 =?us-ascii?Q?vfZTOd6CZFfUYlsPITmNiqQTijKOR4dbGFIkbEs+1Hc2l6YWD2+/c9waGU3Y?=
 =?us-ascii?Q?pOkHP1nZBHXjNlUP6YSDhprpI1lPiS/h7njjlbTPaEMcv2iQiLoahCJAFUKE?=
 =?us-ascii?Q?V4WS0S0852qf/fWb886vyN6QlvmhUf2+3FBe5JKr+W7WvwLNV1BGv+cboMbs?=
 =?us-ascii?Q?aT7KwgW35S9bvU3ezVOqLZwhsxTOh2jE9uQ6vf0fKv1L+iLP/+DnWgCG0R4C?=
 =?us-ascii?Q?Lc3+3gNVje5VdXx44GcLwiPpIv+nANe9aE+SxddXHEbaj+mpU0YlWdCTrEi9?=
 =?us-ascii?Q?zTtXXpxbS8KpqM8J91U3Z3HY3Vs6KCAoNTy18PULv6HNKKPUo6Nh4FpBDFHK?=
 =?us-ascii?Q?lUOhiAY8euxPCWKz1vaUEMI0RDCdBA4WR+jefhigYtau+ErVxoTVpA4PT6Rn?=
 =?us-ascii?Q?TyXHOZB65pH+cVfb+LmfBNr8BGFqv4HJmUoBRwzFdk2/wBYCVnScvsYVA/4/?=
 =?us-ascii?Q?ExmzssO3D/M38l3gl8TJzlS4WJ08JzI=3D?=
X-Exchange-RoutingPolicyChecked:
	FwyROw3AVt3azO9ehSM9UMizyvyUOytWl0THTvPvU2IX2E4eOWSM6wpcYICb2c1AWp8WZ1dru26E+juH0sLF/QqQ0zlyaoXeQm+XWTtaliUvK0ZGsr5uq1mV7EwZTb6Vh32YiaKgEQZwbcuzvvETxzMgHx69CpQnUrzib/zo0MqfxKJjbqqG8yBnpYZUt+RvxbSBmWpFYOCdW44VCXc/dZ6lu7Qaf51lBR0RKnI0R8iv9ZbHjBUIFcaSqScs7fHH3I425RDsHyj/GbUpMJCFXgtSviYwKKsoZx980WPf2UC2NajNgIzkf66zL63Z3QhAi6u3HOmydzvObxrrmqp3Lg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qi9y9Gz2NgxlvbJ//Gno1Pno8TfjKfu14Oos+ryp9zVqoQoIfZC34UruFdJXVpfic3TgdysSffXBE09E6BLKwnKHhkf/7k1JT+v6ErwoM/2ZfWxOYufcyAU0ydnUVt7veXAs6q5pJ0NyAOGmsnJsuWmCQPBncCuNtZxXkAEDp9kNvoNFeCXrMsUJwcA1GzhPO49seQxAlKV7ZnB5G0qCqaGw5dE14MqOrwmB2jp0vrlSct71ah4lUD5evGVwcVzKH6Oe/OjjFdt3k80S5TgZ2m9dbTaTse49KGez+un3P+LC9XRO0Vh8uFuCsmAlSSMxk/VJg+5DQjef8Gp8ScWdLHqil/pDkrpp0D5l+Nu2Pp+GPtadZdr5W5XaNud6vSQIoGnmIHA4CpPKpaWJK/aUv6riWfweg5C9p+/p559SRldfNDEqm7RMEaYYXCZMKE5/ykYCpepjp/m3Uo2bmEIduhMaRPHM1B6nZqs0JDSFdyTsyjVtl3b5a8+bEJDUYx4B4qssk/i4CbUVLr5arsDYJv1e6nqmLfUxNGeAMI9jF/IwwDGNc2GOBd+EGAvjX8kZLc7aCyUUsNiRKo1UCXhLZsVdIgFRn3VOSsZbf369hQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c3ed59-38ac-4892-2849-08df43bb1340
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:24:47.2068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoOuQ6Tor8qSmrftuumoaSrAqTFD/Zw1fWQpIB0JjW+kM6V4AAtNivN2tm9xNRD8Qion+a4hk+nKlYJ1aUHn6xTU6vJoMeuj3CYmVz6Ca2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB8216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=795 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611160033
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX4h7cbt8lnMX9
 mlQjzzoDt89xKeoRodZSuMCmhJ5JVw+hgnrqBWKNA7prVC1YO8C5oJ0GN2MIGy7xMls30iczHC1
 XtMlDau2a3DT4XNKLq+z8pbb0d3f+4jBBwgqguTzNEfa84oUpaB+RKs8M9Y0E2IEvtUZq+lv2tV
 kPiughRqA7eZdcaHGbcSMQccv/H+iykEi3GKtngGgoHTWAqm6BVZsYX98wGkz7/sfbiubiyRKyN
 yGihtdBrePITtbaTGFMYosLqcBBkKKX5vznLrn/SIFf/YAlxj20gIABOC7+dk644AxqHlWO2DjD
 9jUwukHf0Q6lF0rt5K6PKJ7CALPbzNfcAr17UlPqePr32BboDpjsZaJduwET6gXwgsEjoS04a7E
 9YtOTTvBipvw2BK5i2W+35Ybfoq2T0YIThQwsyBZ4cEMibjLZY2toGU4+KHewCPYXoibsiPeXjR
 pOrkO4v1NUPX5SwIH0Q==
X-Authority-Analysis: v=2.4 cv=BJ8mP1QG c=1 sm=1 tr=0 ts=6afabdd2 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=NufY4J3AAAAA:8 a=vggBfdFIAAAA:8 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8
 a=TvzTAWdPqagB0ohX4sgA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=TPcZfFuj8SYsoCJAFAiX:22
X-Proofpoint-GUID: vZb4ureGjiOuNsAgsU_I3mSpayT-oZLz
X-Proofpoint-ORIG-GUID: vZb4ureGjiOuNsAgsU_I3mSpayT-oZLz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX8TiQ1SmVf2bi
 qUiXXIJKN4yL+OoyYCqH56XK8NGaHWEX2fG8j1IAMpS1SGyjVvRtgbO4Y37pCq5axyk3YJE70xb
 SalnmkT03zMTbr7XWJgtHK6g4K9uhiqlOY6iSXkOaXYNbarl4lig

Make the WFET deadline available via arm64_wfet_deadline().

Also update xloops_to_cycles() (used to compute nsecs_to_cycles()) to
use mul_u64_u64_shr() instead of 32-bit fixed point arithmetic to avoid
truncation for delay values larger than ~10s. This adds an extra mul
operation but is only used from delay loops so shouldn't matter too
much.

While at it, define some related constants and convert relevant macros
to static inlines.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Christoph Lameter <cl@linux.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
  - keep nsecs_to_cycles(), usecs_to_cycles() local to lib/delay.c
  - note that the eventual intent is to use smp_cond_load_relaxed_timeout()
    and thus arm64_wfet_deadline() from poll_idle() (which is noinstr).
    Will do handling for noinstr in arm64_wfet_deadline() (and
    __delay_cycles() etc) as part of that series.

 arch/arm64/include/asm/arch_timer.h |  2 ++
 arch/arm64/lib/delay.c              | 38 +++++++++++++++++++++++------
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 6717209df05b..3012fc0d521d 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -86,6 +86,8 @@ static inline notrace u64 arch_timer_read_cntvct_el0(void)
 	return cnt;
 }
 
+u64 arm64_wfet_deadline(u64 timeout_ns);
+
 #define arch_timer_reg_read_stable(reg)					\
 	({								\
 		erratum_handler(read_ ## reg)();			\
diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
index e278e060e78a..dab36c7a913c 100644
--- a/arch/arm64/lib/delay.c
+++ b/arch/arm64/lib/delay.c
@@ -12,15 +12,33 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/timex.h>
+#include <linux/math64.h>
+#include <linux/types.h>
+#include <asm/param.h>
 
 #include <clocksource/arm_arch_timer.h>
 
-#define USECS_TO_CYCLES(time_usecs)			\
-	xloops_to_cycles((time_usecs) * 0x10C7UL)
+/* 2**32 / 1000000 (rounded up) */
+#define __usecs_to_xloops_mult	0x10C7UL
 
-static inline unsigned long xloops_to_cycles(unsigned long xloops)
+/* 2**32 / 1000000000 (rounded up) */
+#define __nsecs_to_xloops_mult	0x5UL
+
+static inline u64 xloops_to_cycles(u64 xloops)
+{
+	u64 loops_per_sec = (u64)loops_per_jiffy * HZ;
+
+	return mul_u64_u64_shr(xloops, loops_per_sec, 32);
+}
+
+static inline u64 usecs_to_cycles(u64 time_usecs)
+{
+	return xloops_to_cycles(time_usecs * __usecs_to_xloops_mult);
+}
+
+static inline u64 nsecs_to_cycles(u64 time_nsecs)
 {
-	return (xloops * loops_per_jiffy * HZ) >> 32;
+	return xloops_to_cycles(time_nsecs * __nsecs_to_xloops_mult);
 }
 
 /*
@@ -54,7 +72,7 @@ void __delay(unsigned long cycles)
 			wfet(end);
 	} else 	if (arch_timer_evtstrm_available()) {
 		const cycles_t timer_evt_period =
-			USECS_TO_CYCLES(ARCH_TIMER_EVT_STREAM_PERIOD_US);
+			usecs_to_cycles(ARCH_TIMER_EVT_STREAM_PERIOD_US);
 
 		while ((__delay_cycles() - start + timer_evt_period) < cycles)
 			wfe();
@@ -65,6 +83,12 @@ void __delay(unsigned long cycles)
 }
 EXPORT_SYMBOL(__delay);
 
+u64 arm64_wfet_deadline(u64 timeout_ns)
+{
+	return __delay_cycles() + nsecs_to_cycles(timeout_ns);
+}
+EXPORT_SYMBOL_GPL(arm64_wfet_deadline);
+
 inline void __const_udelay(unsigned long xloops)
 {
 	__delay(xloops_to_cycles(xloops));
@@ -73,12 +97,12 @@ EXPORT_SYMBOL(__const_udelay);
 
 void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 0x10C7UL); /* 2**32 / 1000000 (rounded up) */
+	__const_udelay(usecs * __usecs_to_xloops_mult);
 }
 EXPORT_SYMBOL(__udelay);
 
 void __ndelay(unsigned long nsecs)
 {
-	__const_udelay(nsecs * 0x5UL); /* 2**32 / 1000000000 (rounded up) */
+	__const_udelay(nsecs * __nsecs_to_xloops_mult);
 }
 EXPORT_SYMBOL(__ndelay);
-- 
2.43.7

