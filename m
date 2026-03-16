Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F4F285CAA;
	Mon, 16 Mar 2026 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625075; cv=fail; b=BPdxEw+7x0IOILeusbb3iKGL/IYMk4thr2EKPT6qsI4bRgtda1I/YQH5dOsbR5K3bpLdjW0GWBO8l+14SSb+JriBEBxjEZYnQrGZNw20ZRZX8uo4V95ad8LWQncpM8Lv9nAj2QQfSlOh9odYcc2tvRGY9Kersh/7EpzWlO42Z2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625075; c=relaxed/simple;
	bh=Ma3+LLvRNlnb9rpI/GexQynajwIoSrQH8Zz5qEdytqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pKZqrfaTj4Y4daQLH6n3qE0kNpMD5Mfy0T4gIem4csSEzniCKtyFhEZfm74CFiEgYZiuUBScL/DCErOgAwIMPDKOY+k1ihXmBueXpnZDTAw/hcEQ4vKQ8p7kcOQCpAzBZCZpOgvjTCtERYzpWDBhnVpOl7AOeZkfcnXmPiL03lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aF44jZTp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dhbZj415; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aF44jZTp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dhbZj415"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G0d4UN2998684;
	Mon, 16 Mar 2026 01:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JL5DIg/fCw9vB94OcC1DQAGQTB4WeTAPUwqJ5Tkeiqc=; b=
	aF44jZTpEmyDH6s4XF449WInul9OF1xSwIx136/j3NRXYa8SGlH77vcNRsbVk4cq
	3I3hNJUl+sgwq+4p4Op+p+AvjvnzHXhco+iISLn823xTNVNRe93IyrKVV85hHpkd
	eUAEkKNO+G6Y36ISrjweTCs/HpU8hOMnxvxAQ2ubOvRBKrhhVpromCdjaYy9T4T+
	V/97xXGNu89k60YnxQmMye6yOofRf5W4czUaQQN47/uN8V5u8TB4csC02NGZLEYV
	shh5xZV4jBlGXX6WZ9VuIiKtNgFM28KXpD1oa02JAvJ0dYM4f73f1CvzapJbD4/l
	PTeWjJiiP6qOWbGX6mlEVw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyqbsb1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62FM0Fjh014043;
	Mon, 16 Mar 2026 01:37:26 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4802ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9nsItvHvoRWDAHrZxMlYxIQKDpud6Bjpwjiqd92s0fHfKnrAOX60RhuZwuJGHf5iQ23GrZPD1p+sXYeXB5yGjJdMDvloSZco7EdMMTBuadTRF2IUxHixzNNVvG1nFu8reTCSRB2ZPR78BHhnm8q0BsntwQSn4rgQ/y0XR2FGWgyNF6UsnLr6kPFU/uGp2VBFQfCL1edbWQcNpSQen45gDJzp46FjnVrHa4O5W1bNwL+vxGV/GZOLDC0qjx1YwKBorxb6uXUhWWJnETIgfrlq/I9Qqrjp9fAJZMJphk4bt5ITHKj9YE8sDz89Slebw9MMl0vqY9irqbYisMnM6ITfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL5DIg/fCw9vB94OcC1DQAGQTB4WeTAPUwqJ5Tkeiqc=;
 b=gaYKp4Tkx3gkdifO69PQsIcaNIohJRPi1evteSoSa12LC8JlCYrZCMBYiVVcCZ5RJixy6FBTx0ASlG3RW5FfpXknRQTz5tjp1PpmOJJGcvwEt8uo9ep+f4sRfrACBzzdkJ0nilXwY3LpOSrZ2OqbhRzzpi7EnOJ7l/NuIrPDrkWyrsACAulhpyVl8pa627lBldqS+OcQgXtfj1mlQW2E4Fn6PZo7B/21NJxTG0NT9QFpFwMpntYq7Ir4FDc73bRGMMUuhitTVXybjoh2w71BD7UyYrgQ9SvmGkwvMxnBZkBNnHrcalnhtHi3Vjf7TCgQgpY0ycAEMsJRm2S4Qk/2Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL5DIg/fCw9vB94OcC1DQAGQTB4WeTAPUwqJ5Tkeiqc=;
 b=dhbZj415e3HFCceV/bjMA9m4ttExkpg4yzj+fYkc1Pi/Ng8cFeQvzlpMDk4GqGWkQ2Z36BMSbDtZeSLedJP6mgPtnCNhTcLVczuaTjhfXMDuDSDtlK99zSUGjzctCTL72jpJVPn4oyZHGkYblE584SomL4TUeRq+ifb400nrWbw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA2PR10MB4571.namprd10.prod.outlook.com (2603:10b6:806:11d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 01:37:23 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 01:37:23 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v10 12/12] cpuidle/poll_state: Wait for need-resched via tif_need_resched_relaxed_wait()
Date: Sun, 15 Mar 2026 18:36:51 -0700
Message-Id: <20260316013651.3225328-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:303:b8::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA2PR10MB4571:EE_
X-MS-Office365-Filtering-Correlation-Id: 2963861a-b182-4a8a-72f2-08de82fc9215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YDKQgJtFDZFv4sQL/AWbevtzdxUa5MjAOSXX/qWwNJc3cVQO36Rdc9c2jLN7eVmuXpyUxPnCoknqOWrRmnwZx8DwfPtM436F/GPgt1mm+zohZsL4mmp6R1aVBOSTaLVqdno/LQgHEvuXyTXueLTuAnUPmPaRMl/r6W/xo1chJ/uEBkWg7kMrQYVegooM9zsGOPgGbsyvQieHHn61rBpQEu739TigaKpP0NwcVX2VOmvLGR6UmfFtZlNJw+sdvtBEdTNi6YSI5Iz5ZN0jbsfELBmvNey9VrzPrhKx5TVySrpX7cpbWW5aytVB7wNhepWq4gaGQkIaigDchn0V5Bd3R38Jts+tR3A7hmo8KoC436GF12MhGw/JnbBd9ECFB4cRQbfPWXfEwS0nJmhoCQqmDqR7POEajerTylxEVEiEWtNS6+QtuLUrIXSRkLsVCpfCoRN52V80t9M0jnMp7KXustG2BQV0Yai9gQT9xq7Z7SC9togx7ik0l4JJlVKNwHM25S131RKM5vVEtxIuy1b/a1jd5flZJHHRZtvYSE8oGAGsYwGhc8Hb6WA1CAQecr/sFlz7/aH3aoTjzh682xLYOT9ubNMG8+XtbFY7DOLXcQu09FcVfiJ5Faclsg3Og2pGRCvgsS3bkHr+MCHOue/AVVv2Q61H3IhUHLFWhAFGkfblnHdwRaag5rWVMXql/cPnnU5EScq6w8YLaIpiaBa7hqCAANjPixYkzQycerdHiac=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sy6ReswyNe/bFXCtkfsUYsGA+5H3+3flowyjGWqQD1MfzE7TIceFkDqwmyx5?=
 =?us-ascii?Q?91eMMUNIiGbLntzWcwayMwz9oEiKCk89EmOER+XhUyC9uonB1Dk7e8MfmFgu?=
 =?us-ascii?Q?E/AuD+qei47vrtsPcCp3QECoNmtu4ViMf8P8GODAQHFlvfTo9I34/y7KmUy1?=
 =?us-ascii?Q?2wfa1+jwSIUdfPOdsebVdy9XMe8WpMamPkCuf7vdgsL/PjldvsokClPlMVoe?=
 =?us-ascii?Q?HrkiuNR8wdbQZGYwEh5f3rlKtfLAf2Nz56tTQJFKprSZwmgDdeQMZ2XEI+Tv?=
 =?us-ascii?Q?B3XK1XNsY4OcSvWKgXNPhgJMvasacIsSI6a+BTULzMatTgUaAvlBosvdK5wP?=
 =?us-ascii?Q?l5IiZWTPcnhaEkzhKGUZiIohAVJAWFE/udpO24BIRr1YmvxRXiijD/g/RePq?=
 =?us-ascii?Q?0Sq1ESg0GfpXORK6S/sA8bEIAR7PbiWcLWsu1Ps7P6akiVkpU7cWFVtNH1bY?=
 =?us-ascii?Q?AZlHsXNQ2SSBfBL3qhexD6p1QL+og5W+9qlTPwx7V4xdkd81Ich0v8oniVp2?=
 =?us-ascii?Q?AFAyBSzUyk7rkB/Ngrwc1zUPqVECveSFZaV+MH0Zcg7N9NURItLwkSBCCTeO?=
 =?us-ascii?Q?GrM0RPxMfv4MwhOOuVwkYzBuk9OGsZ5gH3QKdu6Qsr4UurKhroRkyv6oTaCO?=
 =?us-ascii?Q?yq9m3gCqgFyC3d9xyOgTOpFk/ZJurTOWw+kRtnTGjlLZhls9p4tdwl18VECP?=
 =?us-ascii?Q?GJDJbrb5xXTUSegeL1F/VfFL6K1Si3WoCxWpXteCjL1e5VSWF130L9ll31PM?=
 =?us-ascii?Q?YGa3dy4bKHuiS84gG4H5h0LVH707fN0a+Gt/jbfplxsMyX6Mq6d1//0g+Ty/?=
 =?us-ascii?Q?UFSU2IwuHXB36k8a6Afnj2jAkyVd8auaXq24PHOdapg1aKxy7/TLid9z6wLO?=
 =?us-ascii?Q?yZJs0H3M69xBed8Hi9XQ3uU4RXr8gWL8NgD81zoIXuEnBRNoHVChfO+90Po1?=
 =?us-ascii?Q?edKIsoHB7ZeGc4AsrnWIt7s0npkVsgGWxdJ4IA37imiU/7r7FzIfUYh5+ve7?=
 =?us-ascii?Q?QXp7hJbh24H9iFkVdC+LYxHJDyY1lUFIdAojKTZM373lakj+xqcjWVCBUCY4?=
 =?us-ascii?Q?5DMI/lDDQbFv0wV86NwqlBSI1NsBmusQf/OeY3xaNVZqqavbMgKqYKsKtAH/?=
 =?us-ascii?Q?Ps7ApiVFmivRhNnZEOemgy94nvUvfevGRnWX3whaE2RfU0fcZEszTq+iXc0j?=
 =?us-ascii?Q?xx3QoGgWHzPwae6JRxpYq8NLElTk32/JO0k00qJFh7Q4LnkNEiYYt9S7VdX0?=
 =?us-ascii?Q?u78cnBaSlpJblXVLmcYhheV51FuQ8gYOxOxdiiPEw333FteP16WepKnUqRjz?=
 =?us-ascii?Q?s+Ll0btXUfvGFriQhi7/LEqeaMlwCpurtcVYvZfc5HljgesaX6thHRpoFEvX?=
 =?us-ascii?Q?6UXfYhWEVJIMtvLhFBoUqP55D/MRK74lDKRTYrvb+RIvym7FGmPTNN4rgW4B?=
 =?us-ascii?Q?HUDb8ECsyWFbKmaqF7XiNk3/hT+P3iYuDlNRGSwiButxJAWemig2hEZzUPTj?=
 =?us-ascii?Q?wE5E2nyTwNO7i4zz8Dt7gs2EfsnvNOHkUlgwqsXnyxeeomFv5SF0CWC3KHny?=
 =?us-ascii?Q?KXaoPA+jzuae0UpRNZG6tY98L6nrKJFOe0CRmSs240ubGANK8x7AhmbAjNcw?=
 =?us-ascii?Q?0RXK1XbKIC2r1tl6fig4T0w+2OtiIxYfL74c5BmPK17pomO8FDowWb0HrvwA?=
 =?us-ascii?Q?0PDzG/+yBTUwoaTri1R3CaEzhGL6W65Z35ln5ufqwS9eZcu1lr3O26Tn7hKI?=
 =?us-ascii?Q?LyZpX6DQxl9Nh0816QxRpXvJn2kj5ps=3D?=
X-Exchange-RoutingPolicyChecked:
	rv4BAPU7fyKyJVUaWdrtIvYZS9qUnNyhJTf/D3BSmxIsbqMXuLmp3oqN+0tNnJrIA5nhSQdi+YfXkvYq293yX0Se8ntTcbAvC6vDLsPB5or1ZXEBqQhwktQw5QYmmcDNQe1CHunANdzCl8O00XoYBLLrR2DmJ8h2WNo7pBiLfTJJ2KKrbuw/XSLKmdowqqnTFYTEok//uS0CFLJUe7v9cz0Fj7+Ofodq9FTTufpMZY69f6Y4enw/w/+Dydf4jSUUdeT5reWgwkBMRX81ju8wiYbdiLIK7T5+fXuAHk3ERB6xYarAM2RPynpHVVi9ipBN977OYKe7x8LE9rfY3E/qoA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5agshfjlk1UZkTfZPZP4Aj1Uck0V97o+xBXF4tGfd9+lcLtk6mLNI81Fi4+iriedusNjdKZaxCTMxzVcW+qVOZf3UW0ACzpjzv+WCp9+JBYR8AZ0Ks0XORNk1vNHkluW1vf9W1hCWJc7VpZxBrzc7o5T2XyV9mmXEFHED1G69DCYoGoqQCJalL+W0J/o4FaWu/jMql5GU5X8sBBzOlpUJybamLVfQusqP/CknKJSmdRGWw6T6kzu8D4leri0Gc7yXzrEinPNFkiXCD+1Sc2Fp9doIzQWoW5JP1v7ojRJvLyBJ6iKxPnT1Rv3UwlnRY6Uy01T60ZYnHvsqhsarxVT4OCYfkAL0JB6sOmEIunOyGtm98JpInbLGucAhLNAB5Cz8sjeajhiQhZFSn9GAtsoSaumN5AmsDrnll0scaIvFObDPgAJfyjx6CVF0wFrFGn3N+sPiRow6T9cbnkQqoSzO/5PwdpjchTISDRAgMXSoAGTYd+WQtlt3lIyqLSEadV86kSnSQ88sL1agLmC5Ix9DpfsV3mAjrK+DNF7PMa4E2BqWyIhyLFieN77V+LcaxT1n0heohJuiTlf3lDt88Ex0FTUXDtxkO3FaKhSoV/lo38=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2963861a-b182-4a8a-72f2-08de82fc9215
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 01:37:22.9882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4KdUAAF8LuTEbV4KfMGimHSSMCWKSwL0yqRk93ObC7Fa5sB+mp4LUBE/8agfUgwLsgd+yy4mDpGHW9ExYnYJViu0zS5Ccq+Kvvbc0s0fcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603160010
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAxMSBTYWx0ZWRfXxg1Ukh338bDn
 9D56BsoQ9Dn+IgZa8TWhk5WPHm4LLOCGCy5L0e9jWRxQk974XlgaNexdPRKQy0b0xx4gFj7jYqG
 cvYVI0BcpErx7H+74ZyoNluosT9ocr7xcAQmQrPHPEreIjv21A07c2PrxmnQVkKk8Ev1FDQvOf8
 gcBSVvEfA7HlI+JypPKrdA+PLZ9exl0uR63uv/9Gn8F6FmcxkMTRJZcTJeQjJ/hFk9aqkhtDCoj
 NHQLsS0j7Rqk4G3Cec5rQYzM7iDQ6uYrecu4uitLdpq3ublMzBCwJn61XQ99X3nRI5lIwKRxU1t
 xYdUYzzz0M4hkbtoPFMMCEBQ6TIz+g/d30QUc5UwsXIOTJDgQ69uYM+WyYquwW4h3NcJk8kbHgT
 YRCghnZkqS7hDwEP5UZ5WvsKJuRiMTuGQ/vBFMsi+kgRs18MIETwne083MkBnIqZ0OUuASJz+eJ
 YU4baoE3lVjh8KpF+Xw==
X-Authority-Analysis: v=2.4 cv=J8WnLQnS c=1 sm=1 tr=0 ts=69b75ed7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8
 a=7gr8-LgUhGOHEYCj_R8A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: e0Z97X9KEAjfQWDz4rS9d9M419EKDKy9
X-Proofpoint-ORIG-GUID: e0Z97X9KEAjfQWDz4rS9d9M419EKDKy9

The inner loop in poll_idle() polls over the thread_info flags,
waiting to see if the thread has TIF_NEED_RESCHED set. The loop
exits once the condition is met, or if the poll time limit has
been exceeded.

To minimize the number of instructions executed in each iteration,
the time check is rate-limited. In addition, each loop iteration
executes cpu_relax() which on certain platforms provides a hint to
the pipeline that the loop busy-waits, allowing the processor to
reduce power consumption.

Switch over to tif_need_resched_relaxed_wait() instead, since that
provides exactly that.

However, since we want to minimize power consumption in idle, building
of cpuidle/poll_state.c continues to depend on CONFIG_ARCH_HAS_CPU_RELAX
as that serves as an indicator that the platform supports an optimized
version of tif_need_resched_relaxed_wait() (via
smp_cond_load_acquire_timeout()).

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/cpuidle/poll_state.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index c7524e4c522a..7443b3e971ba 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -6,41 +6,22 @@
 #include <linux/cpuidle.h>
 #include <linux/export.h>
 #include <linux/irqflags.h>
-#include <linux/sched.h>
-#include <linux/sched/clock.h>
 #include <linux/sched/idle.h>
 #include <linux/sprintf.h>
 #include <linux/types.h>
 
-#define POLL_IDLE_RELAX_COUNT	200
-
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
-	u64 time_start;
-
-	time_start = local_clock_noinstr();
-
 	dev->poll_time_limit = false;
 
 	raw_local_irq_enable();
 	if (!current_set_polling_and_test()) {
-		unsigned int loop_count = 0;
 		u64 limit;
 
 		limit = cpuidle_poll_time(drv, dev);
 
-		while (!need_resched()) {
-			cpu_relax();
-			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
-				continue;
-
-			loop_count = 0;
-			if (local_clock_noinstr() - time_start > limit) {
-				dev->poll_time_limit = true;
-				break;
-			}
-		}
+		dev->poll_time_limit = !tif_need_resched_relaxed_wait(limit);
 	}
 	raw_local_irq_disable();
 
-- 
2.31.1

