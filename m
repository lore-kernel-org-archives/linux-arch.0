Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F97439659A;
	Mon, 31 Aug 2026 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207827; cv=fail; b=UAU+TOXfy3PgBFcycK+y0FSa7wg40VspkzlqA30muk3FAPCuYwtILuOVfPO4BmGFPY7Fz+2RZXtO56VZMd/1PGWfJONf/GzaW9tkb/KLbr8F4URwLWIDPijsRG+Z79g6YgynEEMyEspRnTxGEDTmZUkCukiCRBZ9Dpmmd2fohk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207827; c=relaxed/simple;
	bh=IIH10hLaepDyN8P9wYR5SFQibE+MigzxdSErvd6Dr0E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hVxoYpWtQWNBAmIo1sVOcG+PnQzxnAZ8F9vpJK42BlX/+SFv1GjYz4bQwoZ/LVBgA4fFMuuHcTBZ2fdk5UED/eg7fihg7Lmt0ZovKqL3o/BdPj8rwR5IF3aOuwel5sAuOtenDR8+0dDIO0f2V9KPTF0ONRFkCJ0LnbvXKxyVOiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=On0sWgz9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=poFxukDa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="On0sWgz9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="poFxukDa"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VGBijC2165149;
	Mon, 31 Aug 2026 20:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=EUjundtly4xbe8sf
	LxNgPFYa9tnzAVQeduVLpTT9phA=; b=On0sWgz95Fmt7HWPSJwG+TBXsn3ZcnHZ
	M8r1z/GwU+4XIJ178Xvd6/PFwk3X0k8ZhnXSkcHDsNkF9L6T6u4C6svjk1xrkv6e
	h4/JBalxvalcZeE5CRXpntW1LbBrNgjBZqPDzw/0TQXgwD1w+B9kMLEwxk1t0Hmq
	I64TFKA6X4GdT48Ui8pDDu6/OhUqAI7VjOZGLvhBDuC2WlCuDyCW89F+rm651iuo
	pYFiyGk67KSyRUyNLtcscey1Gzb8TsnlvQYnJ1dHFJUBbetFJ0Kf4FzslKfwRB8Q
	owcEGOK2BGfb+PZoDRTqmSOCS11LMxvbufXT/6yQVFiXZ3uB4uPSdA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqa7kbk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 20:23:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67VKK8ct038776;
	Mon, 31 Aug 2026 20:23:01 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvdgjj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 20:23:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmkEXwXVQtFfqs8/Ib5WOLbXBWDF2p2A54+M00ZXFkDvbqYUqPC2IfxM2Sx9XgnVyrVWfR5xxX7kf0/dHnm17KGC5j2Ua8mjIOqACuJqJjNUTkENE0hom5nZpMw8QGmbnWGT5/iXmDs1u4G/oaEJOTjIJekwblxdVM7Pan/NNGF9awPz5i8CzfPzjpbr7XFaa4NovlQhQgm11HWf6GPHpSWCeHRMg4VUH94CF9GBzkADyr6oCH7NI6qFNDdKvZJigGRKniqzUVbQTzXdIKwPDr6yW9DbnFiTqNXffkqRjhjWE56beICzKEftsDMM4rhXVKElnMmW38t4usznjmTyUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUjundtly4xbe8sfLxNgPFYa9tnzAVQeduVLpTT9phA=;
 b=j4FN5mFnc+EhV6XZAoRjjn378GPsh0wUC4OSkDfhUyk4LnaJNfTnUyL7L97UYTMKGwbglBjUibMvFOwr9cQHQ3rEDZ1RBuOgzBOTLF4bIT4vy1NU39wvW6nV7/cY2ZU7uHN2tPgnMhYphaNXBYuMWlXL7UE47VwVk9O1qVXAqXWNBmfOtxB25L8mMEDfn/4yWcQ/yHKJzQc0BiI7Bv7uB9BBx6uxKptlyPcb1b6I9uD/WZDCxarGPymerMLg2U/Xmd7/HfrGJa2eIV8txta8x7iQZ7bRhcZgjQN6Le1s3XsGVsHvtT4TBE33qJLD3VwR8URP/76YEUERPEzSbjA5vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUjundtly4xbe8sfLxNgPFYa9tnzAVQeduVLpTT9phA=;
 b=poFxukDar9SW/9zjsMK2mhZ05/O85kpXUg7CcDyGoFXl5+cg7wyr6zUOyZ8GbMGHZWIj7iaCEsHPUDb6/bZz6eeHma6fIvlvKzgrhjUIRG6vYDlVVojg1NFJ28PujGPTpMfCY4TQtzwLg5S3WssWN9QcfHEUQWlt8GQxEnrtCUA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH2PR10MB4263.namprd10.prod.outlook.com (2603:10b6:610:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 20:22:53 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 20:22:53 +0000
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
Subject: [PATCH v15 00/16] barrier: Add smp_cond_load_{relaxed,acquire}_timeout()
Date: Mon, 31 Aug 2026 13:22:35 -0700
Message-Id: <20260831202251.305046-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:303:b7::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH2PR10MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8ed07f-b47d-4e21-6d83-08df079da29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|13003099007|6133799003|3023799007|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	5O/OzU7YWskqulxq3qVsWP4a7yLLGDIZzQyIRfdDsIVBvh3Bh74GC+J009ScfaHJLdhWiDF3DMjeKQWqa0p5+VLrs5aQaJYm5lkF64Ht/06e2Dhl3iM9bqf61wgcnLBSGOoeX4BMrSjjp3RPq8rH9oxm0x8IIsjRzDHYsPKWlIZjglyLF64AB4SlRmsklvnekal8IWX3neIzwGsKa8HYML2/yxcAz9AjCK44qkivTtwSaQprK8Z2wkMl99A6DIsE5/gOgEsKeqWZ/riYQgYQ3BrenaOHMiSrwAXB12SxJusBTUOY9QASEdOJ2BrrKhEqfnTYqSPgCKTfxsUz/rbO1GHl2swmXqM4Sqvww2/XpDA3vHNAfhCiDU+9tmJeKaUXvbYxLVg6YSa/jv0Rp6XMDm90RGSYyM76n5iowOHdI7qpvgU+Lx9QStB488Xjn8fRWHnRUUAaWNb+EfnbfbeR7/nSlmaf2cF6yzWb6GfxGdVMsNK5AbXnLlFr2wa2LTxjkvd+Lw0kVaVYuLuac/aCQCaaYY+MrTQIOAa+QJaQvCkLmSvg+laNtlwZakd7o7/UkNWNfp/iolW3LA0yQxWN1sBK1jKk6+HOQzliyPYZSUcObfXldeZW17WkkuL4JL2C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(13003099007)(6133799003)(3023799007)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1hvGPy14IkSCseS8zS4ZS6DuCT1l/C+t5eq3ABLnWBitMGoJ6BJW4TEqtaXb?=
 =?us-ascii?Q?1MWk+VJbecGebies/VUkqtKEemmEPZMraYmVhtwUuQcmVlIJcGBI0JHJjrEQ?=
 =?us-ascii?Q?ct4smBDHl1yMvwM31JGlY+KFTQJp4Iv9ro76eic1OGUOYL8ifmXbW8yMq6kv?=
 =?us-ascii?Q?cq7BI5h0REANk3PwawAEjD8uuNgsFevGNOoKIcKJICw1Em1X6Q88hlQ0KoOB?=
 =?us-ascii?Q?rA+Xwv/BYZD6L6LUvtpg24WUryr5+vXqIHNeoSuTR/jITLOUF/wNpuIfWTHy?=
 =?us-ascii?Q?/nphIxgmtuRNCZQW2ZZYdzxwm9D3Ary7exBH8CxRp6hTuV9z3tHaW58jO9Ma?=
 =?us-ascii?Q?InCMUUR+VxKtctlWjP99Nlgflw7XcNUWdbg4VUe1j8d4kDpR4KWae6B7YXrD?=
 =?us-ascii?Q?0dKQ6TOf5ysynii0d0z5r8YMfAq/6GLyCs0lo6a6rKmB+tVraxZ+PUiPcofF?=
 =?us-ascii?Q?v9l9dCdgugHXe7RGwSRuAYxJiJ5jFd0tyM1BQEo5Bf9ntX4O7HC6aPehND2m?=
 =?us-ascii?Q?5ox0UkwEV6dn4/UM9Tp83bIrOq6DJ1v9pPLoK655AnRp+htf5sFg0k7aiqcI?=
 =?us-ascii?Q?UzTFAz9aatradeyTj/aa8HN6kLjwvHQ/X+NJgtVhtVwr+ccIg7fGHjEHKpfw?=
 =?us-ascii?Q?KLARsUHSs/Vlkm9ui8F6u0yxajkYwAYA61nvDQqPap1RyVjA67FiHEsMkjF+?=
 =?us-ascii?Q?TCPW0iPqighTSWPW4SuET2WU0gP8s7QCPPgtl8HIRwkYsXkX1VrQkqD4Gyf/?=
 =?us-ascii?Q?8qXjDjT1Hd1Ci8uyJRqzTpGyGhJew8DbYp/4X2nfzAPDBBjJKUi3BUDpRZIJ?=
 =?us-ascii?Q?k/lqCWb990eGz4R8I9kuvMM/stgsIy4mRMzmnScCLKmjK4jHA613zHDPscy6?=
 =?us-ascii?Q?Q2BsLpiJmOs8kLMMJzGauWccL6QPPZXrDBR0UM1FUEde7dz+cQPLk33DucHh?=
 =?us-ascii?Q?XXvbAsZW7ATzzcb5na0FxX3YfMy4Ol1yXvKNL88W3pqyfd75xb/dPUOTedXJ?=
 =?us-ascii?Q?KLCf32IxDi7DqAmVmaj3OD8TF0us25QxV6Hsl2QyjSoOKxXDOlZnr+x9/a93?=
 =?us-ascii?Q?HAxd5FDDVI44FKgqC1BPFvVgVRaO7K9WOObBVhykkaMEjmTnyMWwf5P0zPmc?=
 =?us-ascii?Q?9ZIrQi9x9KEWNsBm6IKMKfsa5ni7F9cfhtS0o1RiBb9+1OfYXiyUDb41tvYt?=
 =?us-ascii?Q?uTHZbNnjpNMZRP/V+Fp9h7ccqma6kwOkgKrJ4OfHAd7qAFUOh72cJI/iTkPn?=
 =?us-ascii?Q?B0WJu0TQ2QTkv71k582b0D0QxDuZTvyM9O6CaIuem8NPYuI0XlRfpf8zwOoJ?=
 =?us-ascii?Q?6VnlA68cMAvqxrr+DuOVLNBMUgYlthcvJq71Q7Cs4GJ+tYLrWN18vB0ngh4a?=
 =?us-ascii?Q?8ABVw4xoq93iFK1l64BFkdDEKbulPQ0xkzQpv5nZLTix8k5r4pdcHazGerVM?=
 =?us-ascii?Q?Olno9BPOBVgVRYXkhFnVejexTqguwr7ZXQtpVRAoGmyAPDkxOdQ4VucKQ1gd?=
 =?us-ascii?Q?7AzSOe85tOVoa3q09GWJFYNhV818NPOFPslT1vIJCandtCBLzZ+lgceLul2O?=
 =?us-ascii?Q?Q9A2rmltZV8VxdHLZjcO2AIC5G1ixr6+peYCmH+p6Om2aK8VEg8p7vJNGYTx?=
 =?us-ascii?Q?LwluV08nqmIbVf+aF4nEqIMAF75fT24GEqJ4nXa9MgM5vQHFq+RtF6RbY8h6?=
 =?us-ascii?Q?cN1duBuMvcU6Z2DF2WobzycfT8/OP6QRiOWmEQE6FoHCjDc8O7UcROpZ2mpx?=
 =?us-ascii?Q?bvGL+rfZ9LQuY03HMMoK3lEp56SgS6U=3D?=
X-Exchange-RoutingPolicyChecked:
	YhEvt9lWQBZVFuZY7zxq8SczL01NBJtXvku/zBcNVU5gtrjBYDEgQsE0E2z6R7HrP9CqnQqFj0ZtyZZ7luuHbiP2qlB5ukpIm+1/Y6+1N5BQr6oOWfJrbSwUygruiXB7uL2iThrcI/qei5SEODVRwQ+tTSyQ8xyJqNlsLMwjnU+QiWmLdSNvpIaJe6QdhGzE7FpJEHodAUG6sZ6rKfe5h9Ptd6HwocUBLwGJoUvqALFAyY8EUJXyAUq1zjQIqoYv6ZyTapzlD7t2Du67ivFau16DIrdA/skdfRMswYZaat22T1OxkG6tPvl9quHPo+IEG0LPJrCZH1nZn1B5FZYVzg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1m+Uczx8SC0oh8b7h/AazqPLxejj9xFKL0t/pHQeDwXWFJB8SkXrO+OoU/omHSbb3mjDiflz+WfGZWwTiK22c9xTDJDj43dwaew15jCSW23qflTHzRoOuMt7f2qEFW/oeh0HnGYwV5skbqweFtdwvuo+R2474beq8V0M8ZSFDT+ZONd1axXhHgpv2W8Dac9X6zSjfuGgGCkhcBhCx3oCtmg/3FJX/H+hULcgLCZGgvgp6Ba8A+hEfQnbKZq9fO/eYnaCWldT5H5MXYrl4aWCjfA55lWGxltO2g9KcX8YJAtoCgTsk+UGiCUKFTIwCD4xim7yRoqyvMpczdYli3rDHkWVLMS8XNEpZ7d8Oh/vrnz1WPvxEzxZZGiKdja0lawSTGsY9dfvMaADvpjiUYXNi5KIMGMScwDYMxXKPANzuYnHWYPSxtpc6zll839PKJf8dj6ybVPEjpB+jycwTYT+3dXVEkPc8gr1rY/s4tYo7KxzYKWF1+OOC9r4TSm8089iHTwlkgkLmVIvid3fc+szKSuixxN7zlpgzy+UUSRYlN3DLAfshN4HifDZRKM3nzzJoF+5CFNwZ4uOn4bO6DXejGp0X/QWqO6lVqXTI2ET9J0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8ed07f-b47d-4e21-6d83-08df079da29a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:22:53.0510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUDAffDS2s0Pav0JeMMqrEDYN1G0544wLDSYpD+qNLg/flqU4FzDI2Z8tVJOKhvzjPYqyHYpuF+gkp3Oqh9GyOkElmt3GQPCIV5j6fB8sn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608310176
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX0fwAc+1gpymT
 sizEGfodKpq3Q3UNwmv3w+zHj0C53WoJVZQrUJaXHV080J4HOVVbbM+3/gC/d+UgMN33Dz5+jsH
 OroOp2bctF85lO+m+9LjcUC7VjN/hJMqDXfS90XdG4Wy78YL/t4w
X-Proofpoint-GUID: arr9hMOknZ7Pn9Y7rsLJG64qhDXJ8BM0
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a95e2a5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8
 a=WsHKUha7AAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=Z4Rwk6OoAAAA:8 a=moej7z2YPE_O563F8YEA:9
 a=H4LAKuo8djmI0KOkngUh:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-ORIG-GUID: arr9hMOknZ7Pn9Y7rsLJG64qhDXJ8BM0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX1FH8ERRyo+mb
 ya8uIkOPAUh/q7oZkD6WUd4xvq8uyk72wUh1uEkLC1wmmCYU2TcoNOHd2f1AOlgYcA4ThEquWlm
 HbCAwkG4QuxdHMsb92lIDCrkStRDWmn2giVEoex53wei3JZLOCVm2K+Fajn507+piOI/kyeJvLp
 03N0yHTzws/pY8qpu0eGqqLup3QJr/6/zSErwuHbMf2LvdkNnPb84XOp4wiBa9OmUMXArhA/L2L
 wBTmLDYUiFwhfLL/wNVOWaOED/FxF/+tQYeFOzvqfJHJGkhA+glxL42+7rBE8TsRN/D8x8FuOIs
 It9HsNE7FhGCm2FO7h5YVZjxA5SzAiYVC1hpqbvmnxb+HyHdT7n5+krJYojIUJRCRJAjvyb94cI
 EGRADvMhqE3VumJG5kVQuDymCUzpu68KX0ADpo2ioiEVL9b/ChqYcILa4rrKcyBBCGSCZLR6H/E
 vvffajkLha2Px0cb8kQ==

Hi,

Changes in this version address sashiko comments [16]. Major changes
are:

  - patch-1, "asm-generic: barrier: Add smp_cond_load_relaxed_timeout()"
   - deferred time-check is now limited to a single usec.

   - smp_cond_load_relaxed_timeout() now enforces that the timeout_ns value
     does fit in s64.

   - SMP_TIMEOUT_POLL_COUNT is explicitly defined to 1 if the
     architecture provides a waiting implementation of cpu_poll_relax()
     (defines CPU_POLL_RELAX_WAITS).

  - patch-3, "arm64/delay: move, fixup usecs_to_cycles()"
    - convert the 32-bit arithmetic to use mul_u64_u64_shr() to avoid
      truncating large delay values.

    - make usecs_to_cycles(), nsecs_to_cycles() static inlines.

  - patch-6, "asm-generic: barrier: Add smp_cond_load_acquire_timeout()"
    - provide full acquire semantics (via smp_load_acquire()) in the
      failure path.

  - patch-16, "barrier: timeout validity checks for smp_cond_load_acquire_timeout()"
    - add some tests for clocks that can fail (rqspinlock like
      semantics)

The core kernel often uses smp_cond_load_{relaxed,acquire}() to spin
on condition variables with architectural primitives used to avoid
hammering the relevant cachelines.

(This primitive can vary greatly across architectures: on x86 it's a
cpu_relax() to slow down the pipeline. On arm64, this is a __cmpwait()
which waits for a cacheline to change state in a time limited fashion.)

Regardless of architectural details, typical smp_cond_load*() usage
does not allow for termination until the condition change occurs.

Beyond the core kernel, there are cases where it is useful to additionally
terminate on a timeout. Two cases:

  - cpuidle poll_idle(): wait for need-resched until the cpuidle polling
    duration expires.

  - rqspinlock: nested qspinlock acquisition that terminates on timeout
    or deadlock.

Accordingly add two interfaces (with their generic and arm64 specific
implementations):

   smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, timeout)
   smp_cond_load_acquire_timeout(ptr, cond_expr, time_expr, timeout)

Also add tif_need_resched_relaxed_wait() which wraps the polling
pattern and its scheduler specific details in poll_idle().
In addition add atomic_cond_read_*_timeout(),
atomic64_cond_read_*_timeout(), and atomic_long wrappers.

Structurally, both the smp_cond_load_*_timeout() interfaces are similar
to smp_cond_load*(), with the addition of a rate-limited time-check.

Usage
==

These interfaces drop straight-forwardly into the rqspinlock logic
since qspinlock already uses smp_cond_load*(), and the time-check
extension can now be used for timeout and deadlock handling.

Using tif_need_resched_relaxed_wait() in poll_idle() removes any
architectural details allowing arm64 to straight-forwardly support
that path.
(However, for efficiency reasons cpuidle/poll_state.c continues to
depend on ARCH_HAS_CPU_RELAX since that is defined on architectures
with an optimized architectural primitive.)


Performance
==

Apart from simplifications due to this change, supporting polling in
cpuidle on arm64 helps improve wakeup latency (needs a few cpuidle/acpi
patches):


  # perf stat -r 5 --cpu 4,5 -e task-clock,cycles,instructions,sched:sched_wake_idle_without_ipi \
  perf bench sched pipe -l 1000000 -c 4

  # No haltpoll (and, no TIF_POLLING_NRFLAG):

  Performance counter stats for 'CPU(s) 4,5' (5 runs):

         25,229.57 msec task-clock                       #    2.000 CPUs utilized               ( +-  7.75% )
    45,821,250,284      cycles                           #    1.816 GHz                         ( +- 10.07% )
    26,557,496,665      instructions                     #    0.58  insn per cycle              ( +-  0.21% )
                 0      sched:sched_wake_idle_without_ipi #    0.000 /sec

       12.615 +- 0.977 seconds time elapsed  ( +-  7.75% )


  # Haltpoll:

  Performance counter stats for 'CPU(s) 4,5' (5 runs):

         15,131.58 msec task-clock                       #    2.000 CPUs utilized               ( +- 10.00% )
    34,158,188,839      cycles                           #    2.257 GHz                         ( +-  6.91% )
    20,824,950,916      instructions                     #    0.61  insn per cycle              ( +-  0.09% )
         1,983,822      sched:sched_wake_idle_without_ipi #  131.105 K/sec                       ( +-  0.78% )

        7.566 +- 0.756 seconds time elapsed  ( +- 10.00% )

  We get improved latency because we don't switch in and out of a
  deeper sleep state or from the hypervisor. This also causes us to
  execute ~20% fewer instructions.


Haris Okanovic also saw improvement in real workloads due to the
cpuidle changes: "observed 4-6% improvements in memcahed, cassandra,
mysql, and postgresql under certain loads. Other applications likely
benefit too." [12]


Changelog:

  v14 [16] (as listed above):
    - patch-1, "asm-generic: barrier: Add smp_cond_load_relaxed_timeout()"
     - deferred time-check is now limited to a single usec.

     - smp_cond_load_relaxed_timeout() now enforces that the timeout_ns value
       does fit in s64.

     - SMP_TIMEOUT_POLL_COUNT is explicitly defined to 1 if the
       architecture provides a waiting implementation of cpu_poll_relax()
       (defines CPU_POLL_RELAX_WAITS).

    - patch-3, "arm64/delay: move, fixup usecs_to_cycles()"
      - convert the 32-bit arithmetic to use mul_u64_u64_shr() to avoid
        truncating large delay values.

      - make usecs_to_cycles(), nsecs_to_cycles() static inlines.

    - patch-6, "asm-generic: barrier: Add smp_cond_load_acquire_timeout()"
      - provide full acquire semantics (via smp_load_acquire()) in the
        failure path.

    - patch-16, "barrier: timeout validity checks for smp_cond_load_acquire_timeout()"
      - add some tests for clocks that can fail (rqspinlock like
       semantics)

  v13 [15]:
    - rename kconfig entry for the barrier kunit test to follow
      the kunit style guide
      (s/BARRIER_TIMEOUT_TEST/BARRIER_TIMEOUT_KUNIT_TEST)

    - make the kunit test be visible only if CONFIG_KUNIT_ALL_TESTS
      is not enabled.

    Both comments from Julian Braha.

  v12 [14]:
    - smp_cond_load_acquire_timeout() now only has acquire semantics in
      the success (non-timeout) case.

    - arm64 now does not define ARCH_HAS_CPU_RELAX as without also
      defining TIF_POLLING_NRFLAG, in some cases we end up with a
      degenerate version of poll_idle().

    - kunit: removed the test case for timeout=-1 (not supported)
      Also add test cases for timeout=0, timeout=1.

    (All of these address review comments from sashiko/bpf-bot.)

  v11 [13]:
    - addressed some review comments from sashiko (see commit notes)
      - The one notable change is to the implementation of
        smp_cond_load_acquire_timeout() where there was a missed
        control dependency in the timeout case.
      All the others are minor.
    - fixed a low probability race in the kunit test added in v11.
    - added a bunch of kunit tests validating the implementation's
      use of the clock.

  v10 [10]:
   - add a comment mentioning that smp_cond_load_relaxed_timeout() might
     be using architectural primitives that don't support MMIO.
     (David Laight, Catalin Marinas)
   - added a kunit test for smp_cond_load_relaxed_timeout() (Andrew
     Morton.)

  v9 [9]:
   - s/@cond/@cond_expr/ (Randy Dunlap)
   - Clarify that SMP_TIMEOUT_POLL_COUNT is only around memory
     addresses. (David Laight)
   - Add the missing config ARCH_HAS_CPU_RELAX in arch/arm64/Kconfig.
     (Catalin Marinas).
   - Switch to arch_counter_get_cntvct_stable() (via __delay_cycles())
     in the cmpwait path instead of using arch_timer_read_counter().
     (Catalin Marinas)

  v8 [0]:
   - Defer evaluation of @time_expr_ns to when we hit the slowpath.
      (comment from Alexei Starovoitov).

   - Mention that cpu_poll_relax() is better than raw CPU polling
     only where ARCH_HAS_CPU_RELAX is defined.
     - also define ARCH_HAS_CPU_RELAX for arm64.
      (Came out of a discussion with Will Deacon.)

   - Split out WFET and WFE handling. I was doing both of these
     in a common handler.
     (From Will Deacon and in an earlier revision by Catalin Marinas.)

   - Add mentions of atomic_cond_read_{relaxed,acquire}(),
     atomic_cond_read_{relaxed,acquire}_timeout() in
     Documentation/atomic_t.txt.

   - Use the BIT() macro to do the checking in tif_bitset_relaxed_wait().

   - Cleanup unnecessary assignments, casts etc in poll_idle().
     (From Rafael Wysocki.)

   - Fixup warnings from kernel build robot


  v7 [1]:
   - change the interface to separately provide the timeout. This is
     useful for supporting WFET and similar primitives which can do
     timed waiting (suggested by Arnd Bergmann).

   - Adapting rqspinlock code to this changed interface also
     necessitated allowing time_expr to fail.
   - rqspinlock changes to adapt to the new smp_cond_load_acquire_timeout().

   - add WFET support (suggested by Arnd Bergmann).
   - add support for atomic-long wrappers.
   - add a new scheduler interface tif_need_resched_relaxed_wait() which
     encapsulates the polling logic used by poll_idle().
     - interface suggested by (Rafael J. Wysocki).


  v6 [2]:
   - fixup missing timeout parameters in atomic64_cond_read_*_timeout()
   - remove a race between setting of TIF_NEED_RESCHED and the call to
     smp_cond_load_relaxed_timeout(). This would mean that dev->poll_time_limit
     would be set even if we hadn't spent any time waiting.
     (The original check compared against local_clock(), which would have been
     fine, but I was instead using a cheaper check against _TIF_NEED_RESCHED.)
   (Both from meta-CI bot)


  v5 [3]:
   - use cpu_poll_relax() instead of cpu_relax().
   - instead of defining an arm64 specific
     smp_cond_load_relaxed_timeout(), just define the appropriate
     cpu_poll_relax().
   - re-read the target pointer when we exit due to the time-check.
   - s/SMP_TIMEOUT_SPIN_COUNT/SMP_TIMEOUT_POLL_COUNT/
   (Suggested by Will Deacon)

   - add atomic_cond_read_*_timeout() and atomic64_cond_read_*_timeout()
     interfaces.
   - rqspinlock: use atomic_cond_read_acquire_timeout().
   - cpuidle: use smp_cond_load_relaxed_tiemout() for polling.
   (Suggested by Catalin Marinas)

   - rqspinlock: define SMP_TIMEOUT_POLL_COUNT to be 16k for non arm64


  v4 [4]:
    - naming change 's/timewait/timeout/'
    - resilient spinlocks: get rid of res_smp_cond_load_acquire_waiting()
      and fixup use of RES_CHECK_TIMEOUT().
    (Both suggested by Catalin Marinas)

  v3 [5]:
    - further interface simplifications (suggested by Catalin Marinas)

  v2 [6]:
    - simplified the interface (suggested by Catalin Marinas)
       - get rid of wait_policy, and a multitude of constants
       - adds a slack parameter
      This helped remove a fair amount of duplicated code duplication and in
      hindsight unnecessary constants.

  v1 [7]:
     - add wait_policy (coarse and fine)
     - derive spin-count etc at runtime instead of using arbitrary
       constants.

Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [8]

Comments appreciated!

Thanks
Ankur

 [0] https://lore.kernel.org/lkml/20251215044919.460086-1-ankur.a.arora@oracle.com/
 [1] https://lore.kernel.org/lkml/20251028053136.692462-1-ankur.a.arora@oracle.com/
 [2] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
 [3] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
 [4] https://lore.kernel.org/lkml/20250829080735.3598416-1-ankur.a.arora@oracle.com/
 [5] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
 [6] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
 [7] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
 [8] https://lore.kernel.org/lkml/2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com/
 [9] https://lore.kernel.org/lkml/20260209023153.2661784-1-ankur.a.arora@oracle.com/
 [10] https://lore.kernel.org/lkml/20260316013651.3225328-1-ankur.a.arora@oracle.com/
 [11] https://lore.kernel.org/lkml/20230809134837.GM212435@hirez.programming.kicks-ass.net/
 [12] https://lore.kernel.org/lkml/c6f3c8d3f1f2e89a9dc7ae22482973b5a51b08cb.camel@amazon.com/
 [13] https://lore.kernel.org/all/20260408122538.3610871-1-ankur.a.arora@oracle.com/#r
 [14] https://lore.kernel.org/all/20260608080440.127491-1-ankur.a.arora@oracle.com/
 [15] https://lore.kernel.org/all/20260702013334.140905-1-ankur.a.arora@oracle.com/
 [16] https://lore.kernel.org/all/20260714073041.40250-1-ankur.a.arora@oracle.com/

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: bpf@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org

Ankur Arora (16):
  asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
  arm64: barrier: Support smp_cond_load_relaxed_timeout()
  arm64/delay: move, fixup usecs_to_cycles()
  arm64: support WFET in smp_cond_load_relaxed_timeout()
  arm64: rqspinlock: Remove private copy of
    smp_cond_load_acquire_timewait()
  asm-generic: barrier: Add smp_cond_load_acquire_timeout()
  atomic: Add atomic_cond_read_*_timeout()
  locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
  bpf/rqspinlock: switch check_timeout() to a clock interface
  bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
  sched: add need-resched timed wait interface
  cpuidle/poll_state: Wait for need-resched via
    tif_need_resched_relaxed_wait()
  arm64/delay: enable testing smp_cond_load_relaxed_timeout()
  barrier: add tests for smp_cond_load_*_timeout()
  barrier: timeout validity checks for smp_cond_load_relaxed_timeout()
  barrier: timeout validity checks for smp_cond_load_acquire_timeout()

 Documentation/atomic_t.txt           |  14 +-
 arch/arm64/include/asm/barrier.h     |  22 +++
 arch/arm64/include/asm/cmpxchg.h     |  62 +++++--
 arch/arm64/include/asm/delay-const.h |  35 ++++
 arch/arm64/include/asm/rqspinlock.h  |  85 ---------
 arch/arm64/lib/delay.c               |  19 +-
 drivers/clocksource/arm_arch_timer.c |   2 +
 drivers/cpuidle/poll_state.c         |  21 +--
 drivers/soc/qcom/rpmh-rsc.c          |   8 +-
 include/asm-generic/barrier.h        | 154 ++++++++++++++++
 include/linux/atomic.h               |  10 ++
 include/linux/atomic/atomic-long.h   |  18 +-
 include/linux/sched/idle.h           |  29 +++
 kernel/bpf/rqspinlock.c              |  78 +++++---
 lib/Kconfig.debug                    |  10 ++
 lib/tests/Makefile                   |   1 +
 lib/tests/barrier-timeout-test.c     | 258 +++++++++++++++++++++++++++
 scripts/atomic/gen-atomic-long.sh    |  16 +-
 18 files changed, 663 insertions(+), 179 deletions(-)
 create mode 100644 arch/arm64/include/asm/delay-const.h
 create mode 100644 lib/tests/barrier-timeout-test.c

-- 
2.43.7

