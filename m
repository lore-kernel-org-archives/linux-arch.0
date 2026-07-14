Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191913EEAE1;
	Tue, 14 Jul 2026 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014326; cv=fail; b=bMYt4KFou6YhvJXj18m1pMjMq8MijChrRWc9ITBiR6oZ82zoT2m2BwONvY03AJYASe4LwFlKFfLHGJWLtqOM+dOUo9topRNB1uA3rV2ngROWm4W+MzJroCoxjaU6ImnemQ5hlNQ1r+nf0BpjLXl02Z4kpmRsMjOfBEzPG6+MS+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014326; c=relaxed/simple;
	bh=wa0s8yhsStG8Vc15yt3sloMYFZV2Cb4HvSp8OZSRB64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ifi+60+LvZyWY1ssP70bSB/0xS+ykPUOiBR+eN2YStJOr8fLyuPEQRCwdF4Rco9D525frDeFZEgfIvWiFb9eYlXk5n31+yGKM97qW6W//ZtUyLtRpeuTMEuckfEOGWlf/xdcM7/4dAf96CKd8Mj8Rom/IqkX76b0vOj2jccMc4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r37hBGNv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k+SuTlyP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r37hBGNv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k+SuTlyP"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DLFPmk1347396;
	Tue, 14 Jul 2026 07:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aljnVLin2KbGyaD+Ih8Aiw27tw7tOLS9IgNEd4ohxD0=; b=
	r37hBGNvBS2BNzecrO4FKs2JTlnA83SYtL3hmYE4aNlelEL8zkY6i1xcpOeJ0Igf
	KsKWXoY7oJ/83zigC89xF6TELtCWhovRwfeeSVZFxl7jL77YmwKdPjVKIxwGy0yL
	ANrYHb6LVhQAewh9lAaWMhdJC6JAcOENHanZzTkK/VJYj5rVN5R7xx/tc+H9JZhV
	D/eR1Izgjt0pZRW62E54Ov2+iz7n8NPihx2c5PzsAU9l4bSF4AqCg+ZvSH6ZngAG
	BH3MaZmlap9dF+WkPpKvvNA/L0xfYZfYT4tmX5dDkEXWVbjw/yZr14RYJ7c2lBjE
	fLFCrvfRU/gKrchnykz4Eg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbep33p4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E7STvg035318;
	Tue, 14 Jul 2026 07:31:37 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9h4922-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QI6dJ6BSWZL/4DgB+2MdiOf1LYnOHub/wnzn2hob5Gd7DCnuqclhtkPlkig5Tbrx/HipdJzidvnJ9jUOEGtCJ+P6LqhtYqQUZy12HolVlt+o954wf92pW7SLMGGhXxFoKqtc+kPREkZ9LXqvRZXOpqEbejqZfrOJHHKUYc0uVXYUjexQIGWD6qHMCesDl1GxiLrCNBlqfd7ed8VV25opgIDvSLIByEV74KRb0fgwouofyRByfG2vtj8CFWU3H4JIFZmV0MKz2xCrddlUa2QqobxTaYfDxLwZJd1l5MUee9s3/N02tKGJJAJxZ151O/81s+/khfguBvl0+4hjJ2kvVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aljnVLin2KbGyaD+Ih8Aiw27tw7tOLS9IgNEd4ohxD0=;
 b=Xq//m9p0/0jwG6ygDSDqyVQnUtKRyCB1eT4EZ/sKfIaSb+MWI+05FKfj8w0dTkI9K6l8/3uR/w6BwfXT9ZGAk6KlgI+qrVOu6X22G6War9TIE3wQmr7kKKJA78gyBGx4nrvE5Sbg7a/Wo6OPAr23+Jw5m/P0ysgzTrIhSIIxx7qM4eebVMJA6g1yQCy6dlO3zGUuboluIhj4VcWS/CGsox8oxbfgKSJgNRAzZXK91Z19z7R/lrxVWWUuoZAHcHqOddqtKDfcP2AENR7r6NSv6sjk9J3276ZPQUYIGalox0fBnnIoeQdKMeW8mUxxgk6iN6s2CQXAgV9LWCUUsJKdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aljnVLin2KbGyaD+Ih8Aiw27tw7tOLS9IgNEd4ohxD0=;
 b=k+SuTlyP2WdTvTaV4BAQjVoiUkHTlpNJTjDSDgF0gu+KxvZTbGSs9hcTg+Ezz2007qDrVEOvYlFKug5GCfRq2N9jTuRlmTBwhnWQWhJi3wWeG6pX/q1ebDzdz93yYxkxHWT4ESp0aEfyLzI8MRaeF4BIyMQbdXxno2n/7u63Wq4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7124.namprd10.prod.outlook.com (2603:10b6:930:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:31:33 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:31:33 +0000
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
Subject: [PATCH v14 15/15] barrier: add clock tests for smp_cond_load_relaxed_timeout()
Date: Tue, 14 Jul 2026 00:30:41 -0700
Message-Id: <20260714073041.40250-16-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260714073041.40250-1-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0164.namprd04.prod.outlook.com
 (2603:10b6:303:85::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: ad266817-7de9-4462-31ee-08dee179ee0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	4q/eAXlWYgwY8oW++ZMDTEQFBlr9JweTurYIS/dFKNZOVpR+hd+ZlFEi06CO2cgiujm0zSvOfq5XjFbJQGGol4qSCLigaZCV/8QeFsTq64pelunP+6IBHpEIEuX/Vr1bz079DlCkDEkJvoSOMac6WVjFiXqc3KjUWkKYRmLpGGQjfSvjyAJsgO1prJMm6+2jK5RmcpZi5OKbr5Pdrehmow1ojL5cHbAytZYYHqUUYNB98UpVWNrzYaYlRWhJBoKQFhFZygIFcfqHm8QrBrXtqjjZX8TBj5SHtSimkpaH+oti0ltPMhpZOwoAiUg6b72fy+NcNxaT2uj+acaScoYgTktzu+m1U33hJ8hOkJfg8yGWyaedqufioKbqupHIQdU2bYkQaR92SwqWLM09okjeoqcd0wVyVIt3dP4tcpllYLe50/KzNUTvdhaiIpjCSHbgIK5mPGCU3cAjZk5bQZG2d0nSMofOl6PQlXmFqyj9VKVOJXh96tcuZ3bzNW/6/ZXDH4wJCHF9KSuXfwnz0TSUhoeBx5Kn3OtUAgpdhaZEl7Iy6W7jkPCSEGE8msVVfZJaVCthDu/jhQi8LeNpHcJb4v8TpNPRkPl9pJjd5+iYt26BtDXHispFYIcSfiDn0UWi8U9Tb7gyccSzuKsKLtF21n6x3dWZtXV+LkCDM9zyVHY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PPiQs589tteHxC/f3v+Qrjul42F2Qz4+4J+oPKizSij1cbhyhpS7IZYknHwq?=
 =?us-ascii?Q?PcSxEsiZFHlfd+lPbSUHWvFg7K4oS3jXNmn/qr/z11TErACD58nednareAoP?=
 =?us-ascii?Q?8HaD6FMh4b5nVQ2IH5wZN7Z/OEU2WtFvoJ99Bwrmp58GTAsVAqTMLsSGSpcQ?=
 =?us-ascii?Q?cxeYVb8iCG3inD+AtM71xg/aOhqKCrpbOVIEMKC0pqi3FRe9mkNGtvPaVu1N?=
 =?us-ascii?Q?NEcyn6QuFqbBIGGoLBDHoz7Fyobqhht1I9oy5/AtPuTMzzfnH5cmgxmQnLbM?=
 =?us-ascii?Q?h3m7WSuOj/5rYTzpJunFhQSBd0RfV5+3qbD9ZBJBFG4Rz+yHWOZ/HSfB9etJ?=
 =?us-ascii?Q?oO946YHTzGMIMHeetP1iLH5qs2npr+uJAmNhLJ9SdUkVO/XWX8FKHSuPrhnT?=
 =?us-ascii?Q?VBZ/O6jYMfqYfVM/1XNVNDBD78R5khuZRB1AIZGqtPUqXHgd9KNoutCr8aC+?=
 =?us-ascii?Q?c26KMbFHQThcjxQTAjb2oSN/aeUYFyHkagmvwtXzO/KnonSTZeuwgGHk/Fgr?=
 =?us-ascii?Q?5Yrtvl9GuK71rKWmubHSSdntoe8avvKxkV4hYzg7pr7ZmePFS56J0z9cPbYp?=
 =?us-ascii?Q?1q/BgoYOfwlKA0C0fx0ndSHkWNn2piBqHBsHNm2S4QwD3gag/Qd2pNMC/dZz?=
 =?us-ascii?Q?lutvFOlvZ5X1AcePF/yVpRFjeartaS93iYmPq21KE2yDHy5bcxrhdh7RHPz5?=
 =?us-ascii?Q?QQvTvCP0w/8VThtSiPcXqoTIBZMqI+MoeMsG0lS/8TTk6P4DNmMHEiCqMw79?=
 =?us-ascii?Q?rzLs88OpFbt24p9Y5KffK/RfwFOGliqhNgFAKjNFFkrEI6nbRrvZIK7wdICD?=
 =?us-ascii?Q?P2HsnzFUlYW95KbVWg6lkEkzDFbbCMEC+lD3PTuObpH1L0a35tzzIhhfWjp5?=
 =?us-ascii?Q?5e7hsWRtLxuWiNB9BwCNku1gi5v5fXpoqgB8bRsbr2V6Bhm2aMxpDuV05U4R?=
 =?us-ascii?Q?uDyujfoRoKs91IgSUIShFuIWBVadNtUUDNfKjh/7YFwwSc/synH3a84iA89M?=
 =?us-ascii?Q?ZCdHulfcUEDJ6hVX+p9qCTu4M32lSRx0cXvRLapsMQZ7jEyzIY0uOnst/8AR?=
 =?us-ascii?Q?STJkW4RC0QMyO1Bnm/H036D5RHsjlD+PwXLzoxNKcrJfpJB/gEM13kkVKYot?=
 =?us-ascii?Q?aLVM9YEDttsxqxNwHKPn3rlWCQLD7B3iqHI7mIZ6wROLhYLHNk20y7oX4n2P?=
 =?us-ascii?Q?q6opvRqEWCx/svbKb1aanJRiNYln4A6G0FvE1UYbs/8FzgPpxhC+32MUHIW0?=
 =?us-ascii?Q?tjZFOdL6fG+iAeuem2BMQQGfD1ssn8wKTPZbYkkY5CzR3aboy5P0SZ4r0NOm?=
 =?us-ascii?Q?CsOJHMs1jxe8yHO4V7mU4fFV5JVhWauliyiAyq8tsLwy/ag1amlhfmPzM1cM?=
 =?us-ascii?Q?b8wiU6JC9aUcfZ046y3APRyzD6cUl3N/nz7HNj0v3HQiECemD7ZYFAJOwIIj?=
 =?us-ascii?Q?r8WPbEtysRuGP8yCf3QEDq3TnqfFP9Ygix9/ETbxqqtKOf93/Mxacx0nG8lF?=
 =?us-ascii?Q?uFbHm81wLAaBO4Eejee3d6xzhpoKOPKDOn6H4Sx/QVYXmk158jEBWEazHD9d?=
 =?us-ascii?Q?leRLx6kwMfNZvMGxZzWZAqQxU/Uzxnr7eI6i+3ygGK15HC4ZW63nwIFISmNz?=
 =?us-ascii?Q?5ewiSUrYOQ9bfUeQn1nD0iGa23+7ND0H2jsTDxl0SZzS2P7Q1fylBx+C5FDK?=
 =?us-ascii?Q?rDxgVG5xbrGd7OySYbSTpXyznwQT0Ucp7mIZr1EFMz2DA7Xx1xpyIpIdqQCQ?=
 =?us-ascii?Q?EVdL8xmQrnFq+PcJa4PgYO83wSnAdgk=3D?=
X-Exchange-RoutingPolicyChecked:
	aSPLUC/SfKg2/dng0Eksz6DXzmiX4dbgW1/+dQC2RuqIlBNvbTr8K9PT9qj+ZZrJOXKCLee29s4BFdFC9fQ/PAiqPduvXv6a84WEhZYf1BbMFh8c83pyNGWFtxKQ7ZkK+QGLLoyqFX4b92QAn2TjE4WrXmn/XWB8ZbfaVAOKUIeeWDH+mnOCC/cCIgniNTOwLECFe/8iK7IAi6kk18OsF5DtXCzSFG75Y37qUB9cZ1CzE+9MrQ+4G5rcgRchMd048wOLWn4Z50fITwh6JGX4DPwVQen8XMrJ/4NUVxpUhp0LQ0XReDuzIiswuP5TgIajmg4WoDOlMA0LHkHSAs/AGQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I2stZG9kpEEwPoyKFxv4eEpImpzoXChc5eDwfVq86U3hGcAyuYBLm/i23TvQP6vPoB4yqM/yPuL1ATzdujrF0q8bNeA9MdV8g64uwGgVl6IuzjwZNkC1y1mf5yAAeoKhbGxGNnHO6ookt8/GOcV7/rmkhxF3Pi6wkIJXEm+z7zyAzJTRC8hx+c4NrCtET/NqqJZPvAIRB1KU9hOlka0SOKTttyXmWGeu2BtvDDFV2v8aXrPsNki77il6rUpdK16eNIAizyRRk6wZ79ziXh1UVa2QYlFoRUDAZDNao8faOZ8j5JUF8IYahke4EcML7S1qtd33KHns/huLbZalLE0ZsrSjkxJRrBgDeZ9MTNKzysnsqiQAHCh0XekgsYuTRC86QAfgIZuRBxjyBWhVDYaDnr0HTCfPH3NOFKOD0upMioF0mo1XzkwmkHXj8aY2MXmGr+J9l0tserdLPsbTx3CMUKgKSivFntVgBzvDSH3KcqxdKv7l3BDTlme9d0ztMg+vwSMUrDSslq+P4Jjeffmil3Xk+L32wdiH/JyFJNVNR9UKwHsXkdYw5pyZoIRjV3RmlDq+vQ6fCD59TwZJa/V8f4MFbAile7pDq1ofJAHwIyg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad266817-7de9-4462-31ee-08dee179ee0e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:31:33.5567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEEfA9kYGaqYvf4bAomzRI9HHy7DzraM9m975ocv3viQymG0bX9pROFFbd2qJZeBteCXYrnxXwV5zQhUMnRLYDReOPq0z1X5HVL39F+AziU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140076
X-Proofpoint-GUID: eFZ0rc14-FcAZIazQEtCvwS3GmSF8fAm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX4GC7XP/Tq4qP
 9rK7cAfpIX+QqpLKAVbYDxr7sKx2VYRJHbEOEquklHD00pjbH6ZLqLQvRn32ky2RopaSYaF4lci
 VAIvBESo3WgHXvvLlBuYJb8RFjGZXk/J17fZ+EEWF2FpHd4JoUi6
X-Proofpoint-ORIG-GUID: eFZ0rc14-FcAZIazQEtCvwS3GmSF8fAm
X-Authority-Analysis: v=2.4 cv=dYawG3Xe c=1 sm=1 tr=0 ts=6a55e5da b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=EAuR-l_fSTGrmbixSIUA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12221
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX6I/tny2B2e7v
 0VHvrcfohNeahqGsuRgiZjc6vHOYFCoHFT/44w9Wjduu9ypi60tLvbw99cxA9jmo7wdEgaqDlat
 1XzSHjIT8A6UzPSHUIDiOg4mXO7uqwwX7kq/6yEVGKwsFd3nzX+hqeai0oOyg2ujklqp4mle343
 mHimOGzvewKAg8Fmc8+8dXnAw6zL8GpViX5mJz5ETFrfoCzO09iXzNsgMzxTAMqcC4utpro/W1v
 gr9WzhzReE4qjtOkGNaCa/ljf+xmNVt1wxkTD2bNJk5Km4M/rZu1IDH/EJsOHkbvNchppWdEL+Z
 As4Y35Pvm+lYVzTGfn/64mNltCVWiPfHANsVAknp6HLTPm1gqqdyY08t0sZEDqlE+GA8egR37sX
 wN8yhn76TmYHPWcZRo6Jf0RGGzTk+mjMFrUKZknOsQsjGjZYphsrHEEfE3dnWAEZa5Q382bZF4N
 JKP+C9NX9ShzmiI8dKlP0RmUfJz6rzmDN2gkAW2I=

Add a few clock tests for smp_cond_load_relaxed_timeout(). These
ensure that the implementation doesn't do anything funny stuff with the
clock (like multiple accesses per iteration.)

Also ensure that we handle edge cases sanely. Note that two edge cases
fail: S64_MAX and U64_MAX. However, both of those are quite far out
and if needed, can be addressed in the implementation of the interface.

Also, this tests only smp_cond_load_relaxed_timeout(). The acquire
variant uses an identical clock path and testing wouldn't add anything.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 lib/tests/barrier-timeout-test.c | 58 ++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout-test.c
index 4226fb6456b3..ec78f8533006 100644
--- a/lib/tests/barrier-timeout-test.c
+++ b/lib/tests/barrier-timeout-test.c
@@ -19,6 +19,8 @@ MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 struct clock_state {
 	s64	start_time;
 	s64	end_time;
+	s64	extra;
+	u32	niters;
 };
 
 #define TIMEOUT_MSEC	2
@@ -112,8 +114,64 @@ static void test_smp_cond_timeout(struct kunit *test)
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
+
+struct smp_cond_expiry_params {
+	char	*desc;
+	s64	timeout;
+	s64	clk_inc;
+	u32	niters;
+};
+
+static const struct smp_cond_expiry_params expiry_params_list[] = {
+	{ .clk_inc = (0x1ULL << 28), .timeout = 0,		.niters = 1,			.desc = "0",    },
+	{ .clk_inc = (0x1ULL << 28), .timeout = 1,		.niters = 2,			.desc = "1",    },
+	{ .clk_inc = (0x1ULL << 28), .timeout = (0x1ULL << 30), .niters = 1 + (1 << (30-28)),	.desc = "1<<30",   },
+	{ .clk_inc = (0x1ULL << 28), .timeout = S32_MAX,	.niters = 1 + (1 << (31-28)),	.desc = "S32_MAX", },
+	{ .clk_inc = (0x1ULL << 28), .timeout = U32_MAX,	.niters = 1 + (1 << (32-28)),	.desc = "U32_MAX", },
+	{ .clk_inc = (0x1ULL << 28), .timeout = (0x1ULL << 33), .niters = 1 + (1 << (33-28)),	.desc = "1<<33",   },
+};
+
+static void expiry_param_to_desc(const struct smp_cond_expiry_params *p, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "smp_cond_%s_timeout: clock-%s, timeout=%s, iterations=%u",
+		"relaxed", "synthetic", p->desc, p->niters);
+}
+
+static void test_smp_cond_expiry(struct kunit *test)
+{
+	const struct smp_cond_expiry_params *p = test->param_value;
+	struct clock_state clk = {
+		.start_time = 0,
+		.end_time = 0,
+		.extra = p->clk_inc,
+		.niters = 0,
+	};
+	s64 runtime;
+
+	flag = 0;
+	smp_cond_load_relaxed_timeout(&flag,
+				      0,
+				      synthetic_clock(&clk),
+				      p->timeout);
+
+	runtime = (u64)clk.end_time - (u64)clk.start_time;
+	KUNIT_EXPECT_EQ(test, clk.niters, p->niters);
+	KUNIT_EXPECT_GE(test, runtime, p->timeout);
+}
+
+
+KUNIT_ARRAY_PARAM(smp_cond_expiry_params, expiry_params_list, expiry_param_to_desc);
 static struct kunit_case barrier_timeout_test_cases[] = {
 	KUNIT_CASE_PARAM(test_smp_cond_timeout, smp_cond_update_params_gen_params),
+	KUNIT_CASE_PARAM(test_smp_cond_expiry, smp_cond_expiry_params_gen_params),
 	{}
 };
 
-- 
2.43.7

