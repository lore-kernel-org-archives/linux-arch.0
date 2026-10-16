Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BE6418A29;
	Fri, 16 Oct 2026 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134578; cv=fail; b=lhszksLfp1tv42apPWImVdL38jgeIGexjBP1ehaDOD+t9IjjLxj72ADhYOmCzZ97Af4MCt2jYEow636NU13gpvujTPCPGNXqa5pWsmY78LK17s61xqLpdVipNqKVSRbmkA8HQpEH7+7ynNmMYL68RQYVA/YYs5klgiyX2JdbzVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134578; c=relaxed/simple;
	bh=hQj/z552tO5ffxKmkT+Gr2Vw3cTnqBksBzO8CXsN7C8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Omze5zUyKZJje6wsntWoSDL2dyke0eFGZaOJ1HoGEWvCzTPCM32MjsINXqb4u90ohRInpQYcTjJs9Y4W335WRCUtk0w3COFr01e9ViH1Q0GcdNwCebiPcXigeC7lYuebudGBaqyDieI+ufTrlmjozFCMC7LA6uUpDaWn6g1p0H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D0N7E11u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C9No8wSF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D0N7E11u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C9No8wSF"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FN7T7r2718030;
	Fri, 16 Oct 2026 07:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=H68vrrEIzisQpl2seBTMHtvO/mFlWJtRYs87ZchFTE8=; b=
	D0N7E11uX1cDR5/2DbtEJMmmwq73bwwgTHtxPFhNi5qZVKs38g8IrgTtvdRSzqbm
	TjnaAKhrWaXlO9iDsYkRUDOYTTi19aSoNsoW+rjxdrWkXTvDGtZUFDvvp1A4irAN
	pCnS0+03wSYNW+o5StgZXO9kyCCpoxwUhE62PlG9SOhK10vCursUlpbjZkBnKsuE
	mWUEPFVCTUT8KfTKywZY3o3scRmzYeNm3GKJV2l6s/qTUStCDdcqUmLI1tzuzR9r
	wHnPWsssQ2rJLNuregGDDkXFD/GXHyjTX5rnymujmg7KgEcb9dSdexzdxQPI7qbe
	cAEe7KHi3ZQbuFoqdbQixQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dbksevu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 07:08:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69G76Lsa022726;
	Fri, 16 Oct 2026 07:08:56 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btduevm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 07:08:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQkpW0yJRSYeIDWaErrGwE4SsD1zc3PYDQDgyDbiP4nOR8L1gmrmTqshJ2d9g3U+4tmgk+tHocl4yW7f+aWteytDnKagY9VD3Q7Dndb9RRROk7bl3KXxmcpvKXwekW7NMxdujkPm7VmGSaATq65c6MkQEUZBSk1zI9tTaxRZQOB/02VHbWIkFyhCu8dBuCdr+1l7clDh2cbGV5Qyn5fdRLrDzwBHH5qadTF3KAJKJaIsdfxucLSnPT4O6Mm7YgKHmpKT7QdB/6opH0oF3sefNjoRUEv8eysBwS26JW82OYPLTrcDqSZdOLe/LA5rmWAQDvPBmQNLy1ARYTVqi1Z0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H68vrrEIzisQpl2seBTMHtvO/mFlWJtRYs87ZchFTE8=;
 b=rZ5XYPv12d8C1+uOpjbEIUXvAl1vREHg3G2OLA1DqaDlhI8S7jmADvsoDELplr5WXmURPS5a+xiRORbBrT5wNMAViQ3MmE6y9HTBEMbqUdzPpRm9hT05koFL8qtNoy2zF5UtEA0e1PAusdncwSy2VVDY7DtndogXGFh/wx0FBd8bidwhIaQCFhTBFtyq6vdX7rF/pkPs3RWNaeNTikgrERwUg7IE0+0xPJiGORDkLruTufzVvVBbI4Ai90HK302p5iTIm0+JeyLUOGLtuKgtY//grFWF1FZVoFm/UxQ3z3mV1SnMel9e6CDMVyazCbDmOwd7aorZOX6zAqEL6hmmKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H68vrrEIzisQpl2seBTMHtvO/mFlWJtRYs87ZchFTE8=;
 b=C9No8wSF+ZSNacJpFSae/bD3JVX92JZX9jx67JNPnqvQJi5fKZYUj9QbwSahSUaCfXo353DsHZBHJAmE9t49YiWtn0VLsNOnDb7bZD29yxcCyxCkUSbN5T06zUygu0aaB+T9IFn9tZUk5BiqZeH6BReEk1d/MmNm1lriikQnKfE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Fri, 16 Oct
 2026 07:08:50 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.010; Fri, 16 Oct 2026
 07:08:50 +0000
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
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH v16 03/16] arm64/delay: move, fixup usecs_to_cycles()
Date: Fri, 16 Oct 2026 00:08:24 -0700
Message-Id: <20261016070837.440748-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261016070837.440748-1-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:303:b6::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 98cd0d32-4dc7-4d54-c056-08df2b54546f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|260925021911599003|260925021311599003|260925022911599003|261009223027099003|22082099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	qdVZXv0yPGCWB/iocNXRAAvhPphnoet0Wn7zf6Pq5Tof0k8O/PNt03s1KgI3bWCJQ41L48SwXXOdfj9vaDiAxEQQWg4yONSVcpoHtxqdMkFdnljqWrdHkKYiXFU+MbwzOeKZse+F/3TYV/X6f/N0eWcHjAdFiUdcyVpBtkmKIZOka6YbZXCxMi7CyepOkuvuBAaiPqKijLmLia6JjIIxsXbJJ6CaV1alxKoA0XUNlLv3AZDFEnkwOxd1JVRAUbMm1mBk4A4JQpLCxlul6KAWxh5wFcagTI/cwlvLuUxcx2xLyGL6rytS/q5mrdM+6oZ+mBFlw0iLUQghoMvAjzyhQh/HvFdoF/YX+YdrucfDhamgrOPCWsnKKKYGGWht3m7kZKgplm1PcDNIS8Q6Cy7VtJKT3gjbwDVjPtKOjxhe0CMOs1qTsVJJZk/3+kuJkRHLeQOEYMopF6biZFtfqG5McVZQp4K32J4561v7f0rj9Vu60n9LGFiRpxzmXG1x7df/HI6SEwybAm+mEASeJ5YkISAe5hlkXykR5MVaN8HmkI7oNGUQyiYUeRK+B4z+5qYOalh8rLHE85HknrEQEaUY5ZD5JIo0gQdN/ub3R6NrRTdLeP4l1nESzvkdYRpdapwcAXdW4AlrCLBGHdtUAttYyCz/ceKAJ+1IJ93eSuBRp8Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(260925021911599003)(260925021311599003)(260925022911599003)(261009223027099003)(22082099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MTxHPl4YM6HYb/JdT0mOBzjCbNppDQ8axRQSEtEXAjdJCOn6mzkxPbI1pTAB?=
 =?us-ascii?Q?fT2badvrtb4Q0HUTM4FqZ2hKh/Xq4YaqNcXKmTbTo/QMF0H4rcGIV71LhSUz?=
 =?us-ascii?Q?XA51MeCoQJN279jIJDWeQX3DkBzCdY+hqcl86H8Nn/IVoCCB7opVTBSiwtse?=
 =?us-ascii?Q?eoRo4r98R1WB5tTuzrsZRSwz/8sXusebmRd0ZVYQ6JtyvrOHsD+MJkuEfbUb?=
 =?us-ascii?Q?1uzHGmJhEfnyxtx2VpNNGBFtWtIUJglUsHGq7520ZOflrJbAFKeQtguJT90y?=
 =?us-ascii?Q?MM6pd0oXtHGCeN31VWeuBx1pn1j7d6KoR8/zNbNoxSXf9z+ss9NleFR+Di2K?=
 =?us-ascii?Q?kPybbi29wiBUNRP8FUm8erPFZMggX+3qqGQOiSHt65dtBSll+GEFyEvJXdQV?=
 =?us-ascii?Q?ngy0bwWTmVGNitGrv9YuAy1wjZLjfX80BMfccieffIfqV8GDtIK1Can+ep9R?=
 =?us-ascii?Q?1w+XPclzbWOq0rYQ67VWmgh0mqeMktGNXWV2JjvRr1DLoVktk7YzKNXUpAGS?=
 =?us-ascii?Q?V9RfNABqH6N/6r2ZM+po9rny5Obq4ueCwwIavRtr5w1OrBE2yrllpyfcpvK9?=
 =?us-ascii?Q?OIK/jhwx8/kZSsNUbHIRLbQ3XQp+HTia+9rwX6sRSqPVUsqyJDDzHkkf6TjK?=
 =?us-ascii?Q?S/Jij1uyQlGq8eKW7p6kCwYoTqMSFEY8CVdXJ0+jM9ODVq5JRH6xPU5UhXoN?=
 =?us-ascii?Q?L/93QUmzyp+rd5sMMIFcEM6uEuHRCXSTq2FKlKc6m095F4F5mG7DUCgXP3QW?=
 =?us-ascii?Q?b+v7aSwiJnUzYQK6dXJK+tzIzNA+MAYjcOIKsV6ANG7UM0V7T13Ypq1lz7yY?=
 =?us-ascii?Q?stW78/4P98OTnRn5yOqo41yVNq0VNW19tS7gMKExA3mJY0eui3VBBiKGh9H0?=
 =?us-ascii?Q?gxtA2ZIXMXGt4P/b8uYVER6mZ8o31UEAawGPMUCpXXEXm/8xoAmwcXquD9Ty?=
 =?us-ascii?Q?vnhzS6B7/5//ZrlgURovpTWfLn9Bq/W0HuQfxX+na3/23CGrF1Q8x9sbccEx?=
 =?us-ascii?Q?YkgInnoC+FKRYGu1fCFiwNcHGAFrjn6sIJHRXNoi1G/CHdeiGL9S5KMc4xFv?=
 =?us-ascii?Q?em0bh03ElhpNLYDE8O1pOQ2Bit0zIld1S7qMVKaBj+QcV5FEoDhYFzwV7P9x?=
 =?us-ascii?Q?TwbVogu6ko70NyF9YXVhhoWYAO5XPN+ms1O+MfXNPgzAEJ+MvXEz9k4K9A6h?=
 =?us-ascii?Q?n68DYg9wuU7m3XcdKhamo8b6YoJtclkaezVEqQnTK/dSG59FbskjnaSK3sEV?=
 =?us-ascii?Q?2TaX8aHgDywo7jMN95ZxfB47jW8x+2oXuT0clkISt4eOCxD7Uc76sSAdjFMA?=
 =?us-ascii?Q?ysp1WI25mM5kzb9vkepEQRUWTnyxBDHNY9vsIspQrR+jtT2oij2Bjy0NNltq?=
 =?us-ascii?Q?wCYgK1Wikqc6fkC7N7LsSr3vYUniW2B1seKCvGZRGG74DkOlqQyJiAeo7+HZ?=
 =?us-ascii?Q?/wJZ77AYLSNkm6WZFDXj15aTjGHHalTSZNtw+l0XzG34pKG6Wg3anq+TtdPw?=
 =?us-ascii?Q?/GfoyZt1646Y2NsnkHzY+a/miYg/eFLyenfXsbz4GlDR/Kt96fSO/FllYmVj?=
 =?us-ascii?Q?rztV5k3cQvnkGEcCmxSnxOFkIGqSkxR2p1Zub1Iq8qb6aU0Ey+X1wiZFXs0g?=
 =?us-ascii?Q?DhcpNUDCEoSsvx3zxNyP0A/A5ohQOnZy9EN2T2xqH5LtsFqusd7TBtQB/lr8?=
 =?us-ascii?Q?L7JUzVNz9/4iE5NyTbYV8PhPmO/RAlQ4ldXqG32K4yVYznyIUt0xXDZzAH+m?=
 =?us-ascii?Q?hUuEt4ehF0x0u/TiROqpBWkLgCgpeAA=3D?=
X-Exchange-RoutingPolicyChecked:
	ZBs/MUzNEJNiavFUVJDOTXSuEapt62S/yCdmHne0Bk98Br+lulVhyQT2Ib0J9lVp8qBZCKGM/kmlMp1G7Jf8CIp2wxNCNO/Ailt54SiKTRMbRQD3Z2TGXgbP4mxvcnf+xciOeA3w19oL05maew4Rq3P7THbBKcTO5E/2boTuYeLKd49I0fdACzqymPDeGvIh7T9Wr6C3fFXYKuScZ3a02bgDksR2RWHAACGT44JYahK3FnAhIzTDM9Y+P8aqkQ/51Lz16PP6zXDgpqCrzy48vYD+uB8haZerNoPdjNcUxDuIAPa37BHv0DTFp+qbmTnKifOj4y2sjhB71yxy45vqZg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IpHOcmTApRLTORLys7ySOAaZzRKFZUCu6o+lDzfYg2q1F0oTpotOCs31z97wQRVYnRKEX3TOEkMdL9scyds39AfV6w8hlYA3t6EDLFrm/TFziCcIYE2x1sYhRG2Lk0aIoQZjLHeltPgN2xzerp32K/Fu6EUkT6tAogfiGGQhI78G0LZlKdA2B0zF0oMpNvBaZSnJRKkne1unU6z/LeMtfCoGWEAtbV5UvMZlyQ/u0tP/QYI77x7YouCl8Qm3WAwvvqJjbXlC0I753Ha/pQStD1xHDC5TjuzzokxWr2R5tULhFOXfyBk3F0jTGX6HcKQG5mOFtTl/0aTEl3hRTTZRncXBcJr2WEzWn/I/SWX6Ub8X2LPOYnCYhI6vwSXgq0XY2rhBEWYwRk3zlk5MyAodC7qpgBFTc2tZ+kJ9dVx6yl8PgeBsYc3tgWeKtmDR0JPXLDa6JVxrfPTE5VyrBH2h3ZlbvDU6rmVWsx8Y8cmtVSC1i6knCaYr9491kQR6K9L3MqnBx6WGyxjIRZaDxCHzMlujzibwKgXBkPqijwSqAS0tYFP3jglEKzybJCkzyDamx9zo0izjNFq7gVk6RKmejko9uo6b08+bIpx2xvRhUtE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cd0d32-4dc7-4d54-c056-08df2b54546f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:08:50.5771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0H2TAI0mhpeSbNcee0VOxnhqwWHnRxk4FLWN8ld9ugnv5Az4vZrrbxlA7hxZ1FE+kvsIjUmIFAXsf383N6cuD1hkoxxvyYjcRpGgwGhUC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610160028
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6ad1cd88 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=NufY4J3AAAAA:8 a=yPCof4ZbAAAA:8 a=70AoctknFhLFtkeFxDcA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=TPcZfFuj8SYsoCJAFAiX:22
X-Proofpoint-GUID: XWQWXi7aoB2DMays9UUu8S2Mq7KC20Hf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfXwrYimPTDFBaa
 8VCgoTVR9fd9RB7XkrG85ocGJGUqD4yym0LJ8mj9OQdKp5cnWVxOp5BAe+0DIy4Sjz6CoxXRDKa
 0RRDmo1fzyyYShW7OjBMowXdJ6QTSz/V2F+dAjV7h6qV2tS76yjl7XJstH6wrUJ/yMwKIAsVPT0
 fzTnlgE03QCo1YYmSnDnR7fvd+JPrVfgKzisTgzkmUIuAJTXcJHy3NvTwaPK97eZSZI1m8qYsZE
 S667ZDjsF/vZCIoYbgRBgIuNCzCZKuMYqurt8qLdlA1x0pNEBRi+CsblCRj1tHb6rEA+fHnLlj2
 gm8FjTOVpopdZcfKA+Qs9bLuwNbslTfIM8xDF0FQnRl+Nt3uX2+8EyTgmTa2hPTfzXm2F8Ictbv
 JHqnqFE3dpCjhBpzKIi6Jn2PeIGq/A0/DaasBk14EQxxjM5cJXyici8DYzGT/wlPWxwv8zCl8g4
 5OqulJaibCbwmjH+O5w==
X-Proofpoint-ORIG-GUID: XWQWXi7aoB2DMays9UUu8S2Mq7KC20Hf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX/+RE/ktj2FEK
 Ir6lE07gp0hzPsFSzbamKdxlcLpMWsTsPOLWYmAL+qBJ0+fKa8tNx+4DFcIos7IuFRXh/0hUEzs
 rm4nuyUBOqub5B/haZec0iyegidlObatGn7L8jjJyC7lbaQWhk8h

Update xloops_to_cycles() to use mul_u64_u64_shr() instead of 32-bit fixed point
arithmetic to avoid truncation for delay values larger than ~10s
This adds an extra mul operation but is only used from delay loops so
shouldn't matter too much.

Also move some related constants and functions related to the cycles
computation out to a new header (converting some from macros to static
inlines). And finally make __delay_cycles() available outside of
arch/arm64/lib/delay.c.

Rename some macros in qcom/rpmh-rsc.c which were occupying the same
namespace.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Christoph Lameter <cl@linux.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
  - Make USECS_TO_CYCLES() into a static inline rpmh_usecs_to_cycles()

 arch/arm64/include/asm/delay-const.h | 35 ++++++++++++++++++++++++++++
 arch/arm64/lib/delay.c               | 17 ++++----------
 drivers/soc/qcom/rpmh-rsc.c          | 12 ++++++----
 3 files changed, 47 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm64/include/asm/delay-const.h

diff --git a/arch/arm64/include/asm/delay-const.h b/arch/arm64/include/asm/delay-const.h
new file mode 100644
index 000000000000..6ccdfe0a4130
--- /dev/null
+++ b/arch/arm64/include/asm/delay-const.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_DELAY_CONST_H
+#define _ASM_DELAY_CONST_H
+
+#include <linux/math64.h>
+#include <linux/types.h>
+#include <asm/param.h>	/* For HZ */
+
+/* 2**32 / 1000000 (rounded up) */
+#define __usecs_to_xloops_mult	0x10C7UL
+
+/* 2**32 / 1000000000 (rounded up) */
+#define __nsecs_to_xloops_mult	0x5UL
+
+extern unsigned long loops_per_jiffy;
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
+{
+	return xloops_to_cycles((time_nsecs) * __nsecs_to_xloops_mult);
+}
+
+u64 notrace __delay_cycles(void);
+
+#endif	/* _ASM_DELAY_CONST_H */
diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
index e278e060e78a..f08eacef2f0a 100644
--- a/arch/arm64/lib/delay.c
+++ b/arch/arm64/lib/delay.c
@@ -12,17 +12,10 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/timex.h>
+#include <asm/delay-const.h>
 
 #include <clocksource/arm_arch_timer.h>
 
-#define USECS_TO_CYCLES(time_usecs)			\
-	xloops_to_cycles((time_usecs) * 0x10C7UL)
-
-static inline unsigned long xloops_to_cycles(unsigned long xloops)
-{
-	return (xloops * loops_per_jiffy * HZ) >> 32;
-}
-
 /*
  * Force the use of CNTVCT_EL0 in order to have the same base as WFxT.
  * This avoids some annoying issues when CNTVOFF_EL2 is not reset 0 on a
@@ -32,7 +25,7 @@ static inline unsigned long xloops_to_cycles(unsigned long xloops)
  * Note that userspace cannot change the offset behind our back either,
  * as the vcpu mutex is held as long as KVM_RUN is in progress.
  */
-static cycles_t notrace __delay_cycles(void)
+u64 notrace __delay_cycles(void)
 {
 	guard(preempt_notrace)();
 	return __arch_counter_get_cntvct_stable();
@@ -54,7 +47,7 @@ void __delay(unsigned long cycles)
 			wfet(end);
 	} else 	if (arch_timer_evtstrm_available()) {
 		const cycles_t timer_evt_period =
-			USECS_TO_CYCLES(ARCH_TIMER_EVT_STREAM_PERIOD_US);
+			usecs_to_cycles(ARCH_TIMER_EVT_STREAM_PERIOD_US);
 
 		while ((__delay_cycles() - start + timer_evt_period) < cycles)
 			wfe();
@@ -73,12 +66,12 @@ EXPORT_SYMBOL(__const_udelay);
 
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
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index f881af35ecfc..dabe0ccba370 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -146,14 +146,16 @@ enum {
  *  +---------------------------------------------------+
  */
 
-#define USECS_TO_CYCLES(time_usecs)			\
-	xloops_to_cycles((time_usecs) * 0x10C7UL)
-
-static inline unsigned long xloops_to_cycles(u64 xloops)
+static inline u64 rpmh_xloops_to_cycles(u64 xloops)
 {
 	return (xloops * loops_per_jiffy * HZ) >> 32;
 }
 
+static inline u64 rpmh_usecs_to_cycles(u64 time_usecs)
+{
+	return rpmh_xloops_to_cycles((time_usecs) * 0x10C7UL);
+}
+
 static u32 rpmh_rsc_reg_offset_ver_2_7[] = {
 	[RSC_DRV_TCS_OFFSET]		= 672,
 	[RSC_DRV_CMD_OFFSET]		= 20,
@@ -828,7 +830,7 @@ void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv)
 	wakeup_us = ktime_to_us(wakeup);
 
 	/* Convert the wakeup to arch timer scale */
-	wakeup_cycles = USECS_TO_CYCLES(wakeup_us);
+	wakeup_cycles = rpmh_usecs_to_cycles(wakeup_us);
 	wakeup_cycles += arch_timer_read_counter();
 
 exit:
-- 
2.43.7

