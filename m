Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7315419FB2;
	Fri, 16 Oct 2026 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134578; cv=fail; b=mVS8OLfEtBa5qZDoUeZsvSxFTQlLyAlC4d6T3SIBV/2NTvjFymh960TZYLzxYcs0gx/TNjKNlcfIAmtWbR2ntdih+QkNHwjOI63ImxuED5/rKGxAxolIR+1DccAGBYnIuWGFfw6uaBFhK+z9VSd5lOtsqrbAcuyE4yIjDsIK+KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134578; c=relaxed/simple;
	bh=FKvI7dWxO9Q2Pu1dne/IrpdZ3XMYoOeoKHtgFQOap/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FXIGCwgH17TVymDjyObzVfI6RFfnwtwHQ6llGVHehakKK61lXkgbmSjLS50qiLQjkU2uue4v13Tf1ovD0uP2Zhk1wXx4OlF0E8h4Nl3/BZ2DTuu+4BDrfQk0EBtHHyGsy5rFXenbd6SynmxX87Uhxv4NyC9FIzr4cXDb1WLAm5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IPNl7mdV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lA6BICar; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IPNl7mdV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lA6BICar"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FN7T7s2718030;
	Fri, 16 Oct 2026 07:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kDOd/on/HCh2PbppvJO97Wo9S5Z4iKCaAfTp7Nz8FJw=; b=
	IPNl7mdVZHve1INnKO1/ncFSX32czCf2Gxrmoq0ECzPekorPLxrZIgd/NW4VAKGR
	crntO4JL/6/3h6Cqda+S45t1p3P6QT9rna0ZXdcqZ84C/3E+4SHoGM5xu+G9Albz
	XZ5gNUyM2FvOtyJz0d2qF//MRp9QQG6bi2+a15GvUh5h3fnU4b8UkJO7aiFBhBRD
	0d8PJIjMdIEmwr5J3QQzf6Ek6Pi4il9l3gWG+3yhfGWFjAnCQsHIVNcJCI6Owlpg
	zXEzGdzOlqMnjYLUuz86h6XTngzB930Y3W06Hccq4URQtMSnkVBPgKk4nEkBeXVw
	o4wQ/TDaJt6thMvFy3Ntlg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dbksevy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 07:09:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69G76h8E020947;
	Fri, 16 Oct 2026 07:09:00 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013005.outbound.protection.outlook.com [40.107.201.5])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btss0tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 07:08:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSfRSR+xLW38P75pvxeLOPSvctnYJvx5S89b6Cr20s1W/blPJpILN7ae+FGwfyxdB6v7jtXLopMRv6UrqNG7gW4snlOhocc1ZXY4oZvPWvhdV1VKKM59xLX+NRxQ5Fz1TE6FoakbA03WDx15HTpx2q3sXm8QkNGNUnfLKy67WcMrDzqrAJasZlPo7Z5zWcnnQHLJ1V28Gsaz4EqtJ0gv+6H/YP+sjD9bANP/1vqq1PuPph22rU994/FU/eTOw999wURKzSh/Dku74hkTxtBh3sh0Sy58R2KT7drOAHE5nhJI9OqLGeDyGb29pnvp0aY3JTllLwArBOOVTbcG4adB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDOd/on/HCh2PbppvJO97Wo9S5Z4iKCaAfTp7Nz8FJw=;
 b=UZ2xBIT204xY83iwR4RlAAQwRrkIjHeOQD8KWM/GZ8Kao3Qj6e03xetD5i4eg0ksG1rj4C+IG+arWZoX/po9L886zfJXFhH7Q+nvim1GZmxiBv7yrz/tWdFbbTPWQcibet0LKKC/W5YT+o4xNjmnkFDyHsVYqawpra7Nh6iKl8cjT2zyoSz3isVNUG6S/h30KijRO41rLTAo5eQk3geNMdH6r3GwLHJeg/MjYeTo1jBEocPrLVyCWMywqmRHxHZAH9fw7IVpkmNY06EzilD1WbyfNzAl34NVV2tg1WcpRIoTu8QxmkpnOskw5gZ4EPr09zWhGPTmdqp8TyNdPBFAOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDOd/on/HCh2PbppvJO97Wo9S5Z4iKCaAfTp7Nz8FJw=;
 b=lA6BICarfb92BGgSyC3h/jCrBmKE7Eyr7J35fe09x5BU9vbHWBykAcGjjNPcUK/mmiTqdEWhviCX7lZu5AnAvTN5mSa7ASjRBlDXhskeXaKfMcG8aNbs6uB3u2ORrbxxFbqAD8yc6Olrgkrh1hkIpVhJctrlQCoGad8Z0Vafxtw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Fri, 16 Oct
 2026 07:08:55 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.010; Fri, 16 Oct 2026
 07:08:52 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@kernel.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, broonie@kernel.org,
        boris.ostrovsky@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v16 04/16] arm64: support WFET in smp_cond_load_relaxed_timeout()
Date: Fri, 16 Oct 2026 00:08:25 -0700
Message-Id: <20261016070837.440748-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261016070837.440748-1-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:303:b6::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 94013f8b-17ad-40fa-748a-08df2b5455c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|261009223027099003|22082099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	l4LbU8jn7TpAXi3xyW2CxATdD6YfNQ2K91W0ZWRJ3lF9uahxLDyRhoV3kMQYi9lP0iqxAZaSlxhhanL9KBabA9Vyvrzz37iCLKEgnRf5mNnrgqSk+GAfP7f6I/Eql3hEMBl/AGKyls5Qi1n04AlR6PZc5cuNkeFhk61685bvqRx2bE+UpVCP9bteqfMRCn7QIAG+5xkFjUVmByaB06jy1lyXHpU8aenRRISRNMwy1fJFkw+N/SXswQTfutJT3AjlQIx1AJS1zpH+ydFucKALXrCKgv3/6feGCG+cAGzhvF3LtXKOf1BtD/G0r7T8J9oOiq7k12O0Y4gKkag+8sBIMyP7y4BfaZ9ugvfAnfie1R/Z/+Ju1yXIch67VjjHY1dr/NWn8gHvRGQN3bXxuqqKhLmn5Wn8OeX2Hzlm/PXqUgUbvLHRNZqKgw61tGkcHR9UAUYNEqevjbsKvebteqtoSVKWLUQ3rIjD2LnrO6zrFPmJhQoVhENHDo1M1JqVIQqQFaMxNjWRtE2a609Lw6r3oJYz+FUpCYuvXhq+nLc2bA8aebF93uh6Q3XeSzBSs2sIK5gXsz48vtKoSFJxv/2euYsbzwsL2f9MhEJMcf9fE0DjWNrTgkCsReDwaJKVbSGYj6eAV6IsVC3ULNZsqRVysA2A8nRG/jjcLEBARobEB4s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(261009223027099003)(22082099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RKfqnD5abFMOb/nRj9TDt1zhB5VSIbHNjvh00+gstXOI6GtWB4vrgifVAtvC?=
 =?us-ascii?Q?OtHxNbQPMRFihrDXmvG92wUPXORVuVfjc1r6OWFu3Q3Jq/Zdt6nQlkPMBVi2?=
 =?us-ascii?Q?KC53KV9cuqn0GOi+Vw0zJejRng3sKICSXObE2kEsuQhNB5AcpTPxfqEy+bab?=
 =?us-ascii?Q?VNuqn7QFvCp6eSJ/TudjcHiy5pcjXu6f5EBvf0XaOuxaFEB2FwQDz2M8fz95?=
 =?us-ascii?Q?C1fF1Ub0o7mbV+3Ph0eHuS+SvAdAU7pY2NDLRtZ+kU9j47OxaGN53NoQQSKJ?=
 =?us-ascii?Q?JhUr2eSlpdL3iDpoR7rXOas9g3dgYfuukyQ0oQ5Zd/CE28+vGui+Z+oWs1+z?=
 =?us-ascii?Q?jhgIw67IHr5x2NDnCv1lYx5oBTx8AhjpK7SO4avTo5ujjK7OlwZQ8QpnTHAi?=
 =?us-ascii?Q?88B8Aflnwzb+N0OoGlU999IZzkV9QdnVuqZ4EKmKtsgcDCoLwUAw3QjCgQAl?=
 =?us-ascii?Q?sta+pqYacxxNtE451gLAy1Fg1uQsvc0CfFsUMwSGOWp0lPklWGRXD+TDod//?=
 =?us-ascii?Q?UKLDfNitKOKSmwP6/0nIU3xmcj6KKECQYBFRxnYvuD6zVOACWFMVTK2m7jhM?=
 =?us-ascii?Q?IAduIE9pvhBeGueNlVfio/657TtegmNTqHWHf6OGyyuCnQnyaO69dpjmx/NE?=
 =?us-ascii?Q?vgCNi8AHy9hzg6r5qhK/7FnQ+wL7G2nalk1aZdzazZXyTX7iZvUoG9LvhQn7?=
 =?us-ascii?Q?9OS6GxlXwoqI5jYpQmdfSRazsOfNgaudAWYsiHTD1w2W89BAKI+C0VKSTw0G?=
 =?us-ascii?Q?CpDbEgx+kBFDf01uEOHgk4AZR0vmk9d5elj6b0Jw2KaCCAcg0OYU7R6xtLDe?=
 =?us-ascii?Q?UFVbfMuYtfH/ftK1ZTUxykGwvNCejVr1Us5jLUsmCJhjj07E6CcHf3n4g13T?=
 =?us-ascii?Q?eMvxj0ZKYq20+rLSAoqyLpX/ckSmyROu1AVBJSiFDRNsGnW5J0YHlEH9WDmp?=
 =?us-ascii?Q?efPRIAQB50/1SFtokjo0rJexqd9Av7s9UTOYHWx4ZuVlUg7YsqGqsd+4XRM+?=
 =?us-ascii?Q?Ern7nDMBvsiScewUV/GdS0MXbsEm6l77IAas1WTkA848S9tZ6gNyUQIXIOuM?=
 =?us-ascii?Q?Hw+KRil/Xm+xi0/cjDe2mj5qDH8X3BbU7C12NuLUi+Pq4A/LFNkR4eTqWZdF?=
 =?us-ascii?Q?yLobON5ruIAYwFUXo+BLmyWCeDFZ3WEaWh8UwV++ULpgwr4KgLcXXKiCoWqc?=
 =?us-ascii?Q?+u24V3uK0dW5KPfG2PxbcWLzWeRC9yIRAPF+xPb0IL3iIojc02XcfRLbGHCK?=
 =?us-ascii?Q?JoBVAA4pSBROB79jqKCoKGzkzN9E5fNUvSuA1vjr7WQVBKVZoN/unbZEn1ly?=
 =?us-ascii?Q?IfMhjBqrFeiqqmNN/BTEMXb1sNUYf7P2CD9UChCuY2IBOAUTNqe5gDey5r4i?=
 =?us-ascii?Q?oA6n9dN06H/cjcbz7EUwWxwFVg7W/o7qZrHE8CCeGLr0pvqMC0cDJWKF8A/J?=
 =?us-ascii?Q?yNiNnw+zHDvuJRpeEw5HnQXUHywQAwiyYYvPN63t08k6ueuazy1xhzstpUBH?=
 =?us-ascii?Q?Jz8czFJhA5eYkToqRy59huBi3Psp/Io0wnXMMSoaqp3J5iQycSrHXOhPU2yu?=
 =?us-ascii?Q?00qkW9D4XN1kQsKV2QYsn71qixS2ux6wLpmvU+vVM4D2Ubhcgstg4s2LBiv6?=
 =?us-ascii?Q?lvVR3nWK7LDTEp+sBC7KYuwpvPDXi3n+vTu+LKeNm9gwjTb/Ah1DoAYhdd+j?=
 =?us-ascii?Q?0XYu3/OFO7L6e6NZCGTB8s+f6mdNCSw0Uhpm8SRRgf4D0ro3PzZR6dazG0hU?=
 =?us-ascii?Q?W9ZLzUAt+BywQxwQnl4i00hvgvVxln0=3D?=
X-Exchange-RoutingPolicyChecked:
	u23YPTCUbajFa46egizz74peC8wYHNkfdu7DTHpX/d3gae8Xph2cKvucX27Jx5T7rhhVY6kWLOxwl+3YN1s34jdisLm4RfbY6/cwDge4Wr0Xq1EKHbECHEU7/hvPi2mLH4jX0qgr4a2AzpQuemZPxlrHvLR/LcNVNxB27hosJ9McEB87PhpbQ2wYbuvZd5upIRW+L6iMUp+OPekCk7d+88X8yjC8Iyuz3/jn21YW7ABSSlhgJ59+01ArCq6BD8nfZP94qt65tJXcE8BLHTsdbciqHQ3OwQduMqdgg/TolngD3Na3r36FMuEBtzzxf69JUsQSn5MBq0/W69yi4Zaq1g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oSjlCWivYyF7Hji4QDoCFWLGV9C99a/QKaGjTqzyXo+v+TQuw5TRx+tHFFLptptOfm/hiHTjMHJKkWLDiJUSAsfkOYnIBYnWpIQI9+kGFQf1jF1wGp1g+IyUTJRrdPrt+FNdCxTrSTTcgOFdo8vjIRsecUsDB/VZyPCxJJp69D4cUmJ7KPyAp9r4LCQyD9BXG6jcfF5RhCBqoPqp1JwtmDISLo5wXlsG5005EW7qoh202TGayskpHGzJROAvu52tf8PFVxkUD5O5++6AZRdsAlnPIoqlC0+Jkvmf0rdwG+4DG2UjgPmYAS9REZMvecMJ7tIqmFdpkPK0Vin/o/uEX6SPhiLU6fbNHUtFNFMarEVxfEsOYa7zXo7njAYjFkQ0wyKQcPkDWSmCICMjb9MMV+QKx+OE96g5DJuNynp1iu3cHpi3pgHS+pcXhZWObgqhha1NJmhx0ssISSe3AXXBbUs/3L0LD3MtHYYpCWVkq72XKV5f1EfjgB76X+U5V+O8Q7RYo0Mx7kUkLEu7VTQ7jnnjdMz7QkT2ukBJX3HtqoGh6G8bVQfqJD6fGk16ukzrciaB6QXzzk717BJmxRrgYep4Xnrx76ug5vDx9xybrpM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94013f8b-17ad-40fa-748a-08df2b5455c8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:08:52.7379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dd08gqVxqiKWGIqWg9leIB51o9xiw9zAbS7/bVKYCqX1cjl0g3SrckjyjABC2re/UlmiEpDxJimE6Gy2tiRv5mx0QvRNF6QrUobBmZ/cJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610160028
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6ad1cd8d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=h2j_Ys_cKJEXrGAlRtsA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13537
X-Proofpoint-GUID: 0A0VnPlZvKw8sIVI5JyF0pfieC3apGkF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX2AR8ok/tagz0
 7h3Olz6IG2uIS/fkXZzVOCcwsti8UPP4ofdjCqTLqjM0oD62dAneYlGLHrQRErZuKkuxa0+KfPG
 RJvSzXK+ZCtpYdnD9S2ty25CA+jryqcUg8ZjE4O2iwtjTfHHHuIxR9PhAcIaBaX9/FWBYgV7IUX
 cx9N5i+CjA4DLJSECrlRPdFIM5pfNNLbMTMo96/F7DuBlb7lgZQO2pUWRFsMMyT1PLD2/1lzm0O
 p0hG61tZX51SoPr/UyUScsB8DLzvw8dGFpdO2lGQpsx1kjKT8H4g/JuluHt0OZPF7NvvLBFHvR9
 G9O8DARVaDGCRnfn7NzuD3LNSfkn1j8jSIf8u0fL2vRKzThV8wZAYs/B30MMoJwykiyrl6kI8WX
 DCjsMW25KXS3oQ14KxItfEdj0zyK5bsr8JV/01atv8tFtVcs4septx3ErDk5HhXE1NuOa34s5Kx
 nWQX2eGLCg02IhG56Edjy+nssZYhipeAujFS8Yg8=
X-Proofpoint-ORIG-GUID: 0A0VnPlZvKw8sIVI5JyF0pfieC3apGkF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX3aC0ruPyW6ya
 hjbieDw2LXrHC5bzb2OfB4ClXMxhi8LeTNLJzbvpnlYyAED9iGe7+GsZItpy1dkU0fD3r5bHDLS
 gJMRTzxc2f+gmmbyXZyOvFmFrDuWdQqzhUc0I2pdLqjZbiRIagWP

When using WFE we can go beyond the timeout since, lacking an event we
depend on the event-stream for wakeups when there's no event.

So, prefer WFET where available to take advantage of precise wait.

Handling of WFET is via __cmpwait_timeout() which behaves similarly
to __cmpwait() calling out to the __cmpwait_case_timeout_##sz() or
__cmpwait_case_##sz() functions.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes: detail the WFE/WFET choice in the commit message.

 arch/arm64/include/asm/barrier.h |  8 +++--
 arch/arm64/include/asm/cmpxchg.h | 62 +++++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index e2263c754a55..3b024058cf2f 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -224,8 +224,8 @@ do {									\
 extern bool arch_timer_evtstrm_available(void);
 
 /*
- * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
- * for @ptr value to change.
+ * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()/
+ * __cmpwait_relaxed_timeout() for the ptr value to change.
  *
  * State this by defining CPU_POLL_RELAX_WAITS. This enables a time-check
  * optimization in smp_cond_load_{relaxed,acquire}_timeout(). Note that this
@@ -235,7 +235,9 @@ extern bool arch_timer_evtstrm_available(void);
 #define CPU_POLL_RELAX_WAITS
 
 #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
-	if (arch_timer_evtstrm_available())				\
+	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
+		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
+	else if (arch_timer_evtstrm_available())			\
 		__cmpwait_relaxed(ptr, val);				\
 	else								\
 		cpu_relax();						\
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 6cf3cd6873f5..30dca19c9a7b 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -12,6 +12,7 @@
 
 #include <asm/barrier.h>
 #include <asm/lse.h>
+#include <asm/delay-const.h>
 
 /*
  * We need separate acquire parameters for ll/sc and lse, since the full
@@ -212,7 +213,8 @@ __CMPXCHG_GEN(_mb)
 
 #define __CMPWAIT_CASE(w, sfx, sz)					\
 static inline void __cmpwait_case_##sz(volatile void *ptr,		\
-				       unsigned long val)		\
+				       unsigned long val,		\
+				       u64 __maybe_unused timeout_ns)	\
 {									\
 	unsigned long tmp;						\
 									\
@@ -235,20 +237,52 @@ __CMPWAIT_CASE( ,  , 64);
 
 #undef __CMPWAIT_CASE
 
-#define __CMPWAIT_GEN(sfx)						\
-static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
-				  unsigned long val,			\
-				  int size)				\
+#define __CMPWAIT_TIMEOUT_CASE(w, sfx, sz)				\
+static inline void __cmpwait_case_timeout_##sz(volatile void *ptr,	\
+					       unsigned long val,	\
+					       u64 timeout_ns)		\
+{									\
+	unsigned long tmp;						\
+	u64 ecycles = __delay_cycles() +				\
+			nsecs_to_cycles(timeout_ns);			\
+	asm volatile(							\
+	"	sevl\n"							\
+	"	wfe\n"							\
+	"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
+	"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
+	"	cbnz	%" #w "[tmp], 1f\n"				\
+	"	msr s0_3_c1_c0_0, %[ecycles]\n"				\
+	"1:"								\
+	: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
+	: [val] "r" (val), [ecycles] "r" (ecycles));			\
+}
+
+__CMPWAIT_TIMEOUT_CASE(w, b, 8);
+__CMPWAIT_TIMEOUT_CASE(w, h, 16);
+__CMPWAIT_TIMEOUT_CASE(w,  , 32);
+__CMPWAIT_TIMEOUT_CASE( ,  , 64);
+
+#undef __CMPWAIT_TIMEOUT_CASE
+
+#define __CMPWAIT_GEN(timeout, sfx)					\
+static __always_inline void __cmpwait##timeout##sfx(volatile void *ptr,	\
+						    unsigned long val,	\
+						    u64 timeout_ns,	\
+						    int size)		\
 {									\
 	switch (size) {							\
 	case 1:								\
-		return __cmpwait_case##sfx##_8(ptr, (u8)val);		\
+		return __cmpwait_case##timeout##sfx##_8(ptr, (u8)val,	\
+							timeout_ns);	\
 	case 2:								\
-		return __cmpwait_case##sfx##_16(ptr, (u16)val);		\
+		return __cmpwait_case##timeout##sfx##_16(ptr, (u16)val,	\
+							 timeout_ns);	\
 	case 4:								\
-		return __cmpwait_case##sfx##_32(ptr, val);		\
+		return __cmpwait_case##timeout##sfx##_32(ptr, val,	\
+							 timeout_ns);	\
 	case 8:								\
-		return __cmpwait_case##sfx##_64(ptr, val);		\
+		return __cmpwait_case##timeout##sfx##_64(ptr, val,	\
+							 timeout_ns);	\
 	default:							\
 		BUILD_BUG();						\
 	}								\
@@ -256,11 +290,15 @@ static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
 	unreachable();							\
 }
 
-__CMPWAIT_GEN()
+__CMPWAIT_GEN(        , )
+__CMPWAIT_GEN(_timeout, )
 
 #undef __CMPWAIT_GEN
 
-#define __cmpwait_relaxed(ptr, val) \
-	__cmpwait((ptr), (unsigned long)(val), sizeof(*(ptr)))
+#define __cmpwait_relaxed_timeout(ptr, val, timeout_ns)			\
+	__cmpwait_timeout((ptr), (unsigned long)(val), timeout_ns, sizeof(*(ptr)))
+
+#define __cmpwait_relaxed(ptr, val)					\
+	__cmpwait((ptr), (unsigned long)(val), 0, sizeof(*(ptr)))
 
 #endif	/* __ASM_CMPXCHG_H */
-- 
2.43.7

