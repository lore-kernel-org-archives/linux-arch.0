Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794817605;
	b=gZ2lk05mMZ/wtB0BRK+ZMpCedrAOLmYjFFmII5dKXfsGqbHw5EzcbNTbCYXVRgVZsEOf
	 GqAtP6Vmsk95enPrkZlXldR5BPgzDEUWo2AI34Cg9+jSWXnHxbHciH3kee//qbgEMNS5R
	 RW2tKVfkZbDOlpy2xftdX+HlHINjDv//bmdIuxFspdnFKq62YTIXdlWr0NUOACSAWL1T5
	 /acYTcmbGMhW4Z589waIAzFZevgoY0umkmfWYApzudo1h6ZN/xsXXhDS8AEBx/w/EXh1D
	 zaDTMZrykH06IjLi/dSccCtSeads52pmEGIt1rMtHc6yKvDwPzcqXngaO6vw1u+9o1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817605;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID;
	bh=spWfCq7b/3npA4OTjPM14/ubjKsrXaE6n1gALC3AXL0=;
	b=PBAFJa/YMzesi6pa+5sX0hN+1sHun7XqGVoufRi+SNwDhZ+ZJKtxa+Itjv92vAneaRvm
	 KmiTLTH5DfyJx23qS6UPmemQzgF53KtiXegB3cwZNpN0hl4GwUzCg6VhyvsA+jq5P+4ZS
	 NZwYQXjs76xdhrLMCwaWJ/y7nHR1KcPmdlo4SAAzCbzN5nPGWp+7mOJGFIxGUSBtbyUo7
	 Puidx6F7sw3z0TviLMbXfiwkl/oSoLkFt8otNP+45JARzSJPikEiBHwMJEYs0EZWUkWxr
	 aCS+vXe6rDHpE2RRSrnFzEB9ToEnTPCYYOfey0HnWcrFwi+1c57JKgFCAwBc3A84Spg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b="TX2b/WU/";
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=J2Xk8OKz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E58A606A323;
	Mon, 16 Nov 2026 08:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E58A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=TX2b/WU/;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=J2Xk8OKz
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFNbSJE3795004;
	Mon, 16 Nov 2026 08:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=spWfCq7b/3npA4OTjPM14/ubjKsrXaE6n1gALC3AXL0=; b=
	TX2b/WU/JMuJpCHlyfIjwVij19qNfm2sVmA/vOBTtzl4TE4gSz8svbqgydhHXzbx
	hqE6FtmOxtEfLG8YZWf814BvS0W9ynTIu50Z1gkGgQvOIbnPPJYpPD5hzkulV087
	l1SOaFrqnXe6kpXnUhoyvdTB6WXevKis/av4CLVO8FkUU19J6F1AT3UaMLjpTcDp
	N91cicm2wA7CMDRVJRQn63SodC4NSQiScHdh+tY/GBPCR5PALu2DHZ6ay+4yWnOe
	w//nuinHKxKE2DPZd4Sh7lDkvD13sFimR0RdJYBOa+jlh6vcU8ahUDqk0fU+YPeo
	m0DF0w1+sEmNOk3S6DGddQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxe81hnaq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 08:26:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7c5Vt2871229;
	Mon, 16 Nov 2026 08:26:14 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hyvt1u5sj-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 08:26:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRC3zuWpOWMIgTff7v4LFuT925I/nhIMU/nE/Ai+sipk9YZ7eJOHxL0EUHoaCNCb2nHW2BhEPLFAwh2ZMIZ8OZzzkvdGrw9Im1BsRqR11J1oX+khvpXWZcL9/HHa9anMvxJUpwEGwHtg62YooG4xXy7uPl8N5pRIEEjWgDCfU3axDeSI8s6ulv3MhugoysweXTTDoJZJYMwtnb0iK+wZ1KuXlIkald2Gm3FesCDkqKKClCtvLTQGsbATCCZoSfeIeWYoVeiuHLuwM4aCFT65ezcdiHRaCRfAHLuFZIW6VHyYT7pltHerKlYU2b3LwTS7+xKKpGLvDh/r6hqy0QuUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spWfCq7b/3npA4OTjPM14/ubjKsrXaE6n1gALC3AXL0=;
 b=xKk4N9YYrY6AsuMIL0LBPD4hQP1jlVd8SWdrAU/ugGtmDOLPUScROpCiJ4GToHHxtEYnMIDoRXs/1sB9ZSgPuU4O7Gxuwo3i6vVPlDo9QjnmUEa4jjuFJSZltXtv2JvVYr8OcmN8/2Qh1EJwsshz9eUuLeCQ4rCXuiYGff9u0BCCunn8mJsrGW7kypp+BIvMfEG025BhJuZisa41p0Ph3hhzLUs9XlprOiRYRgADsH7/7yOnPxFwX6tzWzRizJYnhgArmHGwzR+AekkczCBhol/Fx/5y37F5nmofb5MIuQiVPH45rCCLdPA0KnSmFqaUgvZThSBCS/r5c1RaFWL4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spWfCq7b/3npA4OTjPM14/ubjKsrXaE6n1gALC3AXL0=;
 b=J2Xk8OKzzlY/UzcMQQPvePCyLWdy+rM/m1VHTUlUCI2ZrfEDIyvMF9ddv49Yox8J79k9Akq8RDGGcCiFXrk7pN/6ho24zfCjzEvCTCcgge0i9dRctjORcrcqS0utDLuI2KD4j85JbTKei3W01uqFPdQUq1aZpycMveqVm5YjNrs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 16 Nov
 2026 08:25:16 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:25:16 +0000
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
Subject: [PATCH v17 15/16] barrier: timeout validity checks for smp_cond_load_relaxed_timeout()
Date: Mon, 16 Nov 2026 02:24:36 -0600
Message-Id: <20261116082437.66739-16-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261116082437.66739-1-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:303:8c::15) To CO6PR10MB5409.namprd10.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 1db7eae3-497d-4595-1b0d-08df43bb2466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|56012099006|261026140227099003|261022075727099003|261026121527099003|261028144727099003|261102123227099003|261021121427099003|261022105027099003|261102130727099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AUMYZ99i4Uj6enlf9bQwxCt0fRsc+udQJRHBLvxWwXYg6VQGRGM8JQ7vFWwaFtq/RGRLi6B5ZP+Gu9Wxmczxui+G8sfcl1+1wmvuT6bzEDJNKC9+MtS3IXe2dBdNkU6PSPb/SBECdXj7bjQYdZCbc0IOsL/Jo1bc3Wc8AneJlnnNXVuRCMa0fwn4lLM+yIFS3rGPIBPQVRE6AxRPARR6ePftS/jkzyTdl6TQUdR0N6MvvFqlyK1yyP1fj0RJdM2ASwpSDAG+iJTdn3Ok3runIP1bnj4h3ylSxWo/WhxHrYbobvCWH6yfTus7D/0LV/jS+amDi65osk0x7yhEU60+5jeykBhVISTd07x8MabNWFEUwDt2yrgHq41X8i4tvlHlEL1giWupJeekWUe8Ex+n3eYUDaPdtGJISUdjAdUVgYUV/1tp0qgsqDSavMWJRngCTu0TYFEQYIrSYgy81ovQPq6nQC2ylkfpEeQTr7GVgat235Tsn7v0AjNX/fVQrt6/OhfXY78kYvBawNgim1nSr6myGb5hQ6bx44nVz7oJMZspX2D8Y14iDIg//dPT26pUUCuxODWf8YiK9z2DDiDjGQlh7JqK6yIYBnH7m02AotQZLlGRyDJV+Mmg/yPCifWi9Y2VAStpUqPdnjQsvDmZ4MmPvEzlEeWI16DH1tBgLGY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(261026140227099003)(261022075727099003)(261026121527099003)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261102130727099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZQuWq0NASr+R19pBe+iCDT5jUGBxy30Xd63dc9VAxHDSn+eWLDGB4vwTkWvG?=
 =?us-ascii?Q?vxp6fjGnwZ20lcZXAr2Y+tZEac0a8PkWBEc5Cusum5KeUfI5Ej4UiuvgW6+5?=
 =?us-ascii?Q?pO+TaX0O2eVlaSxq4MpAC4OpnxxFr9Qmjloi3XJt5kyDMRZ4wi84ni3eoaeg?=
 =?us-ascii?Q?DgLG33xg4bn3GmvpMppACq/eZ3RSh93//SbO8SgVk2ubjivhDlyu/k3yrChT?=
 =?us-ascii?Q?8qmq9EAFsr5XkQFuv5iBmL/mN0Y6oDgBxY7PZB9dAsmGPV/oHj+tk5UDet2i?=
 =?us-ascii?Q?jSLqeueDQxwedERrI3mrxJIEkO/xbSKbtBG+QN7LA4IMf6F8a1v+CDP9MhvJ?=
 =?us-ascii?Q?tcwvN+guP2xQiS8VZoRnDNQU4c+/bggwE94S/sv1+7YkS2T8lpBoqUGvwXsp?=
 =?us-ascii?Q?W4OY0ySxkGcyZP0gIoLFc1HccL5E8Ap/rYKXTY2j0PRVavOs5xYxFv69I8D9?=
 =?us-ascii?Q?11NByAuIwEE7+kPkWk7TGNmgV3HizRi7b86aWlYvDGfuS0NRuPm/SdOJruAr?=
 =?us-ascii?Q?2GggIyHHC4YRyOdEeJ7M2HOerxVUpR6w4F8/kRs5/uWyWlKLulUHCVhR/fML?=
 =?us-ascii?Q?JJxbrnnkxCXAtPhlJ6WnGnLZdA3+RfAi8WTrI3IBBEiQIGCdjtA0zuilX6Hk?=
 =?us-ascii?Q?CdTTZYyUtbA0iGJuPPHbMlvFTQptO3ESMPkhZabcJb4SzP+KC43AVYOl/oeY?=
 =?us-ascii?Q?qNlY3rnbWOTnnvTldGusf/LbQ0+VhAiz28SzCGQxBCZcAugfRnfzSW30xeSV?=
 =?us-ascii?Q?GzSr47qimqg8RfTmp74GLxnVHe//YHgUCJvo+UEKJWgO7B0O9ISQawtxpvoD?=
 =?us-ascii?Q?dFcqUoZl7CXDneEL6jhAYrsmFsAbbHZxHVdRX+/4zN2hNPB3lZTpRoUkBqvc?=
 =?us-ascii?Q?FXB5lMjAaNzpz6B4RhNn+dNDlB30Tuh1oMq6X3D2N3mA6ahUiidIWBTqxzkm?=
 =?us-ascii?Q?3k4jk+5MtuH+ibnrxaOew2NSNN2LpJGtZT9KQ0dFZVs/q5wsa9U1FvZlZzza?=
 =?us-ascii?Q?gs+59bengmoAdQjcijBLdam/IY26jfSWhfWByR7wDgFW2vQ1p8UT/Xqg02bc?=
 =?us-ascii?Q?+huISv/Cr50QHqsKsr3uEEZao3WOnluFHvQsMCTvOT3OdGewvSrX38YjXNmh?=
 =?us-ascii?Q?MTn4f4lsn7SSM8BIt+cCvqIDi1cDtKgPMsKoRiVa9/GrEipa6w7FSeeZzN9/?=
 =?us-ascii?Q?gc50FkAUNz6TFv+J9Jce6uNq9qysUY1/V5DElf1URbNyg0GO7pUpaW8Ek5q/?=
 =?us-ascii?Q?jWZhvi3FbxlZL9hUqJdJn718vDEb+T64elVCcSEHw3JEYXdouewgQihJDPjG?=
 =?us-ascii?Q?aTobzX4DGoX88q8f8YeO2aSq+carqDjXy1jleD1ATLG9BjwQeUpM84aRGuMP?=
 =?us-ascii?Q?GsXvOi40xGS3LP7G2QBG1hdHbCpiavxZxmfhhBuYpySlT7Re06Zx+MaXvVII?=
 =?us-ascii?Q?KOoQ+rQKvjujRSfhmUhSyjPZTnELacLQK9PF8kDxSd27znbeXhQavDVjIlWQ?=
 =?us-ascii?Q?aKZrWSH61LqhgV/GyM/Egx5T4AIlaMIK3PtykqIR/kjJD+cSwAuvOJVonwI3?=
 =?us-ascii?Q?UMZhI40FTwe3zMVq2NYLOfn8kDOeR9rn9N0j2MZUD5U55WBovvixPv6Cb0ci?=
 =?us-ascii?Q?ZpG39bMstOVoizuSSlORMtzejWk7Ig4zBwofQxMCVMROWchF3ZKyJ5GF1fCs?=
 =?us-ascii?Q?79dSJr6zF4qs1nU2IbxT1LkeQM0IoBF8e2BGyFRO8URdEuFtwooRBX3ZDrNt?=
 =?us-ascii?Q?7YdVYbqNEhCoOU7P3Asp+EQ4S+ZBeIw=3D?=
X-Exchange-RoutingPolicyChecked:
	0qkrFSx2LAnWqCv0MWegb/FQKu4CfTuH2ouRY8lESm7VZMKbbOpEJkxfhTQ2q67gbNy1Gk1B3TJJAk0omGKDN9tS0utMGsG+s4XVNSav9+/5fs9mHpGtXGRy9xWAKCOrx6rFrRdlCR87TZFLL2IKTe71y+KrtyUJuQdh0zXomlrVNrPTGmHZTptAQbcRsQORP7wrMtSNcgruA5WQ1rXN4Hd1KD/BFm0t6PUkWkFf7fj/ty8OX0BogIl7xOD0GijoatVdqBvKpy6t56GVjFsEzWuN6r7uHHq7CT7pmXwdjbn9LdEuPoA0BZef+7GhJyyXdPqVfPLFGZGGKQZUK46rRA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bAlHld52mYTDWUQvEye3JcpZ+Eqg5+5Zt86nbCmN/qz2MceE0mF6YWsCwWr1nJipA3Y+aZzFV1HqOB30tXuVHYtNoyXJScj+95bHF/e91WZuMFuVVV0dAji9KIn9S+TziKXZ4camebmw9DqiKzZgIqabPpn4iR02atsc3AdqlspQdB14CC++IwnepDIjpM9LFoMWa5LdsemzD6nkLI3srg+gH4T9YBRet6xKtHPswMnWAt6GpFEWwqpqAZDAyA34oYA3JHZIhrr4XQ6hptjbeuHE/7B62GanoGtNSLlnM1ihA5IteG9tMLBaxQ3fvPrdYsqmlxG38WGHr6EQ99CZzYcrZsj8ikItM+OWpttVvHsiRyY2Pxw2tVIapcJrmgcXDIO5jd8qkW4lOMydA4Wzb47nb0j67xK28yfzSoU4cVjNnPmqfFTUts5VmRzeJ43wg7kRZVRLfgCOUPLt1JIIPqQ0DPf81kKxAsG5INRBTrvP/C9mg8SX1uoBkIe8Q4cgVq9OoOBMaU92O7fpWbEqd1ADd+Sxym/GMQIH/M3/34pII027wzoqo2n3UHA6/zbtx9milir/BKAXDABct85mk0SNiC88IaErU3bioExFBpc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db7eae3-497d-4595-1b0d-08df43bb2466
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:25:15.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qb1M7AlCmAWJJFDMWdCD/DS3ZW8S7lnERf/OPaUtMw/26FLISiibNA5OrqJzixlXsb9h41TpBEJTswAJ+SNwQTGHwtNJMF1pUL067y6GSBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611160033
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfXw080I38LCC1t
 u/mYfUJopWa96faJ+tmwKSFRcRcyIk4Rn7DMts4lgaT3tZZ7xGGg66QUdRKHo+92c/JtxYw/kIY
 v7YYsGvLfARgk+KQ15Oypf+QNoMdW0rNkg+Cxgz2m+0aThEftS6uhcXE/TLTFgYX3uAtDmKOKBZ
 0811gi8tvtMJr6rFs1lKndgxrKKefGIS1/9fPQUL4J5FOq842Cf6BKXYLLErzf+1LT6zAfkPh9v
 hkH/rYdggXbFEBfW/wtgsv9fzfH+u/XFqWtl8u2lSbeZveS0/u79HCVxTIJxerCgPnKWH5RajUa
 09YbI78MKGW/sV3pmZSe7bL/Ml4Pel4X+GuPD/d+3fdry/DJ5yqRzXvxfV7kKaytM8GW6sK2BYR
 UOZfHCiJWUrRr+/hFSX5Tz6lUXTCz1S2XAIefapXGbu+WHAsfuwMNBOtU2oaO2xJfT+cPH6uRyS
 AnQiKEa6ndYniAazw+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX5VDKZYQs7Xre
 stzlK38svkAUwK7hY9R4vr1GNOACx9RDU4fxDOfQhAqoB8rJz70JKeUQlkTQrudqh25ogviLM4G
 BbKSeY/tKS6aup9Wf/pjbhgq+MUmMDSQZbSY/LP3sU7Pt87cd5di
X-Authority-Analysis: v=2.4 cv=ZIBCCn7b c=1 sm=1 tr=0 ts=6afabe26 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=vggBfdFIAAAA:8 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8
 a=TvzTAWdPqagB0ohX4sgA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-ORIG-GUID: 959ysuGGPRMb08LIobA508YbKpszsZ5S
X-Proofpoint-GUID: 959ysuGGPRMb08LIobA508YbKpszsZ5S

Add timeout tests for smp_cond_load_relaxed_timeout().  These check
that the implementation returns early on invalid timeout values and
handles edge cases sanely.

Tested-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 lib/tests/barrier_timeout_kunit.c | 112 ++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/lib/tests/barrier_timeout_kunit.c b/lib/tests/barrier_timeout_kunit.c
index 63d82f05ca59..b6cdecf29574 100644
--- a/lib/tests/barrier_timeout_kunit.c
+++ b/lib/tests/barrier_timeout_kunit.c
@@ -19,6 +19,8 @@ MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 struct clock_state {
 	s64	start_time;
 	s64	end_time;
+	s64	extra;
+	u32	niters;
 };
 
 #define TIMEOUT_MSEC	2
@@ -113,8 +115,118 @@ static void test_smp_cond_timeout(struct kunit *test)
 		KUNIT_EXPECT_GE(test, runtime, timeout_ns);
 }
 
+static s64 synthetic_clock(struct clock_state *clk)
+{
+	clk->end_time += clk->extra;
+	clk->niters++;
+
+	return clk->end_time;
+}
+
+struct smp_cond_expiry_params {
+	char	*desc;
+	u64	timeout_ns;
+	s64	clk_unit;
+	s64	miniters;
+	s64	maxiters;
+};
+
+static const struct smp_cond_expiry_params expiry_params_list[] = {
+	/* timeout_ns is invalid/out-of-range */
+	{ .clk_unit = 0, .timeout_ns = -1LL,	.miniters = -1, .maxiters = 0, .desc = "invalid (-1LL)", },
+	{ .clk_unit = 0, .timeout_ns = ~0ULL,	.miniters = -1, .maxiters = 0, .desc = "invalid (~0ULL)", },
+	{ .clk_unit = 0, .timeout_ns = S64_MAX+1ULL, .miniters = -1, .maxiters = 0, .desc = "out-of-range (S64_MAX+1)", },
+	{ .clk_unit = 0, .timeout_ns = U64_MAX,	.miniters = -1, .maxiters = 0, .desc = "out-of-range (U64_MAX)", },
+	{ .clk_unit = 0, .timeout_ns = 0,	.miniters = -1, .maxiters = 1, .desc = "degenerate (0)",    },
+
+	/* timeout_ns is valid */
+	{ .clk_unit = (0x1ULL << 28), .timeout_ns = 1,		    .miniters = 1,	      .maxiters = -1, .desc = "1",    },
+	{ .clk_unit = (0x1ULL << 28), .timeout_ns = (0x1ULL << 30), .miniters = 1 << (30-28), .maxiters = -1, .desc = "1<<30",   },
+	{ .clk_unit = (0x1ULL << 28), .timeout_ns = S32_MAX,	    .miniters = 1 << (31-28), .maxiters = -1, .desc = "S32_MAX", },
+	{ .clk_unit = (0x1ULL << 28), .timeout_ns = U32_MAX,	    .miniters = 1 << (32-28), .maxiters = -1, .desc = "U32_MAX", },
+	{ .clk_unit = (0x1ULL << 28), .timeout_ns = (0x1ULL << 33), .miniters = 1 << (33-28), .maxiters = -1, .desc = "1<<33",   },
+};
+
+static void expiry_param_to_desc(const struct smp_cond_expiry_params *p, char *desc)
+{
+	char iters[32] = "";
+
+	if (p->miniters != -1)
+		snprintf(iters, 32, ">= 0x%llx", (u64)p->miniters);
+	else if (p->maxiters != -1)
+		snprintf(iters, 32, "%s 0x%llx", p->maxiters == 0 ? "==" : "<=", (u64)p->maxiters);
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
+		 "smp_cond_*_timeout: clock=%s, timeout=%s, iterations %s",
+		 "synthetic", p->desc, iters);
+}
+
+static char *expiry_skip_test(const struct smp_cond_expiry_params *p)
+{
+#ifdef CONFIG_ARM64
+
+	/*
+	 * WFXT waits for the full p->timeout_ns so limit it to a reasonable
+	 * duration.
+	 */
+	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT) &&
+	    p->timeout_ns >= NSEC_PER_SEC) {
+
+		return "runtime duration too long";
+	}
+#endif
+	return NULL;
+}
+
+static void test_smp_cond_relaxed(struct kunit *test)
+{
+	const struct smp_cond_expiry_params *p = test->param_value;
+	struct clock_state clk = {
+		.start_time = 0,
+		.end_time = 0,
+		.extra = p->clk_unit,
+		.niters = 0,
+	};
+	unsigned int result;
+	s64 runtime;
+	char *reason;
+
+	reason = expiry_skip_test(p);
+	if (reason)
+		kunit_skip(test, "%s", reason);
+
+	scu_flag = 0;
+
+	preempt_disable();
+	result = smp_cond_load_relaxed_timeout(&scu_flag,
+						0,
+						synthetic_clock(&clk),
+						p->timeout_ns);
+	preempt_enable();
+
+	runtime = (u64)clk.end_time - (u64)clk.start_time;
+
+	KUNIT_EXPECT_EQ(test, result, scu_flag);
+	/*
+	 * Check if we do the expected number of iterations.
+	 */
+	if (p->miniters != -1)
+		KUNIT_EXPECT_GE(test, clk.niters, p->miniters);
+	if (p->maxiters != -1)
+		KUNIT_EXPECT_LE(test, clk.niters, p->maxiters);
+
+	/*
+	 * maxiters == 0 means that the timeout is invalid/out-of-range.
+	 * When not, we cannot return with runtime < timeout_ns.
+	 */
+	if (p->maxiters != 0)
+		KUNIT_EXPECT_GE(test, runtime, p->timeout_ns);
+}
+
+KUNIT_ARRAY_PARAM(smp_cond_expiry_params, expiry_params_list, expiry_param_to_desc);
 static struct kunit_case barrier_timeout_test_cases[] = {
 	KUNIT_CASE_PARAM(test_smp_cond_timeout, smp_cond_update_params_gen_params),
+	KUNIT_CASE_PARAM(test_smp_cond_relaxed, smp_cond_expiry_params_gen_params),
 	{}
 };
 
-- 
2.43.7

