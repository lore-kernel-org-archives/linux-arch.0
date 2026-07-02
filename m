Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D13429ACC5;
	Thu,  2 Jul 2026 01:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956147; cv=fail; b=iFugptDS5erzjyJJm6UWcw0meLM2KQUB+N2ilGK8ni/v0/3J4ikEiCslLFaPd+abuZnOtLVb4lxeArG9F7v+6VOzZGRfumLo4DVMjAz7Xz0KlHQLekh55tnitg2nVLbtUuvGWZIz3p0jpq9KUVdRb7uB9I2+fHUNmpCbhXftHCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956147; c=relaxed/simple;
	bh=QPTkn/Ei45JI5Ef28dKMdRB0ZU6JHVn/wc/pviVTxk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WnWhd8puL6IQoie6FZI/v7tOkLb98wp0B/ZWC21gM52dptFTHs2aX/9ntqicaYbEwpOeVTiPupOpNSfE/qZMB3E2hNGjBC075AmvzRFpoEpg2D20zfJ+IUTUt1oWJwY/GxGkHK4Myn/7fXzOt+JU6fAN5RSLXYj68HEmYvzAoYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=INqv0Ymp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RUm6y5Qw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="INqv0Ymp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RUm6y5Qw"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661EGstq2838608;
	Thu, 2 Jul 2026 01:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bq+FbXxJ7xy/r/4JzMlumFug6XxBYI8VXoQFLMf3064=; b=
	INqv0YmpI/G6s7CMgq3oKjXO6ivLW9CuDnvcmqB2e7AmDp5v6Et2TrAzXt0Rsidy
	EvQIR2dn9Oq5VCh7Y18JxqK2KwwhxUSybyiGU32S+pcXBw7fIBB/qVN0BjcAEiFO
	UtvOIu6KGi62RYG+KCPqdDLAsbWF0r03diduyh5SPC34Z2eD0CN7VFDjHaHJvjTt
	00U0YRXKav9bw6JVu/LXK+OpopUDBrBlj2WrZjUCBo5zi/G4Z4k/p84Fc4KZsCmH
	gBF6zM5OoUhWha2lI2ASpn+1uKBOb5PzJjZ4N3XTjjxZoJsJUaSL497BH8DUlatr
	ONEZqrYDyoaxVuofWeYAxQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26p47873-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:35:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6621X8oX012588;
	Thu, 2 Jul 2026 01:35:13 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f24yg6y0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jul 2026 01:35:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8QNEd7bO1oZvtSPwd6Wh2XrdqsPrv8dAb3dMEpJhdNz0tjRhDqx4qVjalnyGih5JzYnwO+TNWQfecQCbQ3SBi5Evpxx2nDbjC0qxiq2vm5QiTrgO7F1UH9GanYw1xX/r6STgyetdaNRiMVTQTEQfYWPfjo9MlARpKKsGbMCB8PNJ6W0BFR+2aMisMn2tEYWDMvRBzNUmJj/piscemf4ILfgmHxkf4ow0cbDgIFUycevOlhDlosFV9FR5Jh9jdjh8dU/4emfOqqYx518a0hp7r2uXshNLGb10sJng+v4zKGlWzl9ORnbScC8sRdQ4LMfiH9BNGnBcXItYGBfioyupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq+FbXxJ7xy/r/4JzMlumFug6XxBYI8VXoQFLMf3064=;
 b=FZIGNnv7k+QVzGysM5AMf7XWwehuAQ5aNWnm6LYH32PToZ3ldZqjTvqSWXMEQ4bQ97NnuJ3Yiycx6hJPWM3VZweuHF/AbMO+MaTPOTwPUfHjyiazFfqTtxxSBXnl5XGlcgjHx8q+1p1u7ZfvWmSDllqU2ZlhGCMSNEqYdVGA1XLC7X5JeYlzYny2chn6Xk5DO0SwcVgyaIcf7qUQ8K1Eo//mC+RNJvx2DwqIWbZKwfLTYvp32OEFCf8MaNPxp2cJZZTLwmNz2Oxa3JCRctG6QkSktEVvmP8DuKKfVLnzxUrpeERo3DfiYqymDOJiHI0Z+TZZuVFHsHmubZIRywk20A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq+FbXxJ7xy/r/4JzMlumFug6XxBYI8VXoQFLMf3064=;
 b=RUm6y5Qw9mj5Dfcf0Uhw91kSywnLDnEXc8VYREuh4LSc4UgLzt7icvDxf3ZuGNnDjKIMj5pR19uO07EA1FNpbpg0cqJrSawtwPw3VXPAsDHhe9Vt7vROgwVCOEhaAOWTmNMutMAKv+MrAe6aOB93gRPn311s9waHarTFIIwgmto=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA3PR10MB8760.namprd10.prod.outlook.com (2603:10b6:208:581::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 01:35:05 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 01:35:05 +0000
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
Subject: [PATCH v13 15/15] barrier: add clock tests for smp_cond_load_relaxed_timeout()
Date: Wed,  1 Jul 2026 18:33:34 -0700
Message-Id: <20260702013334.140905-16-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260702013334.140905-1-ankur.a.arora@oracle.com>
References: <20260702013334.140905-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::25) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA3PR10MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3e627c-3e9e-4982-7df8-08ded7da24df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BPTPRtBnpA9F8Hx1XSqQnv3C1Wg2Ag2BqSBsTfYUpjPE5Kvr3FZhg0d1MNM6ONrdtQNOXg3CsbAdlmzyHMLm2x05jcbQ7lMqCJholkRCvFKq1HjpJgOJzn7DIWs27Oev0zVz6d/8Hn1osudTnDrYI70tPFU18vap6OsyJnjWtbGW7A2Z5a1Smfc+558PiMkpSFGgg9ZFH+ruqhCOAY5u5l20xkYklCZ4G60Ff6zlSOozgIoPAU88/8NLPdVqk+VfrG11dL+TfqWWeyfaTRIgVPVV4BmltZV5POIo6J8b1iK5oN/xghtH2BFuQVmCX7N2OxgTRkhmp/xoW8Gva0f9ULySr9OSzyqGzt6XYgBnJ5AVBWSr/zP/PH07hEFLxOa8qC8UZb7UPgpzQH4BjpzNxAGlYHeg7qLVRDcoL8j16fIP5ZtNHVOYTxNiaETgkrQb+mC8njmrFoSHFbjyN5EA/WzKDDrEsdqMGeD5jjpTqvhDXKy3/m1XsOXvndOtLiD3JMs2n4BFV6GUC51R5wM00dQ65dqvsAsC+oSt4AnDpYgpFKq8etHPkjdlZ0xyerdt6z8ChqjqThmGY6SgadADqarhABj4JlnzXfnegddwAEEALjfL0jM78hMJdUurDiQx2NUyPh5URSuJnF8sF9/gql43xWF9aVaNy5e0r2sPtS8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ma8gjbpRU7g/bgv/McsiWAlS5VRS9SztE+X2CFk81MUZlyPWissWSI9oMqju?=
 =?us-ascii?Q?WvDS8AxRIYbzgh1SBUOTWeNF8QlayYZqsRGtU2qP57BalQh3Nn+EaENQNk+j?=
 =?us-ascii?Q?MGZFEpeJMNRpAcluc/0TFFk//tC0mgC7xbdoSFAU6z75qM2LTSls2Hv4iLK2?=
 =?us-ascii?Q?RSx/MgGcuYR3V9GvMrUMzTABcvwMDZqvyD/13MqTeci27GRg/X+T4r+QxsKR?=
 =?us-ascii?Q?IvfNPSjLhjCToXgTnvnfavuJbsEzJdwtbknSaV0wdr+mf6CzK8E3KajJj3X3?=
 =?us-ascii?Q?smjZncgd2loJJreFQ5dsXX60fjHcyYbg5l0NSwVeUvJHF7zTo71LK6l8qKD3?=
 =?us-ascii?Q?WWZSlqPfRoEzKD+t/mSZhdg2hLIxhwvAU/Fmxb/2agU0lDSGRdrfSOdxm522?=
 =?us-ascii?Q?KxxFP6x4z/ImXPxKPIVqa7xW++ojOLi/LgRWA5tNsEc8cJi/IGwFKZFynInJ?=
 =?us-ascii?Q?aZkIdshLqG2ZReb380CODejA9y9cYt0Kn+s5eI81RlZfhTNEB/Up8jLVlmEO?=
 =?us-ascii?Q?w8hT6ga8Xh+RopXBHnlJG3gjP7AlXZx5/QmP9UJEYCv8cerDJbcqrOeoVtsr?=
 =?us-ascii?Q?sZ9i2Xm4QQyxWwesne1ijNMppV5zblNsT4XzN6y/qUQnZH3ilbXyizptfHa0?=
 =?us-ascii?Q?KJgwxFU2ZkaH6Ix5AfetzNYyIZ0VG+SefOIOVXDOPHOHSMhJElsDSqgK0XwK?=
 =?us-ascii?Q?ZpTPn5HBFxhIZliqCtZ1zyBIqE5CO7xlFv0eRvbvXlKHBSvyy/moS8iKBpr8?=
 =?us-ascii?Q?jMakviBl35kzu7HrOzSYjciMtMteh0W2jN83kx0nipK1YAWYosQ4agiKiv3w?=
 =?us-ascii?Q?feSJSpP7AHqEGX5kQsqtowPIJ5aZ/xA/R4fAII3z+ASjMY2dL/OBhGz1mLeA?=
 =?us-ascii?Q?3qeAZmzN5p1fLtEHzZV8tnua5QkgEBXijraCVgKUrx+8xAaS2Io0k/lFhhNY?=
 =?us-ascii?Q?wkx/2i/wn5PBs3zs9jo8rd4sHA/ZaqjhG6rjCUYRfFD4Y2GHudka0ss544aQ?=
 =?us-ascii?Q?DhdWWcICFfwhAaim85MmWv/xjo3k/uKPfawJxlo+61nk8EXwl9U4XMS09zNZ?=
 =?us-ascii?Q?akrrd7PlBNZsilWIYibuu0QazniiXSwxsWINANglt98ETV/VQTyiJ4800uNL?=
 =?us-ascii?Q?v5rN7V6X3juEZwgGzIt4WY9NLuNnoRrMvgMtIYRJ3bLbnscYbvvLZnKYlT9l?=
 =?us-ascii?Q?/H3aOjwfGtPhkKT8avyXNRYSybGKcuhib6Zm/oKl7AgYJqPhmcTcGoYFvWn/?=
 =?us-ascii?Q?ImphMevn89xaLCFJuht0AgOjhJd92sB8ZmHjarYv1SOeL2J8a2C+XSqXiA0b?=
 =?us-ascii?Q?nxvTW3qSIUvFgOi0ICbbOBC4+7VJZJScGjstJ6qMtHsMgzkswKRNbZRPU2Mp?=
 =?us-ascii?Q?JpnSM9Chnr+xqGmLu0PRX+3GLueU6XtSyP2hroFf16icwr9iOq7Xzs4Ji8yd?=
 =?us-ascii?Q?rAsZEzGQGkVE5CH41SKW5GtXlwbeQH9MCtul1Cjw6ofWatqM9vqRIZXj0h9x?=
 =?us-ascii?Q?gYiIdFX6HmTWYpaWvp+k4RmFcNEX/B86P9c+SNqadU5F5EEOlk1I2Gqd9Zwg?=
 =?us-ascii?Q?gezD7Gl8gFm+RvWxHj5pjeHdDOmOGNuGcoa1VJe/1jjzHWTLg92YzhlBA6dE?=
 =?us-ascii?Q?tt9t3ilEBnpKFx+r9JX6cj0GgwMoJfryJ1gMFtD3loaeaSfEiMWtsjvxADti?=
 =?us-ascii?Q?UW/d1Q0Gm2QeWPk9PUbnYAqvfdu5rp80EwNGMOboEXlvu+WzgQUQ5xHwl7JD?=
 =?us-ascii?Q?UwV4A0CLud6imS6sYVl3hzuOqBnHofM=3D?=
X-Exchange-RoutingPolicyChecked:
	VtoTDFV1orwPjuNcPjZsPpxK0s9rjYGvDmlVCvBczHRTDNmp8iIXZ6B2DR7ZONWuhu99hIadsTuFriYM7j2LiAzIiTIE9TQUO3PXe2R0eWcL1oOqtWiBKqsOBlr2cLmSTbgSN/RfpYnxSun7+rmFfBcGEUbGP02iCgf0qqIj4NbmDIbR31o4e2PmX36aPtn15JdVfhJSoSULFx/UcFGwHMArP8SZXomEX23VvRGFf5aS7RCtra8yWh7tjwduJax2zLddKJflSW/TMyDAZMXESGzgCRdNOj8oAqaQUJU4lffQza3te6Bn6n5Xo1p+9hkOKz3E+Gr7TL0DFOGS/18qlQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+qMMquuyGIr2euh/RazB7V+Yc6aTsqY8gg3YiUA2uiWLBDbBfJ1jlFiapmt0/U0EpFfSKkDCWSsKNt0UN4UjdrFwQ3q7MMK8mEFvMxUPBiMWDCplKMJozr4zBUQmpVH5D18YyVUqfKoqx01SwwZjAoYJ2A8swd6STrRJ0O8VuFVGg8yHMpy4nAp/O100/iwgZg64pXa4PE7jmySe8Df6JBrY205rE2yee27TV1yYy+hbyNXGF+4HEg2pAZtrqh8RF1hP/YjuZSuxp/5eFPyXd3ANIF+vriIkVzpw6uEFx6xf6Yvyq0+VVcyneFHkfPFlImva0IFxusaeZgcbQPLjiXO18CFpl+UCbIOBAiJBLlyJthq5+iTdTXjHGw4GfwHCJaYInMABJmKaU9C5VI12l4I8qQpC65ywuhDnmmqy+rPT5IYmziyUE5l1qQZ640kIlfVzv8q2wfLe5KXIyqW9vFFkty+9pUkVl3RS6cInfmivT8w0E3fOylcqAaCjhw8Y7hezLP7CtV4cCSf3djG9dkpWMzhtvBW6PaOTv6HtWF5xwb7cmwF2HkSiYrY6NS2FnQZ8WOwlNZ92TZAOcI0REETulAMO+MK/MwTJdFq1LOM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3e627c-3e9e-4982-7df8-08ded7da24df
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 01:35:05.5669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GO2oXC++5snQltNM4IMfFQac+5G+dyiRlNuP5o2Ue/kHcphTuKPuKPScScQcyzbQ15I8BAYRPEgGfCAJtlAHbfC8w/iZT7LPSp7pgGipApQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607020013
X-Proofpoint-ORIG-GUID: TtQpm5lleRqpB2nQJ4_8xSjGsWPJdNXY
X-Proofpoint-GUID: TtQpm5lleRqpB2nQJ4_8xSjGsWPJdNXY
X-Authority-Analysis: v=2.4 cv=DK6/JSNb c=1 sm=1 tr=0 ts=6a45c056 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=cTNLpHtgc_5REjKn3O4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX992GlhgZRTMi
 xCs/hTjxSIAVACWzPpSZEblMvuQVk+ZPoue8BmU0R3K0qiZdB5sl+h1peg3w9I+OFPRfH7Xlnea
 RVnwl2puJgz30q97G2okUWA9wh7sJTG7lDnF9QF4ke0J5u1dH2Hp0Qb7rcXWIee58HZu7RoyJpj
 MkbhBpAJngHQng34eLZaZUJhk/74QIQG0wJgcWRfKOo5XevyOrV0Fb29adMpjahC3vfBgw33+mi
 J0+OPYXfAPM4zvvhJIXVjgoRYW26GVKGxyUGtw2ZtH365eRbb/EiW/96bTGGXGUb/qygJtxdVdL
 zf3x+CWEOjzSi6qmshrha2DaMZMfZdDNjLgUHG4d7i354Sd5m2hIJL7yC7aydM1dI2jG1JkLjaT
 9Vqb5tkN3nyQ/gHhfVPHsTqvsXScuZuueD+nLyhaJvBSQW3xQp9dpBUqsbT1g6AtoubEHYv+T2N
 mzc4e/o4Q7g5pbzJqTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMiBTYWx0ZWRfX6dw16l+5I7Dd
 dA3jks2R1i9o4gC1zKWZbrKu4GcdZcTAaQQIxMRBhEhki3lL2SQR35YJK7DejzPGgqcaWnx6wZo
 Gz8Zy2ucK2hfzz1djTh4ORtEuQyzZKfHO6w2hn/64u9W2ijLxKlj

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
Notes: removed the test case for timeout=-1 (a negative timeout value is not
supported). This also addresses the comment about the test for timeout=-1
only being incidentally correct [1].

Also add test cases for timeout=0, timeout=1.

[1] https://lore.kernel.org/all/20260608083449.171881F00898@smtp.kernel.org/
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

