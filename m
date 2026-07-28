Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C2A3D76;
	Tue, 28 Jul 2026 23:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281795; cv=fail; b=H5vpOxhgnVNXXyrDT/riOBGuOJeqpyrim/mg/Bdbknl0KMDc+qihytIqqmiY4GKnP17TfLHf25RJ5vxeD3l/GI1mlApBv8CpEjtFoyCNFrPhf0Xw/UwWj0tQZw0IzFWoVYYLtGLj4bFidHhgEGImpsaSDCPpIVxAVpUzlLf18w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281795; c=relaxed/simple;
	bh=YHo1w0lw4bCE6NdyGPpx2pNiL68V2gpUM81un0iLFXs=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=O2qroMvCKPcihyfY+Ab2FWFlhg0JrL/A11Qs0EWyktBYlYR7vBv+ZiYElPUwNN5oM8TcjxIojDFqHLD9FtfN3i7cTl4rMg84s/8CamvsSOilVkxxHLPKqRQRg55/whYpVUF0/M7zFiHguXzjsgG1yC9cLT1J3vE3YQfywT2En7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Blfa0QAD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CIVrfuSj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Blfa0QAD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CIVrfuSj"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SItc7A1279545;
	Tue, 28 Jul 2026 23:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=LCXjYby4ShTZwHkMju
	LKIFoPtYa2fW2q3uGtWZFTitM=; b=Blfa0QAD+ZJxJMQN2QcfP5O9bEiiWuuh+4
	ZTjb+b58G9RQDK/vtMzArClAgI0vX1DQGEzrOKxmAQPGAgXv8GrGCc+vVrtJ/TtR
	6VJjgPM/wXSs4hUphHMGhulXCayVSb5iUEwKpGqsuGdqy8Ft/60PiHCnlMpvlhG1
	CmgElaBJuNJEed5eSY0mc4ZjCydNhiJzx30lQgbcMbcqQVZL0nYJz6pR/0jXNJ8/
	gIJwS4+/vYhau7gj3kXO4VCsgS7NZCEgBQbGzEpdd916NyoyT0klT2o3BOX6V9Uq
	GNgFuClLsi7RPPf2ZEShmes+YGuHTwMIKXRtmTWRcoxxPD4GCG3Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr3pn22t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 23:35:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66SNZfdG032155;
	Tue, 28 Jul 2026 23:35:52 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012014.outbound.protection.outlook.com [52.101.48.14])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fnh8j5e89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 Jul 2026 23:35:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6avoK7kXLYIRhQkhkkHppAyIsXdIc6vY/OJkxHaq3H+v6/ztg/EVAoYKoqQX9zVWtih7X/LXlHgaQ5NBqOPTG2i8TBIJWz9KcBzy/OEKF74QhTLYdli0Rp4jfLb89s/Zwvgo2ui3ac9oy3+KtQEtA73EsyJEVGRZ+M9uxFVcOHsTUdYO1kZhmPOn4mZR897/C0eskpVXfrBH7a6ODtAfpk3JXhhfTUmnXMqeH3cO/wes8LKa2E+06DDKdqG7S28TFKRGhf3FYP19kX3jOgVrkI5y9WvBfObo85LV5sYcK9pPmMa99AVEorj+RTIK7wSBtQTsHfNNkfA8krAr0v0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCXjYby4ShTZwHkMjuLKIFoPtYa2fW2q3uGtWZFTitM=;
 b=WDCAHJ1QU4w1C7Fqi4FWS+XUHsHSVHsa1nDSsIJg0Vl/dato26XvqMvdR/gF8vhk5BlQryOoWCrdGtHftuXoqBm3UQk5C6GBnVJQTAd+0EZuajdGXnN1bTFR/ttGxHMxwJ/9w/m3Weg0tXUOLo8W8bukepsqogvFGqhMVng+GyD0HtE2W1++izfOqZCHDhFpf9VHT7FNWEhR50wMZyyGgOKSyDHxRqye1S9ShRVY0VxE1p5d3s3NZmOBsbY3J1X3Q7SHroqutTuE0DfSJP+iRsL5OTP8/4ZXZ47BvBVh97J3fua+Qys3BEtuV9f1EUd+7Y1HhGbBwUQaDQ2SauCFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCXjYby4ShTZwHkMjuLKIFoPtYa2fW2q3uGtWZFTitM=;
 b=CIVrfuSj0Cp+3h7PVWFIfXdueiLmckI76eY73mqYX43rxxX+PL8bBEkZz6hZQ29Bxdp0HMefQ8bBE+xenosHjLNguj2KVRu90nugN++tiuYV7zl/s4RwaAid0Xfd6OHQhzH/2iuenfXnJFvK0b0EWNBt/A+W+oNZqolSuv8C9f4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6832.namprd10.prod.outlook.com (2603:10b6:208:424::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 23:34:33 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 23:34:33 +0000
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
 <87bjc78lld.fsf@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        will@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, broonie@kernel.org,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v14 00/15] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
In-reply-to: <87bjc78lld.fsf@oracle.com>
Date: Tue, 28 Jul 2026 16:34:31 -0700
Message-ID: <87jyqe7koo.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0267.namprd04.prod.outlook.com
 (2603:10b6:303:88::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c13206-8fd9-4064-a03a-08deed00c716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|13003099007|6133799003|56012099006|4143699003|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gQPHXfHc3O9PGTUGfZgnfpCoiXWrwNwk254w2vjKyyJpCPLnlKf58FC7Peo3eBUUd7vdiqmqlNMO+akDEHKixN+XwCU0LKz5mD2hndLE+ZjBl4Hd882SI2VdLQyc/rgJxO9vuKZJJqOe1FdqHF+76PvsFuwlY4Dv+z8t+Ln3SX9rcQlkwYfzGSuGXkBZLZuJgmjdBR+pIZXSVwAQWheGnoBw/G3F9p8IbQF1QV8TfKYBGVwUa9uk6VP7MdPVsIuPpB4JoIpexxSLdkmKILXbHFB/33C48LrDSM46JFGr1/gU8tS/RS/1Oy1wDmcB8xa2iWZBPXLxArJAWm5atXvaoTwUFtmEPuN/JhojWMZjAIdMsYy7VxcDA1fgnsL720zdz6TcsrK9C7vUO5LjPggG87+NbHfXgbPUPdgtmDV8hUgd4SujFTRYNbHMTQmIWJhhQoTRfQ7Vv9bDUg9JFA+9tQ5jeoy1hpxIiv8CWjqXLELgxlJZ/pu9tLu/+RAlHM9mFTKJHUdizjVmeHYiuK9F6gmceBw8QTvPLWiIx4d/RqipYg+/POlukbzkX5ufPR9lA6KfeVzl9ZLlIEThEJm6IMkENru4Al85zWrP0RciIT+Dkd96r4tQBqmLWyyQ2jBk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(13003099007)(6133799003)(56012099006)(4143699003)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?El/g/O0O2CDvnuxK7LIMwRn03WuVCOrE5eKBwFz1rJpjgK7g1VTkbRqykA8e?=
 =?us-ascii?Q?L3651cLRyjpiaGseYBxP8xvV3SQteT2LQnKti3Fwhv3wcA4IXYWi0c8IoyAl?=
 =?us-ascii?Q?QP7RT1UQwItrN+ipcJ9PYAy5yLGjmROKILe1tsWphtvGiU/9Odg82IxGI8oA?=
 =?us-ascii?Q?QepbPc6G01wmWmKENg5tfVaI34si9U4C5QW3L4WDXx1f/WHHWrCs7x4V14Ty?=
 =?us-ascii?Q?mqa5ObmXsSM0FAmzyduDbB6g9OkQZCOSiwNLP07tH0ij9QM5zoTXYKFzpNWa?=
 =?us-ascii?Q?aF+u0GgFiHA792jB38NfuZ/Udc7qCuAh2rhDQqe7m99dtcgEwVq9kyEOQL8e?=
 =?us-ascii?Q?egbwt1ChzRjNLV86/cHVME0xNVNqGmDroY+RsCLEHXPj/DTwRHhJrkrwypZi?=
 =?us-ascii?Q?U9Z+DAxt9fow5JCKyiRGwbfgAgYfEKefVJEKpUwuisBsbYDlxYqvlA8V0rpn?=
 =?us-ascii?Q?VL0nnNttD/qeS1YXK6G/m/L8YFJpxaAfoc+yu4pAgWFsugLxbGkgjN62/E8n?=
 =?us-ascii?Q?zkAbKwHDgXuQLATBEJxHkS6Dkv5EBF23m0D99VNuDjxJxJUnijk3UoJSPKjl?=
 =?us-ascii?Q?JSi1q6sbtfOtA0e1vzdvCCsZfxX21cYmq5EEFOM+8e5Xlg2ZXprgO4IDdKNG?=
 =?us-ascii?Q?n403eAa060zaqLwUGi05L9AkUgrW/K3SPaXjC/qpY/A+FI9U2Ti5yeXi8CJQ?=
 =?us-ascii?Q?A+uz2Nqit0Ljp636q8fd2NLlccPzXSQEgQMM/xgzPgm1RX++Kc88Cc5aFXvk?=
 =?us-ascii?Q?xiJ0hR0Fcy0LfwCqxBdQw2IVZ+V8nAdsA6gnvIaEhfeMw+ylexvhKxnNYpiA?=
 =?us-ascii?Q?6wfthxLQ+TrkoGdLfVfCwDoYgRFQ5zztN7BrpWUI9tog1vp4NIV/aa960ntt?=
 =?us-ascii?Q?FVrfUnSgupG5wn/f5IQxgZNwPVqcondSsSRbmjQ2ho4lgrqmVY69uDxgtSvU?=
 =?us-ascii?Q?/47m1PKfVewWWA0Uv9JbVHB4GKB0YLmOHG6WO2b9WU34FF0wvF4sYf+bGsn/?=
 =?us-ascii?Q?u9LvTcRANDT3zid/oQAZ/C+3uJlRCnESA05t/Q3Uor7zJRIwKw+CyL5YA0zA?=
 =?us-ascii?Q?jV8xovAZHY8fr6EcwlvSwaoxFBOVp4q7E1T2EJ/cl8/Uj19zg9WGQyWV6Jfi?=
 =?us-ascii?Q?7jynw0PfhKUcp+ckYmdGL1sBcjgyJA9y4yRLw5lnC31Mxc1TxNmRyCFxW/El?=
 =?us-ascii?Q?0utGLXZ42oU3e2cHSkwrG1a/O7R9aDF1y+qC1UrfDuTNCuDgjEZNebEAa6NL?=
 =?us-ascii?Q?IH47dl2FebzgfffPPtzLq6a1nj75XLDhQ6xZPgMbggCJQV2hXnQI2p0pWvHJ?=
 =?us-ascii?Q?M5VKBe4+iew0RL/4+ilCtRGO1v1NWvtzzGHBntjFC+4nPtYhati0F5NZQCnb?=
 =?us-ascii?Q?18ZI9brNCuJ9YX06Hm7dZoJtSBR0KkUFGWeXB9nO1l4rYWFeTDugDrT6AjqI?=
 =?us-ascii?Q?iohu8Cx54fL6LF6bGFFGY+NCnZricQl2mxpNhkpomtd+yWL1dGDcTYo5lJ9X?=
 =?us-ascii?Q?OLUFEVt/kLfojxQpxkLarfFb2Tf7clG8mmNCfVvQFqto6Oo8dbIg6NEYr/o2?=
 =?us-ascii?Q?r203HP++YdO4vfwGrXBlzfAdKVIAVAuVLvUj4PjqPSnTJnjTCRw0OtmERSgw?=
 =?us-ascii?Q?kTBdpJV40FokT5u98iOsxY8oIM5XH3ucG8iaA8dkmTpdKma9Fu+PK/sq1rXn?=
 =?us-ascii?Q?8kPrJzbkghNoU3tR6wCgxcqFD80NYzLCMmsE7WmQjvNinn9kWDlT2Jrs4dXg?=
 =?us-ascii?Q?w8Odd4Xw60dsIpcYpOgbPWgpyfzloYo=3D?=
X-Exchange-RoutingPolicyChecked:
	HbyrR6Bd50C82bzxS3spv686jrHODeVvcWahxCwPCtpRuc1RX4W1k4terpfpGxqzIG/7fdxFt07H/i8RqdW6EYCP5/IRvmt5XUn1/VGrjdimWWnCck9xB2sUgsLLVrjcYRRSaPr3Ks0Pu5FK1RYeSMhu4oHccBMCyFlcquP9ZLm92pNiE/fXTk37z9I+ph++mbBl9ehAaOgRxMYSViSvk89sQw/+TGobV+gql/S0/SA2u2E4KUmBiNs//5GOEYFeYsu5ic4nQVUvOIkarIVknIfGzLjWTv9lkYPhbxrWmjDNbAG606hQU3sqxJ2QOcOIFIyPkqblesANo994Q5VMig==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2LyCbGFdBp4qF7pUuC2i7sH+YYBQ/yYUJdjppIHZHB2p0qO/2yzOfxLnqUaltV57S4b0EV6XaQXjpzmVyib0RsxSILSnLWE9AQSmBsVZkt+7KPMHJMZm5qHNhk4s1NelTCZ5jE/bxe1X9rnazjffkZA24a8V4DHRGivOkrr9oynkBqvCAA3FFNu82HqnZ12VS75b9Ow5cbyV+kNlo/qxN4gaGnkhXE1/l5lztt0xTucAfFC+hyKNynuq12BTC0yc9YIl/L4EGFB/J9kzBZBH32e8DPU69oCyHYw/6eXjvQ/SaCWfasbATmHGvl0psgs7BUzNLGrE+mQ7TbQ1jid9eXJT+BcfbTW9YDubn0Rb6Gwu7ejzrtIEAOpGIoOMcSkGahiQBnKC1NhApt6tNohpk3HGq6/C1ZF2oO4eflTlyP7DUIZSeoTF5j/Z9zmtOnMY4moavy2yoCb9imHlr3hl7dzRPlkcPkenIbL/UGCafUs3qo6+IgDWSzgZmQR9C8nkwcDzMnrG4fI6AcV7CB7NYMPd4yNagXFCG4oUU/rd0o9z2GMhWe/9vVjKdglRnLSIQvPcm7wrCMk26sb81LJyen4ZetuRG/z1vA8z/wqYHys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c13206-8fd9-4064-a03a-08deed00c716
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 23:34:33.1160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jO2NVkgp0yo6YVSVGD8yYjm66XFWBn15rTInoq/KXWVDDI0RBKsTgytour4LIzKeo6lmBIpmuQdl96C2pzdGzI5YVzJMnKe/HYsUxfrAfZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_06,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607280201
X-Proofpoint-GUID: IObvIiHxiBlON8RC6BmE1OXSslL45JEX
X-Proofpoint-ORIG-GUID: IObvIiHxiBlON8RC6BmE1OXSslL45JEX
X-Authority-Analysis: v=2.4 cv=RKWD2Yi+ c=1 sm=1 tr=0 ts=6a693cd9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8
 a=WsHKUha7AAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=Z4Rwk6OoAAAA:8 a=xxH57KQ0QDiWDncxhyIA:9
 a=H4LAKuo8djmI0KOkngUh:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22 a=HkZW87K1Qel5hWWM3VKY:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDIwMSBTYWx0ZWRfX4hQ4V/EIqEG7
 W+z6HtriehPNEp5IgdnfkjCUGqhy1zvmFIcNwrLbwErrQ6PlFeMPSikQLIET8IGh4V5InnltuiD
 msFOHFzOGzFvBhMXssT3gyVhHj6dN4eG0SRs6/fpFI4D2FUWqrF8JKvJkrSQ1DMUCZhsRHz9NRY
 WuuaUJFMDwPFNXvs5xm5wGWa1TDpkX+qy3pjCf0VVXLZ9i/0d35vkbZ7kZYZdiieTLutOzs9Mij
 /KeYUfBTcTRE0Lfu8OehPqkFOCNRCZHv7rXRfJ8duS3OzU8p5tYyLs5NK2DXlw8yoj9kVaR0Tbk
 qagTv6c18pspEy6QjPdNGWnhQ5nmveKPGuGD5H1sLqkCi1d1wHov5tOtiUnhIiO6ril3JmVt23U
 W1mbXyBWybTqEpl82rWb2G2cLSl1mWYBDQKfieKeUCI2igy+0sLXWqKHwzw5sfFzj25zyv0RVJ+
 h5iWwQHFQfkTj8kKe3MfZ9bIGVIC5ujsVo02bLes=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDIwMSBTYWx0ZWRfX5uzw6mF9x+5v
 0yXVeUvEGU5BlsXeoZsTg5MIL4oMOxl5cnGE3NC8RbFwgFELfIFPI/bY2C94vZ8NSYdiZ2WyaGk
 piV8w8VAZApYEyfgSnD4VGq3mRfCZ+JAvR+Nh0Ks01Vq4BlOAKsp


Hi Andrew

This series cuts across a variety of subsystems and at this point most
patches have been reviewed or acked.

The only ones not are the newly added interface tif_need_resched_relaxed_wait()
in patch-11 "sched: add need-resched timed wait interface" which is a simple
wrapper over the added barrier or, patches 14,15 "barrier: add tests for
smp_cond_load_*_timeout()" and, "barrier: add clock tests for
smp_cond_load_relaxed_timeout()" which add kunit tests.

Would it be possible for you take this in mm-nonmm?

The only things missing are a few issues flagged by sashiko/bpf which
as I mention below aren't worth addressing (or are newly introduced
typos).
Happy to respin to fix those if you think that's better.

Once this is in I would like to send some patches to idle where the
new interface could be used to poll in idle on arm64.

Thanks
Ankur

Ankur Arora <ankur.a.arora@oracle.com> writes:

> Ankur Arora <ankur.a.arora@oracle.com> writes:
>
>> Hi,
>>
>> Changes in this version:
>>
>>     - rename kconfig entry for the barrier kunit test to follow
>>       the kunit style guide
>>       (s/BARRIER_TIMEOUT_TEST/BARRIER_TIMEOUT_KUNIT_TEST)
>>
>>     - make the kunit test be visible only if CONFIG_KUNIT_ALL_TESTS
>>       is not enabled.
>>
>>     Both comments from Julian Braha.
>>
>> (There were also comments from the sashiko and bpf-bot which I've
>> commented on in prior versions of this series and which don't
>> make sense to address.)
>
> Sashiko/bpf-bot review comments so far are a repeat of earlier
> ones. There are a few new typos that got flagged. Will address
> those if I end up sending another version out because of more
> substantive comments.
>
>> The core kernel often uses smp_cond_load_{relaxed,acquire}() to spin
>> on condition variables with architectural primitives used to avoid
>> hammering the relevant cachelines.
>>
>> (This primitive can vary greatly across architectures: on x86 it's a
>> cpu_relax() to slow down the pipeline. On arm64, this is a __cmpwait()
>> which waits for a cacheline to change state in a time limited fashion.)
>>
>> Regardless of architectural details, typical smp_cond_load*() usage
>> does not allow for termination until the condition change occurs.
>>
>> Beyond the core kernel, there are cases where it is useful to additionally
>> terminate on a timeout. Two cases:
>>
>>   - cpuidle poll_idle(): wait for need-resched until the cpuidle polling
>>     duration expires.
>>
>>   - rqspinlock: nested qspinlock acquisition that terminates on timeout
>>     or deadlock.
>>
>> Accordingly add two interfaces (with their generic and arm64 specific
>> implementations):
>>
>>    smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr, timeout)
>>    smp_cond_load_acquire_timeout(ptr, cond_expr, time_expr, timeout)
>>
>> Also add tif_need_resched_relaxed_wait() which wraps the polling
>> pattern and its scheduler specific details in poll_idle().
>> In addition add atomic_cond_read_*_timeout(),
>> atomic64_cond_read_*_timeout(), and atomic_long wrappers.
>>
>> Structurally, both the smp_cond_load_*_timeout() interfaces are similar
>> to smp_cond_load*(), with the addition of a rate-limited time-check.
>>
>> Usage
>> ==
>>
>> These interfaces drop straight-forwardly into the rqspinlock logic
>> since qspinlock already uses smp_cond_load*(), and the time-check
>> extension can now be used for timeout and deadlock handling.
>>
>> Using tif_need_resched_relaxed_wait() in poll_idle() removes any
>> architectural details allowing arm64 to straight-forwardly support
>> that path.
>> (However, for efficiency reasons cpuidle/poll_state.c continues to
>> depend on ARCH_HAS_CPU_RELAX since that is defined on architectures
>> with an optimized architectural primitive.)
>>
>>
>> Performance
>> ==
>>
>> Apart from simplifications due to this change, supporting polling in
>> cpuidle on arm64 helps improve wakeup latency (needs a few cpuidle/acpi
>> patches):
>>
>>
>>   # perf stat -r 5 --cpu 4,5 -e task-clock,cycles,instructions,sched:sched_wake_idle_without_ipi \
>>   perf bench sched pipe -l 1000000 -c 4
>>
>>   # No haltpoll (and, no TIF_POLLING_NRFLAG):
>>
>>   Performance counter stats for 'CPU(s) 4,5' (5 runs):
>>
>>          25,229.57 msec task-clock                       #    2.000 CPUs utilized               ( +-  7.75% )
>>     45,821,250,284      cycles                           #    1.816 GHz                         ( +- 10.07% )
>>     26,557,496,665      instructions                     #    0.58  insn per cycle              ( +-  0.21% )
>>                  0      sched:sched_wake_idle_without_ipi #    0.000 /sec
>>
>>        12.615 +- 0.977 seconds time elapsed  ( +-  7.75% )
>>
>>
>>   # Haltpoll:
>>
>>   Performance counter stats for 'CPU(s) 4,5' (5 runs):
>>
>>          15,131.58 msec task-clock                       #    2.000 CPUs utilized               ( +- 10.00% )
>>     34,158,188,839      cycles                           #    2.257 GHz                         ( +-  6.91% )
>>     20,824,950,916      instructions                     #    0.61  insn per cycle              ( +-  0.09% )
>>          1,983,822      sched:sched_wake_idle_without_ipi #  131.105 K/sec                       ( +-  0.78% )
>>
>>         7.566 +- 0.756 seconds time elapsed  ( +- 10.00% )
>>
>>   We get improved latency because we don't switch in and out of a
>>   deeper sleep state or from the hypervisor. This also causes us to
>>   execute ~20% fewer instructions.
>>
>>
>> Haris Okanovic also saw improvement in real workloads due to the
>> cpuidle changes: "observed 4-6% improvements in memcahed, cassandra,
>> mysql, and postgresql under certain loads. Other applications likely
>> benefit too." [12]
>>
>>
>> Changelog:
>>
>>   v13 [15] (as listed above):
>>     - rename kconfig entry for the barrier kunit test to follow
>>       the kunit style guide
>>       (s/BARRIER_TIMEOUT_TEST/BARRIER_TIMEOUT_KUNIT_TEST)
>>
>>     - make the kunit test be visible only if CONFIG_KUNIT_ALL_TESTS
>>       is not enabled.
>>
>>     Both comments from Julian Braha.
>>
>>   v12 [14]:
>>     - smp_cond_load_acquire_timeout() now only has acquire semantics in
>>       the success (non-timeout) case.
>>
>>     - arm64 now does not define ARCH_HAS_CPU_RELAX as without also
>>       defining TIF_POLLING_NRFLAG, in some cases we end up with a
>>       degenerate version of poll_idle().
>>
>>     - kunit: removed the test case for timeout=-1 (not supported)
>>       Also add test cases for timeout=0, timeout=1.
>>
>>     (All of these address review comments from sashiko/bpf-bot.)
>>
>>   v11 [13]:
>>     - addressed some review comments from sashiko (see commit notes)
>>       - The one notable change is to the implementation of
>>         smp_cond_load_acquire_timeout() where there was a missed
>>         control dependency in the timeout case.
>>       All the others are minor.
>>     - fixed a low probability race in the kunit test added in v11.
>>     - added a bunch of kunit tests validating the implementation's
>>       use of the clock.
>>
>>   v10 [10]:
>>    - add a comment mentioning that smp_cond_load_relaxed_timeout() might
>>      be using architectural primitives that don't support MMIO.
>>      (David Laight, Catalin Marinas)
>>    - added a kunit test for smp_cond_load_relaxed_timeout() (Andrew
>>      Morton.)
>>
>>   v9 [9]:
>>    - s/@cond/@cond_expr/ (Randy Dunlap)
>>    - Clarify that SMP_TIMEOUT_POLL_COUNT is only around memory
>>      addresses. (David Laight)
>>    - Add the missing config ARCH_HAS_CPU_RELAX in arch/arm64/Kconfig.
>>      (Catalin Marinas).
>>    - Switch to arch_counter_get_cntvct_stable() (via __delay_cycles())
>>      in the cmpwait path instead of using arch_timer_read_counter().
>>      (Catalin Marinas)
>>
>>   v8 [0]:
>>    - Defer evaluation of @time_expr_ns to when we hit the slowpath.
>>       (comment from Alexei Starovoitov).
>>
>>    - Mention that cpu_poll_relax() is better than raw CPU polling
>>      only where ARCH_HAS_CPU_RELAX is defined.
>>      - also define ARCH_HAS_CPU_RELAX for arm64.
>>       (Came out of a discussion with Will Deacon.)
>>
>>    - Split out WFET and WFE handling. I was doing both of these
>>      in a common handler.
>>      (From Will Deacon and in an earlier revision by Catalin Marinas.)
>>
>>    - Add mentions of atomic_cond_read_{relaxed,acquire}(),
>>      atomic_cond_read_{relaxed,acquire}_timeout() in
>>      Documentation/atomic_t.txt.
>>
>>    - Use the BIT() macro to do the checking in tif_bitset_relaxed_wait().
>>
>>    - Cleanup unnecessary assignments, casts etc in poll_idle().
>>      (From Rafael Wysocki.)
>>
>>    - Fixup warnings from kernel build robot
>>
>>
>>   v7 [1]:
>>    - change the interface to separately provide the timeout. This is
>>      useful for supporting WFET and similar primitives which can do
>>      timed waiting (suggested by Arnd Bergmann).
>>
>>    - Adapting rqspinlock code to this changed interface also
>>      necessitated allowing time_expr to fail.
>>    - rqspinlock changes to adapt to the new smp_cond_load_acquire_timeout().
>>
>>    - add WFET support (suggested by Arnd Bergmann).
>>    - add support for atomic-long wrappers.
>>    - add a new scheduler interface tif_need_resched_relaxed_wait() which
>>      encapsulates the polling logic used by poll_idle().
>>      - interface suggested by (Rafael J. Wysocki).
>>
>>
>>   v6 [2]:
>>    - fixup missing timeout parameters in atomic64_cond_read_*_timeout()
>>    - remove a race between setting of TIF_NEED_RESCHED and the call to
>>      smp_cond_load_relaxed_timeout(). This would mean that dev->poll_time_limit
>>      would be set even if we hadn't spent any time waiting.
>>      (The original check compared against local_clock(), which would have been
>>      fine, but I was instead using a cheaper check against _TIF_NEED_RESCHED.)
>>    (Both from meta-CI bot)
>>
>>
>>   v5 [3]:
>>    - use cpu_poll_relax() instead of cpu_relax().
>>    - instead of defining an arm64 specific
>>      smp_cond_load_relaxed_timeout(), just define the appropriate
>>      cpu_poll_relax().
>>    - re-read the target pointer when we exit due to the time-check.
>>    - s/SMP_TIMEOUT_SPIN_COUNT/SMP_TIMEOUT_POLL_COUNT/
>>    (Suggested by Will Deacon)
>>
>>    - add atomic_cond_read_*_timeout() and atomic64_cond_read_*_timeout()
>>      interfaces.
>>    - rqspinlock: use atomic_cond_read_acquire_timeout().
>>    - cpuidle: use smp_cond_load_relaxed_tiemout() for polling.
>>    (Suggested by Catalin Marinas)
>>
>>    - rqspinlock: define SMP_TIMEOUT_POLL_COUNT to be 16k for non arm64
>>
>>
>>   v4 [4]:
>>     - naming change 's/timewait/timeout/'
>>     - resilient spinlocks: get rid of res_smp_cond_load_acquire_waiting()
>>       and fixup use of RES_CHECK_TIMEOUT().
>>     (Both suggested by Catalin Marinas)
>>
>>   v3 [5]:
>>     - further interface simplifications (suggested by Catalin Marinas)
>>
>>   v2 [6]:
>>     - simplified the interface (suggested by Catalin Marinas)
>>        - get rid of wait_policy, and a multitude of constants
>>        - adds a slack parameter
>>       This helped remove a fair amount of duplicated code duplication and in
>>       hindsight unnecessary constants.
>>
>>   v1 [7]:
>>      - add wait_policy (coarse and fine)
>>      - derive spin-count etc at runtime instead of using arbitrary
>>        constants.
>>
>> Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [8]
>>
>> Comments appreciated!
>>
>> Thanks
>> Ankur
>>
>>  [0] https://lore.kernel.org/lkml/20251215044919.460086-1-ankur.a.arora@oracle.com/
>>  [1] https://lore.kernel.org/lkml/20251028053136.692462-1-ankur.a.arora@oracle.com/
>>  [2] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
>>  [3] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
>>  [4] https://lore.kernel.org/lkml/20250829080735.3598416-1-ankur.a.arora@oracle.com/
>>  [5] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
>>  [6] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
>>  [7] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
>>  [8] https://lore.kernel.org/lkml/2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com/
>>  [9] https://lore.kernel.org/lkml/20260209023153.2661784-1-ankur.a.arora@oracle.com/
>>  [10] https://lore.kernel.org/lkml/20260316013651.3225328-1-ankur.a.arora@oracle.com/
>>  [11] https://lore.kernel.org/lkml/20230809134837.GM212435@hirez.programming.kicks-ass.net/
>>  [12] https://lore.kernel.org/lkml/c6f3c8d3f1f2e89a9dc7ae22482973b5a51b08cb.camel@amazon.com/
>>  [13] https://lore.kernel.org/all/20260408122538.3610871-1-ankur.a.arora@oracle.com/#r
>>  [14] https://lore.kernel.org/all/20260608080440.127491-1-ankur.a.arora@oracle.com/
>>  [15] https://lore.kernel.org/all/20260702013334.140905-1-ankur.a.arora@oracle.com/
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: bpf@vger.kernel.org
>> Cc: linux-arch@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-pm@vger.kernel.org
>>
>> Ankur Arora (15):
>>   asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
>>   arm64: barrier: Support smp_cond_load_relaxed_timeout()
>>   arm64/delay: move some constants out to a separate header
>>   arm64: support WFET in smp_cond_load_relaxed_timeout()
>>   arm64: rqspinlock: Remove private copy of
>>     smp_cond_load_acquire_timewait()
>>   asm-generic: barrier: Add smp_cond_load_acquire_timeout()
>>   atomic: Add atomic_cond_read_*_timeout()
>>   locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
>>   bpf/rqspinlock: switch check_timeout() to a clock interface
>>   bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
>>   sched: add need-resched timed wait interface
>>   cpuidle/poll_state: Wait for need-resched via
>>     tif_need_resched_relaxed_wait()
>>   arm64/delay: enable testing smp_cond_load_relaxed_timeout()
>>   barrier: add tests for smp_cond_load_*_timeout()
>>   barrier: add clock tests for smp_cond_load_relaxed_timeout()
>>
>>  Documentation/atomic_t.txt           |  14 +-
>>  arch/arm64/include/asm/barrier.h     |  23 ++++
>>  arch/arm64/include/asm/cmpxchg.h     |  62 +++++++--
>>  arch/arm64/include/asm/delay-const.h |  28 ++++
>>  arch/arm64/include/asm/rqspinlock.h  |  85 ------------
>>  arch/arm64/lib/delay.c               |  17 +--
>>  drivers/clocksource/arm_arch_timer.c |   2 +
>>  drivers/cpuidle/poll_state.c         |  21 +--
>>  drivers/soc/qcom/rpmh-rsc.c          |   8 +-
>>  include/asm-generic/barrier.h        | 119 +++++++++++++++++
>>  include/linux/atomic.h               |  10 ++
>>  include/linux/atomic/atomic-long.h   |  18 ++-
>>  include/linux/sched/idle.h           |  29 +++++
>>  kernel/bpf/rqspinlock.c              |  77 +++++++----
>>  lib/Kconfig.debug                    |  10 ++
>>  lib/tests/Makefile                   |   1 +
>>  lib/tests/barrier-timeout-test.c     | 186 +++++++++++++++++++++++++++
>>  scripts/atomic/gen-atomic-long.sh    |  16 ++-
>>  18 files changed, 548 insertions(+), 178 deletions(-)
>>  create mode 100644 arch/arm64/include/asm/delay-const.h
>>  create mode 100644 lib/tests/barrier-timeout-test.c


--
ankur
