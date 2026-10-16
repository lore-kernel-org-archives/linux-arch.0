Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95C41BA9B;
	Fri, 16 Oct 2026 07:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134588; cv=fail; b=I+FY/1d/Q6R5HLoWVmv4bNTfVa8WiVXH4fBnufDPbSfsNOANzl2vZcKcDivvkD8rw+Q2+VxDKx7JyVlfQb2UnpUZMBB6B7+0O6HMaH2oN4p5sNHTGb5vseGKf9WkPDX61ZiAqER+BESqCEeBNT0wD7WvtlWTQ7wbQ9zhRvxfxK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134588; c=relaxed/simple;
	bh=rUMYliG4l8oZdUHHnMaHYXaPviR8pu5Oo2Ta5S4creA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KF5pdO51/npNw6sii5w6CQWEjgfZE687IyJ0gzunLe0JlS6jIIo5bPsRk2bHqeCikZ/bP7N4sgD3hFcGP5ipKrlk+Jq+EqOJmEp2euRtQ5i3NBg3PMz/ThEIx3a2rEgQYKb+9SoCTH/Xu2Ui6Clk/vKzW3Lqqe1HhC+n/VQmGgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NXrBUmrc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rTtkW4t5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NXrBUmrc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rTtkW4t5"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FN6nKb3476420;
	Fri, 16 Oct 2026 07:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QsHyDwbZDt14FavL1G1amq1dUCjoYT5O4o88+Pn2YyM=; b=
	NXrBUmrcZNs+j/O3+c77TnmtS0DSiH/82pxLV8mypncXTmxxLGvTbtTUri8WX6kv
	uUJiy5gIblToErVwosUvy+GmgRxvi4GM3eEP8H7sVFAFDp6JRvp6ppGyFbXd9vtA
	YBF8V3XSWDu2ZBfFDC1LFiO5NWGJSCZfVyT5EOO2ufWCaQQbpAjTi4zOfanrfkFp
	UWrY2AY9GjKD/PMeOnVRB/h2P+543ODiTaQO4t7AG4MUm1eM6IsfqCN1O2HG6wld
	2qXRZUxpzjTU4A6XHVANAEbIXplkTR5cWvLwQV1WRnwboksNVkVc10RYigX1J/ly
	aX75hsp7AhhOL04EUMiksg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dde1me8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 07:09:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69G76mK4014578;
	Fri, 16 Oct 2026 07:09:13 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btt1vw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 07:09:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mF/4GM/U0GlssSAeIIlh84cihUyKe3Ef9/Jd230azWd2EWmTQZCCTQ0bekxrwv9ha5ornA/0WO+lS92LSxxcSn/CAuA/kkR/VZZFtmCo9VoN1d7zgxHAhM+U1L5ww84iNI16iAQJ4jGBDTJo9bPe7IwOilN3cw+EmXDR7tqtCXJXggUMfgPvDrTM1u+dspjg7YfdzSuvb2lIz75ILUFHcBzd20gbF6A24hbo2rjMt4YwAiZ3z1BDhxHF9zq51BuLFEs1L0swpVlg3JTyaoAWWtcdZ1DTE/pKi4M7XoXi7Pa7a37/Z7gAo6d3Sw2wJNXf8Q/nORp4Amgiq94Hz8vw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsHyDwbZDt14FavL1G1amq1dUCjoYT5O4o88+Pn2YyM=;
 b=Czw7VL7CccfDGyd5R3mhDcHxmGaMm9aem14s4Qm0Y1bdfNwUzx1YSubKBceo/HZ3/JrSvfzUn03EyesLP8mf66V0+pbCmnF167ubBbCyfF8SK/3POHB0vh5MOBxtDFTseoW2bfB4oAq9urKDF4rY78frrXz8lUFCeZ/SxUyPX/dIHlY5S7Rlm2UPjst7n/dFs+VlYb9ZHk01xT4Nn72OQ/0OvZ0CVBke14RFh5UvQ6CJFCP3ugrQIasj+8ICNEgT8V59Wge36B/DUM4ujsPv3lguRhS84V2zzGO1tJHgOCxY+utkngULOoMEBkJ1XuRzjoApfzdWZTqZGLEDlfSI6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsHyDwbZDt14FavL1G1amq1dUCjoYT5O4o88+Pn2YyM=;
 b=rTtkW4t57s5Eu9uGNLCXo6yg7S7gU6CVGYhX+iQlu7YJBtjxhEdollwapCiRm1ltSkeLDwhmi45VB03h/1kJgMkZcNhUT/WlNNBbnmzVRc1k0bUDjReNs5Lfm8wPaILy7Yf8aOR5ilhPRltJrNF89gp83zpgRK69gwTiJd3J2uY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Fri, 16 Oct
 2026 07:09:09 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.010; Fri, 16 Oct 2026
 07:09:09 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v16 07/16] atomic: Add atomic_cond_read_*_timeout()
Date: Fri, 16 Oct 2026 00:08:28 -0700
Message-Id: <20261016070837.440748-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261016070837.440748-1-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0051.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4c34f6-f81a-420a-8dc6-08df2b545fb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	msMNO/D8RDqDlAKfG4giuIo1ruOQ+dJtRro1f5CJtnVeaayJNw8F/ZzHEpC85kgTvHDxwk4+oUJztxgxQy9jXSrSg6fFC7lXiGz35QyaMwjrpEF4hr186JQx9X0q6WVum1jkmPt6/w78jiikj73BWwP1P8mHUAEGVvLWrENPkQE4ZP8UNfZkU4QnSepgcAerZFtNPUlwC8bAwF4h9J5tWZvNJtGfYRkU1Cs1GV58ifvlI92M0/JaD3so0jpZOqZy3j5UUjknknKHcb96mZv2vWvT68a72v3CeF6iXKSbYCrgG5ktwV6PrYg49MTeHJShewHF9/+aGjTwnwhb/9/d7XF31mOIM1k9c+OCwCENBqEhQQKmsTO4UppnHz8pToknhi85RrXBNfyt6wmz4pbyyNUKXI/DVkBfGxO83CY7yh7mpepgFBoioBkqeGolPoaFj9VG8mg8roufuv5BdNsDhaxAbHur5oN1Kwn1dXniNNC7Iixbn6E0leKBNzxUXNoJTu35QrJKGwU0t0GrewlQx4ecQ9kR2kyEK+oZlp0ZuGl55AKp5Z4pTMyhWCbU3oTPDhU8F/ZFnaMBh6VUaiFxDTPk7vxAQgXpUELFYjZSZ49NvAXvSf4FTs+hYXAUOEnwrWn3i5aBPVY7FuQkQoAxL6Z0LpOcD4rBCx9RbxdeFR4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(261009223027099003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rC1oTHozyadnY4XLRg8KcQcaXg5IKnPO6wQrmHd+bLwDol0p0P2N3cip3/+k?=
 =?us-ascii?Q?RK6tlVs3/cvAj+k41i99H238Nhsn/5rzGvafKe0rVVkQEccXDnQqsXDxM5Om?=
 =?us-ascii?Q?+k5HuaSP9dP03HYpGNLWD+ncGRHeO3V+TC7MaQVcHRTuj2H+2YhBMbSYHrQt?=
 =?us-ascii?Q?gaYoy8vrgQABzaPm90wtsdZvocG4+y6566KItc73ESiAPBleE1duhRmG+e5Y?=
 =?us-ascii?Q?Z158kb9po6CMYIWSM82PjYa/Ne/prDo+B1QbU/iwIdOT+54EscxZO3BfJjzz?=
 =?us-ascii?Q?5ZfXCwhbELUdzSa5QSFiOelF7RNphqRoVjr6K18/Vw0+0u/b23+2PNhokUtk?=
 =?us-ascii?Q?vkGkMrteDZtRM4OdSkKe//74btFOKZ31Ebikx4iOOOb+rkuUaAJ0jywYOBgs?=
 =?us-ascii?Q?NTDpAiHa5Wui61tV2Q71KG+E//6IckYBZwD8qq0gsLaN/Zjs2f4dPhVZu8QP?=
 =?us-ascii?Q?NtQYGv6QNGNMsTmYyCIBSW0uZc6/ZmQWuv6Nfpf9YQrqJBnGX5DMmKmR8wYM?=
 =?us-ascii?Q?YGWJ52sCXKsoyt6DWfuM2WIXWhpBLsHej9ezLWA7E4D+ojLaSOWt8TQSZukx?=
 =?us-ascii?Q?MIGvo/i5cQqVMPBxXdce/Ua9cYwTcSRZIM2EEZ35avlnh//GGQJeM6eYfWTa?=
 =?us-ascii?Q?joopdBswq6nW0VncfjafbaYohUbhWjtwhCTkqWJs/4UADsV70RrAwdLYUXKT?=
 =?us-ascii?Q?kUzFH/6Kj9E+oHHcQfwv+PCQlA/WXONdkdc/26Fd05TgNPWJuQv8sxuvRkxx?=
 =?us-ascii?Q?Oolexmcqh9uQWkC+WgGzRIn2/XCG9FweF8fMwIKmYJeFCP7jJprzg2WLm3hp?=
 =?us-ascii?Q?BvUnGIRIS1DVJQYG0HLDjxijQ6T8S2ai7EhnNYm8JLNCEtsJGy06w8H9Tm4S?=
 =?us-ascii?Q?Q4DXUXiQx/yhPt6D15zB7FTmKTeYiREfMBgNb6TT+FrrrYBIQfcvwkWAD1eB?=
 =?us-ascii?Q?J2KI6fx6D6eh85RaH1JTqcVbQjWBs7fDZeK4xNS9t6KS8ZaOWKY49FZH7ctu?=
 =?us-ascii?Q?kCkoTWofHOXLNq5VkWbiPo12kUc+y6oKab/ePgfM4OytHQbjPCPnKPoamuYb?=
 =?us-ascii?Q?zjM8mdj3Bxf97RnT4gGsEFqUCxtjXG8HfLkktjgxvvBdqYn2BLYhw+44N50M?=
 =?us-ascii?Q?9ACK2MWsZ58yi2xd3V9D2qswIWQjWRp2G1YJZuycAZBVt/gl4hskd9ykLjYn?=
 =?us-ascii?Q?sbwsfrHmjrmHJGpHJqbS1ZHnYYzFait4fYDtrNXIiJ641dYxd/4VxwiLOXzL?=
 =?us-ascii?Q?MXzQljR/ZlhiOZpHGoJ6d5443nhN6XIzZd8LgywZR5hpWqgZcHEIEwwbuMfH?=
 =?us-ascii?Q?ZCdlJczePWa1eBql2BRyA+mlxvHP+gcS3xWjeYNGfHZn29F2T4DDF2PrstNG?=
 =?us-ascii?Q?UHpvwt75g3mudNjxjB0p6hbUD/pM9kZ8km18HU7qqv2Aw4+pPn4++4pGldIX?=
 =?us-ascii?Q?abIBn9fukWIavlr7P3AdxtWrsJF763Vpda1SeJzC+PosSwrn9N1bwa1OUoLf?=
 =?us-ascii?Q?S6xav/x99C5+GD/utVW2H6FxAFLU/uu5gkGLybHtp8DmReXyBSszi6nJHsB5?=
 =?us-ascii?Q?2hJGwsgPFUHEzqp77UMKQgROtjmBKhZUzVHvJnwHA3iCrq/dqW5NrcHCVPBP?=
 =?us-ascii?Q?9SzwXkhimHX2Adw/0lGSz9KlGKNzmnlxhg3M6z8AXPRJlBamHDZG/3HOM4Jx?=
 =?us-ascii?Q?ivIm7Q7axD8KbL2itjXoZ1I5xiIBSiggJgrpfpAvV55sf3NgMjdTvKeFSeRt?=
 =?us-ascii?Q?xofLWMneYiMGvaEcjn4wdcmqf2C/LX0=3D?=
X-Exchange-RoutingPolicyChecked:
	C57Rpsnte3y3xH0zmKBpF8RQ4WGuoySeI8c7sHzcoQmojoFNZc53otdIRMToF72Lz3bm3TzCCtEJnWFDEN9jxU/q8ZSo3FSjhOSK8H51un+pKARfXkM0kKMF34t1ajLSC4QKTf4lSrIYoPz9YHUo7s+5eeU4euOvjvj52cLFbLCH+XzqfWQvQ4XnmiR6wacJq+JwhMmzD+lpoX6jGoppzXCvhoxE9mLYZyCVJ3JXUA/P2aYHDE+Vt6X/QeEhXqBNgp0ePpKgjjTUpDTMSlFPG6DGthD/7Xpecjfryo05y2pYuqzUJ4bNDkMJ8uyIvQQ3FBofI8sNKr7Wpb+bCO0KrA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/vbUK/A7pWZboZs6U+iYM9KgMU8FB/Y4algZBNkwgaOKpUo7MRy+e4krUkXCIj93gAjBTRt8TbvJM/i7I1f77Shj/1V/Q4pPow6XZMAvdptLGzykJPt3Yt+ynsTH1rofSwmBYUaJZScxRbX/5hL/YYEFoA+53OcdcA2RIFz++53t63V9+dFwpvD7A2Yys5xnhGQXipEj66JCercEI6z6RP84SXFiBVZsGua266wm6I63QVdxrO1dpuHcO1zL7WDrHmuCNkTIzlMu7zdJPp/jVc+b5JuKKyw5kdnBkJ1lovNtK8yrH8LEsfpzi/lW8/Yr0n49qlWudZzIq4xgBpQzIRdG+0SVDp0hXTG7GmHa3tNmd8AtrLn28DwZKKrnOD6JW+ldqYWl3Ai+4drtuHR+jRG5/AmdlyOnehWcKyCRhF2BSDWRKdge8Uey0XgJQjQnz7/XYzhwVVieAsVz0urYQ8A7xSuebsTKmiDyGGukKwFCXqVlgrbYsXjoNVumf9zQgbfjez+bXBqs2k1i/eK2euGU3IREJjwKX2cE+o6pGv1YkytKMjTvML6MBPdXiVkSKz8+54FqSEM7EX8YN+dlxDRRGRHnHsA6hkAMMmwGUBk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4c34f6-f81a-420a-8dc6-08df2b545fb0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:09:09.3830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9MG8x50jX3dVfluRC1+jgtXKK/Ie5hPXHOetUV2XRt0Fecmas2rCmDlh0YRiiqGOkBtqSf2UkhGmaG/ZXo51ndx2ntwkIV9OGAsQDl48P0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610160028
X-Proofpoint-GUID: 1z0br4F-M1XHkEibEFbFRATNCN096l3t
X-Proofpoint-ORIG-GUID: 1z0br4F-M1XHkEibEFbFRATNCN096l3t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX2apSYuDB+8u/
 EVxJ1IIAFvBcYqBKzMngFZ0ReM9ubtZC+or1hNFbBU65HZAdoedLowQEOEikXZiWsVUJbbhmLlw
 F93b7PR2ZUcRZLiiWCKDWSOs1NcN9ZuJdOl7/CnhxSJhfpTkdQIC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX90OTGAbuzZVb
 p+7ET9fWg09oLLIbAnCqVXa7FA5H90YHGCn62x3D3yQZbF+Sl5JjncuFkNJx7W49eqw7lSQcaE+
 ci02NZZZMWfdTqU9vg43/nUpNDxhNTGzF5Qc/QubK0Wpv5HHVoAXwmyNHlU9pp7AnQn3m2n+fay
 scDCUnk7TWxvp9IXU5BPvO5yhVUwDoudvkvFcy5U4OxisMWNbDZ6husthb8hv1tIqMoaLtzDL0B
 NVIdsAy80rg4bnv1vBiL0p4oNPnLmlPDrPpf/eZRseKUvcQRCq3ryVnM6mjzZn51lfJUZZ42bHk
 U4K86P88yyDsIRSZV3sCIMA8b8d3vfXhufRZopsSysq6Ix0395g+4WrhbTXs3ODAxBd84vaK9ZR
 vjFdyibmLOtCIXpo8lzIl9ZT1RDULO+uBneZhG3mWbAGY8lT0w2BKNQWwlJf3MOJBlII7MTzHRF
 W7zWbbwJ9GNKnI5IrYMvgjovo5puaxg2Wnhig6yE=
X-Authority-Analysis: v=2.4 cv=J/8/fwnS c=1 sm=1 tr=0 ts=6ad1cd99 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=RgR6v_fFY-8vhBXvnRcA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107

Add atomic load wrappers, atomic_cond_read_*_timeout() and
atomic64_cond_read_*_timeout() for the cond-load timeout interfaces.

Also add a short description for the atomic_cond_read_{relaxed,acquire}(),
and the atomic_cond_read_{relaxed,acquire}_timeout() interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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

