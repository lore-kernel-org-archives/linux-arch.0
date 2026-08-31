Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4E6392806;
	Mon, 31 Aug 2026 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207820; cv=fail; b=JB088StexI/7xb5k27xEEWS33qpWU56ZoSnzf08Gmz8AoTY5jpm074Mb9JUBCRC/cmYe+GgZVIEzjUstZq/FKstyV4KSLPTgcjSLowMo9Bl18AqxwsO2NjjOr5xnq3XodQbANHxxGC6y25Q0F1y2ICEsOX8IbzLmMYl1Y98yd0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207820; c=relaxed/simple;
	bh=L7S5WF2ih4M7a5zTiOZCEKie0ZEdhW6jeyfDnrxh9Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mKc5JDzUoYNuG7oScUR8lpQ6myI42FM6+CZPh/gX8lFw6V1uVCVpnz/z1he6rOAq2B+V5WtcIj0dYEKNYmyk3b929M0hTNGUtx5aH73Du/ygqofNh5KbGUK1OLTAVVM8flqpukKLumMlsxDNQi/d7LTyVmjv6fFp3G/Lp6LuTEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p679jiyD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O3VhR+pQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p679jiyD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O3VhR+pQ"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VGBmIA1708938;
	Mon, 31 Aug 2026 20:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XFl6/30YgIXi0TTl9/SvwhBqAHuGQubcfGIA4Tdmz8Y=; b=
	p679jiyDZZhOhwMH1oIRvk4vOadDS68B+5W5aMBbBxMj8FFnC/VmJcOpq7CpPiUt
	r7s5GSRkeKJJWoxcajm+ro8vIZH9574b9Xj7Bxfqscvr0Gir3FX0eGSYk40Bc+bx
	E1VLbhDIdnTTg4z6S85SFQ3hFK/82kmeKzYjKgtQ+gIdD6ouozbX0FO9WpT7QNvA
	NMvEMsTreGLDxHnDvouxD9ItZliW9Uopwb2oTSkL+O9tKw1eaIvBlABSQyZVPGIM
	xx7adWH1AycmELCZTSjQwYXExnjvArmcNSU+M75yTXhwAnXEdv7b5Vdk7DarHHAF
	76clAPI90YXV0D1iN9owGw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqyrubes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 20:23:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67VKK8cv038776;
	Mon, 31 Aug 2026 20:23:02 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvdgjj4-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 20:23:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jw0qX83D1xQ2fFWdTx8RQhlhT8wntlKAASySeQdU5bCrpgOxUOGlVUlFFHDfu8dJw8XAm20yti9msPclzGQnHhOtlukjlPC+0N1anZ8PNLviyy52fBLmZofDTADmuTV45b7LlCEzv4bqrUaq8UOjCclxmuqLn3BzjwAKmjk3eb7FjsbzuxJUmHZ+J037oD4D19ySplcvqD76YzkfSBFk3jDMVXgEnkiodFq9nkQGWVKtvF81zNpIb6w8wD+h6N7mWmfifVpIpnZScE3WEpPaWBugftJOEpLbTEghWzk+Ir8oS6Bej1S0i1QGvFhXWLjeCdrGvA/F7ze989zKoD3G4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFl6/30YgIXi0TTl9/SvwhBqAHuGQubcfGIA4Tdmz8Y=;
 b=VXeBcoesjgZaO6kzF5s+8hj3T9WiIzrE5V+D7APDXqfY9hZAowistcdk4JW09jRUJBGRbZbKo6x8mIXNBOiRUGwn1TyVWnBbR1AA0wXEpHasnLTLkKj9pE1K7C3mpcFbyds2VGKm6RdWTdk7I/03s6BGIiwnOwwxOt36DJd0S6dC/s9YvjdQcdtr06WJGWppCUCjxAQiAwcORAF3AccTbwifBPLMFelfTIiFzi5ML58yrrkrEB2e7NA1UHAv+A58xSAgfVRxMJcqu1wEEyFMewZ7Gtml4fjNb8VErvPSI6rXJpj+3Lb6Dhvpoae2JX5H1SlOavTTs75MH16M3FDGvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFl6/30YgIXi0TTl9/SvwhBqAHuGQubcfGIA4Tdmz8Y=;
 b=O3VhR+pQFum8pIwh91wQb0d/T8L7bp0Ed3chjN9BY0FRD12yxR3afDuPw2teddPJ1RbR/EAuKf6/sRyzmHXTS+mpFxLqwDcYAxukiKeF8+Z/XqPevK4HLD/8KuEtZq2+ron+F+L5/mrpwBalCIqywbarxNVHjR8Dgb+w23F5/As=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH2PR10MB4263.namprd10.prod.outlook.com (2603:10b6:610:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 20:22:56 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 20:22:55 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, broonie@kernel.org,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v15 02/16] arm64: barrier: Support smp_cond_load_relaxed_timeout()
Date: Mon, 31 Aug 2026 13:22:37 -0700
Message-Id: <20260831202251.305046-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260831202251.305046-1-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:303:b7::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH2PR10MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c666648-0998-412f-6a7d-08df079da427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	24VP12Mr2oQD78g7ae3dGP2TtNWI/w/2Ap7zr7IbY6xRHOYZlZaFifiORY/FAfnVcDpFeWkcCQdXdIJt+LsUT+/AaYEqY70jewJtqKSiWGJtn72dI+pLTH7C3DI1Wz5Vi+QsDadv355t+tid/KR+0kn3etOsM1QTaLv9mJZrwOk2+528HunU76CpeYrNC0SVTOnnExSuHH46+qJZB6SytyVhJeQSSRs3zChOqAOCxNhJIMqsB3O4SxhiFyMBT33K5ox2kccBSnEABYn7hqMrIhiMjOhsyQfoJzygTmmVk2zUMeLVUB7HceEZ+D34pkWv8MQI0UAW86eEdYZKZP/o2qTkmH5kaTGLo61Fn43oiu1dNst2zEpj0nvpxH9p5a9XUbGRE5sNeJX8tSLh8Np7ParUmG/tzcfxIgUnStAewkz43WJFQ0lmknZjuZhich9EXAha8D9t7dE50VrUhDLMySz9Sg/0iaNZWfAkrozkKFe4Sgw5TlcSQ9ERGw+J70JowI58xlod2SRiv6m0k57PoAscjSsmH9C6DGdoFRjYkuC5uaybfaK9rAV7fwbPaIU5ol3woefEv1hQn17AHJpIlQpCYyz27Tm3AY9wiPcPuAZXwxGJjhNwX1c2oMOwdiJrsvwvgG4/l/JYGqci/SkyWUXOtX8ak6iQZ0jHF3o5ySs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QISoNlkd42xjRoOUyLwuI5qWaGH6/3ZoHgSKcgIbLMluulPRwueQ7HEvPWEx?=
 =?us-ascii?Q?ZjZn2rIs4FOPOFoUNsSI/j7l0dTh2eZcswefSeEfFVewiar2KUUJdUyMpz+0?=
 =?us-ascii?Q?wiRMC/ZVvJEA5qyAQSZkN6ur7faq8QSui8mzOvUBqgadf15xk4PEPziCPUTh?=
 =?us-ascii?Q?tStmAVMGzNKTNoBS4gBubIbve1su8bmvzhsv00zVtrTUW8wB6kAOhYmy+MbL?=
 =?us-ascii?Q?utD6XjMe7zxx6W7LnPxug0MMTzHdX/DBke5M0W/wq4ZKN5+LaR66z2zUWGLg?=
 =?us-ascii?Q?AnxV5yuBRqcVQxTj26Vv2BvMDMmUMZoWWQkdK+ncSh4h1PJcyPUwpd30o0y8?=
 =?us-ascii?Q?i6QVa3w+rnY7ZCdbrhKfVteEZ9iKgURUdWFhUpwROuEb96K7XiNUj10Irg+0?=
 =?us-ascii?Q?elYW32xNqilcTkkn/wtnBoVUNELw158d1MprwdjyErrev44kr0vSvU3XelgT?=
 =?us-ascii?Q?HEl/AYcmuGprIhecBI8PFl2v33fx3Uwx+ZK8kbTM1u0cfm6McDfn6GgqTLeO?=
 =?us-ascii?Q?5gBtBBS3bFlV0m3+Xyr38rBCMCAtrQOdyifg7rUrzV+Tf34NOrNuU167CctI?=
 =?us-ascii?Q?8R/+bKq8yN5Wwo5HqhOrcpeS9zVbgKWCcEB3sE3TCUYfkMPkXuMAO05VMUG4?=
 =?us-ascii?Q?ZnPOnEVVxsYAlPbkYpDLUgIx/2UGURpQVtqOJPqPfhatI/NOABAQqnBeQY7q?=
 =?us-ascii?Q?rhOFlXBqmXpjP2T366ADDjt7cH0u+7qIe6zKHJpJdL2RaHLK9sgotCf9Up3h?=
 =?us-ascii?Q?jsq78RNg06w2UeEDe/GPJFRE1YHYqY4Wn7gN2dqzmxc51aAZ+cVe1usP0p8K?=
 =?us-ascii?Q?ois6orYsMVX925Zw9SGrVsADQ7z48JB39sKSiZYEMnLRrcy36/ALAxTqDOn2?=
 =?us-ascii?Q?TR4DtcQRwVEF6acqXioOwXE1qA1dexD9rsQplcQE3jvh6znq30B2NVTpNk21?=
 =?us-ascii?Q?f+5ONjSahtVNSG2kc96CgAGQAXboxnMzphqcKRn9E/0mr3dAwtK4W1mniPjk?=
 =?us-ascii?Q?dATqw2U4h2W0qc51ODqzSngSaQOWR1nPglzQBdB0sSe7FbFux2V+mT2g6c9+?=
 =?us-ascii?Q?mEeGrQq2OPnjRI94nF+4s4Cle7BfoOHLo+ikstS1ZaPD+cNMuf0KsJcfROEd?=
 =?us-ascii?Q?W9tslI5KYW1gKCteu76PJi65bSSu0/x1ykdmwCysE76PDOMCfpk6rrmaO4pV?=
 =?us-ascii?Q?jx2dQ0sSBNhk13iJFw9RcyU1TT1vVP0idPhCgsrtfdLMLAKh3UFVTfgV0MIb?=
 =?us-ascii?Q?6jm81kLtn/17BIl07VWwqc4oY3dLBJQGPwQKL8CRJWZ1frbmCxJov32gWkPk?=
 =?us-ascii?Q?r+BWrnYtkVitaMeUoFvDTFwCOJxl5Y18APgYtGMJQI+DatvDnil2ffvecjeB?=
 =?us-ascii?Q?hjuGxVshBhacoM677ThgmeWXvw2HLb4SFJnK8DdlmDpMEF19XKOSX1lzUSj5?=
 =?us-ascii?Q?+WGV9xXraEYzkOgaRw0Sylv+Cbz76CET6Alk8wQBNSswn/vHj5xJlICY9K0l?=
 =?us-ascii?Q?xzd5QtuYptao5jcGUFD6Zy5SiAA2H1cAyXxJHwQMVH2FzSl8e+jb2ZdQZoLz?=
 =?us-ascii?Q?wrMo1ukmE6KS52r8Utihwrag8rqxaMrgIFlBia35aL4QErWOL69idEnnBAYi?=
 =?us-ascii?Q?2/rd9+2XjYrkFjqV776wS7ea8Jl7aEwWjQfT/btplUs2dYGByWjDonfvFUtG?=
 =?us-ascii?Q?f7hHPbw9BPYlk2y8e1CJhELeLjAdGYUG9Mh5htGu5xQCfkY/wps+68pKcloB?=
 =?us-ascii?Q?fKgffRClMQ5cFIC/6ZZMwO87dvPchjg=3D?=
X-Exchange-RoutingPolicyChecked:
	OYgl/xukUGJ0qBPNxwiru+8Gi9Xt5NHOz0iHxVhEp3IbLnXWFXK+Z2106hEICpuj9jYQHGmcPxT7OCy3q2Pj4ums6q+s0GxkzVk5dfWdD9aeK4+85NjrzOIKDHurDEFFapKkkQsR3X8T0l8eAeHS+8gDLNwUVypHFuEW5trvYMpuKrmnDX2jLmyNwgryr/Zw2K7IXEtCEoeuQgZJ9UkfygvhhUio4sRkPp80Zjknbs9uW9mfgI4rRB34h7UwwcC1T/PhpuRvnSTB+jjPS6mD868Oq3ACXhdEmjtXNSAgW34TIE4kbS7i7HLhA6GaT+vOMPTqjUE7Lx+IxyivcpqY7w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RAnjyZcvB0kGUn8nIN3TKfltuSbmodpsBktOlXrjKPL4c5urBj+JTvYUz+tbS2MsCY7nw8QdbIjjuh6r/2ujaviT9swaiQdQKJKs2tV3xCi6qbcO8KgEbgWYQEHcL2H8BqG4oQWdNmWVd5/+ZB/Nqf+ziMPycP3VrRqy52r8VifkDOLtZCl/Apl1ME6CsLyt5swYC3htm+cjqxTJY9I1R8HMnb2WXIpmZP+7NbMVuy1bc5t3ufFLAZ+1l9A7F/sRRohkKOr/01/sJLUelScrTAJNSeojVpTGvAT7IiKW6rV9z2GlrHf76VxtpCItxdHUA3qnK8ytR3fGb5vWP1UV9kl2T6OZNOc2fw4AdDyQYizuVAESojQpWeMtPvbsglmrWhc7NvUwYOfyiuGD9vfJksHSbCUcHwVhI1NOHV341LR2iz0Ho/BttWtJOkRHMCgHwF4BbCoBKXO49jDpbljUohsUeXWhPoeXio5r5LadLo5CVnmREAr/dwRWo3yAV0bQaHDHB4NBh0o4Fp9gYZzXtnyHX2kaKkBhm9T+NibDiSghDKwcfv0XT36DeCML6RfC9sVnn3jStzSpGYA0Li42CouO94quvdYXDUwOzAqH0GM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c666648-0998-412f-6a7d-08df079da427
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:22:55.7700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzbTcMnDATYt0b0Lkv9K5JpIHGN3KYERagzB4x6L77leaX4RWtNLBNWitNJNLEK7lmvXPXhw6mEL9XBRwgZ9GVAP2jEUf6wudC32ALvr3/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=965
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608310176
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX+3rw6/Nll5Rb
 dTJ5IYWdWCj7a2+avUdlIeRNwe0ZDqZ3tu+4oGzL3dpHUyNBY7T+O0LTeu0/aR8lcvhJVQyfOjv
 +oi6sT5rdck4aVN7X4IkXJbEd1MYcI+hg67v101oq8W3QtRKHO5vMWMZmx6lNdvfq3WQryIIVjU
 7exJ6WpAU9M0bsGFEG/9hv4AaPrEPoieyyddtEMTY+tT0bzv5IdK39zjVZWX6IG60Ml0aewHjTP
 zSKyZBanxoOMJ74Q7mPiya0u4imjyIF0AtNWrNh8Tpkn2mI/lNcl9S2wcRr+ltQK9OgkkK0JnK+
 QJ8FQDypK3ITg6vIXa2moZN4OVRsOIQZk3CFMLj4B88hB5vZIKVFBZS9YfwUR9epK3qdELX3nZ4
 SNy7oColX9txeXimamzFZszWfuDE1D82PbHNE3OJm1eHyDvCLnRv9K+/99WpNf3OfkMjn8ZU7vt
 349CiDG4zF/T9LqdYIw==
X-Proofpoint-ORIG-GUID: ojr6x5LJMpXND03UBgrSBcWn_scvVhJy
X-Authority-Analysis: v=2.4 cv=fbCdDUQF c=1 sm=1 tr=0 ts=6a95e2a7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=hR4SQ0wyJhDrZCoruAAA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: ojr6x5LJMpXND03UBgrSBcWn_scvVhJy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfXxawWxdbU+CVY
 pGDcQFumKXk132qO0noXn93H0eX9Fqvql8i6MUcBPKdf4DL2np7RI6hAtbABSckp8+3OybdvcAj
 8GMqcG3X4K+Tl3O196ZvKO6EwL42Aohl0q5BxtfrdkUlUSTs10FI

Support waiting in smp_cond_load_relaxed_timeout() via
__cmpwait_relaxed(). To ensure that we wake from waiting in WFE
periodically and don't block forever if there are no stores to
ptr, this path is only used when the event-stream is enabled.

Note that when using __cmpwait_relaxed() we ignore the timeout
value, allowing an overshoot by up to the event-stream period.
And, in the unlikely event that the event-stream is unavailable,
fallback to spin-waiting.

Define CPU_POLL_RELAX_WAITS to state that we have a waiting
implementation. (Non-production environments might not have
arch_timer_evtstrm_available() but we don't care about that
configuration.)

Note that with this we have enough to define ARCH_HAS_CPU_RELAX to
indicate that we support an optimized implementation of
cpu_poll_relax(). However, defer defining ARCH_HAS_CPU_RELAX as that
enables polling based C-state handling, which really needs
TIF_POLLING_NRFLAG.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Suggested-by: Will Deacon <will@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
  - instead of defining SMP_TIMEOUT_POLL_COUNT to 1, just state that
    we have a waiting implementation by defining CPU_POLL_RELAX_WAITS.
    - update comment to that effect.

 arch/arm64/include/asm/barrier.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 9495c4441a46..d186a4558776 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -12,6 +12,7 @@
 #include <linux/kasan-checks.h>
 
 #include <asm/alternative-macros.h>
+#include <asm/vdso/processor.h>
 
 #define __nops(n)	".rept	" #n "\nnop\n.endr\n"
 #define nops(n)		asm volatile(__nops(n))
@@ -219,6 +220,25 @@ do {									\
 	(typeof(*ptr))VAL;						\
 })
 
+/* Re-declared here to avoid include dependency. */
+extern bool arch_timer_evtstrm_available(void);
+
+/*
+ * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
+ * for @ptr value to change.
+ *
+ * State this by defining CPU_POLL_RELAX_WAITS which enables a time-check
+ * optimization in smp_cond_load_{relaxed,acquire}_timeout().
+ */
+#define CPU_POLL_RELAX_WAITS
+
+#define cpu_poll_relax(ptr, val, timeout_ns) do {			\
+	if (arch_timer_evtstrm_available())				\
+		__cmpwait_relaxed(ptr, val);				\
+	else								\
+		cpu_relax();						\
+} while (0)
+
 #include <asm-generic/barrier.h>
 
 #endif	/* __ASSEMBLER__ */
-- 
2.43.7

