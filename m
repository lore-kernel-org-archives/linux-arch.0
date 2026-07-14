Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D94125AA;
	Tue, 14 Jul 2026 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014316; cv=fail; b=TriI23whdGBxLyr7NaEv5C6Awi61PtefGrGtMZr0OEboh+m6t6FbnXoBnLOpJhFTLkQQtMA4RbkfLH5pv4fiR/rz1rNtABoqKWggYeMhaxP3IhE6QXEVNXqRMk44ds/z7PKmu78AXjSWrQt1vkBfEzjTPaNFvmy0dNxWAFFNDN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014316; c=relaxed/simple;
	bh=DGXJpSo9uxBbtAh9m+rA5dQ9EygdHPH2M1pAsLHWgv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=orG/rckEix0ak/vgJPlzVZeWXAWyS5JCVubojT63aOUKmURYP752vYZCb1qvPZ+u4yQxsyuQe2rUleVbLdCZhQ9lgKs6CXLWNtSLm2agWh3OPAwH1hPD//Qu0OfNNyUlw85ZokjoUk+/m5VW5UDQbvi7DKKcqUQuUDh49eyyYco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NjntTmsc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nqt2/oec; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NjntTmsc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nqt2/oec"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DLBKQ11400143;
	Tue, 14 Jul 2026 07:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UcqDHQpjAp4Q60CSgs5vj5LY3c6xQKhHL5kbw/NnE8U=; b=
	NjntTmscNKr8vDQoZrObBUUYY/+Xh119yHd+D4qelUz+tgdGbJZxKt2p97HiJi0z
	P+Q4GthZwaSGgB1Dpj5OnJWcWP9+DdznsIQS5ODXwyU/vUmizUL5SfuJQvsZeoTH
	2r31Tjl5plNK5AP0fN9ks/qmDuZbI6H//IzjMSXYY8KmLahDPZ+JKSqvgmqoxfQp
	RZmKU1zKOVopgCbRPVBI5w9wmPrwTAJruNW9/u6qavFZYWOCu8Zi1O81aeZ80MCh
	ikahPnXCa851yr9NUOa8To2AB6anU6RIu8W2XGP2QF6VuygIRtPTGKPuhFmXOPvV
	7fXrIMb3aJLWiZ0xklR3Mg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbeh63q86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 07:31:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E7ScCJ028698;
	Tue, 14 Jul 2026 07:31:31 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9r4grc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jul 2026 07:31:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teNB3GIK8tm7KXvfmg+AQV4siq+GbSPY1+XJcawexqXEtPw9K/XYRGjAuWXr0urr83s6Pzfuw/IiKA4PcwhZ2l21/UIDFCb/odSfUr0DFHCMVSpY2p0qdSPzOxgiKIOpRNP8wqzD4lTDbjkqhDQiqxmv3HBbwOnz90Zz0ci94ukwcbNXZw6YPreFtLFZznTRf7YkgD9psotjVQO62G47u8gzb0TAl3mMm+pHoL84loaM/IZlwVhDVMjcatug8rTvElHutNX50HcCrX2SfjD+gj2GiEZDySv7eLollEsSqobS9iGl553GI+I0s6J5u5qJqoT/ASqpE3+D9+NlpcqKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcqDHQpjAp4Q60CSgs5vj5LY3c6xQKhHL5kbw/NnE8U=;
 b=d3rsNUjQmfACsrK/bSSPZnWf3KYhq/BNzSmdE2ZaawJrx1qgePR39FaAAhdBksm/tY6CykIZJPOk90isdX6opvfBJ099R9ByDw5QxLBBBlOJ9HMEkISTx1+gcp18tx5bkvOLn6l8Ca27add3Og4yyb4RHqm3MWCSwlikjVkiidpBbsjYrd8hbMuXP5MuHFDewMOnwdFk/Lx5ttQff15CC6VNra8vJg5G9Sd5V7OTgsv/L9EDG/c6I2tlfX32ssIOdVCEb8SwM8NqniPKAA4Co3vlaEO2o4tOM8LRo5aGVBe1+UV6/5l1wHPCXT6VbGCx7+zSfWoLXAaivEjCXRfZ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcqDHQpjAp4Q60CSgs5vj5LY3c6xQKhHL5kbw/NnE8U=;
 b=nqt2/oecO2oofeJ18iAL+aip2PPBR21wl1Jo5kOmcsvbdwKfW6QaBNj2V+EAdYdJbRr/WQvCBUAH3MCqX9xDqiQPzuQMbbRkP7Mv23vKG3pF19NU+V9rmpi6Ziw+DL0ouPgRnP6hh8VTu0wUCvM3U2HnYDaeg7dHmfBXAdLh8p4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7124.namprd10.prod.outlook.com (2603:10b6:930:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:31:27 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 07:31:27 +0000
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
Subject: [PATCH v14 13/15] arm64/delay: enable testing smp_cond_load_relaxed_timeout()
Date: Tue, 14 Jul 2026 00:30:39 -0700
Message-Id: <20260714073041.40250-14-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260714073041.40250-1-ankur.a.arora@oracle.com>
References: <20260714073041.40250-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:303:6b::25) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 926e339a-6da5-4fae-fbfe-08dee179ea76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	vwgrsxnuqRoGBKmunQCdnZx0MEqgLcjFSEmIEYv5kaI71Dnsp05rcxYibcR+45+ViBDXZhR+oEyLitSyXGftn74Dx73s6jlYo+o0QlC9AxPZeDaakL0Oio2BeE2VxWin3QnEaAN11ll5J22irgqFylx130FjllT5oxnQaR6p1zMLwOufugc80O0MSpZZ2dKkOE0LgnewA0jNXTdRiaOPoALo5ZWs0C/qb1+WWSA52b7YQ4Y/llnrO37pHMEt3SQ59/t6Ao9v5IawYMDO8X+/wX8BInTKYz4xv1XMhbzJRcPtcEZ3fAunaAY3CvaLdHCKSczFVcvCyiZAtVC6ldPehCHE5WjUZiWleOznm7m8NtJUHYBYt819UNKUEAjKZTrkgzj7vwzNa1RNKlWpAjMSOSwPgOhVHFzT4v6r8OrPaLOeaUKYi5pmu0xAI1jraC5oIfnxZVUH1USRlUqG45toPeuzhZBIKNKjLbmVp/hg54O74SVm0mBalM6ru1TDsgm16TBSr2BIt6GFW/tMafG2ch+39mLQ9EYf9/q0KvaeOiITfHXcDFnoujlqm+r8WpSPbgAl085dC75Pm2IM8ThiNxsW4QTmUe9anYDajWdADhjo4XQT0JGMaho7f3ApHMA6OAsMT161c+okWNwDPqVikjekLAH/RJzcUEteah6k6jA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OrJK6o31ftg5tPuogUsFtmwhXAq8y4tBRhZ9vdmEJretBf1hDPajio3TS8jI?=
 =?us-ascii?Q?+FUuTCu8yhAX2P5EG74xlA4Um90y/QEK5kPno+nKs8TjXvwWKNjXe0BLMsAH?=
 =?us-ascii?Q?zbLT+Pz7Wul5mR7RBxlMN6htC0lFBkRrKKzANDvDHbtQfgqPOzOXvunLSWUu?=
 =?us-ascii?Q?7svE+Uty4RLyj73nfHxHnIUQZ3G4sp2qYUyLiMHsL9lM/FnzQuOWL51GVOgg?=
 =?us-ascii?Q?souelYooR/6EDpH34h5ihUAEIk8oDsfkOySmiYNwuewcE3VtncS+ZX5oNHlq?=
 =?us-ascii?Q?+2F8023shH6PEc6ION9xn82HbrPfcgosC8SaSedqQx3KhS1rK/sH+69++I8W?=
 =?us-ascii?Q?A5VMdF15oNn6mb52H6wESr8dHTjfCENjGOy+0QIDuLem10VF/z6PZUw8gSbB?=
 =?us-ascii?Q?8VYSmSA/AmHCpehZXVw6VNP4D4rJ4aHcHstPhKYtioAq0CIMsaUXmOERE/Pa?=
 =?us-ascii?Q?bVo/VsUIOuui6NAusXh6JHx5KneYyLInPC3p0DpVaCCcWhZeFOQb0FixIJCc?=
 =?us-ascii?Q?4tc2S8Cl7mA9/d/2V6sk/IWZROZTa5J+cKcJrTXvkDZ4MnESUa/1YNOo7S44?=
 =?us-ascii?Q?m1CDLBcFi2JlwQXJawgQJmAErdFjc4uYNPX1yNabO+8ltH9bGrpGDE3F8X+y?=
 =?us-ascii?Q?M+MCgw/2phBdmmcJ9uWUDz/D9kVRt+IPI8JBGGAklZGFoLwIX0yC1f16W50h?=
 =?us-ascii?Q?foiYyr5xJAQJXFnwAvqqQzgqJ6MHae5zYlN6mROsvQnpfwfCs6uja70np7it?=
 =?us-ascii?Q?596efB748hT3xuQxesU4+RZwP/UbKUsI6ys2lSdnZkmp56wO+eUEOKdgQ7ma?=
 =?us-ascii?Q?wWOULEVC2VW8jTug8VnkI6oheAU1RJdhpSr2xs8ARae9MQzTjzd7ClwOJCV+?=
 =?us-ascii?Q?OGnCiqT8KEo0oT1CuKrZDGFfWfxWpi0n0dA/P9xJ+vy7lR6Z1kfAUYPapAvY?=
 =?us-ascii?Q?nrXp4I9r0HuSMDrYUhNm1T26Pv99PmKcIc8xgFqKoVlUUVbWuBn113mHB+5p?=
 =?us-ascii?Q?ILzjhd/ObDqPGZqkzzJc0622uMMCPU+6jNj6vtZM0yvZIm5jk2TqHGiHaRbh?=
 =?us-ascii?Q?61mj+D4tJf3Nfyi9PzzJZWMAVZQm8QFNpVtr9ldYIqO9k953Ipln8XB0TOfd?=
 =?us-ascii?Q?h3Op9rV9cGvCAVC71BuK1dvREj0pjfOt0UE058yGvX8utqQ5yEJ+f4czksxq?=
 =?us-ascii?Q?l0ww2zASKaWX6D9k2ygAoA9g25ofheYvFkBR32+y7BAozXTB9dCoHKK8+dBe?=
 =?us-ascii?Q?oRxR1ZnFxmNEIv3RewarWQukfNLfLm6kW+USdjvZXfg50krCQmxLSGorFi+p?=
 =?us-ascii?Q?wMGzeS4ZOVnp7fKepUuoHu6X91l1GLzGiErsmq4jUSRI2ij5ecWcpNyIbcbr?=
 =?us-ascii?Q?hO5tpUJZy5ioHEs52szfR23yRxZL1p/HQP8+1f004GpMT7nEukAVbPHjS6Ze?=
 =?us-ascii?Q?QHNPM2cPmtnYQIO2dtKiSsc4+X7ZFLTTjdARr53ZuiOTeKbrqNthojT/m9fi?=
 =?us-ascii?Q?82BIjJWOpM8mB6/mpaDVP3iNNfvD5b7ZgyeB31LIG9SQl0W3lTGkU/IF9ZRs?=
 =?us-ascii?Q?dv4rFW6RxVVQGdcRiHD+5fYWJqBLvJtxHVRRp4ngkztSRGdvCfL/Z3UXeopR?=
 =?us-ascii?Q?QMNxJ+WfeinvqPxDIqE8ljRBS1uqvYzZHzyvpIfpESnd6zEvb7d7+anC/GCI?=
 =?us-ascii?Q?o7T/vzn3KxjEsaZr2BKdUOjETQhv9Ko1Q/Q9wjOPwVhuCoYVs2fN/I9LSjmW?=
 =?us-ascii?Q?pw9/1UVjzCdHk1FSY9l/c3bLLf3twew=3D?=
X-Exchange-RoutingPolicyChecked:
	Uqn5SscrjV+cyW583NSnNbHjH5/sPOIvvOX5PEXSikhNRFZHg6AuWenOOnoS1n/aoyAmQ8D6SekMhhl+xWtpMCyLAUoCA0uW4mL7ZMCjYs9GNVh9EnW/lAuKo0sI1upgsFgxM9HSUHlwdWhXe+bLV1TOSe7dfsnId7PzI4THwjvTTbMwQv8yu6YnNxlXlipjCI/aAEhnz4E0J4CO7iH+BFwipPaVGjCPbPaMhC1pUJazZRP5Cw++Uj5O49Fj4VBk4ohVcWobAfGXmekjuIgqfmIBaam/L78DmLtxTf650ATz7K/rhalzi9XAvRyicFdGxk95rOVJXIhx2Re8SZH4Rw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	061S3ajCh2pdDPj06DxW1irB4SugMrqmOamno/AQwPrlQ9+An3n3Z3pclMU9TRbw0LTgjqbzDHayMfzXP2gYTigG0S5a8sE4HS1f0LI2p5MOBVqKBs40v4+Hs0VFMWZMHdQmyFATQKtmRblnDCVMwZqidPCaTZ3MhhB53vw0WTPcoTiJ3v5eg/38J9GPvK1OPHjxS4wR9376KNfAOGo3WRXN6/hjvrywWnUYhYdZtbTl4QG92zJsqjOFrJwpeAIc+nqcB9Hql8MD8VLGehoKQxHMN5JgdbNn68tnW+yeimF4Q9TyAz5BdobarJo+sZ6yWf1GzyT3Gcy7mROV0VDrKkgs/MsY+nZ+X+Ypvsqij0EZ4R5Ei2ILSiXBnaEWD7SP0HhgJWfDSBjcmL3sAEbhE+P/V/JJe7Do03XhjTF9ETUoqr/bxIaA1HZxG/1yPvsZS1FY+qsGTd3cBOgtgC/bTfouD/y4Q9gHfuIKWWhpPd/VBIoSIKLQdXqvpwg+V4BsrlIdg+PPU0cJztfsT29uKggYH44EzTCVwZaPpSGrzP7b0mbjxM/olyhEmYguLheNJqMmAeomvX5vws8cfkdCiLUe9N7yvrmpuRorFbgzvuU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926e339a-6da5-4fae-fbfe-08dee179ea76
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:31:27.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgOCe2exdgLIEiKQSs4da6LxpFsR9wGoGQDBd2bZwB4Ew2XLoluzSiqyFeXItId54kAg/r5mU20Lw88Vhqs3ek/rRrNLlLchDrRkGUBaysU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607140076
X-Proofpoint-GUID: N41uIpRbgpHQ_hsBRlo89RudobqDbSYn
X-Proofpoint-ORIG-GUID: N41uIpRbgpHQ_hsBRlo89RudobqDbSYn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX19jIbEolSi1a
 EJ9FFUjYe4f3cUlCz0rz7l1pVC6Xbzo1FV/JOCKe/FBsYOPxKJNOGgeNr+DMEEEps7plr56pnDi
 tKAjnU+olLcPtgkK/gzZAyF716FFbxrA55KbYISFsJm54DKxumZv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA3NiBTYWx0ZWRfX9IaJSn0OudO1
 LVeJDsSN2GvTh3PW0KBP7WK3P4TT9rJ8VfSJ2dpZYt8JFYb/AKxCMSCmpa2oVpIiHMLVpD60VRo
 9WrgneOgqNhaCFE5EeaWUTceH/8qk8ze6/wmlwjgpDgMvngs7S4QGEbrFHV/zJ3EpTRJoYcyeB0
 03O3xpuMbeoXATO3AB1EjXv6HSYVxSyxlaLdRIH+lCKYy0cK3EHuurjoJgPFROxuLnYCkauSDYH
 LKfex+d1gcsVgbBWZBAobWAkJJqKa1ziLqCtVR8MKH04Dc5I69ywMEg5O9OAV1ylFHEP3UnhKKb
 w91cpBMkB79FF/lAr+wbZ2Zvqe4xCzFvc0usKVnCOD18XR7QhC8fOy8I/qoQ/Hmo10v+OZb802n
 loTkmcxhGCGc7h/pBcKvC31th9F+L357Ow6IOpGCNVVqZo/YDBWyUwbMA99tqcZuayX8EFL5Pot
 r9uzhbtETXo0h3uEQOkALV8ShLbmdywCzSAPRiSI=
X-Authority-Analysis: v=2.4 cv=c+Obhx9l c=1 sm=1 tr=0 ts=6a55e5d4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=bb9Fw_vXVJAL2FTmegcA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12222

This enables the barrier tests to be built as a module.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/lib/delay.c               | 2 ++
 drivers/clocksource/arm_arch_timer.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
index c660a7ea26dd..dfb102ce3009 100644
--- a/arch/arm64/lib/delay.c
+++ b/arch/arm64/lib/delay.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/timex.h>
+#include <kunit/visibility.h>
 #include <asm/delay-const.h>
 
 #include <clocksource/arm_arch_timer.h>
@@ -30,6 +31,7 @@ u64 notrace __delay_cycles(void)
 	guard(preempt_notrace)();
 	return __arch_counter_get_cntvct_stable();
 }
+EXPORT_SYMBOL_IF_KUNIT(__delay_cycles);
 
 void __delay(unsigned long cycles)
 {
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 4adf756423de..91ab8552ead8 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -28,6 +28,7 @@
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/ptp_kvm.h>
+#include <kunit/visibility.h>
 
 #include <asm/arch_timer.h>
 #include <asm/virt.h>
@@ -897,6 +898,7 @@ bool arch_timer_evtstrm_available(void)
 	 */
 	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
 }
+EXPORT_SYMBOL_IF_KUNIT(arch_timer_evtstrm_available);
 
 static struct arch_timer_kvm_info arch_timer_kvm_info;
 
-- 
2.43.7

