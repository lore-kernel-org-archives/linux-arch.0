Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE773C060C;
	Wed,  8 Apr 2026 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651258; cv=fail; b=bSb8/zxtIS9yKEzToWoEiVZ6s78t87/yWlcdu2e5EA+boEKk+5F7IBrSTgVmraqRp6S8sBJDxof+GnPgWwMQXicocnyDJJc/+MEMrmWwLJaZubE59m4RC8ZVY4u1LJXOU8s1OXhmoTD09Ksdzm0h7TMPW7kEF10DDLXds6tVpa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651258; c=relaxed/simple;
	bh=tT0cLS/UrKEC87Urlh7liagfftEntSNFbUV7mYGaJgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KbQM73issLtDQmq6cr3FZD4O7uBko6XPLTuatQAhFzco8kOv8lfP67XjQgbv3mrKrHPRUTTC1HDXvvM0qnSfOSZ5K8WeBEg41UWt+2FKY6xOfZljkUypN6tjcm//Ik75aOGnZ2ti3CHNYTHyWJT4Ooshku/cCvOMTVIyzA/MnFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HXdsvhon; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uTEdJFWf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HXdsvhon";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uTEdJFWf"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6388UHXF1803126;
	Wed, 8 Apr 2026 12:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+wHrN8dZEJC6faagOV1ii6EEbQvyEplxm1j7+gsfSGA=; b=
	HXdsvhonDSoJGoTKMHnJkXT9tD681J3J8kBmiQs0AaqCB6qe15fj0qBqHcOzqtfp
	Pw4m04UYYZed6jNuU0M9RF/4oS3BUzO8QCESjPRDUGZnNes0Z0kPAAzYdqaHRaC/
	nBDwH8jKJBsBV8V8aK96tx8QZMo/V5/4hHlLFJN3TNIcrDWWZKC+ruiRCN3fKLsC
	MQbS4ZSpbXXdJBpj8OhbnmBeC1xs7M7wRT2+90Yh7v2jL6zVQbBnZ11x2C5UOJGn
	BViwk7wbZ6CzZg9G2lu4ix7anmz0VfuXt/T9CIoWzj9CnjyxyLSlib1LnZjD5+77
	GuhtBL2nkyxvxU/y1ZC3kg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqakfet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:27:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638A7NJH011883;
	Wed, 8 Apr 2026 12:27:15 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmnrfkkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 12:27:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Umh5XXpr+OrpQKQHeUOfVV5ACwFYfEu5wRwfBI4gJczcZGbwM7BRtamtfe9OK/QZVyeZP+Fu/381V/pPRatinhE8xxQq7RKe8gwv2pag6e2GtJahfvYgwNOcTBiSxDkY4+FD99z8bRE1z+BqNQ1wVY97NPhME5BCekwd17F+FsQIJAKRKgv2xTxAmiWa3XdUq0ZhIvmY9TfHBHn1vwLGyfzardP8MGvSn2NPGvtC5v/RB1qsE0FjSDoUVYjYbu4uX6JzRXm2snstDWj2IM40K3Cb19MDVrVbMAMHRzaEVkcvlGxzZ16kJ34I6dCnMI5nGO3/mX6nT4OJnzE8BRZEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wHrN8dZEJC6faagOV1ii6EEbQvyEplxm1j7+gsfSGA=;
 b=aQNX+F7hcled0ry53o1459JpUpy2gMAyVOmClIVKTtCOEuQ/5UKA3iHRyeMebgHOes7Hi7eV2s/LjTCxJhDG84oFrdGC5TMo8kxPhCS5ZkO6znWsFHNZogexAOE8Kh07kHE+zKokUxu5A+uKBKPM0Z9S8eFCmSYGVTeAyoStv1GihRQACFxc5hHi5vbxeVZX/SBGlGIXxqKCXhVRSsRni1bzqA5Ft+2ZHKyiwjwl6FMkHfLg5Eh6pM8LYR3DENe4evicAZG4qTdMj8suH0n5NiTO9vOv5xBxzcAmaFwFHPNo84esmNx5/ekmQuvcjcpl1fVLMUwLY1zRR7/UhmjT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wHrN8dZEJC6faagOV1ii6EEbQvyEplxm1j7+gsfSGA=;
 b=uTEdJFWfcDs7kjiLRcn9F2Crh2q0nw1LNrkVexa43jfgXMr2MBLs1jjwDEmX1hulKQCvXCCzFZFkksGfHzYecpBVJOzf0yGfegTawuwps7D8OdLQPeKoor1Oeo95FCseGREQSx4A4yI4Ttfak5lxl3+Ax1IAUakrEjxc05PLjg0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN4PR10MB5574.namprd10.prod.outlook.com (2603:10b6:806:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 12:27:08 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9745.034; Wed, 8 Apr 2026
 12:27:07 +0000
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
Subject: [PATCH v11 14/14] kunit: add tests for smp_cond_load_relaxed_timeout()
Date: Wed,  8 Apr 2026 17:55:38 +0530
Message-Id: <20260408122538.3610871-15-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN4PR10MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: 95fa41a8-bce7-4857-8e72-08de956a25c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	f+dqPlF7NHDBzDsByHDaPGyMdBgJAGTObe9pW3Um9WrY6ddLJ9y+3kbPGMU+ODSwJEMhoYuxVd1qb9Q2uIkpwU7+pP97dQtCNyUhpdHuoE1R2gqmlbfh+K5cDwd8uv4Vhnlh7dsxEpiVP0chkjV2nLaEsxrPeckXFp/3b7kCzvcbQek/RwfOK6AWt8ZahZpo4os0Tk9PIEJnuDel14SzFQUZaBcqP3GocsE4ED4ZpjTeNrG/AuCSZw+b5EMqIMm+I4V9vR4jRAdWBt6c6FsrBsE5s/bGJCIG8klxGl5svWahgj2xuyR6wrUP8fPgLZTC2NXDH//3B3tbNY1h4drAorUMpjRkioEeH0DpTanilDIlV+1gluotSlW1YCHFmpA1BfLumERnICx/QpbSl8uXMUgFSqlsH3nVHrDx9ET9YifwjbivqPY9EDpEs4ZBbqv5rWWAhlk/mJbtAuvjWzqFtQ7J5EyJFXSTuvIfWCYdLGqtmcbCehmW6c6ZVPxpQuzGtTiMDWTpGm4ZFftYcirfNg4gJ6WhsxZ9oDqJAyKEUsVtIW6S+pbHrHLXAUI+UEnZQ6HebFxQ3M1QviTe990CxA0jXxjYMoffgdlqhu9HHIGAOf4biD+duWDwyuG3G7wO9/4yxhcEU0Loxedypjsu6CFgXj7b6q6qU0/znJNeMRz+sMGAZF+vvNlll2ej+tI031jx1awUG09s9PKmdiYU2bPNj5LACW9jPrc97XykAh0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OVM9f0kLsPbNSkjlCCewCnwnojZiqGvJsNu3YWA5RzYQro3QXgFrvHXreCHC?=
 =?us-ascii?Q?Wv4e2icOb1TxpMv0VBNq+7hTvcCpnRQxthtaJlfKNS9AKxZ55h+5YAPP2BY+?=
 =?us-ascii?Q?S2odTnGJFOXhq4zGbNoFzXG/xxbIk8nKlJGS/xVkL5fzeSSFCliBNqmSC2hg?=
 =?us-ascii?Q?F96IsADtEjyPSHJ/NmtrznXqHbJ5+c2zjj3Y3Cm6YWuGW9NrgHpe3zRsZ3zP?=
 =?us-ascii?Q?6FHpE9Mqj/IKsFFQnROVdAfvllrvXsLR+NRx7P6rMjs55Ru6P9+vs5v11FO3?=
 =?us-ascii?Q?KvXAd37er7A/1C96n/v823ImhvVPFni3gvMrWLMfSgY1Za6BCGBgpSWndRU0?=
 =?us-ascii?Q?/oaF2De+lwNcoxGHjknNtJCHZWo6SnbpGOZs7fkRcU2t4W5nNtrD6kjzzW0I?=
 =?us-ascii?Q?afzTRB84WVQ3Rnb1R2+ysLrOZEBqKidu6HTn/o+tll9weuzuPkDxv3nXpgSl?=
 =?us-ascii?Q?skn2SKo5rtx2rNZAS6+Et74mzPdVT1MEDAtUdSuI/TyI2nNz63fW51XTjwKU?=
 =?us-ascii?Q?O/Ua+dxTHdYxBsBG1kPXnxHYWVcr/moRMULpWUB6Gbjngdjv5OqcLl1/TVwb?=
 =?us-ascii?Q?TZCCjV8ujQIIP3+JOaU/FJBv4QNUCcdk/MyT+JuwReqcVg8zxiWqyXy/sCIL?=
 =?us-ascii?Q?o9DJj6LPlLmCchi5R3XtBFq2u5wecni8RD+HVe3IJRy7XS4T8xg/YNtePpcN?=
 =?us-ascii?Q?8lHYqAo5M90I9xWfSPkxp8sBxWy48AxkColeqWpuzxDDH8sptrp+Jsv66wae?=
 =?us-ascii?Q?ZoEg7IvIw+tL0XSCJaYf0kp1ZBxdjheh337TO0jaiZzs4jdy3+JcJ4sD9vic?=
 =?us-ascii?Q?TQ7e//YhSNuZH80PGykt1an45bRA704rEgL2GTnM0coRyOHNAy0ZfGF+B25P?=
 =?us-ascii?Q?S+WE+enK5iHLeOEFy/nMTkFqNjouO7VS34tNKTb2O1pbblkJqi/bj9zAovdG?=
 =?us-ascii?Q?Vwq2S4N8YaN6baNisryRKqyCzd7dFO4PlCtd3D3Ra1uAMLZBqXRYIn2AAP7f?=
 =?us-ascii?Q?MSdg58D2LH41db5vfFlJ3mAz+4ahatpZHkfp4wl1Z0KoOSmnwFWgRaw333tQ?=
 =?us-ascii?Q?Bop22P455Ean8SF2IJabCJfChnZdm7O8ADT36KHfevuRaalKeFHAIpxzNhf1?=
 =?us-ascii?Q?6xrRNj8fdSgP3jfs9tFrRomSvz4bq1NO3ove4qn1nwi7eAcrKprSsV7rsIaM?=
 =?us-ascii?Q?b6f4MI+3SLclbgHYeXBKRFxa4ajUIHY5Ol2kwDXw/Jy2bigODff8Myihp1Ui?=
 =?us-ascii?Q?VnHBmywx1I0t1AaJrAoW0pv6fSBMdHmMJDK49etk7UcVLuhTJSMNHzCeNq2u?=
 =?us-ascii?Q?gOUQCg86tRMXUaDqHKQG3mTlb5eywgQS6xV8tZkun4LCTlcGNfKXVNcn8f9c?=
 =?us-ascii?Q?vsNzhQCPhDdaENlLsR0KSNHFjj7EYCBlFmo44nzyeHuo2pDzAqyKNSiPWMbX?=
 =?us-ascii?Q?tzUATeJF1DKeS1NyWBCZnd2Wyal/LjXbh6RKP7Oe8jwOof4zu0cHcnpamlPg?=
 =?us-ascii?Q?e8cmYLZYnxHA8C/d/GhhEkXOcrdK2dbg4ljN8NMify1DVCKd1/+eZK0iKsvV?=
 =?us-ascii?Q?1BwChUbFWGuz4CZMd0/yDB0z6FKUAjT4DP1JR9ay1mc2tvpLJoOIU1lxKeYU?=
 =?us-ascii?Q?17sLqgrB8tGi/ogQYmracKVFf5nQvg7hh7/MFMed6fuhLlxj84yeR/eUeDyf?=
 =?us-ascii?Q?1L4dROPObRfEUFj5J1Rn6QPaSbeQi8UvTmi0Wx3RJtPdlWEaoZ7Xyd7aPyCb?=
 =?us-ascii?Q?vSIRle5saBA08TOLnBn/CO3+exFJrccwC+JHXE8ZBsNxk+ra86PoNUEwzIbK?=
X-MS-Exchange-AntiSpam-MessageData-1: npwcvifyGHKu6ahYtTcMfvmlAJbXZ6F94jk=
X-Exchange-RoutingPolicyChecked:
	B8Tm00ZZvEYG8mDEe8S2oZKnrAq3HgTN3OWkrMUvZX31Swx3cMhpeaUHfeSLsPaATGrUtLLyaMwUrd4V4jUJPb0gsfBYgLN9klEXYF/KjUoF7ect/nPTpM2xzywjCEGIggI0wh+Rp99vz/+16R/yPauBgZIimXvk/B+eOB8dE7MWxOoKceN89GiKFeQnx37iPfJpH1kl0mquIL1C4O03aJ/s2v1Sp445767CV45UIG91jRHCp1IXxLv3anwaH59dPo6cCaOYAfmI/T21YUv1FUPRJNfIbVHSUNTKYSNQWCnHH13UjN05DxQhVy3MZsgFHn3tuN0XYuUJ//WcrF3tmw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eXmnZBVJOMEVgrFBN995oabb8UcsxjgCTcRK14u4twR7aCmfUkEYxneQA+0hDOQV+hMAddDRbgnJMN+nKgeJfuHus3lkj8PgHDE/ctd7PEilZWRGYMR17z5Umxkw/M+RLWL/gOlLWT8Ssv9AS/1Wu1Ghu7pnH4JWhihnt4JO+nK4WF2MVGsPHoDdeYSWoybYVjaw7f81r4YkU+TGeNR+WxhigllE4dUinOqBozhau9odAbMuW8ZpBM3TE7xyGkYZhcafeSiLXLl3PoNrtzblHPOTwMtRJbHCE8/xJS1BHKXG5UbKoMavEWxbnWzs8e8K/EYfpPMK0VOcoiXkPu/IaTxXdz79immJ4kMuxQJRTNmToNsBDwYQDh9ttvlphV0FjqbsP63NSS51rS1f+/GfTB89LU2YBlbG19k3wuOnNg9MJotUBcYWt8Tbxm8VDtfnZlVqPZgIXbl8laqoW2zzx5l13zReD13tHBk3Dc7Z/W20owrafxDhmR8EqhKo0XSsy2yapJld9tiK3YSjwKO9OHMFLoihum10o1IjAumGll88ca975MAqkxQ3hzZLm6jiGpxhdP4Wz4YLs9y9IgDd+QvEh80paiaMKZJIpdct5No=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fa41a8-bce7-4857-8e72-08de956a25c2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:27:06.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okQDvy3361hawisSkxQiyr8B01P0x3mMhBoOo4oSw0QTejvQV3Tg8DhlxgT3S+Ska7tlz+YM/hAoqkpiA2VYniGb9z/hCEkd1bcSJetxD0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080115
X-Proofpoint-ORIG-GUID: 99Bh--LEczjzRVykLqSygBITskh7evbF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDExNSBTYWx0ZWRfXz0QZG/jUFeea
 M3RFIQHnA63aFfA5QaFyBlbX99jCWNvirp0O8V23MdOGw9pp7QTuwtsa/LAj2vLZK+b69WG8TXh
 teI8Oi/bBsXqz8D4HU+c1CDSOb60m9qGgBBTifl4/Ye0FhKwFVkDaoFD7BzVZP24AGeC1VMMS5/
 NBBAwPKVB7RNymuYsuubnTf2eVBskQh2XcVpQRuSqRtUUp4OWKc/I+HwuCW4VEpxdpDsi02hauO
 D+XqcxCA37HvF8tjRC+kMvD4sM2oAJywU885gzGbt+OnYXltjJt+hacFwpa6vKbwX7JGl4oIIuS
 tkjxqadSQOp9wCsnKy4ahDlZ6ts0rWzNlFCdYvWzUA9EgGFajn/A/7VxpdsbkZY8J3ANIwfOQOH
 N4bpWAl+W2OMmduHu3wFapblHvtWDeD13ez8KR5qqtJzpjB8mruelZNkyYgeqw4mBGO2k8HueXs
 q5e6Fv/EjwI4Wf/T5hg==
X-Authority-Analysis: v=2.4 cv=AsTeGu9P c=1 sm=1 tr=0 ts=69d649a3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=VBcJBklsqum4Hz-1tlMA:9
X-Proofpoint-GUID: 99Bh--LEczjzRVykLqSygBITskh7evbF

Add a success and failure case for smp_cond_load_relaxed_timeout().

Both test cases wait on some state in smp_cond_load_relaxed_timeout().
In the success case we spawn a kthread that pokes the bit.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 lib/Kconfig.debug                |  10 +++
 lib/tests/Makefile               |   1 +
 lib/tests/barrier-timeout-test.c | 125 +++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 lib/tests/barrier-timeout-test.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 93f356d2b3d9..dcd2d60a9391 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2398,6 +2398,16 @@ config FPROBE_SANITY_TEST
 
 	  Say N if you are unsure.
 
+config BARRIER_TIMEOUT_TEST
+	tristate "KUnit tests for smp_cond_load_relaxed_timeout()"
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Builds KUnit tests that validate wake-up and timeout handling paths
+	  in smp_cond_load_relaxed_timeout().
+
+	  Say N if you are unsure.
+
 config BACKTRACE_SELF_TEST
 	tristate "Self test for the backtrace code"
 	depends on DEBUG_KERNEL
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 05f74edbc62b..3504d677b7b8 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -20,6 +20,7 @@ CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
+obj-$(CONFIG_BARRIER_TIMEOUT_TEST) += barrier-timeout-test.o
 obj-$(CONFIG_GLOB_KUNIT_TEST) += glob_kunit.o
 obj-$(CONFIG_HASHTABLE_KUNIT_TEST) += hashtable_test.o
 obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout-test.c
new file mode 100644
index 000000000000..d72200daa0f2
--- /dev/null
+++ b/lib/tests/barrier-timeout-test.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests exercising smp_cond_load_relaxed_timeout().
+ *
+ * Copyright (c) 2026, Oracle Corp.
+ * Author: Ankur Arora <ankur.a.arora@oracle.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/types.h>
+#include <linux/sched/clock.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <asm/barrier.h>
+#include <kunit/test.h>
+#include <kunit/visibility.h>
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+struct clock_state {
+	s64 start_time;
+	s64 end_time;
+};
+
+#define TIMEOUT_MSEC	2
+#define TEST_FLAG_VAL	BIT(2)
+static unsigned int flag;
+
+static s64 basic_clock(struct clock_state *clk)
+{
+	clk->end_time = local_clock();
+	return clk->end_time;
+}
+
+static void update_flags(void)
+{
+	WRITE_ONCE(flag, TEST_FLAG_VAL);
+}
+
+static s64 mock_clock(struct clock_state *clk)
+{
+	s64 clk_mid = clk->start_time + (TIMEOUT_MSEC * NSEC_PER_MSEC)/2;
+
+	clk->end_time = local_clock();
+	if (clk->end_time >= clk_mid)
+		update_flags();
+	return clk->end_time;
+}
+
+typedef s64 (*clkfn_t)(struct clock_state *);
+
+static void test_smp_cond_relaxed_timeout(struct kunit *test,
+					  clkfn_t clock, bool succeeds)
+{
+	struct clock_state clk = {
+		.start_time = local_clock(),
+		.end_time = local_clock(),
+	};
+	s64 runtime, timeout_ns = TIMEOUT_MSEC * NSEC_PER_MSEC;
+	unsigned int result;
+
+	result = smp_cond_load_relaxed_timeout(&flag,
+					       (VAL & TEST_FLAG_VAL),
+					       clock(&clk),
+					       timeout_ns);
+
+	runtime = clk.end_time - clk.start_time;
+	KUNIT_EXPECT_EQ(test, (bool)(result & TEST_FLAG_VAL), succeeds);
+	KUNIT_EXPECT_EQ(test, runtime <= timeout_ns, succeeds);
+}
+
+static int smp_cond_threadfn(void *data)
+{
+	udelay(TIMEOUT_MSEC * USEC_PER_MSEC / 4);
+
+	/*
+	 * Update flags after a delay to give smp_cond_relaxed_timeout()
+	 * time to get started.
+	 */
+	update_flags();
+	return 0;
+}
+
+static void smp_cond_relaxed_timeout_succeeds(struct kunit *test)
+{
+	struct task_struct *task;
+
+	flag = 0;
+
+	task = kthread_run(smp_cond_threadfn, &flag, "smp_cond_thread");
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, task);
+	test_smp_cond_relaxed_timeout(test, &basic_clock, true);
+
+	kthread_stop(task);
+}
+
+static void smp_cond_relaxed_timeout_mocked(struct kunit *test)
+{
+	flag = 0;
+	test_smp_cond_relaxed_timeout(test, &mock_clock, true);
+}
+
+static void smp_cond_relaxed_timeout_expires(struct kunit *test)
+{
+	flag = 0;
+	test_smp_cond_relaxed_timeout(test, &basic_clock, false);
+}
+
+static struct kunit_case barrier_timeout_test_cases[] = {
+	KUNIT_CASE(smp_cond_relaxed_timeout_mocked),
+	KUNIT_CASE(smp_cond_relaxed_timeout_succeeds),
+	KUNIT_CASE(smp_cond_relaxed_timeout_expires),
+	{}
+};
+
+static struct kunit_suite barrier_timeout_test_suite = {
+	.name = "smp-cond-load-relaxed-timeout",
+	.test_cases = barrier_timeout_test_cases,
+};
+
+kunit_test_suite(barrier_timeout_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for smp_cond_load_relaxed_timeout()");
+MODULE_LICENSE("GPL");
-- 
2.31.1

