Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B4B43785F;
	Fri, 16 Oct 2026 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792134625; cv=fail; b=qyM2TY3uR4hJvjpzKucmAkUULNE2GnPYVOuLhb3/B34v9FzfRNOe+3B7cJm4BJPSdwmNa3ZZmkgNuXaXeS4MWm5T9aXOdHvfKvhFvmHHTZkdN6iXzbyISxTqtNgGw3Gke6NJ9UOja8XjCYFQ4vF/8o6s90JIjwHbWYWgkhH9eZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792134625; c=relaxed/simple;
	bh=gpJukCnZ0HDsczZMhoF6w6vEcEVHRXCOqQmhb/fCYls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LYMuqZilBfDIVHsGHRUyJzm60P/Z2LelTiPaC7NBcXHB5e86ZrDrByQRLQk1RrjlAaU3kjYtPBpcR+xn/Ea2lpOJAxCq0GNcSsz9h6sFFTYG80Z+RfDhH/VLmceiTMtclWwIHUPSAVZJW+SGJySnUaoBR/CLDRxzbpwUEcwfwsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ENNEIki1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Oa5l9fxO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ENNEIki1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Oa5l9fxO"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FN6w9U2717190;
	Fri, 16 Oct 2026 07:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=reWmY6xJB4PGm3KildW1hDEyntbhMIL832NVeDWBiws=; b=
	ENNEIki1EOYJEuo1AHP+pr4EZzX/2RYDizvF5q++LoOsTbVNvb5Em039ob7rgu35
	eOKPo4/ynMfcXboQi5EtFVMzs2POv6GvtRQguA1kidyfJJO4IKJSnL3rp/Zdm7Mq
	QyD25yj9O/VFg0REt9werjCcNVaJPvje5qPsefHDr9cs8NjJbgqRi5ltO0qSOElH
	eehyCTQc2fuvb06VyKTAQMhug8jDX+Jx8cmk1u9ULt/KecdfEaNc1Asacjwqtp/p
	vqLUPXEcBIAltMe0RHyJlj5lHbKYWrzK5e0uvyeu3YeEWehAgPwV2i9/iUCL4ZjF
	zE11sYc6PIxQEXOxn2n0Fw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dbksex0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Oct 2026 07:09:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69G76MvP004365;
	Fri, 16 Oct 2026 07:09:45 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btcty0g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 07:09:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOPlx79QOnO8JQAcOdmlFAOti6ag4aXJCdp9NvTcPj9ZoNYzzHiAgcEu5819jX1PxU6lGZUqHV6My+kdwoZ1sIU+2sYIzySW/e+jeahtbcwO1z0z5wfgybFDmSCOCn8zVv7DSZPl3hgz0k8bU0wvWaHqBKxsKR5jF439X4MlephMoY3JMqUtfThHmkzvDum9dQUfOsVJetCHoyfDjMBXv1MsWYowaIytRE6aG/vYyVn5wroiN0ejPYtD7pXjmju31gkBMK0qDFlSp1Uf7I4Ot3dr1dz4xLsNpNDowMbau1FyUSJO6F4xSsJXxhfa2PnOfllUq4Q2Qb230PsCaIaqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reWmY6xJB4PGm3KildW1hDEyntbhMIL832NVeDWBiws=;
 b=ej1If7J5ha84oJq9ThXfF1gUxwdwzEvco9x0JBgQqIBFEzGiXXJ/uat5JBsyftR26j3n5cSfHgXP9YW5REtdUimPmB8kDYYy3K3HCH5EpYN7oZbnvzCR8rkQPtZfYcgOX+VVmMl3GQMczOuDu8ea9PmgG3Joyj9GUGb5pSUoaxLRZX2VyXXM6cDkw4mZzmJBBQYc8lNvKu4+eagwdVIS1UKrlj3FwGmnHf2e2y02vG2+YH835vUjli0xsaEqRZJthmriVjyz+cPD2QUdAt02EVU54vf2oBcKVULKQ8se6/2rvaMDb+G/fL9rjNUcIRWD9/5sClls1pkXa1CJeQAf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reWmY6xJB4PGm3KildW1hDEyntbhMIL832NVeDWBiws=;
 b=Oa5l9fxOuyYgj3JxksGLpzjEkc1/TvCQTnOBqORxTkM3/7F+D+6+yu6TkUgBq70x+19OESzw5PRqP/nAU13yVy41qJNHCVLKcAJIB7dZHBi/DeBauVftFD4HygcXZwOO0UIpH9TU6DfJW1rigHuQWPHwRd2eE/NXHJW9PgdLMqg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5668.namprd10.prod.outlook.com (2603:10b6:303:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Fri, 16 Oct
 2026 07:09:40 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.010; Fri, 16 Oct 2026
 07:09:40 +0000
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
Subject: [PATCH v16 16/16] barrier: timeout validity checks for smp_cond_load_acquire_timeout()
Date: Fri, 16 Oct 2026 00:08:37 -0700
Message-Id: <20261016070837.440748-17-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261016070837.440748-1-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:303:8e::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: fec6dcf4-2c61-4a05-196f-08df2b54724a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	f3vunYPPr+nCGa3FGvsbQnu6Luk4emhktgYbPfRr1qqyZshalXCgJ2JUl1sLj/Q5M/22Gw7NTtsoPz039la7yJl5ekwJcv2qD4jph5MJaV5WQ9GNRFSEy9JFldwLRcAd0ZJaKNbq58mEvr5Jb0jIDskfod1fI/kMuvoh0au0ajJYpGhQE3H7cdstiOErCAu381/Jud/IHTu7KZtARdp1TvCk2/1kwBeH6cLHBFe73bKkM5OPt6c8o953DW5FLNAn7t3GlBRVpLkV2n5mRqtOCXXIJd7Li5bCYZqjq3PIv1Ot6gYMG45hG7yLw02jfc1hdsbKGikz8SEtmW+bdx1et6VMng1v6ufEmBc3CUUkzMn4pS03IicMqkZlRsG5G+RNyfdTS2DOdFuogS1zC+339W51oDniJIC5Xm7ODfC8iL6ZQLm20nGx58is1x/IElwdvhC6bFP5XLSZ/AVopmEHCokruACnp5h+xf8hJoZa5wloY77UfzqzWz1+VCqxkq3m7beTCyrbWM7Pi1zlf7dlCNeTwEWja1D2ypm9FOOGU9Ri4ajyimXceQjSYpZUFmCB2pidIShCUvaVg5m8yfu3eT3gCOUjb8/0O/j/Nz1mI2CG3y6tD4a/yx2S5HYpitGNgWEIZy2UjMvH0uokoRy1aOAulEqdGZjSs8nnA/Jvgjw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(261009223027099003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NK//B71saz8H/9hUA10qEjVVCn26UtbxmBx6MgPkX/E08tb0OAfsY2sotyb+?=
 =?us-ascii?Q?x7qXbrdBY2MawaPpAK0oLP1m4mLUXQsNdYIq0chKUxdKi9ywPxDQjfqYWT+9?=
 =?us-ascii?Q?VVXgQdRVhohHkeuOZQX4o5dCiojlGbDPLOmaU+eeFeDD95RPJ3H8+LsbTXPL?=
 =?us-ascii?Q?SoXIogOGKwQOF4ZPa0td8xzL0lXw1UWibM4OgZ0XDj6c851LBrXoPa37wQ9B?=
 =?us-ascii?Q?kVblauiAqx7fXMD7ofrclgZepFTDxmiNkcX2HOT3Y1dDkyMKcH/te85nBfMK?=
 =?us-ascii?Q?QgJi78uWfrRliHjr5TCvfDOq4lqWycQM/8HJ2wCos6EU8THo2xVks8INxRl2?=
 =?us-ascii?Q?qQCzauYzrL+qEo57ATOHyCZllbkONnzEfUSqc51sdaRiIpYHgQm+4xcbH1tX?=
 =?us-ascii?Q?6Qa36FVEC+YI4q4ufDK35pACLrY4c7rYfoiNA9TdOj9tRr0mJ3opCVDbWFv7?=
 =?us-ascii?Q?LqpHOyhOmPTALQ1YYkdfLiMrI7d6X/AhHOBFfbtaYQPuUyWEn1SSwHnZ7AdW?=
 =?us-ascii?Q?fj7SeLfRcNX/8yVzPrs5aAPqtFErCtfbFCAh6BuvuK5HNGf5bJGQ4OF5VWZ7?=
 =?us-ascii?Q?Y2Iod0Xv4SR7SJBsmNJjgxeKQleToTJWZgDXhIk+ah5xwRaHHbEyseQWjFOB?=
 =?us-ascii?Q?WGrPfAOxBBheXYKi+mZRMaf/PqmOK55w7uy1aFjKqBMdfTsHlrgZur16+7QQ?=
 =?us-ascii?Q?FC56/Pz/bs5/B2jMIJFMAdFzs3DujwEdTj/MHy0RHbI5yEp0zQI77rNl5kJ3?=
 =?us-ascii?Q?rT0swxyyd6Yw3eQVtPQ1Tt/kE+B2nZiRGZcnBfihjZ97bZjISTcG550plrlO?=
 =?us-ascii?Q?z9QGaxnswZrrslPUn34EtQcHMWvT33BEPjL3xpwIawbiKectc262ueabixFy?=
 =?us-ascii?Q?vEERf1txorCt41aNOOGUWrgIquS5nCamj7jIDHak1JjFhSrYSHHx5cePPoP4?=
 =?us-ascii?Q?dq1D1KTIg1Zy3qCFOeflB3Qc6utfk/dtmlbGsvrmZbE8dhpWxBA+nl7JRmoC?=
 =?us-ascii?Q?483/hE45okV1CjMPnq/DDrMsB4PhyiEd5R0Mf/YRDb2LaI5bv2wWsGCEVyrG?=
 =?us-ascii?Q?wNKZ0REmBw5OHy0hL098Czn87NsHD+wNzn18iBiuRHjxaaceEOU05TXs2BTv?=
 =?us-ascii?Q?Z95pJgYRjpxDcgheAgsnWJc7qbgfTnbCb/IxwvXxiHDZJ0t0f+iiwfbRdwit?=
 =?us-ascii?Q?N8/5xBzcV2SWbhwcq/h5jFZ9Ncp+vX/9Rzi2NR3rT4q/h50QcV6UFItS5BV4?=
 =?us-ascii?Q?ujlCJ1qd3TSdPXEiIvzqJOhAf2kDZdNw1nTA0quF3+GMS4tNdgVJ67rVTU7l?=
 =?us-ascii?Q?wYM1X2Di+GgkbEnvF3g2NV7653OdWc2Nzm1PC+4wMPzyftlAjUa7QqVoEUfK?=
 =?us-ascii?Q?Nloi58nnH156dTyTJAqkPM3a1HY+F6NQrx4RM8X55V4KMmL65GIKxqURn01B?=
 =?us-ascii?Q?FywjIDXoE72+XrMorTA/0yFcV4ma7uflaYX3WR+sP6WNGG37a5JXk3mmKEOI?=
 =?us-ascii?Q?OOcijOv054XrbOFAVW9t9VhMPVlA1RSYnbj7cnu1O1Fl4vpZYiSAFr8Jgpma?=
 =?us-ascii?Q?gtvFv6yJzoaRlnO89Wh+b7RKKOK3R0djlZMGLOyLn2scG5UB8slypOC+g/TA?=
 =?us-ascii?Q?S89PwaTRqlCAGAUUKsnJIh11GObIUmWS2pAAJj1ph1xpx7Gi9w5KZHFmhjHL?=
 =?us-ascii?Q?bBgiJwke5PWYe3r9Sfir0wvSEbLdy0Ug1IDeeH0WFGvagI39Bq9q5AnHPn8B?=
 =?us-ascii?Q?oQRANVPcjvtAerYSU+C5hYg66XmF52Y=3D?=
X-Exchange-RoutingPolicyChecked:
	kUKgZH3mOmzUqzT0dOsbeGMh5rdFwP16TwUcaArq3wHAa0Ff3ZmBx31dKbFaeeNjr5gy0xZGcYUfNj1cCWalDx4i9ZPgQkqCyGyxZmqhDvgdA3x/JwxHJ8E30rgIyz/+IkWnHuhe9UBUk2gSzlMiOWyYsdM5HJO3iS+s9dfnqrNlNJjF/jy3zeCKMhoTTgW3OiIivSihZ3oWpBJiNkNF03/ryCi+5Ny8AjzhIBGuwkK49Z0yOSY7XDkdqVJ54yz8rfR4W8NgkpwzY/jqwpli7aOERu50wxmqCI2zWmwalPiU2kajS1FBtQn3NgO2FotK+LBjBTXFd3xGWJL+YDjpLQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IqdGyOtBkPV/d6Qya6STDw9gEU0ZTma1p7C1F3JvQVVHOGi3b+12lkpZohUofnoeZF5DziExN3w/7CA7yLG0dEYQ0dlznHq+xNgkIDYMPWtpA8I9+/lyGUyRzNntOFlDpBfGwJ0CZbrXfWIp0+eqPluBX9FTjyV2vyURvbEAKrwePMebkUtmRj3xJhu7zkyw144zGmbxRlMI4tipELnJjdecCWT8RyayyXch0K58V/IES0SJvhwdEYFw4dzf6+7fHA8Y9gfxNPsazcpD2WThwXIRMsK0CS1Y3SyFWWRCI6hh5aXUHLnEOuvuk5H3VZqoHx77gX/rQXsIfyEy1YoZ9BG7X7nN/3xcb4sxgoMkJ0MPZ07SdgJmN/Dp4xb7HvqGSVHJumZMQOl1vOsaDvGs17pSsuDLZQSNgtvri89Vh1txWxa4AjWbztMs//QjZJqitq6K15uxNi49XFsjdsWhwtKfcLePXbOLyCtkoDJ1mZatnBMAqUjY+XMYcZAMwd1KMqC2la+c0mPPvhoMsSMXTs6YF8AdgHadl1yH20Qk0BNQSpjO3/jFWS6qtDBTCPk33SwOrs1r0eHBOVMlcx5DNBZ1G1EQa3G9eBX4nmYCKZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec6dcf4-2c61-4a05-196f-08df2b54724a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:09:40.5311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4Khd1KzLuErLXoiIos1jmAt3P/ix+xwK+vaWypLtg/fkRO6APVhq5NAYXZxyRVu6E/KckPWMb70f578cvHxUnEOilf3+UH4ZnM8rolC6Bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610160028
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6ad1cdba cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8
 a=ZPAOx-6ZxAKxcsEDc8oA:9
X-Proofpoint-GUID: -Vxd4D4PPW1syM2USBqj5w5NC5DWZ9dl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX3PmkxV7wp6vC
 PzSUtMTbfFrxCLOQfiRkJqPMHRPhJpIi++UO3Cju06aRGF/dqSpaTLwzs9k7x6GugGzxqdE6/iP
 cTZTcYYhHvgTtamgTsH3wEU8sn3S9mHsW2kjM07M29iLxPEtM1CZVBiEMe/iruBSK8zBJN4khSh
 zIRhBp6vXtckFIc3W1AiP2MQsRVZZwga7fDyzhDGpR2nxZfYAMMJnzcN6nO3tD11rQ43Y6A67XR
 1CiG4tiFg+AEV1nW6LqVk/THC3H5Wir/57NGOq/AN0iTMi2JfBNXbuJ+kThJXc/MSQ7p/fd3FSg
 geu3Gqq4u1D8QcfMCEuMHAEdAZnU1768bF2jS7JfX/eNcMbEXF9yyKVTYZAjKf/xYUaWov6OW7t
 JO3FPyTMsxxb9a3YfrGzN1EaBTkHYl3JMyF8JnS9iNqHR4Sv+gcTBpKR4NKLPW8lzEwpfmfEYpc
 sE7Cn4s01W8yA8alHXA==
X-Proofpoint-ORIG-GUID: -Vxd4D4PPW1syM2USBqj5w5NC5DWZ9dl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAyOCBTYWx0ZWRfX5gPAc8sGKMX8
 YwX+SMH1CtS7ONKQQB4QwHNOhk4jfYpr4T9SuOAacHXpvCV21E+SGNnp/Tq7fbtJzptEdLpOntN
 SSYZ9vslrcuGjqAQqjhzhc7r4xdOPYS2jXehaUahZhWXtYrrjwGO

Extend timeout tests in smp_cond_expiry_params to also test
smp_cond_load_acquire_timeout().

The interface supports clocks that can return error on timeout.
These are used by rqspinlock. Test that by using a similar clock
that starts returning error past timeout.

Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 lib/tests/barrier-timeout-test.c | 58 +++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout-test.c
index 88b374ceb78b..addb83ceca2d 100644
--- a/lib/tests/barrier-timeout-test.c
+++ b/lib/tests/barrier-timeout-test.c
@@ -158,7 +158,7 @@ static void expiry_param_to_desc(const struct smp_cond_expiry_params *p, char *d
 
 	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
 		 "smp_cond_*_timeout: clock=%s,  timeout=%s, iterations %s",
-		 "synthetic", p->desc, iters);
+		 "synthetic/failing", p->desc, iters);
 }
 
 static char *expiry_skip_test(const struct smp_cond_expiry_params *p)
@@ -223,10 +223,66 @@ static void test_smp_cond_relaxed(struct kunit *test)
 		KUNIT_EXPECT_GE(test, runtime, p->timeout_ns);
 }
 
+/*
+ * Use a clock similar to the one used in rqspinlock where it start
+ * returning failure value once it goes beyond the timeout.
+ */
+static s64 failing_clock(const struct smp_cond_expiry_params *p,
+			 struct clock_state *clk)
+{
+	clk->end_time += clk->extra;
+	clk->niters++;
+
+	if ((u64)clk->end_time >= (u64)p->timeout_ns)
+		return -ETIMEDOUT;
+
+	return clk->end_time;
+}
+
+static void test_smp_cond_acquire_error(struct kunit *test)
+{
+	const struct smp_cond_expiry_params *p = test->param_value;
+	struct clock_state clk = {
+		.start_time = 0,
+		.end_time = 0,
+		.extra = p->clk_unit,
+		.niters = 0,
+	};
+	unsigned int result;
+	s64 ret = -ETIMEDOUT;
+	char *reason;
+
+	reason = expiry_skip_test(p);
+	if (reason)
+		kunit_skip(test, "%s", reason);
+
+	scu_flag = 0;
+
+	preempt_disable();
+	result = smp_cond_load_acquire_timeout(&scu_flag,
+						0,
+						(ret = failing_clock(p, &clk)),
+						p->timeout_ns);
+	preempt_enable();
+
+	KUNIT_EXPECT_EQ(test, result, scu_flag);
+	if (p->miniters != -1)
+		KUNIT_EXPECT_GE(test, clk.niters, p->miniters);
+	if (p->maxiters != -1)
+		KUNIT_EXPECT_LE(test, clk.niters, p->maxiters);
+
+	/*
+	 * scu_flag is never updated so the clock should eventually
+	 * hit the timeout and error out.
+	 */
+	KUNIT_EXPECT_EQ(test, ret, -ETIMEDOUT);
+}
+
 KUNIT_ARRAY_PARAM(smp_cond_expiry_params, expiry_params_list, expiry_param_to_desc);
 static struct kunit_case barrier_timeout_test_cases[] = {
 	KUNIT_CASE_PARAM(test_smp_cond_timeout, smp_cond_update_params_gen_params),
 	KUNIT_CASE_PARAM(test_smp_cond_relaxed, smp_cond_expiry_params_gen_params),
+	KUNIT_CASE_PARAM(test_smp_cond_acquire_error, smp_cond_expiry_params_gen_params),
 	{}
 };
 
-- 
2.43.7

