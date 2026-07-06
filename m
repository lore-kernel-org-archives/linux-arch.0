Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8DE387375;
	Mon,  6 Jul 2026 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783365565; cv=fail; b=rSV+cCqhhCATq9SN8s5thad2PVIagfH+1DjBFerdmUEV1PW4mdfVPPbxKI3o943+gxZBWkmyVljdhvw/tgEHlZfwIsm148ZcmAWp9ZLqt99WxmD2zuBP91wos4gmMuQTAvk72hOVTXDJDV4eGgRRtTlZA3dtKCklSPwuunw0mtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783365565; c=relaxed/simple;
	bh=NtfW+K4M46llwZ02/toWzRNZEECjJgOE3UcOAtDijuo=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=ETG2oX6ou3r+s6OAyIPCoyf2UYDpnr182nbWZpsLz+Du07tP+Kn+n5ZOTpW1P6muHPtTLIUiBE0fseCGyhOulbH9QvVHWclgLNAccBEbzgwjX2nuoez+2vSvxhX9CDO0P4CLUDMn5VTTbsA3h0aClUEEXQpYOuAGEmiClMy97cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L+5wljRS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r+Ye5av/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L+5wljRS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r+Ye5av/"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666H8LfH2854385;
	Mon, 6 Jul 2026 19:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=B028+2A7o+Ilykg4Gj
	9vEy+7GpIokbjgc/7Mt9LuHk4=; b=L+5wljRSZYe4WvPHp7Sxikt6GO7myNUyur
	9/H1/ZeR4nfMd+Z+HBlEhyQ+zO04+NTzOlf0oUZQZ6uX9pjBKk1Ruq1cjS0xUvq0
	XozHvKWEEr2Ct5EQ+dgwYnt8qFtbtGDFNnTmz5hmXIkNxREz+Nm13PULZuB8ZGsx
	rczMamnZ0Pdlds2gxzr2jMLbtrZlG2xsP9q2ZdOLicu/RN7H0UdGvjeVYmtAJ7s2
	l6XUi3zqBMdwKOy402N1BIKTcAQxMeFsjm+CGgchCEjNYneOt87MAiZap2OSN9r5
	eiLM7nShItT/0bJypVP0pr3LJu29I48sxVrO0mjKt4En/8JIlc2w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f6ry4vhsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jul 2026 19:18:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 666JINUS035754;
	Mon, 6 Jul 2026 19:18:34 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f6twh0teq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jul 2026 19:18:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FANbXhaI45jS6tBWaZGxybEI7PPLbmCqNaXOfqQPF3TOefTZsGkh81ZWH9s+Cpba2bl1waE3gC0Oy1uGO0vJ5/mSdzjRgJfZZKHJvkb+TdTg5rw3Ku/epn+LeF77caXj5dpTz2gJFom2jxa45y4FrIuMJUm9FhK37SyJTzg37PKtcaU00plelkHZZbSdhyFYauFoOWRxbr0oul8ByDqNdp0XvtAxeLi1dLkFP+zzTaAnNS3oDGdLHlKnEApVJIkJfruQbsAG+RYGXjTWWXoM2pmLYwYU0n1hQ9vKwphiZJREGO7tfDkVdZ8ZmG4hM8EPK+5rmHqdpPebdwIvbwuzew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B028+2A7o+Ilykg4Gj9vEy+7GpIokbjgc/7Mt9LuHk4=;
 b=lf9Yg1cRCweAfaa4HVaWpdBHCKDtY1bZ028IeTnSaaGRK9PRURe1LgidEIdno/+vkiAhV7ycfgc6icNTZJdXuBo3sCJwlk6RHQ+Gjb22tFfPABZN78tyIkzHgWkLKv5v7tvudkvXgHE05BybgGbhgTHkYfUVEDZZmHv5wnzI1pmSpOYlr99W3OmP6/nA6XDAfDWn8ozBpd3RG/dCRVgoiUxC/tZ2yfTSGB8d/TjV6AVQxhhRQQiQMwmdWwcwscKEeGHXkkp2XAmc4DFvSKy4Dcrw/IuV5uZZmVvd3lwY9P5glliLkeOwnQKK8bBO1JzD78MtUdH90omLlLnpQxXVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B028+2A7o+Ilykg4Gj9vEy+7GpIokbjgc/7Mt9LuHk4=;
 b=r+Ye5av/Yfg8Qg5vzqUvatqBW6XPdY5EZ8bd2Qan3VD2bTQ3V2qUHP+d68PyxrXd3ZjYZyqFqc2FqiWKun4YCFDKdf4yFriGEDnGzm6wVqEyOf9lEUR4ibOAoLs2TUKQQK9cnq8zNALVbxdHpAdW7cLPkevr10hBdw0k8fbDpQ0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM6PR10MB4396.namprd10.prod.outlook.com (2603:10b6:5:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 19:18:19 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 19:18:19 +0000
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
 <20260702013334.140905-15-ankur.a.arora@oracle.com>
 <92264294-afe8-4752-9f22-2b633373b288@gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Julian Braha <julianbraha@gmail.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, broonie@kernel.org,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v13 14/15] barrier: add tests for smp_cond_load_*_timeout()
In-reply-to: <92264294-afe8-4752-9f22-2b633373b288@gmail.com>
Date: Mon, 06 Jul 2026 12:18:16 -0700
Message-ID: <87ik6s6i6f.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM6PR10MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4a0a69-70ee-4174-48cd-08dedb935677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|4143699003|5023799004|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	UOUvYt7eHN/z0HnFS6p0fjlO+V/PBtzQ4Cebd4PutY3Z4CtMRlQJE4IoQZ2zfOj5aapJIs7oSZAFfmIyCFDbDo26eV07hnmh3iM0Da4myt4tqV6QxfgmHY7XATMR+XRL0CuiYAxiTk3yo7G4dDD9a7v4ztbvVMBSWlgfkWd7FR6h0bgD3TWg81NxAGINXsBChMY9bF71a/L4jIDBTW7RTC3qedH04R+yIoU384rJwrm5EIxWBEsmPPp9aB4f3Ug3SC4ybfeHpZogQoTaOGHX4RonTFgUlqcB3CwqzEocxO7eNJst+9hTD+vBS8aLB7DOhDY4CXGFvfXdAZHtFDyXTcMhQlGpj96bve2DcaRVHuZprKpfF9UsSlLATX2pLigFdEnU7BO0/mAwLEwcAyiQQRVLhF74tkUYMrtU5NKgkrMOsK5wLErFC/K+EXvptxn1//KYUOdeoaWStpVbKYSMNoPPK+RaiIvAbZVyFn3dTf8mxJJxJtRNnxQtwFdJxh89EgaKMvuUGZo/VuG9/CEnxI2ZPSHrG8CcHyK2bId100/zYlQJFBcb96OXKCEZT3BREpBYy0HkkHqAJ4XRlBOFH2H+bTx1dx2hmkHLG8jX81qydgfwgZYbopt9yS6GrxGyZ2mIXGLOU3227XL9BXeWdQAHkQSkvl8KMtcTDmR/Wgk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(4143699003)(5023799004)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g6hk+7xStm9q0imciv0fuymuSeiRHAIX1O+IBClfvqwqFjz4c2srbIv+Ihhn?=
 =?us-ascii?Q?U2z9rWzMTGOgc68TgiE5gN4pGu4AOdpc5jS+Ii4fJ6mRznNNBQYIRB67vY8Y?=
 =?us-ascii?Q?ScK3czREr5ropz3N1NHvddnRXzdT03uThis/XquYqTxAG0AncJ3VIJF/a/pv?=
 =?us-ascii?Q?FViXneNl04jlC6LnA19e9ylP97LC+tmQs3t/Op5+nDXXN8ceLrexlyK1mJC3?=
 =?us-ascii?Q?aAcL8xNFwpEPSMP7WfMsaVsceOsk+L0/PH9xfAuaPQrSxo682/TG7DSzWuqw?=
 =?us-ascii?Q?wJMhen86IXSk3+h9pl6tdBp55G4/re8zcYj4iZk+6CqxGcElB6BkfxPY1TBK?=
 =?us-ascii?Q?T6mJyXaudTYPSbiCWRYIErDqkyev+jvl+LsdzYEhQKaKuaTILuyw2hlVxBj8?=
 =?us-ascii?Q?4bgjTrS81foDpNPlT2oP1f8xBx48Z+56FIMFftWU/GK4xi6+m7Yb9cQylkoI?=
 =?us-ascii?Q?ziOc9MipXn68vzA7bDPNeaOOBrpSu9VvFCEBAIemxXwR6ex0u6fu/do1ZLVc?=
 =?us-ascii?Q?3jcUB6Y+pyXpyb/yojgtWikuefsWyO4hsRA+vCrce06F4C9pYHnaRgKCd50V?=
 =?us-ascii?Q?LtciBORhniIjS7UOn+BxWpfllzIchE5Dl/AS4VBgZ2a8vYiGENG9jNwu7JmR?=
 =?us-ascii?Q?FQ+OVZJe5DZRUeojWMTAXWFbMjfNmoxgRdwPO7VQarhgWaAxCmWyD8BHU2jR?=
 =?us-ascii?Q?UpygpZQ26g7J4JjELkz3gT0PPsRlK8eXozauROry9pKCmAKto2b5gCN3TVYx?=
 =?us-ascii?Q?Fw/Ef2KnMwL9WWcJPcBKtMmH6lsTDfKMf0NjNt8LDXud8jAI4XQ5tXKoYzRm?=
 =?us-ascii?Q?0EeH44LvfRoZCAApdBuuYsenT78TmEPjW1UrzrLJ3qneLxTktL4LbYWJKiYq?=
 =?us-ascii?Q?9p9ond65nAH1AhVyxobBsA1S/QqmxjmJ6XosYUuJiPJH1b+4/JGSyYh94aFI?=
 =?us-ascii?Q?OllVyya+0Y87qNOhLlBvxNcJSe08JeQ5XrmJ/ktmXnSR7KrTDG2FHcDZdEnO?=
 =?us-ascii?Q?4vcaqfsH8NhN/1yMZ90gVXacFT4tUcmh5AV36oPCFRzINJrR0uBWpAHjIg9x?=
 =?us-ascii?Q?wJgR4W9ixYo+oGmHjYegBepzDhR0XDqhjnODRyK/HgqtObT3qwtaHkhx2goL?=
 =?us-ascii?Q?Uw+gq0s8zfQrxwKbKAEcoB6LHHeeuiUBdanhKN581T2GV2cgJIk1hmz417mU?=
 =?us-ascii?Q?0JDiaFQNC+cMNv/iSH/9vVhdaxUmnPCrcHmDd/odEF3rnyazG5vTrucGGHr7?=
 =?us-ascii?Q?14uCqIklL3c8Apilq6mWJFAy/80U1xROqe/OSH05eniXgkTj1EtFL2GE8wLo?=
 =?us-ascii?Q?XWF5dcBMuOaHDQKYuYBq8O2TXDJJXWuDhmSZqXDKbucfwjxCaN84sgKrO8Aq?=
 =?us-ascii?Q?w9Eh122zuwm0CPCFReKEJNbRC8EDB7KA6hV0Yh6Gl6hnPYv62x+d3zYbpXYs?=
 =?us-ascii?Q?Wd+JWq+9hfhJ2ZS/xhzkwVysn+1KZWjSU/d+4E8/lsRh1ZxzUTWb8Zss/aLe?=
 =?us-ascii?Q?dQDTDIXi4s9wlvaUJnuFAE1oNgsFZ2UF4dh6jOGJ3HXDbz7VUD1RLosIzBos?=
 =?us-ascii?Q?2X2GkbPQ+2XDqw3JM7eoQ3lt3SSzBWQQP/lhQa6qAAaTuFUDSFqUd4/tnM2t?=
 =?us-ascii?Q?ud66LTBP7CgDT6OEkt+5DkOiu1lsUIDvHe9LcdeiRF5HoOoBn904+Z4yU/Li?=
 =?us-ascii?Q?7o6SkZ6QnMy4LVpfX4Nayz4Ef1ly6LOzscL7D4U6QbGwrsvu5+lx6eMtK9Vm?=
 =?us-ascii?Q?g317l/8Hc+BGl3cdY1Qmz+5Awgq1UF8=3D?=
X-Exchange-RoutingPolicyChecked:
	Wh4MD2ZCQRqnDGtbEYnCufg2EewTxaOEvaTZ300iEhyWa2mLCxHR7zLnfqmiPi2lprnxPRH8WN4BMWXD4hPtnqOUxDYlzMLCFM9ivOO43I7Z81Ip1CiujCsYzTA/WIFDK85/3LL+7IbhhZAzmxCiAonxC9xgtY3YWqif0Wqgs18pNVBVKEp5XnCLMbV+mCZG5vHBFsCb6vbldTdr+OnWQ+M12Z18GF9rluWlz4J6q/Qid5H+1MuKGBcIRMKdm9KsDoG6jTsO04+qTaKTV//2nYtl1dIupv5oxuTrzmhVpNEbv1+usoXsuHJOduo9eONN3/AvfCvkXjBYhFOVKQuaWQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JlzhUHI5ioKUwNp1JhXW9UrEKshvkXpogeiZw+/S92tehKoxSP/sMO5IdEMfTJCiTCSBunsf0+NklySvSGHMXqc/s0R9qbfxjL7X1RVlromwELHK7eATELaZaD5fL6JpKU+OOw+ZyWGZjo1KTmNjMC4ZiBt+nv0UQ5HR82d9kpwSXrp1bZ6H0EhPECEZEwSlTPBYoa6ZZAvPIJ/Q2lPVbw0+tW7s8oN0p5KL4k+qmHJpXgarIDscE+j6GokwarsG3AtHCUX612xxqQWksI0BiVW0ANk93JMsedIDP1CcU1BQMB/7VOmIGSw7epV4uLoeJlE5uCyE5wQvDgI4eXgpGE4POItIteOEhJmYKh33pzNBLVWL5WdA/MT/qQD+yqSjONftbCmov+0Exyazo7anHRObFdvQEdI90YJNUS31X2kIQ3YCCJMr2kpG08XXaauJkHfA4fnb6vJ/LM1g3GLIA2FReuDIgA4E28s3CaMsq6x9kHEYuHABldyETFfWHnA8FVlkSWMhjP09l8/7HtOkSr1FnQFgCJ1ovnksgG9h12Ty3fWJqL59qKUMGzWj8xwtgcKK8ccygKivKWwmv2USxIcGuyIFQbJFepheWoQ8DXw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4a0a69-70ee-4174-48cd-08dedb935677
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 19:18:19.2829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyjyiY04c9saFqH5UR8l7J3je7GwrpoDmpXQ/eytQMmipQiiiejCoHJXl5LX58+crN+gWBs0pDGo0LbXuHgCCqn7CUgmtJKHieW8ef2kHAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4396
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=970
 bulkscore=0 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607060195
X-Authority-Analysis: v=2.4 cv=UcxhjqSN c=1 sm=1 tr=0 ts=6a4bff8b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=pGLkceISAAAA:8 a=i9cesPlCo9hirFWLw_wA:9
X-Proofpoint-ORIG-GUID: 8aI5wdv5zea-gEilOZfS7qiZXshlnT9L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5NCBTYWx0ZWRfX8GmohmxTd4z8
 8PpHPAwf4V7nVwwdrA6MY8O7h5kDM9JhqcSyat7eNN3j0pKdZbf6qQSZXQDFRDg9yFQV+FygcE6
 jZSm7LlUtBO4XTpKjgGfJs1Yhs7ykr3iRCep3D2eUSlcx9Bj47X+fxloRV+0Y43WL0HJe4QanNS
 SU+13Hje/vlBkaabUzXFQT7TEdJUON/TqH2FLq34eKmIwu7mnJgFQU06DsQ0CQTRT42JrH4ACTG
 SOwdYbV+hNJPG6JKBQHFQsRNnoFZY+9uwMgL9KQvIOWUovLGKxDVJ5YpVp7WPebzzsJ4vqZBvUj
 cyLq8S7WG2NNKxYM0YihxYnbnk4oGMB7nj1OGh2CZnt/Rcd70RrBN6VUa1iJeSCYiJF6ATAUcu0
 lJFdq42DFkKZlVatBm+GloMugIY2fL5+LHeZEhi15fazQYIrool8x+WyJxwkhM7Eydb9OhEEpZq
 C99ekZ+VlLlXHX3pP2Q==
X-Proofpoint-GUID: 8aI5wdv5zea-gEilOZfS7qiZXshlnT9L
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5NCBTYWx0ZWRfXyBytVxJR0VIP
 IxLECclLBgP4WLD6DZrqHQ1YYbflGoYQNKFJnEOmF5vbtqDUT0TRPre1lHul+IkmvRCyZXrbM2p
 PGRecggGNq+kV5EqDfkuhF0gIb1FLIEx0wLisX/96iwFKmCvlSge


Julian Braha <julianbraha@gmail.com> writes:

> Hi Ankur,
>
> On 7/2/26 02:33, Ankur Arora wrote:
>> +config BARRIER_TIMEOUT_TEST
>> +	tristate "KUnit tests for smp_cond_load_relaxed_timeout()"
>> +	depends on KUNIT
>> +	default KUNIT_ALL_TESTS
>> +	help
>> +	  Builds KUnit tests that validate wake-up and timeout handling paths
>> +	  in smp_cond_load_relaxed_timeout().
>> +
>> +	  Say N if you are unsure.
>
> Could you follow the kunit documentation for the kconfig entry:
> Documentation/dev-tools/kunit/style.rst
>
> Specifically, these two guidelines:
> 1. "be named CONFIG_<name>_KUNIT_TEST: where <name> is the name of the
> test suite."
> 2. be visible only if CONFIG_KUNIT_ALL_TESTS is not enabled.

Sorry had missed that. Will change to something like the following:

+config BARRIER_TIMEOUT_KUNIT_TEST
+       tristate "KUnit tests for smp_cond_load_relaxed_timeout()" if !KUNIT_ALL_TESTS
+       depends on KUNIT
+       default KUNIT_ALL_TESTS
+       help
+         Builds KUnit tests that validate wake-up and timeout handling paths
+         in smp_cond_load_relaxed_timeout().
+
+         If unusure, say N.
+

Thanks for the review.

--
ankur
