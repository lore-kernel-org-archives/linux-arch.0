Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75E13A900B;
	Mon,  8 Jun 2026 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905954; cv=fail; b=LviS1b/U3SDs6+uUBGipc7PzSkUmGBoeuGgM+8/IYVFmSofTvR2p7A2SyZuBDHyQYt++tC9khPNAcR3nMO8gwehTDLzZ7M0308yOs/eyfA3oiy/5VmZr3TX+ZRwKyPwZqy6pCWU/JHkzrP+Q0R6aCxb1MnRrKDTG58Y1NwIaAvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905954; c=relaxed/simple;
	bh=Hs77ngWo0nhZ8pFZQS15oSSu5mZTHileuhNP0dDxDMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HwZN2VzErEDVMwlxWAJL765D6zxFAdSoez8BbAMGAg4U4XJk2pJlCYGyJdce4vPsHIFS2G/O50Rs8hSNjwI0xA+MqYQYl633yqHuwA9Y3TecrEOPr4FgP7HJa1cZWHv5txxTFb8xpKw/V99OJmp+etkLMZvnf+nUnPS4l9c5bqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OiWdxYRi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i7Tv5GeY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OiWdxYRi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i7Tv5GeY"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657NnIkY3933133;
	Mon, 8 Jun 2026 08:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9zCdyk5E6crTcNzxQ9ESHuxMMNtczyfEbmig4L116J0=; b=
	OiWdxYRiE3r+41LvJ3BoJQBzrUcz0FuXp5F7+Ru6qEIeXeJKj+vVWuZyo+2h5SW+
	9ikwhyMzRbNpFNQ77hn2zKcL41XkH8rvVms9WrMgWpEVIjImhgeKacBUmT21J5dh
	VMlPlWiJ23XeLH4rN8zWF/G6ouYSrxvXSyPQkkpEGkb+AYA3bB0RiphOb5fPl2mt
	xpKAKYvBKpDDe10tFNvr/vaOa0/sE/yenTSVUHjwMJA7V8BtGxw6K6J2uZ+KbcNm
	z7xeWbwCZ3CuWvkNB+VNShWqOCOCEUuM+kQ1cuKwXkNMcqWJO4aqD2R6x1DawLXt
	luaZ8gkuZbLZ9xMaWWF7CA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emb5st0fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6587wURG009166;
	Mon, 8 Jun 2026 08:05:23 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0ngbac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:05:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/on8BFqyymVRd1Z0GuLrczDLWzhAmHvFY5IppdiVf4IWjFhbqFI0B3F/DXJqFeZvT2lgMu3CysudyXkNwgr0tp6M0fK762wlC5Ug4ZNSD2QQonUxDnb+K+/pi99Ws33KnGr6B8TdYTFXVcdGeUF0YaAJgWA1aRufSlDtWaCd4v+VYNt58XCp1onfDVDjjtIqhnSxV8l7ofFFzAbLI4XhN8QKctVb1J0yBZwVkk/zfvDeHf7zA3dmXbCdrUuCpICIJ0wYOw+qruodfJ/xaqs2uZ5E5dlIeQP43C1tWPFK3H2WbG7Oi4B3Ql83Gpz0pYDr5YyMXzL4q3JANY6xTWMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zCdyk5E6crTcNzxQ9ESHuxMMNtczyfEbmig4L116J0=;
 b=yQfjm7prEwGTB0aFreJG2kZWc40MzeC7cBIWJ4Fqrfz9lH2ps4N1jtm1PSu8V+JAtJ+lig6OiCD3poLZu74nsO8xbAMd8L+ZdU+8dTGjv6JF0I/zWQCELcvJxMpUNKaiOzFDLfYzTT2WL3Vy96GkaT9TQDEsQL4HkC3CS2j1Ok+ylasHuNnDapObaDfZ7Up2iZ6fwfQNKAphqakDnnCLvVtd0Q+IZ2gWEin+xE2IBGwdRkAuEBmoTWf1gqhNtbJ8dtH/QeyHseOiCpjUF416aYWG0X9Z/Qwbe7m+FfUmOrVaEGki/t1WV1lX9YcbBPVL3Gsb+rpILTnUi8Zl4YS6LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zCdyk5E6crTcNzxQ9ESHuxMMNtczyfEbmig4L116J0=;
 b=i7Tv5GeYvaw6ITbA6ukUMoslbwYPEhV44cha+jb66GEVlAuACh6AnqAe6spJEn2z7wrFRKy9GMp1MsIvidpLUS1/t2FtpagLXelyA9LynlA7BAdVqF0w3335pNhZ/s7fIFsas5NywPDa2ohKRZLzFGqZ3bM7od0EucFdv4wO0rU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 08:05:20 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:05:20 +0000
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
Subject: [PATCH v12 14/15] barrier: add tests for smp_cond_load_*_timeout()
Date: Mon,  8 Jun 2026 01:04:39 -0700
Message-Id: <20260608080440.127491-15-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260608080440.127491-1-ankur.a.arora@oracle.com>
References: <20260608080440.127491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0308.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6a5c90-ff2b-49fc-2437-08dec534af2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Eoidw9GtbPOyOiYj6uY7Xmaw9UhbgKsnnYdbgtzMFQA/U5gvQBMK1PJqvX3uSta0vi7isE0krKQyLnUSW4tlRlByBos7cJrC0t2Uln0K2HKlnpeIjM5jBywNBkdcrch5yrs7QUrTdIYnEvcCxzv6d2gawus4itUPI20GVOOo+agft4Uboa0CBFMqw/APlnO6IBSNL+WuK8kMMYwHXjcEDFk+9XjBhAFrpg66Zk4G6dFD8Pndp3MzXeRE6/MX4iAAQgb51pi17zUJ2V89OQp7F0FWbB+hNtquQkrOkoWHKjwwxblscINC4GrxpYPg84KLwIbT3XFg4NAj/Wc8hhDZTWf4sQZJIjPK+cwWmfGgqbMtkAddhL2ZqqWV8Ami8hoTDXUUNAsgJUsCYqAcQ1wLWpm9x9r5QzieoVYzQXfRLp/1ECumruB1KmipewLAQXd0UnzNvCsafbNwOgOFP54rzA/up73lw/S1lu01Hljfdcp0+dElAwrL4Zl0vE+FIaC5MXSf86O786Jtoh8KpMARbVydawUKUiivJt+J07R6Hiq2dV73OdQrTVNvqXbQu/8Vxhwju9cvRB2DNhrkuocsjBrUiPqtv9PIxMMc7lww0zXKEp2im+cbOpCp7tVd/ym4JLr3h7UAWXEbtvJvA66XITMghT8vO9bH48wDWQLashB6fFldxJDv508+dPbcExALzmii2AT0m4VjA6mv2sCTIA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kRAc/AZ8FPVDUok6nVdQaMmPz0udTjjGPL0Ec4Bn+M2nuUUem1HGXSXS5JhV?=
 =?us-ascii?Q?la/+4qYvOKoN0+3Ji//fq5YsyI6Zx9I+hG0beh57gVOQa/EVJxhkDP5CUurE?=
 =?us-ascii?Q?sZIMVY26oXTuoTWcFVwgm60mgQE8deOzE0pnpjTgi70M+8Oy/1oEiyUWP8eM?=
 =?us-ascii?Q?s2JcznAQFlQbEHiMn8VRvWAwlbIyVELhqTGo8QtKjIoyjEaJJweyPSmlENMa?=
 =?us-ascii?Q?mf9/aYJbVjhTTMAaoMcOXfCoRaAQN8EibluwT+Z32zoPmwZ9eAPJeHFq1y9n?=
 =?us-ascii?Q?WGD/CwJWIL4FD/2y+BI+RKIvCI3O1zG9/+pvq4Hn5fdEl2atURyp1xV3MNJB?=
 =?us-ascii?Q?G9En/orBje/xD9Uor3Kmx/PExTZhz4fD8Bdt0j39M69RRJ8vFI3MeTLl5Xsm?=
 =?us-ascii?Q?C9RICIA0VeX/zkZkoX1BB7YAHgtPbICtHs1LPpF2409pNcCW26MF+U79dsyx?=
 =?us-ascii?Q?DBt9FGyrgemjpyzaAviovEqc2QlNyJ0DHjMLbTZD0x69uoTYmyUkyiFf+BAX?=
 =?us-ascii?Q?8YA816vvpUjP9Q5zQiLozQ1dfiCE2lC1Rd5ATPETyWgIzG+x8nIeQ7AZh3hG?=
 =?us-ascii?Q?DrbLe4NsLvb7Ck3cAg+hYzPlykSKaaRsaEoq4oa86/YhZqwLDk7mQFq5uJpi?=
 =?us-ascii?Q?6pFBnDlKr5e9Wd9B/9xjiwDr4oKVwSDMUUq05JloNVxMeow1cc3PKeVlxmm9?=
 =?us-ascii?Q?jSPTybRj4m5872cmU6dsSQigFDmI+Z96+DcGXxqZL8SwTaqVl6bGKDETBv37?=
 =?us-ascii?Q?n12L4ALcqhW+zAwXZTvOH2TvCZK04uEa2s8l/D4Kg1tSYFzMGNC6gjtBXFem?=
 =?us-ascii?Q?3sU3wYhF6HswuLiyqqJgCADAoLcOOLfbqtyn9Pl05iPv+Mt9BzAfukh0YMjc?=
 =?us-ascii?Q?/Zu4aRM7H+Ho/GOU60HHGYkB6CEW1E4Z2WYuRcsfzVn31d2Lg29e23yLL9rd?=
 =?us-ascii?Q?yapfruq9I6hU9uSmvH+hr8ur1rnb9ErdqAOWYQqT8wJn5QrA0QQ63ltF6HuH?=
 =?us-ascii?Q?svocOgaSRSrkXXvSWgWq78uR/plgolJgtG4f6juR7oxQhz95XZvUPYL6OuxR?=
 =?us-ascii?Q?J3KjYNxRWKEpERGdgQWX8dI4l06cM25HPhFnHpyTcSuIBacW8g0toB5qdasb?=
 =?us-ascii?Q?UcJ17HM5eUIBL1UfkwV6kF8yC5+5DaNUGgGJ4/CfTscbNkaWgfaqa0YZNvsu?=
 =?us-ascii?Q?h+Bnmo6rvnGObcKtCkPzd0wxQWHTKm2uz1rCniDPXJ+Qb6UAPtF2F5moAdXl?=
 =?us-ascii?Q?4Z0LlDyuf6hM5UrN7dRajiTOkuZs9vb9TVoEI2XCO2DtbSVptf9TcTI7/2+p?=
 =?us-ascii?Q?xLxQWIQyxg3hAbP1STaHBV8lIt10V3DAus2l+w+prnMaMhDTqdMc3PBr4xkB?=
 =?us-ascii?Q?ocaULgUpNWEI1Ut4e7lx+rLDUU4czkMJ/lHQ2Ym+fDHDeuvQx2OwI6u8iaOj?=
 =?us-ascii?Q?BZ4eDh1k+PNQghxzKS8XeNbu6r36HRlfaAOxf+TtX+o1pwvqxnh5X8qAL7i1?=
 =?us-ascii?Q?LQUyLaKqECYlskzGjjiq/54UdYOsRfMcHxfIGee19vF45dUqW8A4uox8KlW6?=
 =?us-ascii?Q?xr4UHf6mXJBehJlhuhBcPwlJme1mEbuo1G8OfFne7JRqCGp3rZlYbRR+eSfl?=
 =?us-ascii?Q?jy0Aqw+T2Mjiu05JCwisyDM/Oen00JWBmCH4LVsFHGe1KcMa3xv/P4w8/ML7?=
 =?us-ascii?Q?PqHhEApGtEUa/5tjQBZLfMVHPbyhu80Ssr9RjAuv0ViQ4SUUYp0idlKfFjas?=
 =?us-ascii?Q?WEy2o+ES29qL0KRnyrMty7kh3WR+m1k=3D?=
X-Exchange-RoutingPolicyChecked:
	ciKch5Vjt4qrfFbj0yPYzxaf612wi18wIzbsxSy9bVjqMSuSFR1WuyS9kSYWCIEehqMLrcqdWq69lY6HdDdsHc+HEVI9j/cmrqzP7VnW1p8+OZvscN/5i0TDCwFFxWP5D8OxyDWUDG+nh1X1i/JSpb/DU6+MJZa26i8pxdAX2PXpGyvkDZ26jxW2lB+M4YVkkhxK5RUIv+UPPP5Htp4y+R38heL9vBd0Fa/22G0MVhByPSL+Zk5M3NUsXGuGgC9QbuYVcvAr2l9utYKJsmj+EbeqNE87TYqOSMp+lWi3+1NQXXr2vt8TlDCUUK2Jdj527pTldYuQ6oB2qvDTGu+EAg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	drF6rTl2U2Bhik6rRncOCrQMISXcpwIbP1XSynn8HU/HXgLc/wTn6Q5Yyd/POrotye5ufaIp54oJh9iILWw7kdlT42CS8zM6ksO6/iT3SyY4mzjofnwqB4rE4wDCZx1t7BFi66mXOIozDyLQJUA3WJxBC6Tg2PESSiroNpamp/blK27ynMk1biI1vXqVsR2duXOhKg7X97JwNCasV9xb8CoyAaKP8fHq7QLGWaBduE71mLUdf34ETtZ0kl0MFuw3z6JxJnkNyCyH+pqFKVGfSTWdDdyyYMaAzDZeezo5lHyExTKvwrWo0thTck3XJLBS8DFUDI3kN59Jcf2xdZ3AuQe6Vn3vfexvfjfpz1cwOt2VOnkDx117QtwD/+2OyfBIYxJMbL8KKoXc8kQXIgvQWDgs+IpPFrE55gegYNSzcxiHVAwd00+l14fOvKXgl/RTpsxUKLviOGOC2TI0IiXQTX/DQrLbzJRG1tqkRF5W/IfMlgOQfSChDw4LRiC9U99RbBPyHa6JqpKyRsx6nvfSfk2jWX96SWVOgnOP57HigsDOyQ6edIYS8elLx0186tQ1+N/xDfGPEqePMfDqIraDvolsVDZ662AiQE48aCb6OZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6a5c90-ff2b-49fc-2437-08dec534af2e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:05:20.2842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xOjV8fA9CEkcK4BlTX2w2pZm7pL57kLWFVWhyJ4KizopSSS4lT9LWz8DzOpXzYHQ6jew6B/W9QdwwJ8ZfhkExfXRWAKuHR16hXD4KqnvPwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606080073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfX53rPhiERGr4Z
 Dz9egpbKGxEUZkZp92JImrX+XpAJ+0Wbl60MBcfY5iwYmgv6nnDyBIZaZZXRNXqwZXVvkAevLiu
 OqzpdJJdFBIKSbb4cD/v3tdugv8+smuww4cUvVcyWy9Dk6lRHlIXz0O3cBf59yamaPxpMhPw67h
 DJ+slC0GjalRSk7aa7pmeazhy2il8QNoSKt4hGjETOuhqTgijq2Cb2f7hp7gJeyVMygDBSzETkr
 PmM9El+v2QxqTj7SfIoUDbGJKu6N7zv3reOUtO9ir0XZaEnkaol6IJPRJZF9JE1Uy93A1Oh0gGj
 m3GwzvqEq34Gg/W7WKz5IcSYhViqe10DfvCJ7qBbn7XxSkvfM+o2LJ+4ELgesrt5mPz5k7xkZHG
 qv7oWv3/gwAWdhz10RRKDENagJ1LnkNt9jHmtJyk9gC7b4iSg1ddlLU9jR0FtW+/48ti3J53Lep
 Wwa5RXfbgjLtE40VzmrMrk0V+xYHVaczH0+lUm50=
X-Authority-Analysis: v=2.4 cv=XeC5Co55 c=1 sm=1 tr=0 ts=6a2677c4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=qNABUOcEAAAA:8 a=yPCof4ZbAAAA:8
 a=IOmrJ1s0mjgGKxRSJAkA:9 a=Ytm653ucTKQjCvbzLygB:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312
X-Proofpoint-ORIG-GUID: WGtR61ssCi5b6WUtX8-BXcR4wcYLJi43
X-Proofpoint-GUID: WGtR61ssCi5b6WUtX8-BXcR4wcYLJi43

Add success and failure case tests for smp_cond_load_*_timeout().

Success or failure cases depend on the expected bit being set (or not).
Additionally in failure cases smp_cond_load_*_timeout() cannot return
before timeout.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---

Note: This fixes an error in the test case reported by Mark Brown
in https://lore.kernel.org/lkml/agr_RxvNtfASfevg@sirena.org.uk/.

There are three changes:

  - One of the test conditions used in the test was much too strict.
    The test was treating:
      success => (runtime <= timeout_ns).

    Instead, it makes greater sense to treat:
      !success => (runtime >= timeout_ns).

  - The test can run in a wide variety of environments including
    emulated qemu. To get rid of potential failures due to timing issues,
    remove the kthreaded case.

  - Parametrize the test cases.
---
 lib/Kconfig.debug                |  10 +++
 lib/tests/Makefile               |   1 +
 lib/tests/barrier-timeout-test.c | 128 +++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 lib/tests/barrier-timeout-test.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8ff5adcfe1e0..ad5131776f68 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2406,6 +2406,16 @@ config FPROBE_SANITY_TEST
 
 	  Say N if you are unsure.
 
+config BARRIER_TIMEOUT_TEST
+	tristate "KUnit tests for smp_cond_load_relaxed_timeout()"
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Builds KUnit tests that validate wake-up and timeout handling paths
+	  in smp_cond_load_relaxed_timeout().
+
+	  Say N if you are unsure.
+
 config BACKTRACE_SELF_TEST
 	tristate "Self test for the backtrace code"
 	depends on DEBUG_KERNEL
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 7e9c2fa52e35..19c1d6b17856 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -20,6 +20,7 @@ CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
 obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
+obj-$(CONFIG_BARRIER_TIMEOUT_TEST) += barrier-timeout-test.o
 obj-$(CONFIG_GLOB_KUNIT_TEST) += glob_kunit.o
 obj-$(CONFIG_HASHTABLE_KUNIT_TEST) += hashtable_test.o
 obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout-test.c
new file mode 100644
index 000000000000..2160844b27b8
--- /dev/null
+++ b/lib/tests/barrier-timeout-test.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests exercising smp_cond_load_relaxed_timeout().
+ *
+ * Copyright (c) 2026, Oracle Corp.
+ * Author: Ankur Arora <ankur.a.arora@oracle.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/types.h>
+#include <linux/sched/clock.h>
+#include <linux/delay.h>
+#include <asm/barrier.h>
+#include <kunit/test.h>
+#include <kunit/visibility.h>
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+struct clock_state {
+	s64	start_time;
+	s64	end_time;
+};
+
+#define TIMEOUT_MSEC	2
+#define TEST_FLAG_VAL	BIT(2)
+static unsigned int flag;
+
+static s64 basic_clock(struct clock_state *clk)
+{
+	clk->end_time = local_clock();
+	return clk->end_time;
+}
+
+static void update_flags(void)
+{
+	WRITE_ONCE(flag, TEST_FLAG_VAL);
+}
+
+static s64 mocked_clock(struct clock_state *clk)
+{
+	s64 clk_mid = clk->start_time + (TIMEOUT_MSEC * NSEC_PER_MSEC)/2;
+
+	clk->end_time = local_clock();
+	if (clk->end_time >= clk_mid)
+		update_flags();
+	return clk->end_time;
+}
+
+typedef s64 (*clkfn_t)(struct clock_state *);
+struct smp_cond_update_params {
+	clkfn_t	clock;
+	bool	acquire;
+	bool	succeeds;
+};
+
+static const struct smp_cond_update_params update_params_list[] = {
+	/* mocked-clock updates flag inline. */
+	{ .clock = &mocked_clock, .succeeds = true, .acquire = false, },
+	{ .clock = &mocked_clock, .succeeds = true, .acquire = true,  },
+
+	/* basic-clock doesn't update flag. */
+	{ .clock = &basic_clock, .succeeds = false,  .acquire = true, },
+	{ .clock = &basic_clock, .succeeds = false,  .acquire = false, },
+};
+
+static void param_to_desc(const struct smp_cond_update_params *p, char *desc)
+{
+	char *clk, *update;
+
+	if (p->clock == &mocked_clock) {
+		clk = "mocked";
+		update = "inline";
+	} else if (p->clock == &basic_clock) {
+		clk = "basic";
+		update = "none";
+	}
+
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "smp_cond_%s_timeout: clock-%s, update=%s",
+		p->acquire ? "acquire" : "relaxed", clk, update);
+}
+
+KUNIT_ARRAY_PARAM(smp_cond_update_params, update_params_list, param_to_desc);
+
+
+static void test_smp_cond_timeout(struct kunit *test)
+{
+	const struct smp_cond_update_params *p = test->param_value;
+	struct clock_state clk = {
+		.start_time = local_clock(),
+		.end_time = local_clock(),
+	};
+	s64 runtime, timeout_ns = TIMEOUT_MSEC * NSEC_PER_MSEC;
+	unsigned int result;
+
+	flag = 0;
+	if (p->acquire) {
+		result = smp_cond_load_acquire_timeout(&flag,
+						       (VAL & TEST_FLAG_VAL),
+						       p->clock(&clk),
+						       timeout_ns);
+	} else {
+		result = smp_cond_load_relaxed_timeout(&flag,
+						       (VAL & TEST_FLAG_VAL),
+						       p->clock(&clk),
+						       timeout_ns);
+	}
+
+	runtime = clk.end_time - clk.start_time;
+	KUNIT_EXPECT_EQ(test, (bool)(result & TEST_FLAG_VAL), p->succeeds);
+	if (!p->succeeds)
+		KUNIT_EXPECT_GE(test, runtime, timeout_ns);
+}
+
+static struct kunit_case barrier_timeout_test_cases[] = {
+	KUNIT_CASE_PARAM(test_smp_cond_timeout, smp_cond_update_params_gen_params),
+	{}
+};
+
+static struct kunit_suite barrier_timeout_test_suite = {
+	.name = "smp-cond-load-*-timeout",
+	.test_cases = barrier_timeout_test_cases,
+};
+
+kunit_test_suite(barrier_timeout_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for smp_cond_load_relaxed_timeout()");
+MODULE_LICENSE("GPL");
-- 
2.31.1

