Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6E6368966;
	Thu, 26 Feb 2026 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125965; cv=fail; b=ZmLmHzOq4XxoOLFKm8PVHf0vjXOPbTPodcrKpVg9W9saCLNHHAEd+nZ9GJQeq7kjzuNkj8EDpmjfWwq7R8oblFRV7oCoWtkt+oB6o3qjbTZxr4SmuVaMyety+l4Se7U8cwTuAVMcNlRNKyvkWMR3F7EhQRf7xlwvIjvi6Qa1s1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125965; c=relaxed/simple;
	bh=0d1zRfWRGfwl1tLo3b6ElIiVH527jNjDoN4wUoQ2MhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sq7RZXBDzJ+kdkTFGJnlQ/kG3QbCwlCtMluo/av2Rv5Lbp4Ss4e39czZcBppP0coGzs1A1LtjCa14Kdci1U8RolsQaL1WQD5zTVCBv3SOC3z8QhR3MEFm9ZyqdWnrCwYKbqY9Q7OFPDLEvnDu243rGVRYB6Krag+gn6kpt6nARA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W/RWrzZe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RJiwxzTg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W/RWrzZe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RJiwxzTg"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QDNOjq822989;
	Thu, 26 Feb 2026 17:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dTfCzZfbgcXxlVXVV9
	lEbgv1KjTCFEGRAmociDTfYrA=; b=W/RWrzZeqThlQTxzACVu433ZbrHmFSO9ns
	J4zq19Nkfdq3ZpnpEihcjaO53Zb0nwmTZWITPlaxkgHz9B4et9sm4vn5F5F2CSmW
	OGYo8bTA4y6Qij5A2ZucM3eqohMYjsojJ/6DiDOpeH3pQElvDnw5Wri+JkD3PmAh
	PEcOtJQL88B6ERh1dYX2DULRF7CxGh0PHqDBnAlJjbnw/R5G7GYTMdpiM8aDFKi7
	7ayDcFEcK8kTxdwvcorbn4Gg5gU4Also/OBWAhGtS962qrqJaLpTDAwQqY9ZZq6c
	EiJYMhyBKAMbBdslUxaa37J9sirMAUIqk0KzVqxl16bwyQbO4Olw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4argnmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 17:12:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61QFOlow006272;
	Thu, 26 Feb 2026 17:12:08 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35d09rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 17:12:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTWyXTeBgrL/uDhyaWaphoDJVkZYmwUibNsL68WFtku8FbQx5egyNxl8VLZh3tYJBSVZNmXAsuip/Uesh1zk2noD08UsfGRJkLsSZ2wga0HdFzxibVqPouegZXg3Sgdj98tL+0/BC3GPRP+KlA81V1iKZr+t136U22L3LBAntMoCRrLumKHZmINXwLUl9cAxz21RdJJLTqDfHbI3cdiQqyhDIM3geB4hpugsZojU/v3eInDuIZQ5JwnG+drCdHON8n84Fx2YlbDmYWfWTxoNxRH4HClHNr6rdOBKhC1IPpOkXn40Q2kFM7FedionkIBmIXivRbSBKkI9my7m/nRmCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTfCzZfbgcXxlVXVV9lEbgv1KjTCFEGRAmociDTfYrA=;
 b=OnXJnAqsO48owYmam9xKFAm/XLmQi5Wwuh55XexcxMDHg4I8UUVLlx5KVPGoa7+PgKvlsVCa5Vo4+0dxNcIcnJMpScyKoTqu+nWLF2l62X7xE+6NGl5M5ppITcrPuK9hrt3g0iI9s1+7Q1oc2VvvdY9lvCZnSCmoQ1o6LChVNacOHpr+uSVgbsZRZv7kTV5eDbe5rq8a3S4865BovJbPB5hDLRfXURfCshdRDw4SkP3/RUrvzWT6Bbp9XyQK5KOWxtjnHFrHXliiV2TeFSo76foGQ/iR3BskHywI1QAN2GsxT++ZcofhCVr/ZCQhxEx/QSoxu/OkOZ9S7A/BXychTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTfCzZfbgcXxlVXVV9lEbgv1KjTCFEGRAmociDTfYrA=;
 b=RJiwxzTg8Nbp83TX8+47Svs3AXcD/Q10urkieCEImOVplEjBzLqmnsV0CvgrNvbAsN9k7JDpgsQvRS2ANnaKuMpBbVfdAF6o80O4aJQMDrNgKR3acWqXeieBzRqNY2egbcH/J03GKOeavPDJqWADYVETel8BwghDyxhJ2UHnH7M=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS7PR10MB5102.namprd10.prod.outlook.com (2603:10b6:5:38c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 17:12:01 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 17:12:01 +0000
Date: Fri, 27 Feb 2026 02:11:49 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-mm@kvack.org, Dmitry Vyukov <dvyukov@google.com>,
        lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>,
        Daniel Lustig <dlustig@nvidia.com>, Akira Yokosawa <akiyks@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        David Howells <dhowells@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>, Boqun Feng <boqun@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>, Marco Elver <elver@google.com>
Subject: Re: [BUG] Memory ordering between kmalloc() and kfree()? it's
 confusing!
Message-ID: <aaB-1e1LoxkcYl2f@hyeyoo>
References: <aZ_lJAqxh_hNGr_v@hyeyoo>
 <9dcd02b9-42da-455d-aa08-165e6ff0b921@rowland.harvard.edu>
 <aaByMLSAIJM8HdbO@hyeyoo>
 <d8308828-ed28-4650-8c8f-22a7e5cfd1a0@rowland.harvard.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8308828-ed28-4650-8c8f-22a7e5cfd1a0@rowland.harvard.edu>
X-ClientProxiedBy: SEWP216CA0121.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS7PR10MB5102:EE_
X-MS-Office365-Filtering-Correlation-Id: 64268545-f423-45d4-a979-08de755a2800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	h6y08yjRN4qH5NCsUcYtuQUFct8GrOp0g+Z0edWZdC/o9MbwOrIlOP+9MeIL2OfcY/uWD0nHuz/dnHXjisByBWM8HUpSqs1N1Obo4mBnSnhK2FAJRgdRX+n5uIMqUS8CP2UxdSs9r7/SfJaDiZDnXY6B0pcCKkGme06tMgVMJACKdsnKYOH1+Q4UJ2NK8VIAjBZ0Lr/LhpBZ5yz6//khzhEmBBZBK2IWi8hdpKrVcVrqtEUfCGP3xf4XymNLjrAKCGowd4/eiEG6DwVHQVa/+i6bprJaqXYAWkHytGo2QHElivfH8+Ioe9alP+IA5O3ykIk1DU2TRt8ztSrsUPuolGh8MvYa843KOelK7+8FQ1UUdkRCJpjkhSuJMy9FXBJbcZMdkgzwAr4okrI4/YEE823gSc4V6TpnLFx1qJ8ngaxi2JYdWembTh9dEHlvv1hchcEk8BEqsqLigwCYJKoHzW88n0YbdjTrNFDKNYzWOpd/q4imlm8FZ6NMRExnJdhLxf9WODqbWboSWaMWKwWjxahvZrkogqol9N5Q6/matDBot14n0KD/b30n/kLYDkmyI/o2xW/D8E38mAUxDBy/9Ogxa6BxPUMQshtuWD20wyaNyNIAnuGWUvpl/4u5VBxt6tcrXwvIrXD81YJxlGlv36l4xUgXkWgJjeTvcDhpNE/VmUPz/nF70WJDk5W3qF83kpzNajrsUIMxxxip1N7Xn9HtUkeeMbTsdbOhrQ3b06g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FS1qd0Y2tGrgZlBXyiwb+V1kfIX0q7aTNPWAhrifTYXfmvQSott6QoBBRt7t?=
 =?us-ascii?Q?BQhQuA6jZZnwzzdJo3T6dF6sVLnEjCm8Yw2eshyBmUduRXyh3tqpNzMy4JM7?=
 =?us-ascii?Q?CrqUz1xQYVbrCJEu7zaGieIUwflB6m8OXozJleIayplMAtMLrV2P6DAliEiB?=
 =?us-ascii?Q?QpjAiv+3bKhaugJ72udSrJlsuDSWSu5DJMIcvTlhMv2VHQdCb1vJCkWxVTkK?=
 =?us-ascii?Q?ayyRrlJnsIpo5fZvAlfGw5BblN3tX4+IinZszX/Sxv2nAj3XG57JdsjXb2nL?=
 =?us-ascii?Q?3lqeMiLBIt0LP9Z3s4MdUTvqx6MRnhq7dIWf9Z0eAgLKE1x7KKpbRBM6nF2r?=
 =?us-ascii?Q?jhTbazAwFwDS/j8PUhVHz6PdktZvOvRc+SNeQLZov3ThXhsRNvqWV6MfvcZL?=
 =?us-ascii?Q?zDXdh02ITgC+Yr++zSFSRss3iTxuM5Uxv2aawCGsdgPxL/gI3yDm9fNiFBsn?=
 =?us-ascii?Q?fi1C9XSaJk7txd2OwBUo5QtEjMBvH0r7gOIoCb2MUSaTObDHj2uBNvi8cGOw?=
 =?us-ascii?Q?XrF3GOmzV9hiw097HM2nAVdvdQBujqbMrS90qH33FQyN9DrqIHvK9J8+ZKcJ?=
 =?us-ascii?Q?9xJNpCN6lf4sgioILe135JPdDSOK4j87Az3Yqsw4xKJWEOoAIiRI4NJFByfA?=
 =?us-ascii?Q?CvC7c9QaZVCFWSv14GBkh36xFSA8mxn/0GFST1PuSuInA9Lrke5wr3Zdk2Dd?=
 =?us-ascii?Q?4i4q53T2C7O/2DLj5ZwG0XHn6PzEHVOvqD9TuBjteFNXUlwtz/IYC/iVUfur?=
 =?us-ascii?Q?9M6Kvl6q3+eY6lRbiEgUsM7IKBqYabw6VIZcF80A9k6hijFScjZarFh7Orx7?=
 =?us-ascii?Q?tYJ5TeW5gUihJAyuIs+zu4FoNMqxQeIjjuCjw7BvpsNAEQIwYMKCbuCt6Nt0?=
 =?us-ascii?Q?mtHPfvvurQjY4+6Fd4qQhdGRDgPhIi+968RTFAE5EItgJ6t8T8QNPJ6X/KBW?=
 =?us-ascii?Q?MWv6KvYmyqVOExFWIu9kOVYSt//FpJWk1fFUuNw7EFwBBXpZolcGUR956yCg?=
 =?us-ascii?Q?JaGvBSg/LtF2GOY/fNGZk4YfwgskwRoM30uR3eUTucZXe9sPpp4n4u8a+N7g?=
 =?us-ascii?Q?5jI8Sp9O6TUwnfbLTzyXDwD43xxURM/J6JorUKPxwI4mfH8nxeqj8bphln+N?=
 =?us-ascii?Q?EitF6w4qseCs7H3uCPUuMv7W8FqrE20Bl7xV5bNoRLMIcYjy+8k77N5oCoBm?=
 =?us-ascii?Q?FJi7OyTwFlTkpVb6K5uMTS2F1r8ac8y2nXMgAgvFT50VeAlB/dJ1ybSGELAg?=
 =?us-ascii?Q?aQry4DcsM8NA5a6qz2DbtTF9V1RK+c5uSltZ91VYlW/pAIFbYhTDZFjDn4mG?=
 =?us-ascii?Q?g4NCuv/+xPCnX7DnbB6IgSx0CYRu8Oxfv8j38hyk9U7kqzEFtthRsfRdtwu1?=
 =?us-ascii?Q?eVMxnz23jgKbAlk5ybIk/Oil9pRqSIcns2rGathZ/q45AT8q13c4dqmJyKb/?=
 =?us-ascii?Q?EJQkhTlt1cl4z6VSW0nW5LH9SQ/1bG6ZnxfbaQbfyil8zyHvwySV51GWMe0u?=
 =?us-ascii?Q?t9i3Eld6bXWX9exKNNkmdyjqxCRDHsX4qeb+RIxuBS+boqv/JhgAxyHhAIq7?=
 =?us-ascii?Q?gOthgfTpnkczqidyzrtueW0cqcDiTc+gKx+k3wSuqFKURpQkNn+KPLrHLej3?=
 =?us-ascii?Q?Ie3siLEVQWvNPgSJQy6401aN8Vka6ezn6CiSjH5LCJsI0Y+i20UIUoJE8Buj?=
 =?us-ascii?Q?D0ywhmiM1mW06BBN4OYFIWhpKBimxyDQlP9sOW2Pj+etMUdHr+/Etkv+ZZTP?=
 =?us-ascii?Q?6vspteF/qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nFABLcN3H329KDvVKrMqZ8ImKgZ0ooWw54TWftWwbvnYMjy3SeG5y1bi/oVyYsSXENWUfUyMo/c1zXf9L4lmgslbaMuD++C64OXwCuwGQaPprAiLVYSjLdiGoGQ0HwjsPAxLsyCSfLJs11wDC8oQBBOWpJL0iNWiupVgw57e1BYMHumn9w7MlY1q6r52OpB+NrzGFZsAIt0pqd+JAJtjeKSzYhE6Opi3QHoEzBVRn4SFPB/rCPDluymR2JouaBbAj+bZFrT+hd8pmsohQ2v4OW3gfN5VicsXBCogk6Cib89y2N5vdGTgo4WVP7fITjhVtz+yDqdkO6Yr6p5t0ZoHj0aq53NqA51oBRU2WXn+dU95gI/43qpLTRmFjuMNb4livqmELfTIB3CSX3SSLlxCfQlzoi8ax76e5FoSavufRfeaqI1+RCmItQ4cP2JiM9bksM9p7fMot2Mwt49GLT2uo9zeFwJVt+aAu9ayzIsAHhKRNJE7KDfXXEbafqmTlir4Z3x0cXJRN3I5aSoeEVISwXSGcnnfNRcUGt7V65V0PKgkhPKmhR1QW0ppdohVPicNcrWOOnnX7NlmdXLBqAEvYNvnMhzZa89uZ+DZs1xbHKQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64268545-f423-45d4-a979-08de755a2800
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 17:12:01.3555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zh43F+MTMDzxNogkVXmIroKFHgbffN00odqwy1Q3tsx0gVorqt92eN49hKjk9pfVpusi8OQvfACwiYrEoqJOBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5102
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260155
X-Authority-Analysis: v=2.4 cv=La0xKzfi c=1 sm=1 tr=0 ts=69a07ee9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=S2rfJWOyOT_BgKZ0uLQA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 2jCJoNuZv2Yss_EO2tySOWtTIkqlaEkb
X-Proofpoint-GUID: 2jCJoNuZv2Yss_EO2tySOWtTIkqlaEkb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE1NSBTYWx0ZWRfX7ri4JNeYr9Cr
 insSf0/G6DUIP8uamJnTgQnHPe7GHNqjqKkSuHOwRms+PdMGGTjmgCvMSQvWJHiGduaHjJ5HTtO
 WYCWGueoRljxoTDR/beDEB7u40JCFMWuvmrMBvRANxTam+VsBfEITMfIrksaCiVMSCaxhk3qT5d
 WA+SJtsuaRunLf0jfTKi4muFJHuUUIjOPRZ/1lr++FmcuRADbogP23I4BK0/IbmQUYpQ+3/AotD
 9m2UDo8L92SDBq1fVXgJvXtvK4O0t0dbXVO5ClS9OWroSgFaCRlmo9lsN6csj3OKX9qAe3SHd9o
 xY9qV6jbnfy9MMHm1mzm6SWwU/phJlVii9s8WTI/Oz89YT4/sdwLTkakIyqqlUDX6PpqMU1JGwf
 gXFUG6KH0sP1twNZBR8Nna/eyQBNdTGOXqKld3Q3cEMBI2X66frbH5P/P5w/Ayq7mrq/rwnbWGi
 xkCQ8xDhi/nOoyXhykg==

On Thu, Feb 26, 2026 at 11:42:02AM -0500, Alan Stern wrote:
> On Fri, Feb 27, 2026 at 01:17:52AM +0900, Harry Yoo wrote:
> > On Thu, Feb 26, 2026 at 10:45:55AM -0500, Alan Stern wrote:
> > > On Thu, Feb 26, 2026 at 03:35:08PM +0900, Harry Yoo wrote:
> > > > Because the slab allocator itself doesn't guarantee that such
> > > > barriers are invoked within the allocator, it relies on users to
> > > > do this when needed.
> > > 
> > > It doesn't?  Then how does the slab allocator guarantee that two 
> > > different CPUs won't try to perform allocations or deallocations from 
> > > the same slab at the same time, messing everything up?
> > 
> > Ah, alloc/free slowpaths do use cmpxchg128 or spinlock and
> > don't mess things up.
> > 
> > But fastpath allocs/frees are served from percpu array that is protected
> > by a local_lock. local_lock has a compiler barrier in it, but that's
> > not enough.
> 
> If those things rely on a percpu array, how can one CPU possibly 
> manipulate a resource (slab or something else) that was changed by a 
> different CPU?

AFAICT that shouldn't happen within the slab allocator.

> The whole point of percpu data structures is that each 
> CPU gets its own copy.

Exactly.

But I'm not talking about what happens within the allocator,
but rather, about what slab expects to happen outside the allocator.

Something like this:

CPU X				CPU Y
ptr = kmalloc();
WRITE_ONCE(gp, ptr);
				if (p = READ_ONCE(gp))
					kfree(p);

Yes, it's a crazy thing to do. CPU Y isn't guaranteed to see
up-to-date version of object content or metadata.

Instead, the code should do:

CPU X				CPU Y
ptr = kmalloc();
gp = smp_store_release(&gp, ptr);

				if (p = smp_load_acquire(&gp))
					kfree(p);

One reason that I started this discussion was to argue that we should
have a well-defined a contract between the slab allocator and its users.

-- 
Cheers,
Harry / Hyeonggon
