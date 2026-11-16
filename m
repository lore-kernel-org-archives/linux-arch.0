Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794817603;
	b=fH8P5gybxgh+lES8H8A5n8X6Nd590v5c36A/tqNvpimgkfIlckJ/jmU7hO9KNCtByFrk
	 fP2QG4KlpPznQMHCElE9gWJ4UETyXjWtyNugTfD+YFe9NLZw/NH0/eVhpwmW8hxORKtG5
	 gCAyfYkt5+eWvylwj5t1iCSaHIvIh3zM0KMN7UN8LS4cuQiBWMtiYqXT6Jbe84kNsL7lh
	 X6tEZk1HksNh24BzQQdvrmSrdSfpsvVNiCsfx5ecAlvx8RJIHudeOwri/BxboH9sSApn7
	 ID3BKuu6SfYaMuVCaMJm0YzhAFvDB1rJg4/WE81bivo3W3j7EZJUgQCIqhbnd+6uOrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817603;
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
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID;
	bh=snhUoqANJ4mQe/xAT/hfRIBdRbk5H+uoMBHEN0WjCy4=;
	b=C2czDdJOtxZRbWmkEEG9riwA0ti5CMfkFfT4/fm7TSVyrzLe1yawAq59hv740LFU7BV2
	 7jzDevTii8UIWAixovUvdQSlAPw1m8QMrJB8vnHKYmCA80CFSl0mjNnIBWNPsieYGnp4d
	 zreJJkOOjwnNoVp6VZwLMZ754+rhnownP467Wmwodn6fEOm4oQP6TvYxyYpQR2zdndnlG
	 lPwsTnRegg8dOlzcEoPBenLaneasjItlp7H/ZWsuOlcfX6d4WM0HtXIjrbtmtaHLk7G4c
	 EokXtWinpuKHfjv8P1NbWwCryLIczw++FSog71FD/B6Mkon5n7KwbGJekG9/mRq41uQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=FvxeZE3S;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=fHq5Etfh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B977F606A329;
	Mon, 16 Nov 2026 08:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B977F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=FvxeZE3S;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=fHq5Etfh
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFLb5S21152310;
	Mon, 16 Nov 2026 08:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=snhUoqANJ4mQe/xAT/hfRIBdRbk5H+uoMBHEN0WjCy4=; b=
	FvxeZE3Szc5qR7mdcty1mQlHg0VqMF2430x000U+I33652Ce58NpSdyFY6gtlbvk
	XuVPbh2sfbbE2rWewjJfbqcHDx/l8GPSwK1Ba2FdtrkFeelnVNsY2VpFdnL5O2pd
	ZPC7RLD7BIbWAUad6UKhBpd3laPvu4G0LbHB3+cI1g2uloIevLMd0TMgAOhlkLs1
	wR+n5UNJJh/zphc6rocv59N9Ue1n4RKCMurvV/gzpyCLreGchCnQNOnpQjRHrTpB
	5LtuzYXkUEDzkHsiIw9XGCf58KqaBg+vAveCFxFRvsa8ySUcp2SXFEFG8W9v1Efd
	qfRCWY7x67uk3OyfnBQxgw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxee41mht-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 08:26:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7c5Vr2871229;
	Mon, 16 Nov 2026 08:26:13 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hyvt1u5sj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 08:26:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRdVhLZdv0GHoh2jMUn/Y8wsi/RFi3S80jKGoeMNdrdUViqR8CD6e0/V92BnsAfYdqgbFapy/Bd4tOtZbDEtmVrMMXEE84eE3PhST8WwZlvu09EsI273H9k+PQVFTflz+2oktMDQrIEbFBx1AYTlz09EP4MGdpkVrkLJ4RGEIL5UEBnONdiT2hAIrVc2xj+nCfN1UdtFXSG74lWnP0FCTumihwcGrJPYwQrN2p3XHd4kLGEGPzA+EfTcrgdfOe4eoQRj09Q5fuSRY0+QmW5lJQKWN7p7N5HNxwHiFY6/J+aJBW4cN5sqEyAUnOxGRcBBCLfahKuuC2xVt8mUUyoiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snhUoqANJ4mQe/xAT/hfRIBdRbk5H+uoMBHEN0WjCy4=;
 b=Ln4/mXpsAooLvgQjXTZQzASplLEfncIXa2bgwloEmOd3wVgvhoYjpaluwVqOPoGUX1vMRcSnXyZWEbeZkaIxMbxQKOje0kWeGla/c0rlNe+8ivxKVsb3Tqa6rhpw0vWWVociWuHvRmM2DUlm8KE6QGqgx+oa6OqKAJonhTPQMYcq6hK+n1rhud1tVDvHCTku3cTvVWdIMWUCRwQpLQnC61PE5XwgJSdOG/JUH27AdY8kqxxopC+JJb2Jqbhb9mF9pStAwujD+Gk4DdGquoStP4VS1eoWVQc80ZmLJ+mgHQMV3RVMFBXgD5lTmFZ/zJD84AsSO9cWuVP+A+WBdknjIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snhUoqANJ4mQe/xAT/hfRIBdRbk5H+uoMBHEN0WjCy4=;
 b=fHq5Etfh5Dk+bxVpYLdMqHJdvdsgkAVxXbQxmmkm7l0g/hxHutTXnjCBRSSphEFnTkpoyz8FYQq6x/zDIz/byI1wN2qnMxwxxHBUuvavKgQukKczTcE3dJNs3Vhb9Hd3z6Jd8MiXkxwcShNy7O+CKiGiJJOyuu/rPKWxcXsUErU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 16 Nov
 2026 08:25:10 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:25:10 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v17 13/16] arm64/delay: enable testing smp_cond_load_relaxed_timeout()
Date: Mon, 16 Nov 2026 02:24:34 -0600
Message-Id: <20261116082437.66739-14-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261116082437.66739-1-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:303:b8::15) To CO6PR10MB5409.namprd10.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 498e5b1b-c564-4c10-73e4-08df43bb20cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|56012099006|261026140227099003|261022075727099003|261026121527099003|261028144727099003|261102123227099003|261021121427099003|261022105027099003|261102130727099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yVqk+DITOcIIKVXM1kKXWWFT4MLMMBfd2Fpinh6kyeBqhYt0xcVddbiRu5V6n4ZdiLv0KA/SrOFBhBHKdKGfDmlLflAnHNE6muZXzuxSiMXtUH4F5x+C8nx7am/8nLOZ/Fh/cLP8lvLicx9qAfJPYWks6bHVatAcnNppIJqvOSiB7/YEZEDJpM9I6kN+8ZeOOxPu2/AKBwgxnnqB+9EsudS0kQMnsXom5CUBp1BfvyW81KhPSXasmWGpzUgxaZsZaDuUBKPPoY1yQEqpPjIFZrKG4t9GwCx0sit6cQbXUOq7A3JU7cCs5YnRs26i3MZlaLZQC/ZHQQCGhWxQXuWk4zdC1pTRxaw1o/Zzaubp5n4bpiQuQeJZAmELZI1MXxd4neQ7h66WpIqGnwfErp1vOeZNW5J5ZBJUP9NbQrWkZHiH3oxugkzWN4D6+yVVnKR1SvNvbdGsKcmmCdsd7FfzhUOIl2DwWx4zePGYabh+PdBcjrbL8Ufr3RvLN90/Z7tpTeoO0z2PHCrKCJxs9BTeI+YsaBJfNiydbVNIkeriEDmUYFIaI2F61EndgzbL54sS0dqeFvPiMiUUD7/tf2LDmfDnkLBagHW5uCfXTWCaglym9t3fOiaSTALJZpAmyu3SzHn8jlFQQO9osHi4Onit1I4EvyDiu8m68WmDBwJ4W1o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(261026140227099003)(261022075727099003)(261026121527099003)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261102130727099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j2DdsPngw2z8q/JespPWl+H1iAOlt7w+1r+PK5pEkPYRbgRhZXApIkH4E5sZ?=
 =?us-ascii?Q?YCil6/TXnY1Cc+ogQ8F2FGbOMOBTR/RVemyChZxVb/7FYgxUQyhnZYEo9k5m?=
 =?us-ascii?Q?6Fahq+hCluSFstGD5UJ8H0kqCbr/V83cfNrIpHLUX+hILcGw3IZ+UuMBxS/R?=
 =?us-ascii?Q?az0Fr3OhBgEO1pYdBCRdvSNVFR9Y5IVivMJ31jddj4mCl/SCAa4hP7uiNDjJ?=
 =?us-ascii?Q?xsLXVEDuoS2XX5UrFIDa6QVDQFVMBqDgk1EWsZNdUxgnKSOFlxGnW8A8tFDz?=
 =?us-ascii?Q?lGwk8fcIUv1oGXnj4u+aLgSWYTZ9LvOSG6pEzrm/sYQHHzWIjkl52DLTjGHp?=
 =?us-ascii?Q?ArvmS9lhad74iXWvcFB3gfcZbAWnXNd+fix4g5D5EyNfZ3utbid1WUdMzRBb?=
 =?us-ascii?Q?oOZDQfaVvGrXzhPw6kmKGC25AIXkY1iMatc290o1hvmCvxZcc391h549zYt1?=
 =?us-ascii?Q?DsTZUvHwtNsxkU/FezoZTP7+o68Ttwfp4OZkl5UHigw/LUyTeCSg4NhPlMxL?=
 =?us-ascii?Q?kDWDx3ng94g3UYwIWXH5AfmXULcaSdBNepkAVF0GUVHmM03iZ/d+fK6fWjEU?=
 =?us-ascii?Q?RaQhI3Gd465JgR7eApCKu93anzPNs4EqRMQ1VoWYeMFg/uQIiaAxS+ZkP9xN?=
 =?us-ascii?Q?LVrzul1vGMrf1hWoPtpYyiRK6o+rg6kVsH8It9HIRKRe9Fu/IxtdAeztY5dF?=
 =?us-ascii?Q?4+AUKolKS3JwYoniRPfzsGwvx3Q8bleYgE8g0f228HMnHdMH53r35QQ9S4oV?=
 =?us-ascii?Q?VfiEKU+MdoAx1oSdKGVEvts33Y22aS9NndY59JW3zolGQTT69PIUoV9RQ23k?=
 =?us-ascii?Q?QAV6Q84XBhBe+6OVDIS49r3XC1Xynk/YmfQL5zvZ/EkI0DPzHjpaMjpWUJH3?=
 =?us-ascii?Q?7a4ossRk+ZStSt5e/GlHewP5poWOYDh8dg9CEgf3vtx8DMsYFhR9XorkZT8F?=
 =?us-ascii?Q?w3a4dm1wGtSGjHFGxCjLeZUf7eJYI7688s2VJmSVA36HisLWB8VSs+cEfNZC?=
 =?us-ascii?Q?i36DbaeyHTGtjjmsrHSUyebmwv+egjunF8OIqjaEBXT82KeEgWpw/58Y3ErU?=
 =?us-ascii?Q?MPYd531TGmZ6WkWwxo6oAbMvwcem5xr3iFcmrH2MiOOzP547XmrQCTDx5BB6?=
 =?us-ascii?Q?3PWCgvWhZCd8Vuw/9cxKiXW6Q+JEdslKgHVou5UVxXNrwWqtW0HMdA8V4Q7f?=
 =?us-ascii?Q?RNbgxotVXOnp1nhI7q4MDAv6Ov948WUpqAaNNmyx05RjXcYEe3Tl2y/dVlVP?=
 =?us-ascii?Q?5dR5kqblJn9RF5w59GomHEIXfBIsHg7EA485x2urfqtBZOjGzS0w5WOVTb8s?=
 =?us-ascii?Q?7N4pB3hnQ2feuLBWdLwurebymfqDHgBjTgFMNU4ert9vdl9ieHPWBTtOST3C?=
 =?us-ascii?Q?fh1lWj5zzCs6A5MfxN1vDVaNi8OauEMncsIeKtDN9NnYrlVXb+HsWg3MnwgA?=
 =?us-ascii?Q?3AOFs4cCDs3ASBiiqGrkdqcmfLgIia3Rd2AE3a/sXCBITk0RPPN2efH2AIB1?=
 =?us-ascii?Q?VEVtELCAmvccnJSkeYKTXzDJtlNys+k8CWFRKQ3o1mc7boXsbmyo9d/lHDRZ?=
 =?us-ascii?Q?cxDAAHb26AY1TfOAmAHZNoAhTNWQU7HT6qHWtR59kwJCsf2NFBW2BlLV3DEn?=
 =?us-ascii?Q?s8WQ/RuY1Lw5RwHzDexah3lHSwNSZZJz4ifPxJpXrJKy3M+b2I+o4j21bBTN?=
 =?us-ascii?Q?m/rRgkPKZGNdGzeXEURp4F9LrrfnaQtNYYvZXAoWdNSj1a9PK9cttPCAlcMK?=
 =?us-ascii?Q?HooSa/TBWhSqWe8LfVEuHzc9gb7Y448=3D?=
X-Exchange-RoutingPolicyChecked:
	vUBeQkxE/9OE7Hmc1/AL2gFotF+Ti/MoE1FFnzc7NqmLIAfIwFFmZvM580k6C4oJJlsPN3XLYsBl63rxH7kXRourLBLsEebMC4MNcvLkgTNAbi6f0dOs7ZMYOW4avYeia2wK2kkpAECBkIYQSMBaMZ+BWbYgoh2vDkI4wwJFkPw9wdW6v0NDQEVsiHxb/rgyVPeVh9AqQEUO/EpegbiGytLCXgwtEh3JszIo/EdvV0vEdRQXHfnQqgRjUKWdkiooPgxhgV6+NwQi7iooA+/Ar5Ajz43jdrVJBLPdDV2EdFf8/cLIAg1LLMghjELWuMp7S10vHL9gS3QCd+piYds1DA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qE2q0jxORMvL6wMdkcEpH/glOssj6hDtNjTKg6kF9iMrlisKLiGNwqqbzKMEEG3DIE51+qRwqrZBK7JynK12Tj7oBVkorWFcgQnO98VU0vi6oTiie3axmju4ay1DnVzH3vNULDl67ZXUBOLmseXCnt0xmOQxAMOlHGgvOwqYoIcqmvfGw9VlRNVCHSwUtWhQh5T2HzL9dmPtmv20+2+aticYmJrki/sw9gw6LeqvQxim9sLpaYHDT6gCaZfklVLCdzm9RJB+S+z/X8jVLyHp5EcA8EcZdbgAHgotRm/Nv4AaQZ52SEgp/R61j2lzFI69GkJYsI5ntFfk1qj1wzlO+R1bD01yLEzx3FZK4/AVVorIVOzqEW1uLk6NYa3MpnLSzBNewO1+Cvw1G6hSbdQ54ANr8ls0Ene9ewxTzMZHCa9AdrYPtX+dxWQTqPUG6liBe7s11exW6Sl7rZs5qze6PM3UmK6FQib8xZgVHnfFyOtkFYNkqXMnK4uiDtc+BOOtn9eycIuadX3nDvnqJ1BquQiyT12IyXXQemwbC98iZTE0e+pgcR7qWCun6MOX4U5uAZa6qaXEb7DRE7RI8Quzuo1/Tu49JQS89Sx8XylJDOw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498e5b1b-c564-4c10-73e4-08df43bb20cc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:25:10.0133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwvgHAh84GCSzc3x+2fhj6pc4UL55juGuwYgHh4cWRKpd7rVetMmCc87lCcsMcflJ/M3g1RpEqKOLRsUfgF/WZ+DohTEnUlc9gFmG7RF/cA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611160033
X-Proofpoint-GUID: 018B1UWLUeMgDtuLQCPPkzsOZv4iZps0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX7Ycd81LNXIte
 deZ0Awqcg8NoUTJpBQpVxUqshJskKln1WUzy0FhcIGv0XMI4ArwHX2wG21ERuzZOSQhvj1wjK26
 Q1TKQfEu1i54wg48eNFxfPfixzaNeBiIGBBkJ+zItuyX2ek+jOb1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX9hi5n9CJ1ItQ
 5muVCs/m04LXVybmqaq8PKfSCOMbVd+/ZaYh9lpPFYkT4sNT9ZErg0N0m5rnZFoqc3TDMXDa91o
 QSb07uW+9QGr7bqCFImtYkJMy21vx3SPVujtsvJd5M73JeKLcJMYtI+wA5DqhDbSUd5yUWxjZ/a
 jKU3jDOvCejVFXN2Znino2wvs0L2NTMw/UnwQcWNY2rMeieP/jvD/1TllyaHZxfgf3dF+Qv29mO
 HXBCNtTQMKyjwbIF6BWcPQZEu1H7/MfyQG8m2YMBo7WiUQYinjGyehrYCoPDwcH73cE57KWXzeM
 /pFrENAXHDNYmK5buQ+H0+Mr4M8LkXh8UzZjH+siDY6VtSCuxkO5CWg1BE64uCkZWR21WWzsHXL
 fz1jaTl7EGkuTvz44w/qWZZ0OnGoh6fiYm0G8PJxDm5tmrWTG0+yZqnHGFYu4sCUChIJiAXApr6
 kWtgU6JcM5W6K6uE8CQ==
X-Authority-Analysis: v=2.4 cv=W7utxhWk c=1 sm=1 tr=0 ts=6afabe26 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=vggBfdFIAAAA:8
 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8 a=_ws1mg_e2a79RCcDz9kA:9
 a=WmVTiCyuxqgg3mnwYu6p:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 018B1UWLUeMgDtuLQCPPkzsOZv4iZps0

Make the symbol arch_timer_evtstrm_available available to kunit.
This enables the barrier tests to be built as a module.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/clocksource/arm_arch_timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index bf27b709d23a..3e8a9bf9c297 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -28,6 +28,7 @@
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/ptp_kvm.h>
+#include <kunit/visibility.h>
 
 #include <asm/arch_timer.h>
 #include <asm/virt.h>
@@ -893,6 +894,7 @@ bool noinstr arch_timer_evtstrm_available(void)
 	 */
 	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
 }
+EXPORT_SYMBOL_IF_KUNIT(arch_timer_evtstrm_available);
 
 static struct arch_timer_kvm_info arch_timer_kvm_info;
 
-- 
2.43.7

