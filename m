Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794817530;
	b=a6xgMzOyD2+ZP9GO5zh72U0AE2eo05ZAU4qsysC8x/oFhzbKSkdsCo6JOiwxp5StNFRu
	 QODnLtQEypr4Jk2i+GAf1XlzK8cy3PMlZLO1PYigboT49FFF4JYqwRJhSpdBv9BS6vG/d
	 P6lze+yH3ALIb2Anl1mlUZ3pkO4qY9gwPo3mFQbiR5KuEaF+5rvt6iNZ0/r046iHJgWnk
	 Ha3kshQXxfPTMUIeEgayYs7r6UYHbYIGhCATII22iDEfFePRBVf/BTVDMKyJs3pFUm6nk
	 zh5A+quBtgr+wnMR2Ez2/B7vSa2X1weWk1BPqk65V0Dd/ywMXeXXON3Vb3NzRJrXtmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817530;
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info;
	bh=ruUDnWlcEdNjswoavKuKhS3K3eSXqTl+vNmtR/gVoeQ=;
	b=YUs1PUSSOSyrV61wnVo4opsfBAlosib2wzt8I6pzLyMT5mYBVAeJolxEQU3QWqssoO9f
	 EUBUsdwNjnbHDPRaOZK7Bpm2t2yOMepztc4aOVXjf1wbO3oyQi/+MLWU6ig/UrDrC9o2k
	 G4rJ2+iUbaMqaAz/wA5Sw3eO5lw4B3YyFbIiCM2Xwfy15QCLn3AHW0cVBXEa5J0jtpbfP
	 smigpaQDv26sK0uiFmyZJTVmjVIWJhy+KQXFVD1zf8lNpMh2tvG12RN3H5xWfroglVyVi
	 Az5nc84QUBAmuK2YRb6hmMxBw7+e5FnwwyubWmaSrZtWnnujRUZ5Ljge+/gh+8An23w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=hYwYwS37;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=H031e96c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F5606A889;
	Mon, 16 Nov 2026 08:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A9F5606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=hYwYwS37;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=H031e96c
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFNxeDW1850662;
	Mon, 16 Nov 2026 08:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ruUDnWlcEdNjswoavKuKhS3K3eSXqTl+vNmtR/gVoeQ=; b=
	hYwYwS37cg6VSZ4+IxsMLiJ08kGJH60iOIjdn6tY/eB0o1H6E2e6IeU0oUSrKNcA
	d36rxuRTSu7ud9JPBDXAiNkitSXw2oOyOX/JQTiQ4jfkvH06pDHTHNd8xeKBIxz0
	igDTw/Iv2CdG4krO0qjHwGrKNhE1jW0si6ZrUfhEscD38kLVw2uvmQnfvuzRcNbk
	awsa9y/ysrs7/5TG2vtlZRN0NiX/J/MpDLHin8ry/N8t1l5M44/gMDnjPY7gSPkJ
	kRQ1V6KIYnHPjnmZLJADjnTLP/CJ2AqO8F61zCA3sMCKgP5u6EBl3xBj95wpqlrP
	Bvu2AckzWWPlMuMjzE5Hrw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxfh9hksr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 08:25:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG8HRSt2181695;
	Mon, 16 Nov 2026 08:24:59 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hyv7pmb8t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 08:24:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyMwSBveEKUItc7OBsjmeVf7khwrSC4SsjXGpHTT8USu7g1jtIMNVTQubeX3LL/I5GloDu/7qmAHM9x4nAPK5Mr4O7GgXMCckydofrm0R136OeLPE4FoQ019pHb5m7oGErygnEYqAqOwk6u7x3gH0hotYZ5K8PCga2PA7JhfaIMeJFr8qaxWGZ5u+u8aYfwSsDZq6stbcmQPGE8ILuPJjwcQKcdUyA/yyD/VeqTKwhgsb/eJesoV6sMgnUQldU5RjugRCINQ4IWpjCCeWrI7ATDjrfARPlXIV7axLAy0zuJLsqPGdMcOHOvg7OTMRrAORX/iofx+iRt+w/MJk9SBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruUDnWlcEdNjswoavKuKhS3K3eSXqTl+vNmtR/gVoeQ=;
 b=wRB4qVoRzfY2K1WAzD2xoU7X36uuTSmhScHC4SifT5weHfI95vmZp+Q/iF65fcHzHqLY71zRm/wAC+tN5tmRgrDT4MKWvgP72pBedDEsCFleHb4B4lAuEdJtmZAjSGa/1vOUwI8e6GnEcPQ446LHr3W1f/v/j0Q5sXD3vFyQY2rzwSCB2Er81fmXd9ryLA7+Mlj+no0cbts3DnyZejYPD74a3dM4DVwGXQEKyjBbNeS+WpOmSZa2LTBLa2j/d0sUMtwsajl9JLQ2IsXxcHYtj6NMl7WkTTnPgbPiNgMBr9A4yffR4A+6++DTvSJ1j3GVorgDT23LT+0Em1eWat2TaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruUDnWlcEdNjswoavKuKhS3K3eSXqTl+vNmtR/gVoeQ=;
 b=H031e96c5RBp+9dmtovCwpmqir0fy6c7wqN941wTKnZgba4UWfedAdXTEsJZWuLiM9SDh6vWYHCsXVeYBOrBV9LHWdHsMY4fvet5CfZzB9GPGYDMYvkmmfPOI5RFqIwqcKWpNpqWo0PLpdTMjC0o3xkVhosGT/RHU+W8JS/JfHc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB8216.namprd10.prod.outlook.com (2603:10b6:610:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:24:54 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:24:54 +0000
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
Subject: [PATCH v17 06/16] asm-generic: barrier: Add smp_cond_load_acquire_timeout()
Date: Mon, 16 Nov 2026 02:24:27 -0600
Message-Id: <20261116082437.66739-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261116082437.66739-1-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:303:b7::32) To CO6PR10MB5409.namprd10.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: 252ba137-45b2-411d-7656-08df43bb1785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|261009221227099003|3023799007|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|261022075727099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	aBth9gPb6nfv4jJoRx+33qV06KK70aCukAro1ImLKd1mq8i6zDrUSM6RKUzvZMNKJnexzLf+01YcSbPpXlrt8Yfn0Q/DFSs9P4uvJ4+b+CIaCFXWtgaGXdZEGOvj6QVPR4kFpeug031fw3t6WADjyiVVCCnVzWgDSFcFJb7yT4yCEnBMrcdU3Mjhg3eYNCZDhTW8dn7t0AYz8AmDHYwxDRX91RCxGSbqBEHvxQoAG3iWZDL5cB21EtmRKQ1sgMsRf92BhaJLG623P43xGwK1oSJR/fNbXFN9SvqUVe6Lx44phwEmMUCX2vPbEOCNbNHbq0Ddh6vqJWPvG42a4LHjbrFNoLHM2Lj8zjqgObnO6nsFrU00JZrDgU+bBgvval7DNjf+JeOpY44fRkZV3UPS2u50o1XCEZDQu/o5WtzcquAjycbROR8vwLBuqfNbgNqJbUJEEWdLz7GnK/HsChmbEX5l7kZTB47d7qY9gL/vngY2hi7+sOnFnNQR9XoU4uy6hp1CRqRmAKG0+hC7cWNuvFimpK39Q4Kfi9AeTehIw5WTX+Tixuee6prMV4HeSOKfP6oi0P5KXV5m/nlHkoI0FRmVvPi/jfhSzWVatw6CfR3pkOvljRR07auROIh8Ju/MlGGd1mcg3B4Ncu2RpYUhSDCMcdCS42Zb0OHP0d2DrmU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(261009221227099003)(3023799007)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(261022075727099003)(261021135927099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A35vFdlir4We16I3JBtud7W++5IEqpxa6ZOTg+sc4HZhvkIF50CVorarcK1Q?=
 =?us-ascii?Q?e2gawxYrC6BnY4QZxG8LPZsrKH8PU5XmEM4P2t8bUc8a9STKkakX3MrH34YQ?=
 =?us-ascii?Q?psTr6o8a8DnUbBGdMPLMRwBPiurhNMcbSR7jL0oX2naMxBOMmYHo/0OdZFMe?=
 =?us-ascii?Q?FPDdU27zHgHw2SrgEqagQwWVYFKQu+h3A3ZJ8RatX+JZfRWsO5MMQHYzDQUS?=
 =?us-ascii?Q?pIg/q15Hcp8yjPO7yyIylxi5E7ISGytvMs9EFvGv3plOqz6+dVYXONcY7QuJ?=
 =?us-ascii?Q?uFzKmL15CVw3PlNZv2o1bU2aPJoDc4vKwl3Ap7XuNfpgVhLNABlpwOXApDFa?=
 =?us-ascii?Q?D0cO/Nt+l6Yr7wNOUUfgpkL71XVKZ9l3CMUo2Dcfgn4VvjtFakeCJC/eGVV3?=
 =?us-ascii?Q?6qX4YXwdR8EVaEDRVEIyRw54AmxHldnV+IaGJzIOeExxpZ8G1bUZxzdyWLuy?=
 =?us-ascii?Q?R/Xg8+qle4I4Nyqh6qDjWugwI//9CTcPEGtuGIW28tIMhbuzX2ijCcR+kweX?=
 =?us-ascii?Q?pb1MDREP+Wu4s0ckt2RnvYDKXYssRqQ/H+6bBk4qfE0BirwGhX3YZgvwL3c1?=
 =?us-ascii?Q?h33QyVraOqH+UtRs9LnmPJ8oaB9LAEzqZbh2S8IH9gTmjAkkNHljKtb5K5Ax?=
 =?us-ascii?Q?gzGFy7+LB5XXa/IzvuMx+yROyxZDDG96fnR16SwHeIlZQQwJHLKZonTi76n2?=
 =?us-ascii?Q?QzgLbxeJjHWWI1rDfhgv8ZCeo5EgeNopu+WdqhIK+IZbquLtN8KoqdxqODM8?=
 =?us-ascii?Q?csgFnD8zILSnid1u2YaZk/Aq1bESx920PXcUGFgwF6zJctcTDqx+w0KLUNZ8?=
 =?us-ascii?Q?TyrVEzeuJqVKdHXL5Ax4fMKnfhIVCP737mHf8wGQBHQ4mnQKD2RVw/KvtuyW?=
 =?us-ascii?Q?mCcyw3NWm1Eka0Vxv+VA4EATg/2dpggZjNMr51h+fnpBEd0uHZVXIxdWcWzN?=
 =?us-ascii?Q?THlsivPceBXQ8j41sKzQa9pplPBygj/qa89MceUuPyghJ6KQ1pCHugtVwLQr?=
 =?us-ascii?Q?3MBwMJfsez0R/ogLZeGt5YKqSm7kv8wnG3DIm8aSFC7iVVYDqm5j7LATnEUs?=
 =?us-ascii?Q?Dev/+fm5kiFFBEJuDK4XSaBhpuo+xqalgpFEfct7Nm1PS51zOeuo/1WR1dp8?=
 =?us-ascii?Q?UXZCd5YEkksS5UreHDuDLezfIv1NjpZIGXoqvQSwvJ/JPNKdquZttUjAcLIN?=
 =?us-ascii?Q?D5frEAxactj3pl3llgFJkb3VzTbLVdFGU+btdC7lQiCnov3ZRpDgSdOprvx5?=
 =?us-ascii?Q?/oXCj1NAf671Q8lP3hmbTMwppXOmIx4d1vJ13dOp8lbkRyG4/T6GAzO+ToAC?=
 =?us-ascii?Q?D54XkDfPCFCrv3v781aZIZtrGrDOxC8VHxvWYXroMCBDqZM1p0gTaA9u06R4?=
 =?us-ascii?Q?VUfpqhEnlpAcOsgpBTKex8q1pKHet0fFUA7eVnY3aV5V1JyuaB+YVUTPtia2?=
 =?us-ascii?Q?xT6JiTDGeeQPl4P1McjPD7hKunqr6RV4Pu2dj3j19S/UaYudKKFtcVDiRDJ/?=
 =?us-ascii?Q?qd7tQ/QHNwb05My5DsTEnz411pfo3QXjsx3TtBrFySEELd/7yDLOMk+a/t/k?=
 =?us-ascii?Q?zISDgkmgZaJc1fcxo5QzKGbrYSvS5+HA7eI9yvCvlLdyyWL0iu+BFSm68pxs?=
 =?us-ascii?Q?99FQ3BkgfV4DmvhzNNYnU5724dCOs9KPE0+IHPgjD/9kUUxqocBTmj8C8rbT?=
 =?us-ascii?Q?8QIOG+/3aQIZ42oTVoJPfuA6mkZo2jqtfn/+DXvTtb/AmINI5oNepytNUlkA?=
 =?us-ascii?Q?v8Xoo1IkYw=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	MJu7eH4lM3cgLjy9nD/iB//x+rDrgeNnGH426/3s8LbRJVOVi8FCBht7+C+5V/+twNivV+n/66SuINkhw+51B2w31F+pM8sKWpXiFW4VsNIVgprTzRaQJYXgl5Jg/dyNCCVqqXiq/eCC1Hd91YGJEq4I9T24uzI1MBBDctoc2E9NZU9qfmC0NBJu5smVM8Qnt4CytBoUia0wdMSdY9xTVexchOmpec2ozL1mLAJOwwo3UQiB5afVfvb7f6GRXfRFFSlZZeU/fNAA4+iEbWy9Sr5w/FDyPDDT7Vkd/nlVD/xeTzpV/1qREJf0Xj3lPVnuBv/Uja/mtC1mgv1/9C/Y2g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gn/FlxcwBFab7sdLmJ8QtdF/6BBcOXhrGfSnde7+QcbuQb3/Bhvt21hQE1z4H/dcIbYRmm6vUpXZYYrUEdI/7Eol7lidntBgZystNuz1Y224be5DfiX6jGN3wckF1JQ5N4E850WIaBWY0m9BxMi8cE4JrQf3hmCSrmNqzyjAtS86UsNCdmtrWEhLt6LD/YF1O9CTafxiqjPzoJBt7iboYHVIgaUgT5LwVXsjxJq6PfBWO0kHxMtQM7iLly05Lc9LwCz5Js4lsQeLdT6NgxR4K3pEnwvs4Mg9Ke30MHNwxWPrcg5RGivXqagFn3Pl+h+OxbpDarBD7uAX/0dHOfHmYAxTo00ni2Hrfz+1wmu68qVFLanpyy2NhFij/+NVmsGcRyaRnpabFijAnz6SlhLBK8b/l7ePvbT9nSW72WnqhpAKoo8JRH2oXNhgo66Hrqo0PNJdaA1P1vAkAUX2EdmBv0pAIwbHLhW2I3F5i2p23oWwRoZNCbjbBQigU+MQkml9oEw39y1XJCgf096KyTZ8/dGVJ86DcCO62IOnvaS876JJPjNQYO/kL8D74D6WsMr9HGFPoV84gsbzEO5RSqVhLWhELhtRXQ797eGCQMo53vc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252ba137-45b2-411d-7656-08df43bb1785
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:24:54.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceAttZX/a7bQ9RZzqeQwRijxvkuEuI4wSJBbVWnvtAF8lmjBAmKAioMBFvYPjJ7pLuuwWxM1bskHofyU5NFhv8md5TtdW2Q8jG466j36Onc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB8216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611160033
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfXwAeXH4efbJnP
 obTmocPa4PHvh372B1AScWGj0tW9qwIB9kXD6nioT72maY2wsgbUl9/ewNIi22oCW56m+XoQCxP
 slQHfIRGM9A5BghaEo1jQUpiLR+vuQCJkwTgMNt1kGwyKIvS9Mgype+UKAQMKeDMFfkq+8Z9Ypk
 UU6lgiAvLi9lKZbqvCqqllHUcRUYjghybJdL1Io+aQzVb6MdqeR/5cA3YuDYLgzx2pSVXYamhX3
 Xh6M6/3MIEgpY+RWMiZMN0+Qw8NqzFGEujEHMwmFVwB+Rh/eT5ZWf4WHU5GbSXQxV+wq6Snz0cT
 BlotWhq3oo2DnnPWOanOuh6ayiTBUpc/soMiBL4f/7YeeO4XbqZfRvuDM4aAVSRzof0EdZ88UuO
 T7G+gEiZg2jIvF1zwFhd+FbiqnA/h8JEOg0GjJSy9y1YPPiFYwmg15v5RqYx/veoioEOllHsuwd
 cCvWThlUqiREm5Q17mQ==
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6afabddd cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=JfrnYn6hAAAA:8 a=vggBfdFIAAAA:8 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8
 a=bAMrUmItZINb0xDQqvwA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: kdaYhVDnZakwTxi31i9FhDMga40HpUCY
X-Proofpoint-ORIG-GUID: kdaYhVDnZakwTxi31i9FhDMga40HpUCY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfX7m5s4ac5KJ4R
 Xfhyh/NWUs28S4ReEuUxz0QyPgrbt4hxTwgNyv5RgIDWZ0+w37MClxwNoVQ4Thss0LmNkYIBhjZ
 llDtQ+bmyr0fY+REQX+UmzTfUXxYw7jXbjS1zr1Gasm6mNcpFMIv

Add the acquire variant of smp_cond_load_relaxed_timeout().

smp_cond_load_acquire_timeout() does its own error checking but
reuses the relaxed logic in __smp_cond_load_relaxed_timeout() for
the actual wait.

The success case (no error, no timeout) guarantees that we have
evaluated the control-dependency. This means we can provide the
additional LOAD->LOAD dependency via smp_acquire__after_ctrl_dep().

In the failure case we provide a full ACQUIRE.

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Cc: bpf@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Note:
 - provide full ACQUIRE ordering for the timeout case instead
   of guessing around if the control-dependency was evaluated
   or not..

 include/asm-generic/barrier.h | 52 +++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index bafc8eeff132..104f38197942 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -385,6 +385,58 @@ do {									\
 })
 #endif
 
+/**
+ * smp_cond_load_acquire_timeout() - (Spin) wait for cond with ACQUIRE ordering
+ * until a timeout expires.
+ * @ptr: pointer to the variable to wait on.
+ * @cond_expr: boolean expression to wait for.
+ * @time_expr_ns: monotonic expression that evaluates to time in ns or,
+ *  on failure, returns zero or a negative value.
+ * @timeout_ns: timeout value in ns. A timeout value of zero is treated
+ *  as the minimum wait so we evaluate cond_expr at least once.
+ * (Both of the above are assumed to be compatible with s64.)
+ *
+ * Equivalent to using smp_cond_load_acquire() on the condition variable with
+ * a timeout.
+ */
+#ifndef smp_cond_load_acquire_timeout
+#define smp_cond_load_acquire_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	typeof(ptr) __PTRA = (ptr);					\
+	s64 __scl_timeout_ns = (s64)(timeout_ns);			\
+	__unqual_scalar_typeof(*(ptr)) VAL;				\
+	bool __scl_timed_out = false;					\
+									\
+	if (unlikely(__scl_timeout_ns < 0))				\
+		__scl_timed_out = true;					\
+	else								\
+		VAL = __smp_cond_load_relaxed_timeout(__PTRA,		\
+						      cond_expr,	\
+						      time_expr_ns,	\
+						      __scl_timeout_ns,	\
+						     __scl_timed_out);	\
+									\
+	/*								\
+	 * We return after a timeout or, having waited on the control	\
+	 * dependency. In the first case, the control-dependency might	\
+	 * not be present so we provide full ACQUIRE ordering.		\
+	 *								\
+	 * In the second case, cond_expr provides a control-dependency	\
+	 * on VAL, which orders any subsequent STOREs after the LOAD,	\
+	 * taking care of the LOAD->STORE ordering.			\
+	 *								\
+	 * Provide the remaining LOAD->LOAD ordering.			\
+	 */								\
+	if (unlikely(__scl_timed_out))					\
+		VAL = smp_load_acquire(__PTRA);				\
+	else								\
+		smp_acquire__after_ctrl_dep();				\
+									\
+	(typeof(*(ptr)))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.7

