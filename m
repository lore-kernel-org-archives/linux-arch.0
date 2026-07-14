Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677C03EFD1F;
	Tue, 14 Jul 2026 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014326; cv=fail; b=Om9c5DI8qihSwKN1v06o8YQxsbwFHkIzWE2Y2YgaAGVVlBnPAUebthULX7y2V20oGHucK1q6N/5OzJaCrf/CC+ztdoG6LgTmn0gnNUWIxA5eVHGe7LB5S5Vdwz7AErFbTEFlIUNdY42PqaUpK6ZWRmf1t42xWsG71fZiyJe4z+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014326; c=relaxed/simple;
	bh=5X9U02aS4T8loT3H8XpIbPonFBPvCzFQej/Dq2yztC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GY7Tulb7RmU8HjG+IghkRJmWrDW72IzrM5GdwhjW3iP8IN2btWDDHgcNNRecnYg6dywQwnozU3cLJs14UNqBGOSQ1izNrrtD5DI6LYAQp9ojcxMWoQtECPbE76q6Nk79j7s4UIwBquVeMiGFtacCcrRaIIETkFB980xdFvUSQho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UVh+J2HY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aWSDkLsc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UVh+J2HY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aWSDkLsc"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DLEbNt1392159;
	Tue, 14 Jul 2026 07:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5Urzdw0yqkCzs1wDL5pmAGbiBV1x7SWWrwo4lrMKHUE=; b=
	UVh+J2HY5bLiaCnjDMrXmEqB3itAMHo4GqyJTg1kGRI0kWtE1v7g7vgR15XmC9Aa
	ZVnY5k5Wdrh63aKuCWvk0vMqtDtfFrOK1nFOQEK3tYTDq+QspQL77N//rxCNfUnW
	5A1MqrgKVsd0SJZ3hdIQxhfgCvlmQnma8IPC9RGqVv/iqSXmC8vaWgfNsixE4FMK
	uVnIqvD9hLiSFoTb9Z5xxVApt+Q9Q09j9anBQAzJfwcPaoz+DL5dVCj9NIEPIBIf
	RDNATe5PYSTnNmBFhBLCs1F/HyuuehQy2o54sd/1wkRUFAH1LzffKQiW9Xx8A87C
	XLRMoM2t1wuzsUMqq7OSkg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbepn3pbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E7I0h4016738;
	Tue, 14 Jul 2026 07:31:27 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012053.outbound.protection.outlook.com [40.93.195.53])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9dvk1b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jul 2026 07:31:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofmPSx+C21W5AOmcM96zVNkQZSopP8C4Y2T9C+B6X5x3Stj5ZCtI8KoA9JU/xG2/Wi/tF0MKOBDJ48FCCxMQIaJ7yOCm8GtazI16w2zPJK0Gc9iEn2Ok5P4VA9eO1J39Ppnv6ai3OVXfvPohfmoerIQlU0CKUMsivdhls+CNE1RkkvZPdWcelM4yyP3ibNCKNZSpjCZt4Yeo6cTqQ/N/UpBVers4LVVZ8KbJDJqHhNQNvndZwLuGFNPTaAsBVN4RyMh2Ukq47lck0gNZd3bQ6M+eJgyFVcLgf2pw8mln3HH4SP9jDTQBlqEiPxC1U3nKat3LOu9DLr87tSuXTWRfTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Urzdw0yqkCzs1wDL5pmAGbiBV1x7SWWrwo4lrMKHUE=;
 b=uRbChtryp8LF6Wsps6PZZV5EjbRiE4th0lHfp6Ds3dYX0CXoFXPDH2pRZ6y6hnbmMKO3GCk62mOgBP/FRLtn/Sj5tQR3qpolyr8NI011o9jUIzuyRQ6hsl4g7xFLqxVaqIlO3FgPTIJouPmuvqNmWGkAFR/PhS//GKf7UK29lifxDDFHMZT5W2iYgGBhhsurxLm2Mno7dA6AjnXssUWE3FzEQjR7/1YNOqQqVsIhYIf7sZ3r17jsfp56CTc8jFnnrkRIfD9bDP8zs4H54i5lAvp92v4gHSP35g5SaTVZZixTx7houhpmBf08Sfd78zsmljVZPUISWhlVMH37Dhm4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Urzdw0yqkCzs1wDL5pmAGbiBV1x7SWWrwo4lrMKHUE=;
 b=aWSDkLsc3qIzw0t7QOUlYZSpfezz5kC1U30fbs6ZEViID8NgtED3fAdQVbi+Eii2MS9hwWf0WMvjYKP4I2smpm0pgfUKNzhsaf5msUhtfReQnnSGuaJB8U0EzgLg3kVAxslzxrbc7GGm1hPV3MeY4gindIscsHUX1N/1lpOgZwA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6262.namprd10.prod.outlook.com (2603:10b6:930:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 07:31:21 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:31:21 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v14 11/15] sched: add need-resched timed wait interface
Date: Tue, 14 Jul 2026 00:30:37 -0700
Message-Id: <20260714073041.40250-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260714073041.40250-1-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:303:b6::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: e3810fc2-e59d-409f-a53b-08dee179e6cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	dmSM0CePrbhQqwqobLF5ENysEHq1jGCnLCOZwDI2l6KoZ1TACiLFVbQ8Il41BktbMVPgRM7naTAc9pxuMCU3+ti+Ur7GMLWhNBh7tZAWG/gvTVH186IJWmbMZwA6pzao1ukY7FKYoM/RI9nqOXd0Vid9Jw+2nJtyobTLY/Y1P7+t/pk93VGG0zp+5pJRipOUGoPQ5O61o8Cd3IZ+83lcTWvg8jcJYVYY25vH04QTzXACU1T+wtvjF4E4UfYc+1JH262zP/PpcEhZ/DoB5k4DYQ9citSoQ6SjC8EZLX+6FcsoW8lyPc5iK97sghp38Gz8ZWBg1jB03zxLK93B2oK8zlygLkVXfO7eJsz+H+sYdQsoeh+mfWxg0Ti3+NRwHj96a26RlpYEIeN73f1Z4/0UXEKVbExbDS4s9bKVzmteC49HIja5XDb74IncWc4v24Inu9uE+EB1ttylrtm2MXdpJohjf2udCJCL49qh9Y4KFA536YMoO2bsQo2YY6sXXQNb9825gPDIm7dzUmDJWoKdWzpQVysNSqv/xlBUfHw2tVsF1faSrFrk4wteJfdHaF6ku1ThZdWYFZVaAdaaRbIxhw3OSdDh9V+NicU03GXNfI/ligQV4aqNG08YMXcyJrKoR1XqYP4TZdFFWuzgL+NJOG7RVRjUlm+KDQOgnwK4VWk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(3023799007)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s6vZaTXP7YAV2UvENqDtyTbIj3os522EX+0MYvQon/HQUN8QQmrlyjxMrgC6?=
 =?us-ascii?Q?izlcEYhG6DLwAVm5VTFWkRkID+gjnJUQsryV6Jb1oxd+Vd0w1ILjfD0IwCo/?=
 =?us-ascii?Q?2EJgV1ds8bCg9XpFr5J+WC5MfH8s7rFNbZ85hqp0lUoJgNiGvxdZzysVeqae?=
 =?us-ascii?Q?fqg4oSBbolt4sOdygaSikToDMachIx9MFJdRjfku/KLfWqUEBs5lS9mwY9/c?=
 =?us-ascii?Q?6Lh2Wt2wqM10M0IHkh4kIGH3upoeJm2MlZIDEuqjvCYnqOxgvSk/qUXJy5lG?=
 =?us-ascii?Q?KZacuaSwOouVvwCY4QkNe8zwndBOpiP0lpYyIscIyg8sUwcvn/jYWaGB+Bbn?=
 =?us-ascii?Q?8ExLpkr62tHQF/wV2jXzkpHiFS360eN/ziNzSMqjR05kEvfcNdfl3vPAxja0?=
 =?us-ascii?Q?dmtmFao/k5HOXRHhghjxkUOFcYL/oz13dalhSdGhUl8KpRN5QZ3F1GeABWGs?=
 =?us-ascii?Q?1/oyDuOfsganNSSGwDG8KSt37lN1z4i1IMiwH52Y3zFlhmXYuoZib6Jkx/d7?=
 =?us-ascii?Q?6q+cOokpoqd9fTCeKu4bIWufZn71tkFpGVNXd9b2cyRL2l/Pxlnv9VcCQFfB?=
 =?us-ascii?Q?Ujg3UuwETyiSmqMan4Rnz27ZzUdwGgfGAKPxeYG5npHbWSYTV8rBbFfchyCD?=
 =?us-ascii?Q?ejK+r0tnVOVjsVAv0TSWf5HPEQgtFQL8PezrWWrVyVtVGDayz75++IRIDh72?=
 =?us-ascii?Q?XN3i0awBYOo3qsDIk9uRI5OJcehjai1fa8KqkhoUfoaqKY/k47j/MO/XWz0w?=
 =?us-ascii?Q?+P3/WSg5pQlseWbEGEoezK/X80AHsZQPz9Yh8EC1Rv/MMXK3ydVb+UDGy4HF?=
 =?us-ascii?Q?ZbQLzki0s7hh0H2brPmtG6T1ZqSifNXXvz2OzRBImo9Z8zCIqajdUBy0iKVV?=
 =?us-ascii?Q?mhIBry8qF7PALyjDSzbKT+3Ou6z6zzoRo9eFx31wrllTWbHNVAShBLWyp8rS?=
 =?us-ascii?Q?2smp337J/HSIdaP0i93YnX3zFEE4eRC80i60rvFGLvphupKD8MRVH3VfNzCh?=
 =?us-ascii?Q?OqHV9kP0cxbLMnmvpxTE8ix9NfndQF3GO2/PUYjfJnjttlz9T5QnKD5dQzw8?=
 =?us-ascii?Q?wGcbFaqv2QYVPiRktgHkXYPTZXBnUdt9FIUlxK8OdHKDZl2B6zArymBB4Br7?=
 =?us-ascii?Q?EgYAUH16CsC8K56uGGTJ5nPAgNlFexyzOgpQx/q8DYVjfSdrGZwfXunimWvR?=
 =?us-ascii?Q?e1QCOjGqZIFK70/jR+bWMErPQxzAtKICOcMGFLwNWk4OKU/JOS1wGyzQZsuI?=
 =?us-ascii?Q?LlKrjDipLkddbyRrMXxMIjsO3bAEM+OypvfQNpXeKULzCZEjj4uc7rerQuEl?=
 =?us-ascii?Q?4yaTYu7ymshDOjHsPzfS30GufTBwCt2957sdlndrATuxJF68/mz3Tlg7dhkb?=
 =?us-ascii?Q?lporJWMUr2pvOs0Xav31S+pAc+Owk7h4gFOcqbiB6rhc5lH2W76gfWl7Jqfy?=
 =?us-ascii?Q?C9OvBo6unNFfpZNQki1Fj+DMv8emuZCvkxEnz7sHtruHAa7mOZGrGUSOSOzy?=
 =?us-ascii?Q?DSZaTBXCikY6OG6xpmpMkSgEeuGmzH7fG5qJuJZ62iCeZlvruMw9k1UB9/5X?=
 =?us-ascii?Q?w73z3EFIxyEzMi2RykLpmvKPl2gbqiCQo7edHfYEdSemMYan1RfCiIdcoHSX?=
 =?us-ascii?Q?f91BJKhg5EZc2uyCPXIvBJ7Cs6ekRP4oUrN+/7Je7sTTIgW8QC93l6gTtMZc?=
 =?us-ascii?Q?H5SOz59jfLn/Gp2hwf9eGz6NVdIOWhWtxWMm10gv36sXG6wzFIbfEkNdCcYW?=
 =?us-ascii?Q?EkiNLtEHfF3g/EHVPwhtHN8GJ4voWI0=3D?=
X-Exchange-RoutingPolicyChecked:
	iEAO8Ek92jR9a0D3uLieHthI73H2ckej6511PGGXFEC57pUM/ini2QEuoA/veVtag6hDHC+VXYpv6PP5Z8uYame5D8b2taSDBIzwqiXzeIo4WmtqQ6JNMxSeQcF5iI9qC5Z8Kg+TVmsOhR4dzPO+kHmJ7C35vgGTFSYNFBB8Dj8K5hkB3hd/KI0aa9YW+bNDKImWQhrNlTB5ISoavAET3Db3DfHUomogjln1eyssuaT6HMFUCFS4n8MfEWklVOjSu9+o7+eYfS10TPOjTa4RsGObdEr2EQG3Zefbw1yqr1jhRxlEjEQ8fZp4hY8SIsGJ5vdr6pzZoaCh8MEazVyFaw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZNHKdWPsKi++Kl/rxR6mtpmKIuJW+VCljBgZ7a773rYNvPFkJS+A1/2pQGe/KD9DaqqEWi08Zg9hqbVDi1dkoJXFkHpi+VI4DJLdkXrtKlJyj/uMW8Y9kaxs0DD38JWEAPrPgZ1ZO//PeR7/4IAB1t60QtFjIiWPrkdXsgykgvHV0jWAnZ0Iu0X6SYNg/yE2rG1pWwHb+0zW2TDkh1i0RghVqJh+fTGv9bLnXyvuabS6EJqUSeHck3tuPsM1bHEUR84jTdDUsDT1v+t9fsO7l0bZHhCK8B25dANkZnL/xsb+wr/arAMldpjYskwDNkWRfbVm8x4qQleGr26dLh9ifIs/ydL2/hQ5oP8MQq5Qf5vezfvzMyTJe65mLQsNjFqZUnWl67/rJZ2b5HBWpQW+nsTdcw0jjti/srzN2UZ77xL4fB7Am3w9WduQ7MOe42laFZ/QTC+dmo7Flk4szdAHvrg/EyC1sqvqF9V+/rfZRJgABf0bfULuhXNUCinaixyPJ3i4XaWlZUnLm9TQZJloWj+bOug1M2RTYnhw4plHxtMhvBzgvmk3PzAFiRuhiJy8CRocGRP34ZZhRyQ+rAGojabtDj91AVn0bAKahvHZwtk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3810fc2-e59d-409f-a53b-08dee179e6cf
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:31:21.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfSxQQnxr/vg907+jVTBQfaoykpj8ZOWjPpfEzwuHKrt2qvc63Wtl8xo37H2g7qcx/j1O6coBeTWwos4IoY5KZ3t/+zeS/UAlPTpYZSl6uI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6262
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140075
X-Proofpoint-GUID: -LZPJt2QFUfWDDibNTbTTv0Eb-rpVmIZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX6rGBahoXk6wc
 4hgbn0XKEpLAceD0ogPSiAleAd9B2w1sj0IjXpmvcCYl/ATarj4slJLIwsYq0AAkElB90Bemrhu
 KJuTdAOIJWY84qpRZrtpVg7D/R7Ok4zozBmO2JN5XLPVt43ecIJYI8SSfAtfoHyOL3axeiW6tYi
 znjtKqPdKNj5WfGBpAFMCcf7/JcDSRZuNG47iT0asZoL6XFnPqsOgXzP/82wNfU9OoDjlHFsW9W
 lZYOm467wjscaTSKnzoCfzIDrBFpEvcCaBkYrJ8qyYnT8jXYyJ6lXzGK2ipiynYs0XxoLgGK6Ew
 u7eE8bgbLk7yVDIifQSuocvke4voEp929jWJ0lWCq0ABRU7giqXmaLxFjylL0fwwvzA67gcSGXY
 2MeLItFDnCifAWxrnwfpDbLDaTThjngd5BrjNdWKC0bpJXjePcPb1idHyq/vjDeG3nVWmW4kznM
 smtYcyS3C0wF2xMWkFg==
X-Authority-Analysis: v=2.4 cv=bJom5v+Z c=1 sm=1 tr=0 ts=6a55e5dc cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=yPCof4ZbAAAA:8 a=DC2jtUcBNbVnd9lHvZoA:9 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX40bss+uial85
 xuXVNRlC6goyNvSSMauOHULAzO0F5fxbDM5d79ayZ73Q2PlRD/qCT0YU9y5iqPBP3rHpVwxCn/V
 6Dc1U74iBXpSeLf7i3gZiCey7aX7N0rlFyKPP5H8fgu0nVG38IOk
X-Proofpoint-ORIG-GUID: -LZPJt2QFUfWDDibNTbTTv0Eb-rpVmIZ

Add tif_bitset_relaxed_wait() (and tif_need_resched_relaxed_wait()
which wraps it) which takes the thread_info bit and timeout duration
as parameters and waits until the bit is set or for the expiration
of the timeout.

The wait is implemented via smp_cond_load_relaxed_timeout().

smp_cond_load_relaxed_timeout() essentially provides the pattern used
in poll_idle() where we spin in a loop waiting for the flag to change
until a timeout occurs.

tif_need_resched_relaxed_wait() allows us to abstract out the internals
of waiting, scheduler specific details etc.

Placed in linux/sched/idle.h instead of linux/thread_info.h to work
around recursive include hell.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/sched/idle.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 8465ff1f20d1..ddee9b019895 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -3,6 +3,7 @@
 #define _LINUX_SCHED_IDLE_H
 
 #include <linux/sched.h>
+#include <linux/sched/clock.h>
 
 enum cpu_idle_type {
 	__CPU_NOT_IDLE = 0,
@@ -113,4 +114,32 @@ static __always_inline void current_clr_polling(void)
 }
 #endif
 
+/*
+ * Caller needs to make sure that the thread context cannot be preempted
+ * or migrated, so current_thread_info() cannot change from under us.
+ *
+ * This also allows us to safely stay in the local_clock domain.
+ */
+static __always_inline bool tif_bitset_relaxed_wait(int tif, u64 timeout_ns)
+{
+	unsigned long flags;
+
+	flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
+					      (VAL & BIT(tif)),
+					      local_clock_noinstr(),
+					      timeout_ns);
+	return flags & BIT(tif);
+}
+
+/**
+ * tif_need_resched_relaxed_wait() - Wait for need-resched being set
+ * with no ordering guarantees until a timeout expires.
+ *
+ * @timeout_ns: timeout value.
+ */
+static __always_inline bool tif_need_resched_relaxed_wait(u64 timeout_ns)
+{
+	return tif_bitset_relaxed_wait(TIF_NEED_RESCHED, timeout_ns);
+}
+
 #endif /* _LINUX_SCHED_IDLE_H */
-- 
2.43.7

