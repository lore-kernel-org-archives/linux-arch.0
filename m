Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C4F44D6A8;
	Thu, 26 Feb 2026 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122742; cv=fail; b=mkXrAe+1/kptddO1pd7EwOvfhiHGkOFDb4ILwKlcDC7UIs+sxNmzOw4LZPqVZ3d6B8ImdPR4p1JOX0PFaMZpIPahjjL2X3BwV8swPgp2jp9mXv+RQPZdgFW1/zLXSXHuA0tSglqz4s13kdkQSJhtKTg9LSHVCY1ahtNo2fn6y4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122742; c=relaxed/simple;
	bh=GmKQGf3+StA3HUfEDADl/JvCjGEUDc/ErqIr+WEeY/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MFVs/P1oPd7yJ2p31cyG2ZAxjiIj/BO18SVJA67/0zhqMsGdMO4MpwUZAmhOoncMpF9PPMSBsRzzBZ9ZpDcuNzCJiarHg2UkBosXJIpwdH7HK+x3siKRL36o6GcWsdwgJ3y3wjqvVvRkHt1y7Cqmrq5AmYncvCm8EfO5sms0XZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XfZ8J/RC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LYJd0ZsS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XfZ8J/RC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LYJd0ZsS"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QDNLTO1973013;
	Thu, 26 Feb 2026 16:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/2iVJAfk25c2aDZkMj
	4U2lX/ly243PCVlIMZnD5CRjo=; b=XfZ8J/RC9oJy9er0awunV4LmpIglby9fRZ
	Lnf1tl8zJgzlxMmcdZklz+/3+Q7v0JLINTRmHs2cag0JNM0AFTxMCuo2C7TVL0i6
	XebEcGJDPgtRg2NSyH0g4Z+3vxGGkpX8xFRPyIdN+BZMI1kU+mA/JFzmxAaq5JnR
	8KLWF7Khb215ycQeDxSD+i5/vAx3Wmh1Utk4eiLYVOXUrJdZvyO5afWtMoxUxkCh
	gFZS4zuPEobMwB+HhcHaV/Q49j+uzmeEgTSAxfIZlxN3dIbFbuJ0RBR/ecZym4X1
	9b/Fcr4M/AEzT+6ieGahR8v5nJwMXJeUqDUKsad4nAjQDFRL3FiA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjgs00wrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 16:18:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61QEiVR3028444;
	Thu, 26 Feb 2026 16:18:09 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35cnu06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 16:18:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRfrcchPjSZYW88ssZV9wGKNqacCsXIRCg5vhnxM4nE06yYA4iPPA8ZiQoU46cMTnR4V9M1ACzZ3xewQBQVBYzJyZ5j5COtBNZJObPMs4zKz1ef+cyXwuFa/cnWNDbjsdXCnE997LKeIsth3GUghM95T8CUoqkktA/+EQ2HhkTG8BZ0rZEN+0Y35CN711ZhrlCJXaM2tOgdmLfJ8BdHW00Ucug/YN8I366hkb6lajKWg5lvPRdizRtIONxkocNX/+BU7fcex3v5L8icmHFQuwkBH963CXbjBsr00iKvl6DMfAF0T8Tk+HzUBVcyUD4X5zFRiX4qZf/gYP6LFhBOTmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2iVJAfk25c2aDZkMj4U2lX/ly243PCVlIMZnD5CRjo=;
 b=x8ItLT8aURH/VM3vJN7oS9WsFZwt2yxWuLvZtsiIxVsYPa7yQe7kJypw1VXiajhUTNDfyzlPaZH30aSmR0WpoKMxBaM+p+wiNAVhWO7jISUX0GPZKSP5uHHBbJ/3rGjKriZOzWvjamM5JPfxOnaqjVXqlcC6Bw8O2VA3o75IkOcdRAci1tUVyaCumhIMJ8qqZ0gmpPMJA1uJ9uJ4bMGlTlKaTInYVrdtWlLykI+hLnSQxGRgOXC/VmGKHMV9RdYYuZbB3tEygZJjDlmuxjvYwgoDAe7qFWD9KEW7w8F9TDidoD7VFaCX86Iw65mZkoxQxqVgxT1JagyZi/8fCVAKCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2iVJAfk25c2aDZkMj4U2lX/ly243PCVlIMZnD5CRjo=;
 b=LYJd0ZsSkCIM+65UIUsXqUwy9702NhxmRq9hP29oKg7zJ8xsxStdU0hXlh0/darBsRzuoM2kL5TiGox452WCmML1iRPkQpiI4LUiZGS5ejsxvTq0m5X7EjHX1CyAhq8NDZYdTcYByRUEo6YDO0olevobxGbwDcfAaWPAe1yI8I4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MN6PR10MB8094.namprd10.prod.outlook.com (2603:10b6:208:4ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 16:18:04 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 16:18:04 +0000
Date: Fri, 27 Feb 2026 01:17:52 +0900
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
Message-ID: <aaByMLSAIJM8HdbO@hyeyoo>
References: <aZ_lJAqxh_hNGr_v@hyeyoo>
 <9dcd02b9-42da-455d-aa08-165e6ff0b921@rowland.harvard.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dcd02b9-42da-455d-aa08-165e6ff0b921@rowland.harvard.edu>
X-ClientProxiedBy: SEWP216CA0092.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MN6PR10MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 283e5596-0458-44b6-10fd-08de75529e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	tSyz44nNUozeOwZRcM+6TKcFuhmytGaakO4G+hLCilrMoeS5Lci9s74UzuXy7I8usB1MBiN6oJqy0l2TBXZ6zVWGuEsPXIAvHjXVx69H3I4bXViBb02yHt4uVorksSO88IgLV8dlmSiWTSA0Ax0gawfU2eMm2iYaMz4K6dEfEvZS1fz7W+o7bciHfgKzX9Buf9L+gouIwQVuQKCAXU5eo28hYXB1NsxR31UfrAVdFGNDUufQRoNXL7yI8ODdieN+/tt+aCvUO1TyGE2lkVREkEqoJ+RHrDqyRKsRgxGvLwKHnmv9qweV0cK/bFTmyOQFMyuTlpEaH10br2AiegV91zwLlO32ymRUok44790lPtDWMshchZLvYriOEM/OjHSQSXKdDvoihttrMS+WV/njViSZ/QdZtgmSbpM+c9fCHeCRJaNXN3QSZHTuN1xlBUPJR3ABp9MlSB75DdSDAeZYY+eu5GxbSdWPiN3QP8tNRQv69VlyJkNJ8r5rt6EUqluoq5o9O0B8KxBIVSDswr+qeBEpkMCBiHrHm7EDK2ehVk4IiEc0afXARztMs8iexyTErTT3jH08xjHCVO9Hmydw/R8wk8EZTcTkTQrLhv/x9VKVuxqTjE7yHQ7M+F4G99DaDWD6Ep0k6GX8agkNYERND35aHYpszZdb1x3XZX02p85AmWezIne4Cjisw1kfZWnsXg13TUafDKTGOTWv/M3AJXgFaYmZxC09fMcN9CJaF6A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kaJSGLT6H+o+cTPF34dtgap7iws0yOkOdbQCdogisirmCQSmTwJWyFhd3RcK?=
 =?us-ascii?Q?lZJ0tVdVAtJ5qByBd/+Nz5aPNDwqq3RGJyIIf1CNU1PtrY0BAljLbVH06ycc?=
 =?us-ascii?Q?RqTAQY6GPIMZkhaPfZMpBoaQ1BY5nRpfKLACzm5AH7fogWVEk4zYnCPwpzCj?=
 =?us-ascii?Q?8WpK8tQJD83IeyLxufvlQ0ePsGCufzJQJs0kKIMINfX0XCAz32T4acjgcOTH?=
 =?us-ascii?Q?sYNqYo4YQ2tP5FHhdVLF/OpnSN/U+ZCVbaF6lOX25LUepE5IIIyhB2i+TNKG?=
 =?us-ascii?Q?Yj1st1/29mJZ22v+xzt2DtE/hTZ4WrA2cZF67mrfElO5EhPrmKeVKiCiDU6R?=
 =?us-ascii?Q?U0JX4Hy3YNusJ1IWtrRVm1NBxXw+ldbOuJ+iqQ2o7VFaPis1o44rHTNCOmYg?=
 =?us-ascii?Q?3NDDgxvvdgdhlhRu1AxBquga1jJVJ5SnnDa75Bc0KBm+e4E+4tO2hAC4+kYj?=
 =?us-ascii?Q?k8C+OXqYMBxiHx5T/XA7VrFywYwsOFhfGw7+83hnGBq/96dXaZSb7pbqiIk5?=
 =?us-ascii?Q?BovwnepmC24CdJ5vZLSZHLThqcFs6HurNhI+PirEV/kuO1EIWhLMj+uf8KrC?=
 =?us-ascii?Q?wMyNQ8ihic1KkjW3uj1fZK+3Cgx8xht2EGBo/cSTYwShxBh/2ybXnuBk9Qv7?=
 =?us-ascii?Q?xGW70groF/exqzh+WPH62zeNFfgMu2qDxbr1M5BO6iXJ1k/L7zOwiOX5Rb6a?=
 =?us-ascii?Q?kPSenIqLPbZlI6JbIetZjwI0lRhWxKydlCn+0OotTm61woUfoFtL8mWJ7n2w?=
 =?us-ascii?Q?JwayyvkuieNihGJhbmM+dkRKS8j6n2KJ01PBfzZ8kpivEqELeEXOoprRx+kd?=
 =?us-ascii?Q?iDcCIzbFmsIWuCYaiS6Zlae2TbZrQ474hgC7NXUocJTGm20iuKiIA1U6tzI6?=
 =?us-ascii?Q?L0Puf6n4QlRKdlXqB50t/U+UPP/HKUhUXb34ApMHOTZ5701Atpb1enyk9i6G?=
 =?us-ascii?Q?ORyKR/apyLufK8v8CGqbBLUds6knSk4fzrmLZBvilQCiJVqMQIEU9bJMXBOG?=
 =?us-ascii?Q?64tpM24XlhObviOhbg6/XP0WPph/XlW34VKgEryAuLKjujP4Xrg2f8ErlLdw?=
 =?us-ascii?Q?YauPo5f/sZwncs6RNUs1ZGi+TLdgj/Hw1ua4U6fXcmNpVngAWwdLLy7v4hOc?=
 =?us-ascii?Q?w063LUleYcAJNMLarT3T8dEHKJlZWEzpppbJUAF31Xo9DalE90yoHVle/f2i?=
 =?us-ascii?Q?s6aPivFjN8BpwuxcV2/4Bst4ijPf0t8VRbn2Qf4FQUSWU16HdkfRTlfGHn6g?=
 =?us-ascii?Q?S4UGi1e/ykllBPKDe4MMik1/lHbA9+7WaFc9l0dG9xBTDIFxUcSu5B19o/OO?=
 =?us-ascii?Q?0G3d8xgZ75eXMdZdrhu6POc8eIkTMXNkGx0f0VNVKlLIQWVK5RyT8eAx7i/X?=
 =?us-ascii?Q?1hkklKbprOJcdq/uNZhZkqma6DYXYCkaJwESQ7Fzhc0Uj696vxMuQY7Jt9ok?=
 =?us-ascii?Q?tFC80yCU6/y3kTbtuFHaaTJzYhIhQmUruKKxrONpyOcFqt4F9HvY0iOH/GQW?=
 =?us-ascii?Q?zUVnziZVUecmCdj4KhUJYOCSlZ87QQ1rilt0nNkhua+0pKklmgAg2z+ei/g7?=
 =?us-ascii?Q?UDEAeNaqUsLdsjVqBWbmFNvFF16KjAq7GU2ym9MG4hvqFt6mrb15BZikk5ig?=
 =?us-ascii?Q?y0/GHYmnHg4rLAo0NY3iXhO9Mx4DYOSRh5msryNEIW1B+FMWvPncPpatcqZj?=
 =?us-ascii?Q?P0rovEYd7SG0g9G/SBpNziy7pG/+Rj9y5rbB7aefZW1T+5K1psN1T4C3QHvF?=
 =?us-ascii?Q?wkIWsEE1Pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zhm28wjmAeFAARSxbJwVkb/4ymWMMKVCERcA4AxsqWRGB4FeeQaeBF5DZMtFdiGfsSY3w0tfVe/E9vTWZ7s3dbzFcAsiy6sZWlvlzaYuZa5ERuv/Qpkgtg/yE+xlGBiK0RpuyNRn/JvNRpYVJZ+tP0u8wzce0vTPp34a698jxDpR3SdCe/04FdjqHXhcRaxQ+9zpBMR83mtbpeIlmWQ0zX+Ze3KzR5dM3jr/lMB0EffNK1nbf1AdPfACtkJ6xZrBug1jW7T3D7PdCFbPwIeN9koAjHfWShYy6j54HHYRb5+3PfiSW31PDArgUr5mAPmihuUCjqzUQ+gUPn/9zT0H05m+X+OcAHqnlCKRJH1qPZIO6MyEwqNIs6Cslsva3Dr0D3xOTyxs77edk+3CJzSQ6T4XAHvbVEaIMdftA7Ts/cN8YMLNhyMn8NqQJjnUcLPLnMVu+gcHM+D9SoBHnb/l9jjBf+f7bUX0SKMYJQHY3ROfNJnYa4KIFjrSZYbW5d/AbZrnqbtNy3msnXLMtG8kw0HAWqbDND5C5YNnIuxpJHskceCfogrmqU2sol7oOIo752ev4wP9B8SIJL6r42lxMlfE3Wl+fpDxg5XkUei9yyI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283e5596-0458-44b6-10fd-08de75529e3e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:18:03.9826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1krZb0yTXIt7p1HADGEF8NIKGS25WLKSoufajIvIHdLw5Vz2aLv6L2cdeBH7/6X9q+IttZlgO3+BRa6CsqX8UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8094
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260146
X-Authority-Analysis: v=2.4 cv=BKK+bVQG c=1 sm=1 tr=0 ts=69a07242 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=Hhkurpn_UomcOeeUT90A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE0NiBTYWx0ZWRfX+V9RMF32C0kC
 YWuXbtKI9u9W88PsYhpTQ0vtOj4DKydBAQ2m4kvp3xefvzCt1Y5yIEJB53WgVvRZ1P/Wu7ICQGS
 mQMR0FX+MSZApCoODF9KQ75vOk2qgbRl5BfjPACALDda6QhsQMeoDoQH84KLKLUKt16arftqjXR
 j9eMrGn/cz9RaAZly8WQ1yLA1D8L2rl452Tp+sVIb6k7eCAUUXkkZd9iyxYBgvsJf7l2esX7MTk
 e9EXb+7w0elsaodO6tb5VqxDkYg7R25PmrY8OORYA0U9cckqJqTUIyjl0aiVSRFh061+KBDvcJi
 wHWv4b7KZob5YPoVHzr0mwozgu+d1QOIY4OZyugYc598jArNzJk1lFfFzzp1t47lgshZ9Zp6hAk
 d3bXx2knKET7cbFSAz/MneMAsX8RxVSp4FmZ1s1r7xYUBgrkh+g25je9LgXRND0jEGckw+d2bcq
 LztdXPoYRsxXEoaZvHw==
X-Proofpoint-ORIG-GUID: tMcU2tDGSR8ERBqaWzpJyxLpp_4Og8CC
X-Proofpoint-GUID: tMcU2tDGSR8ERBqaWzpJyxLpp_4Og8CC

On Thu, Feb 26, 2026 at 10:45:55AM -0500, Alan Stern wrote:
> On Thu, Feb 26, 2026 at 03:35:08PM +0900, Harry Yoo wrote:
> > Hello, SLAB, LKMM, and KCSAN folks!
> > 
> > I'd like to discuss slab's assumption on users regarding memory ordering.
> > 
> > Recently, I've been investigating an interesting slab memory ordering
> > issue [3] [4] in v7.0-rc1, which made me think about memory ordering
> > for slab objects.
> > 
> > But without answering "What does slab expect users to do for correct
> > operation?", I kept getting puzzled, and my brain hurt too much :/
> > I'm writing things down to stop getting confused :)
> > 
> > Since I have never thought about this before, my reasoning could be
> > partially or entirely incorrect. If so, please kindly let me know.
> > 
> > # Slab's assumption: Stores to object, its metadata, or struct slab
> > # must be visible to the CPU that frees the object, when it is
> > # passed to kfree(). It's users' responsibility to guarantee that.
> > 
> > When the slab allocator allocates an object, it updates its metadata and
> > struct slab fields. After allocation, the user of slab updates object's
> > content. As long as the object is freed on the same CPU that it was
> > allocated, kfree() can see those stores (A CPU must be able to see
> > what's in its store buffer), so no problem!
> > 
> > However, when e.g.) the pointer to object is stored in a shared variable
> > and then freed on a different CPU, things become trickier.
> > 
> > In this case, I think it's fair for the slab allocator to assume that:
> > 
> >   1) Such stores must involve _at least_ a release barrier
> >      (for example, via {cmp,}xchg{,_release}, or smp_store_release())
> >      to ensure preceding stores are visible to other CPUs before
> >      the pointer store becomes visible, and
> > 
> >   2) The CPU that frees an object must invoke at least an acquire
> >      barrier to ensure that stores to object content / metadata, etc.,
> >      are visible to the freeing CPU when it calls kfree().
> > 
> > Because the slab allocator itself doesn't guarantee that such
> > barriers are invoked within the allocator, it relies on users to
> > do this when needed.
> 
> It doesn't?  Then how does the slab allocator guarantee that two 
> different CPUs won't try to perform allocations or deallocations from 
> the same slab at the same time, messing everything up?

Ah, alloc/free slowpaths do use cmpxchg128 or spinlock and
don't mess things up.

But fastpath allocs/frees are served from percpu array that is protected
by a local_lock. local_lock has a compiler barrier in it, but that's
not enough.

> Can you explain how this is meant to work, for those of us who don't 
> know anything about the slab allocator's internal mechanism?

-- 
Cheers,
Harry / Hyeonggon
