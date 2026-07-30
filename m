Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33E93D75CF;
	Thu, 30 Jul 2026 23:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454375; cv=fail; b=saSiwdJPIBIujF3YNp8AVT4HxF7cX6tvJ4zsCEA2XRPfpPYfSsxngbt0NXSJdD5qNxGz0sb1xkhhnzNbjyA4BSk9R7C1eQpr8eltSOJqwiE0jQ+FO5GHXMZqLJyMRmfs9W1PPI0+Z0otH1owtkMtYZRM8lV6LHVXprjx7lHBbQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454375; c=relaxed/simple;
	bh=+3CuoX5x3SDxi4B48J/76rn+QaQpttGgCGpK+CQrmnM=;
	h=References:From:To:Subject:CC:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=ThIfNOj8iXn0JG2YCvzLf/BtOTxoDM+KzOWQqZ7pyW/AU0Id0pCBEsJajIiMAcbq1KNn25LjDgpxtQ77tWUTZjewyhcaJA9kkfECzSlZtWKsC1cBxyUZVEL9AQVsUOYDtaHQI/4RrZ7mI2Hi951NK8uhk/XqOXSX4lV+NHrqzCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EAsArye4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KW3NL2C3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EAsArye4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KW3NL2C3"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UEu47Q1780317;
	Thu, 30 Jul 2026 23:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RCj+orpzesOeJE+xTL
	r0wsbdVnrDxZ9aftGEfZ0RucQ=; b=EAsArye4V8HumOBQCcqz1/lCmj9gO/ck0q
	0cuv32gXUAoDmSJKLo+VW8bpJ8i3Pq5WtHYzXF5wLSgrOTpEULVfWQGZE5xEmyUw
	qkrLeB1GCVURN3GAmq5EOdJZg0uxDd4o96J9mhIgo1tsqiDzjsV4YMrOy92iAXEI
	vgVrPpefU7iZM9AuNQGR8YSunukmdBj04vSeavVa+4Thqyh9j/bwMicREiYt8NZq
	oArKXQ67OXXFOv4OlNiVNNj1TXgILh1HNFmlrKzXaBlod4K0PM1rINGgl7Fiy2bc
	NuzmcIDHoGEi2MSjzXQ2es8qcVj3lPb4gXgoo3+E8sLnipcCN0dg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr018msk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 23:32:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66UN9wBk015665;
	Thu, 30 Jul 2026 23:32:07 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010025.outbound.protection.outlook.com [40.93.198.25])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fnh8a145u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 Jul 2026 23:32:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePwgXhldQ+pssQDO4mfyaIRjZT1tDakkHocVIEZO3K1dbrIvbklD8ko/MjucEpVZP/B8KJKjErqQ3dVRpMM1yDCLnXeJlJmrvPPu+xkX1iMiP9aZLBw+qPHpBfLsr6kMIqMZyds3uAPZeX7X5uX505MzzJsH63Wmr8sux3EqO8jLOKesTfTTh0MByiI99jhqBtP6LyvNd7gQkdz8zRKGF8fhmYpHPjfVOuZJhjrNTw/yZchxBpvoDsCmpzDQeMtyxmkNC98XPvsvmHll6bq+p85CvtktGWQ9z0kjwHpyklfwo80dDwtMjQD8GEfY3V4awH6vNpCNyOA/htSY3PC0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCj+orpzesOeJE+xTLr0wsbdVnrDxZ9aftGEfZ0RucQ=;
 b=EY1geZ96P+mDTGdNDJMM1WKxLmr38kZnErRd00I3G2wUz3vCgWoiC5vGMm/awtqOnv/da/Nmxsm4qfdR6u+hsoa48PRK+k3SdPq1H1UJ/ucmqW8pyUkuwLzmD1qBMvk6eRqIUMh/tNroObm/QKyHRHHC9AiW11g6oByRjg+jk9+nAfUb0vCLR3W1vgF7hrrFFze+TibFneMJAzB1ne9aXFQTZM3f7nvztxiQSvT7JcaTTD/WfTdchyS9g4jZirN9qT8SSrAFOS9AZ3+YurtJx2uXSGKLWHFFNA7S1WrWxusEhiX2D89yu6ONEvDATrxM3YP2se4WYQ22f+b3VA4ycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCj+orpzesOeJE+xTLr0wsbdVnrDxZ9aftGEfZ0RucQ=;
 b=KW3NL2C3dld1dXRjLibRiq9FAay+bZJ8dqqvxfO9/xKGW0UYShUO5WRjug2sntpXXxeG5crDf09wfqsjCMNjN4bGzVZDb+W/gcvT4Cx3gU6TfLRnWB5P1Ix8fUxwAsj+GO5bf0UBNoGh37W28kuFdyFN2nQUjaPhG0nVC1cwbsI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH3PPF46347F8D1.namprd10.prod.outlook.com (2603:10b6:518:1::79a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 23:32:02 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 23:32:02 +0000
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
 <20260714073041.40250-6-ankur.a.arora@oracle.com>
 <20260714074406.95EDF1F000E9@smtp.kernel.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: sashiko-reviews@lists.linux.dev, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v14 05/15] arm64: rqspinlock: Remove private copy of
 smp_cond_load_acquire_timewait()
CC: <arnd@arndb.de>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <peterz@infradead.org>, <akpm@linux-foundation.org>,
        <mark.rutland@arm.com>, <harisokn@amazon.com>, <cl@gentwo.org>,
        <ast@kernel.org>, <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <memxor@gmail.com>, <zhenglifeng1@huawei.com>,
        <xueshuai@linux.alibaba.com>, <rdunlap@infradead.org>,
        <david.laight.linux@gmail.com>, <broonie@kernel.org>,
        <joao.m.martins@oracle.com>, <boris.ostrovsky@oracle.com>,
        <konrad.wilk@oracle.com>, <ashok.bhat@arm.com>,
        Ankur Arora
 <ankur.a.arora@oracle.com>
In-reply-to: <20260714074406.95EDF1F000E9@smtp.kernel.org>
Date: Thu, 30 Jul 2026 16:31:55 -0700
Message-ID: <87cxw42gwk.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0341.namprd04.prod.outlook.com
 (2603:10b6:303:8a::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH3PPF46347F8D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9b11da-061d-4dbb-a148-08deee92c221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|3023799007|10067099003|4143699003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Ti3OV2ruRFVyMGm2qd5XI7JmnLUoSjKLIK58WKN8s7e8LTdtcqa2QfydtUQOtlrfMokDxf89Hhpkyg6rcB02eYOReJeyuzNYPiyqYtLqZ0HPiOUEJt4TErOWRr7s/HMVEWEGGazeviLWttrrlPk23LZV1VD298e0QE6pQZJPX5d4hcamDrfVB9eXWxKla6PqpanhNd1qFHJlAqTK2CFle9RIEinNqdC/AbyhqWB7sOnViaH8qCKKL9+z1JH7vBgNi7o4X5R1tqVW9f0ipoZREekHAKPkA1tcITilziiiisiK3hXhTsq37HkH9WwgILx8oGoJbfl/QISGUDSuu6uzi5QWmfG+jN36FW//z58ULCsoAOfKIhnVeATwWAfvghhGTYxPFhP9tED4+tqKtwT35V/sfD5W4ibmq3CYEY6/Z9tUH7pUBL41QYxMRNibnb2bGZOm2A1ismKT5uskrOEvdOc4xydBjwObCmIYG6J8tULlXthn5GpE6vgoEstKNQrQaJbEvuJIp5kcatBfXAKh1i8VnWxz4U1C5fckjlRwhmx+OmWW/BizjJGczNCQLvtuQXoeIgjL4flLD+1b++8IzAmgY8m6xW4TJa7CW7RsdGUlfNmoMK0CUYPnS1p82IBW6dFvjo9nlp8W518wmqRhSyRhWZvPmXxrgW8kAplGkfQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(3023799007)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AC1yHUiNBNQlFeszUmF4wDpRp2YEOhPigzNlUpJ+3vgsoyJSiftfh2ps+nuB?=
 =?us-ascii?Q?ClaU5d0tQ6eHPuBV/Ovbew+h7Uty+Rt+xioy1XnTbJqn+hNxY3GCAK8CS570?=
 =?us-ascii?Q?tnD30cs9t9dCqdGjPiCZPqg8oxuE1Ry7DmLrT4bqHm4gOUAivBqtsqadgFyl?=
 =?us-ascii?Q?a7ATcAe6E4sUuNMCSUGfsTzSSlkKavm82tqs+if0fTKDVh12VXTd9+UJfQxx?=
 =?us-ascii?Q?wOtXPGj9uWufPYB1klhxXNqkg/Tr+w3qO37OXQH3gY3mAscPrjQwfTg8WBdm?=
 =?us-ascii?Q?1cBDsgZjfHKzY/NWYDx7cajjRznTn0/Mt3HNd7l8GpqjA7SYxwOp203fPebp?=
 =?us-ascii?Q?0riHlGOYMdcLCKd01+vCzk1WCI5VVptbMB76s110XWn5u9+9u3dL+CIM7BO8?=
 =?us-ascii?Q?o0DaStRsMnFd4GJ7tfnlBHvnPzJanP09BJ95YrzUWgLp3ESUP4CZcW8EYQLh?=
 =?us-ascii?Q?k1YqBXGQDv1DkFeXxcJV2qPaIh9iwf/oMf7MfP0sIJinit2t6r7zjnOist4f?=
 =?us-ascii?Q?XTM5zrpN2BfAIr5uskVIqaBvSfyxXA+27cHyPKAvklIpD5bv9NazE9MM+r5i?=
 =?us-ascii?Q?vvkKYBKmUBrORRSGXcbwriMSeF4x3upKnEcIZZ26BEpUmCtzw6TwjzhbbYJf?=
 =?us-ascii?Q?zfWkH4kVcPPU4MZTzs1QV0nTTuAcMskmSvom4wR6UyHMyKNJ4i29CzF8vMn9?=
 =?us-ascii?Q?ayEejRX7wBxtX/3fAN07XDVVgA7mvceS2hNrBdY0bxlLsjN//EqVBfASDv+l?=
 =?us-ascii?Q?d6tQAkWW6Mv5RKJPXRHvWPnO/suJhk59wfEFVGu83YYEpHGXv8oEFkVYvjTz?=
 =?us-ascii?Q?bLx37I6+2lTX/zQevFrgDeKHIDF8F0QP/cPSzmE+rFo2g3rVCArKJf9E3PUA?=
 =?us-ascii?Q?prqQoatYW4Qx+brdRv3IMyMDtiCMitmYy/wgsjWRQVoEVjUVSHqDBAsKZXoA?=
 =?us-ascii?Q?NLw+ldt3HvAN/kwIuPik5eP47Gi3usXcHL04F8meJwh8XNDAS0KdoYbhKFR6?=
 =?us-ascii?Q?UiIeCz6eIT0x+dNS/N0tNtISbji0SUOirw7V3rgPLEQ+IPDAPRqz71bgXMOi?=
 =?us-ascii?Q?9648a4P3kV639gv9YZlgaIwNdaWKKxHROpYWxxrQ/YcN7DtyLs+res+v/23i?=
 =?us-ascii?Q?kIznPaYIJBiKVnAFpqfJjRyvtNd8eYa8CHeG7wQTzAifcjpdqUkfhIYuFjhL?=
 =?us-ascii?Q?LX8t4Y9JWvBnI6PHL07uZFN/Kw9QqSHSpEatCLrEUQYFqv1ikt+ulEyUL0sR?=
 =?us-ascii?Q?qlOLvzL/TjC1uRZoBnHFBZLaPw/fk+NMarmncO2l/yRu0XEd+komHV0IFfod?=
 =?us-ascii?Q?qbc6hrDWkZ15rg0ms0ZljMh/SaFASBIk3WRu/tqW1loHdCV99HTpN047/+wm?=
 =?us-ascii?Q?LvEfolXIwrUjfLgpROzGSXcPYSFleKMfbFpVxvYbcGZHG9C6C++4Eoo2LJot?=
 =?us-ascii?Q?ouwPd4lIfWgyfmJIJftn6qxiEm0GVt3sM8ix00I9mk7IXSef30+5GnF2YHww?=
 =?us-ascii?Q?iRlXFq0eeCVbOcw0hC/qzEYwMXlf3Q/h0TEp9b8atVtVyEl1bMuGYWslpC+D?=
 =?us-ascii?Q?TuN3taOerXxfMDE5UI5MOaPdFSg5Uksyk1YoRMhIXdbP4VGMl0Lf0pVBili0?=
 =?us-ascii?Q?eQSa9zacpPWeOrRXBDG+xpulGncAI8xL7+WyDcFMaUXCz2QUygDMhAmp8pJJ?=
 =?us-ascii?Q?278QGgnc6ar/bEhF0Q6dXKUxovA7Oo9ySYFiIqEExzwC4wd7zpcBCbF2OyOZ?=
 =?us-ascii?Q?lMZG5OzyOzHl6S7MPD7HyxK/rZocnyc=3D?=
X-Exchange-RoutingPolicyChecked:
	kiQkff7b8ZzMpzgNQEn3LFZLVsIvdV0bMIgOcupvm0vExouUU2Kf43KwMHQm7vUwKhTB0J61jiS2qqY6Djd794FPWcY7fPJoaZDZm4V33jznJF1SpPvqRGzRpUJeTFkoUELp9ix4m3BQlNl5zoAOoNYTBT7BFmBpyQmSXBjHMbVW6wLxqYtOEcWGSidnFT1GKmHLwkMDhGPZY+a3pesz4DNHnN/6AFdqlYFiVTwtLwKKEwZ40HpfgIyUIRWOxqb/jflxwap2/Jh+wtbsPGcFj/LR9YR0Qm5G8quX76pvMA7Jn2/b/Okfo1MAWM+dxIe7pjZJhPFXpmlqLJVVIHBFOQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	thDzlAjfRDdYAOtSnfHk2VIZtYhg3HPPYwVmuAvfqiPxY7D2+zPpHO9tsnAu+29ejVQjuM2y2oGmib3m5b8K3v3yCgC3RkZAYyM6J7KE8v+653HP893NOWt03OXO9avpSoegELjSSs2oZkiKdGhHi3DfK699M6Cb+cNn7LyegJeMkCHYgf531uzd7ZT+M1AMSdUAfwvRR2P0jnslWIZkqMjjMZS595odwTSl7gtFfssZ3qfH+ANBrJebtgC28hqCB4Sv7bwhMBaEgPXJPIILkl23sBVHrRNditLVxJrx+28mDb2cHlzGBEj7KVQUSWQfwzI2rGgvMw/LiZ0IWDxjH67ernMpRK3UilcJ5WSNl4Qww+Bk7FLl0mMSLRPfxm3bLicSCjwR4zZUPzvhxBtRRKxnVcZwY7xvfKF0y4qSmXhZ++i2iPovmdl5NrBPvyHailF4WHcjdOEMDrUDizdrXKTy3bawTpvjpAHuaRXmA/71CvB2r51t8hPfM38AtSWvJ4TmwDVvKSLNjJO1i0cfTLmmMHj0mMYA4/WjkR0WsfhVAclWqKJa1jDd8bPWe19345g02VPQK7hBCyba5Ulf+mlVd3xOmh4JkeWK5Ze6wxQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9b11da-061d-4dbb-a148-08deee92c221
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 23:32:02.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AInE9VRWJEMevJTl7MoxU4UtOADLUAqY6z9uZjRGoP7JSmUEUdyMCOuzc5oqmEiLbkYEE8CPngtYr0sSKv9U6S2MEa7Mcb0RpWol9BFR6bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF46347F8D1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607300165
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE2NiBTYWx0ZWRfX1TVbgMU7R17G
 AquXr45x55scY23GGgKBtwFGoKzDykUVwuNg0h2WcNgJn0BdPrB6EXMufFDHo9xrlJ8P4X9O0nQ
 iQTizUU0pOMWn9LO1uL8LwQlxGJXNub6+WLJ96VP9AsfMEX7qU2I
X-Proofpoint-GUID: vU1l58rZ8EDIx56kA7cQBdVNu-qh7_TO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE2NiBTYWx0ZWRfX5Q/3yndie8EM
 qlUueSDJCrAJro0nI/JlnzsqKjr+rvrcmkVDp4Xe5Xd7WkqKrJQ5xDaem7z7NUxIKn8mbjITqhP
 CDijZYTPhPj9G3yncEpsuxe4wKaz5NhaVCGL8VaCIn6wRiAmXJFHHzLrXr+xpnSFVJSytNOvetb
 bF+eDhUZHDK785gXCadwh2Z3fAwlkI+hc5FiunYAdG1Xj6VO3nqupAqupE2hwcHerM547YvHizd
 VT9n8oHsAS2YDYJkjsJ0BEWKqR7a/EjFQcz5unbzuQcek61DZaLcaMQgiBuePaDYEdUFcEXu/4s
 LeMRzEZ2UFJcjzFSM84ofuq9HjESLELtK5DULVmVaV+h4TWQdBJEarht7xQ2toKZM5QHGd6dlP+
 Mrz9agbvyP3Ph5FJBAp53ij2UDBiFeHDAfVqRSk/zr+9lR/4HoBTxk4CxmNuVFidBLe+ZyhRwGf
 xE/RF9rm2Z4usOY/pTQ==
X-Authority-Analysis: v=2.4 cv=KL1qylFo c=1 sm=1 tr=0 ts=6a6bdef8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=vHjVXOEvDUsu6dP0IXMA:9
X-Proofpoint-ORIG-GUID: vU1l58rZ8EDIx56kA7cQBdVNu-qh7_TO


sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Removing the ARM64-specific `smp_cond_load_acquire_timewait()` fallback before replacing it with a working alternative breaks BPF `rqspinlock` timeout functionality, causing indefinite hangs on platforms without a timer event stream.

A private copy of this interface was committed to the tree prematurely.

Removal (while temporarily breaking bisection) was acked by the author
here:
  https://lore.kernel.org/lkml/CAP01T75VaNGk+adULuX3q_8uxc0z78J5B_5ECLy2VR=i7pBi0g@mail.gmail.com/

Ankur

>
> --- Patch [5]: [PATCH v14 05/15] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait() ---
> commit e150f6dc634a9b6af6666a67d9bc5ea262bedad7
> Author: Ankur Arora <ankur.a.arora@oracle.com>
>
> arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()
>
> This commit removes the private definition of smp_cond_load_acquire_timewait()
> and its helper macros from arch/arm64/include/asm/rqspinlock.h. The commit
> message notes this is in preparation for defining
> smp_cond_load_acquire_timeout(), allowing rqspinlock to fall back to using
> smp_cond_load_acquire() in the interim.
>
>> diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
>> index 9ea0a74e58927..a385603436e98 100644
>> --- a/arch/arm64/include/asm/rqspinlock.h
>> +++ b/arch/arm64/include/asm/rqspinlock.h
> [ ... ]
>> -#define smp_cond_load_acquire_timewait(ptr, cond_expr,			\
>> -				      time_expr_ns, time_limit_ns)	\
>> -({									\
>> -	__unqual_scalar_typeof(*ptr) _val;				\
>> -	int __wfe = arch_timer_evtstrm_available();			\
>> -									\
>> -	if (likely(__wfe)) {						\
>> -		_val = __smp_cond_load_acquire_timewait(ptr, cond_expr,	\
>> -							time_expr_ns,	\
>> -							time_limit_ns);	\
>> -	} else {							\
>> -		_val = __smp_cond_load_relaxed_spinwait(ptr, cond_expr,	\
>> -							time_expr_ns,	\
>> -							time_limit_ns);	\
>> -		smp_acquire__after_ctrl_dep();				\
>> -	}								\
>> -	(typeof(*ptr))_val;						\
>> -})
>> -
>> -#endif
>> -
>> -#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)
>
> [Severity: High]
> With this custom fallback removed, the BPF rqspinlock code will use the generic
> smp_cond_load_acquire(). Does this mean on platforms without a timer event
> stream (arch_timer_evtstrm_available() is false), a CPU could get permanently
> stuck in a WFE instruction during a lock timeout?
>
> In kernel/bpf/rqspinlock.c:resilient_queued_spin_lock_slowpath(), the timeout is
> evaluated as part of the condition expression:
>
>     res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
>
> But smp_cond_load_acquire() calls __cmpwait_relaxed() which executes WFE:
>
>     __cmpwait_relaxed(__PTR, VAL);
>
> If no stores occur to the locked byte, WFE will wait indefinitely, and the
> embedded timeout check won't be evaluated while the CPU is asleep.
