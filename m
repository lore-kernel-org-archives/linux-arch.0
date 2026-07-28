Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB68422E3F;
	Tue, 28 Jul 2026 23:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785280034; cv=fail; b=a1BG7Nk/HiKE03I4HZ6Bp6lESRkCRx59Sw2Mb5zNMxW44PiuDFvS3uSoL7fkIdW0+7hmkQnIiHWPh/NhondjPC3sUYgruyY0LUYpoOgncd5X8AkeMazjBKhUi/SpZFcfqALO3blpSJzVaqpXbQrs7gR0jX4r5+znGVlMbnH/ZuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785280034; c=relaxed/simple;
	bh=TzPPtnXHxlfPAkO2hkxKSBC/Es+ug4/J1CgRlvMOC+M=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=S13YzYQnzCe5AQRCcb0q3z2moy+xLdUFIa4gsCfFYweCNwtVKA0JqLn916qEvKcbHiJvDQEnGFciDrx2fcm85i+kW3mWeEsQPM0U/JKU/TZNIjEQ9ciJhEcFu8U2PV9TLA9zDEfiSNws6lkxgytDl85RE/j8/6H+cFjRAbPknwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OuzBdoGg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZmutdOJG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OuzBdoGg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZmutdOJG"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SItVx91120893;
	Tue, 28 Jul 2026 23:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zWASr+S72wEr7UIlzX
	haPCS0XUTswxcSctnUvKP2ryY=; b=OuzBdoGgQLSiZmiOAU22ZNvNGPegq6wp2y
	zTI7gZNVwp+JZLwW4Jkjt4k9Ofvuci2TTaURK+WrYsLPOrKHFWhGPRd2U54SECLQ
	KaHpNdREbHLT+YkxHrvYxJoJ+T72n1uBU4+eUGp/6QMVNK+3u2esI8fIDsMhH69R
	tO8Hjg1ugRhT27ZRbpN9iLMT/aGcdJuqWieRjUCUlFYS0cLHh44N3ZWGKiU0NXDw
	EsmNbPzS5WF13PZVKpL+vL5sjq3QrdofN0u9BeRFIr+moTvpzMwEYLr+RuaCRnKO
	UGfopubJ5+1f8+VAGRpXUXFNMrmXzq/qmjLu9jgL22J6VMua1hhg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr5nmyr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 23:06:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66SN5WV4025782;
	Tue, 28 Jul 2026 23:06:30 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010045.outbound.protection.outlook.com [40.93.198.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fnh6d92y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 Jul 2026 23:06:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+/2Lxluq6J2PVuiIHa0Iv9W/LwUHlniXJDotKA7G7zGLmDli+ZS3vx/EFlWNYtpABWSH0r3KExU+Z7CPeVfKy7QZWvcB1RsaJviwAxLvzHslXowlThObUlmCI0xP30osr0Qz8gdnOj7cVUiaDAGP0fkPWBwUs/rSOXF3zyIslZpfUh6nK2BNiYJV8RK4pfNMRawlePjJk1mfGevtgj6t2wvQPSeB+rv3+KeoYLMTAUlmQPt7wgMOuS42Kk2SsBCtiPsvFgyMSIAc1tFzhc5TRYpQL+7AOgq8+80GoBpLjiBtceOvUqJzfHsB1cvuLcUHSRf0x+wRVa47N92ZA4Urw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWASr+S72wEr7UIlzXhaPCS0XUTswxcSctnUvKP2ryY=;
 b=r9eWv4lYBSdry54Jt6BOToqZ2w0RfV0d8+y4Yj12DLFEuRZrRa/Lja05LFcyzKmGdvl1aJ499B9GeTOUf7OqVf/dnZsU+p38oPjff0cdBJuWOXcExej52dO31m+zEF6tI4eLfZkw+DYOZKR/511lsuGQ/Ayhj1ncUpMMSw00zmv1RntRTiVAbMDmo7zRydc1mPWpUCS26lEGmKEuR8pQfwBkOKh9e8rOE0OVE9XBTq9nt+pT+HKX/hDXlx0R1tMm203lwA9UQbLgRGZYupOtetef92DOpzHrLpoOZm7+qmNBwDVfyfHocplYlsK5exymN7TP1i2k/rX1ubbGhkvhyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWASr+S72wEr7UIlzXhaPCS0XUTswxcSctnUvKP2ryY=;
 b=ZmutdOJGfpOkE/OSw+90J70I90qHX+YVXmLSkkijw0SNM0iW61RwCGa0IvBroSY1ddyvIDzF/CTkQgNWVsjGWy8R3HNrZT4OXHZEoln8EyecPg4o8qN2709LaRGncHc3Xag9O5Mj7rxOifmhaVheG3i2+5N87+CdbEmB+CrxO9s=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH0PR10MB4970.namprd10.prod.outlook.com (2603:10b6:610:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 28 Jul
 2026 23:06:24 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 23:06:24 +0000
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
 <20260714073041.40250-14-ankur.a.arora@oracle.com>
 <amiUWpsL1QGf929i@willie-the-truck>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Will Deacon <will@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, peterz@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, broonie@kernel.org,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v14 13/15] arm64/delay: enable testing
 smp_cond_load_relaxed_timeout()
In-reply-to: <amiUWpsL1QGf929i@willie-the-truck>
Date: Tue, 28 Jul 2026 16:06:23 -0700
Message-ID: <87tspi7lzk.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:303:b8::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH0PR10MB4970:EE_
X-MS-Office365-Filtering-Correlation-Id: 726e7449-7e01-41e9-a6c4-08deecfcd8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|22082099003|18002099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	1yVyg28nDOcdH6k8FuK0gt5dMyvPoYryhLK9do2hD7CKALUtr0gnCy+SiQRnmWAzJ/jxii7MeU4omfuzGek0ZF/+Ka5YJlotRC+9g2sAgEuS/B9EnfaWgjVz9Do8EN2T2VCcWMVN5fOylHl7RdnXGPDlVtwWEiuV4TVp2GkxY7ww+Vdr/AKIy6ij1Nel+WkYNjFXUGxGBwNtt7DqxOj1V8qBILMQ4EYf0SLJ5MjVMBM8cUqt3KCWn7wjyirQC5zXHvf3IgEDcVtL1kRSgShGdIrHWGx57ErFmunsJV15l2eleESyroeKkC6DdvnOaduVFcrXve1dokHBd1nP6TldtFjGw+FSX6OSNgIk7vPzOAO71WpYZf981B63DNgXBph1/XtWizPux69OUi/eXINJ3dniZf23bViL6CJR6Y2epnK0f0RtZGedwYzcQi7jZY2zePMXcMstZOcF+FNUEQFRkew4oqLiUrvJtrWXxWXpttA9HkwHaKjusbmYCjCzbOwlThZvmT4ZAc8fEfHa2MckZg7a6vpcz+z02rxECoJihbjPK7Z8PJnIKwaIlL9aU101whUXlc7neUupbqiEITQKpN0gTopl0dC3hSPle/euzexpKYDlJTmoSFxglkN9QzZkbgrfiE861fjQb7JJNEWpBSK95FqLR3V5zr38f/aioxk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+9tqnGcsT0wlzEnr1Ln62FvnzziOeqVtccocgBiC/kmdcITBkUzqVtD1Wwp2?=
 =?us-ascii?Q?LmtfJwjNGD64Smi7W8xq/vg13AHjyUbvePeSooVcBMSuwTdMlzYZrWual9Fo?=
 =?us-ascii?Q?IPs5Lk/OAjMe9ByIfWpOPJHCq9H9Pdyq0SjwGjsmGk6XQ2I6NoCu+AZxJxMO?=
 =?us-ascii?Q?JjRqO+dGt3xu0UWsLwYp26fK9vtZjPqrPG/fFLNIyBBO5jmkvMQ4E2QgPig4?=
 =?us-ascii?Q?6qLHivsC6jrGctkeMjg/4Dw4mh5DSDrSkl4rRJzC2CDhkyQRwGEJKa06G+4y?=
 =?us-ascii?Q?KYVqQ2VJANLHnIbbpXu2LwPdrk9uIWXANEAfKnfGFXIqJZykGfUqSZxnpTyg?=
 =?us-ascii?Q?Jy14JQ3PGfb3tco0D2ChB4S2ctjkEDZl5sVSeCI50obD5k5BW6/NZ5QuPlaU?=
 =?us-ascii?Q?3U5zfUwK8mMcV36QBCo+rjLK2fl3O2vNArCwXQm1zQuwvlJvUkUjKMIWosCM?=
 =?us-ascii?Q?WAQpW6jlKHzXzV2R/omdjyVEoWVV4AjtHfU8NeIq9oZ2XTuoFQtcidBOfq1u?=
 =?us-ascii?Q?xef+hTpQGgdhPNaPm9lvfeDQ04prFJvbo8pc2W5UpL3gEC38IBAvAxfdWV6C?=
 =?us-ascii?Q?h817nN9XAIzh+TuhiVCUb0nb7pohcjVLxXicSgSjtTzwLgkzemdkD9IFPhFt?=
 =?us-ascii?Q?AYbofbk9iPK/5i64mT+O4Noigo3Bdpaxawg1h55uQx/6Zq7OW4M1vmH6qEGH?=
 =?us-ascii?Q?fHp+nLKKVRUnsUPhOmheVNbE9szpIWObD4hyW51lxjhIq3XIbTZ/HeHSYoxt?=
 =?us-ascii?Q?MZFmiHsp+E0MPxNqF/Dlr7/DsgBKU2ipj7foU8xuU4Syki25yBwC3EbmtGWc?=
 =?us-ascii?Q?9ylTM2/isKa6wg6+xEFAdIQiEpiGs2ovJaeuEimEKgHJeY/JzHWpDErz7gfq?=
 =?us-ascii?Q?e7SyKW6YEqOOIj5gTbwAfUM3j1I/T3N/M0eNq/xDvvfwNZahgTueTcMa13VT?=
 =?us-ascii?Q?YSv+P7eg5I/1tWnGtqhEH8NPH7sKgblEfEGpE+3A61rvrt4XhwfpaA5U+YqQ?=
 =?us-ascii?Q?WMnVjsMmePKSpOcl2xYc8siUnDOgr3/DP9fjxJ4EzYqEmmSIrPgXuzt+vtAN?=
 =?us-ascii?Q?TD6EBG6MbsDXOuFfByjeDVZkRcmDTqwwR/shFSFri6QQcUl7GmdtdeAacu5F?=
 =?us-ascii?Q?Ru0yjSaIiG1ehpxFGt6Pw810+r3vNWxH/Thc9pC+b86l2mau5ML/h3cnTTeE?=
 =?us-ascii?Q?v+uPeI4ZxPVIwxXXHzKZxUCvtGNcANXXb/vMfZsdkNjFtWmPdU+0YYgis6hG?=
 =?us-ascii?Q?sg1UmqZXN5uoMnbGsc1AoWtTUsRs7C4TqA8uYllXOT4vJAmgAtH0r5QY0vVC?=
 =?us-ascii?Q?9uGUE7qh2K2O+4XTCIWATSp9GDwMyyO47WbI6c5EtCjMQ6a0Fj6kWHnp9Nc6?=
 =?us-ascii?Q?QshpnB1bxu9zoG3P/ITp/W3nhKz2uqlMgjL4Qdh0WasCRRGxvCij98df1FuX?=
 =?us-ascii?Q?GViVXkDHn7ZGcnis4CPIs4aSEKgWFhVBajgacq87aX+BJuIDehBVvwScAqg3?=
 =?us-ascii?Q?j3hBEvTpGLGsDBsR4nZOz5uaQL7rdDvCvs/HUft4N2uVrxoPUD35xASo4g1P?=
 =?us-ascii?Q?NQdjOBsrTVTiM/wUbFLqnj3OHmatEcZxRSAtDEAAnBPYKgo5Lz37wdPdTxpW?=
 =?us-ascii?Q?c9VEnhqeopc41d3Ur3YIdChUOedZs1BtJtXqlkTLmBMGTaHeLKvL3Bz09pTJ?=
 =?us-ascii?Q?4eXKRbw80sgU7gyX4PL26fl97nNA2J1jvkIE0IEZ4Ie3IwbMBNTe5Axu8Xvo?=
 =?us-ascii?Q?axlf9/j+sLFsQf1OEZ4NEFSqjo3LwTA=3D?=
X-Exchange-RoutingPolicyChecked:
	Vk+/AL/Z+3hU09NY6fORZ1/eAr/1/7QFJKWQhJ4O4EeCt3MZM9yBnu0PGEUwd05dR5Y3Tk2+QLdRcw9Qc+RfrwUh8xhWwDFijyPg49vTuXKv+yiImv/UjexxCOyANeQLEQ25tXY6uuxLoUauyiMH4oUbQRXaXF3dLLnx+uhKwxjsz8E84Cq3WnadnFmkpRUdrR4SgkXjSNBd/FrMgz5jwY3dew6Uc2LGuZZs8brlHZSt4+AxEh1nXGzv8s1xX7fEZ5L+3m2E9whb/pckvDT6rAtlP+IqDLm0oAaOSPQ9/TybXugVZW4I/RwR5pvk39+dgEgvnonFBZPjeP566mBJSA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6+7fY5hTukMFr2RElMpq5kREkOoTme7osFEF1h8StBww1DZCLsDaEK8GLNxUTZB7yVm9W8OUwVHcTpSic7w8DzbSYn4zBa5Tvt2Ox1UCxDs/h234t7XoNJzT155Bp+VZTxf9CcDnyXzzadku0wpwkHSlrJZofTBO3BkmM+Nco8SrtLpV6JbvL4TPx1aVYIkMeqUp5tgOvPBblaHbscQKQtQSi/8maGZSPK3zDWdSar3Gw4y+ife+Sj7qToYb3CaGk7eIk6FC5am63D392ZAH8ioQ9rEqivMByKfDODkzrUOVJbkmbm/f20qfaC87WWpci/nkyiDvTtSrYnsXoAVwcDKK5qVL9+F/jlARiElSJIIGnJSQjbUcF5aRgsNetn6063Gt46zV0+TwhJ2cT6F5eTsF06mefdVUR3Uv6f+LY7FNVBFwPW817fQ6rWqypM1DzXlsvqqQmLA5Ry/bLvkgbBOi8lyFx9w6sG4uqxdX9DEGbWHN7vcSCGP9I4mJshEPFH7CvnJ/LseUO1jv6a/WsfCeYrSfxb3vDaaW2Zs94/+NWbeLdksaOV8Fpys7oBsZC64Q5EAihXTsB2Ec8hjV77cTxZAiaJn3Q9VwkMGCIJE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726e7449-7e01-41e9-a6c4-08deecfcd8aa
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 23:06:24.5637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdyUNB5up+OzJwiXWaWpOEIa39vTTLP0FJYPqR0h5NMoYRwn6yEHkkiM8LL7yzxzKMkTWcaBo2V4+a2ZUoyUZqLYrxCRzdCobpOXRKil7No=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4970
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_06,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=849 malwarescore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607280197
X-Authority-Analysis: v=2.4 cv=OPsXGyaB c=1 sm=1 tr=0 ts=6a6935f6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8
 a=1_9xovCmEI8TIHr9NxsA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13517
X-Proofpoint-ORIG-GUID: dPWd-P30YojbX46DE-RZKZIC1Pyyx6Vk
X-Proofpoint-GUID: dPWd-P30YojbX46DE-RZKZIC1Pyyx6Vk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE5NyBTYWx0ZWRfX+Xv4RA4oB420
 D55atN4VvtA9U6iw2j5p757rmPLkBS9sgFOwd9ILakqGlLAoUT5X3r7anH9bvjKGwSm3bwkO5Wf
 CvOkhhSexvAtDqEBzYkf8M351L43ccs/4bHQbbNTYKaaijof8hT3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE5NyBTYWx0ZWRfXyecvfv1f7QM0
 oEZwlauNOtMOOsZraeIX6pIcX5huu2PtvsC2FIKyGQPpEcBMPe3sAlA63oB3vMWW26sOs0mxKCi
 zgVlws3LQ8kC94BdSuRLP2Dt5SrGGhTr5hu4BQacGgIcU/pOkD156EygqK0OVwXsr9vWDsHrZ2M
 SGNKBqrfu9RlJNIEQOkBrjlIGVFACFE0wuxlHthT91VD2lghniAY5fj/bBqqVWZXfetZnf+fUqV
 6JC3xAk2hD6DlS7+zoL7LiZYGDlNtDHal79FsuiYgx+j1pX00hIJdItPmetjIskSOrtSuVzOVw4
 XBCPAMyw49jv+k9DuN8RpHceKkFYdeEhJ+bHj5MEn2sZyKIicLUVwANE78CMl/zLQ2Ed75bY/7t
 +YWUq6cR+ld0lRvJ2MkPRf+JVhjtHfiUTj2gMem9RzCqTe0thzq3CgkOrK9ZLDCcIGBgMaZ0c40
 PGKBBObXkv9S5CnGqdgkEpPpwUE0rKyclr66xhZg=


Will Deacon <will@kernel.org> writes:

> Hello, Ankur,
>
> On Tue, Jul 14, 2026 at 12:30:39AM -0700, Ankur Arora wrote:
>> This enables the barrier tests to be built as a module.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  arch/arm64/lib/delay.c               | 2 ++
>>  drivers/clocksource/arm_arch_timer.c | 2 ++
>>  2 files changed, 4 insertions(+)
>
> Acked-by: Will Deacon <will@kernel.org>

Thanks Will.

> I think this is looking good from the arm64 side now (and appears to have
> all the relevant Acks). What's the plan to get this series merged?

Let me ask Andrew if he can pick this up via nonmm.

--
ankur
