Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ED03EB0E8;
	Fri, 11 Sep 2026 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789110865; cv=fail; b=J/l1cd/Qr5/eZDS1Jmj4jpbbG3q/cEHDnb5htI+Nu+tTptNd3uL3OZcdsKoEsEUCTAgUBp1tZIum2w88qY1WWbPurln+3bHygQgWRHZb1nBFIX9lRd1shZ/4unz9RToCrT6xiPC93oatisczrzsV+zR/Wu99BkEaObrOexXcEB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789110865; c=relaxed/simple;
	bh=nKfk4vAIwX7/RIzitYgEjQvZjongbfKHN8ZxxMJCVs8=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=G4G16uMnxL1T9AVxIHQe6Am0aCPqPEyApNiimQYl3UnrFHy/9QvhYl+1UPPuDQ8mcFnitUDNvF1UJtnief1VCFfNA2nxfQ9oZ+oLntwcRdGzR7UbxwSFn7SBB4Fiuk6obdZkUbEfJtnwRM5UBJ+eHVE0UNaAl/X1zEMOeEPjlnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q/VCNRYX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BpqKVURa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q/VCNRYX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BpqKVURa"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B3dwwd1894863;
	Fri, 11 Sep 2026 07:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dXrAVSWj34zkCGZDg+
	PHEGj4I3YKEtzVq0k37OBGxaU=; b=q/VCNRYXN/c4oCeTxc+TmVzmegdZLqhN2C
	IT4cDuQSBUs8K9JoyJ1BJq+2fJwluZFy3jEoh2O3Q9XNNbl1cvGD+IQhUT827QRZ
	nLrbDDTNOGG8n5fpXCDfl9H+kUS/XrYlmSRkhMCUa3mmStSr5DmgUWrVjkolRWjM
	F1To3z9XTpvmzyQXRgDwoSSF8+dSCXXS940OsStphajBXPsQ5iar/sXcCXaZAM/6
	mVTWEI9EM6dkhu1Q/nxt5x157+qx6omef2aeUH5Z0R55UrY9NNeHdsS6Kbof1ZEx
	KQyejGteZT+IjWXLsBWPfRtnwPut+y0fMAVjlLuIWA36FVFgNfaQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gkcysamc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 07:13:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68B7AQcc016684;
	Fri, 11 Sep 2026 07:13:33 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gkckm7t0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Sep 2026 07:13:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdaW1XVylcniYQDR2A6YpGNgVM6McRbH/hGwcA3b7fjZBEr8C9Kz78eK2ilazKF7+sPZSKkJM6C86153iBU09cpF/8hz1LchA4ozZAQaa6Y6nolVJE/QVdasXJhhyzHiGpntXJqzKm35ycCg/9tMfeh5kbfFz8MfFy2xTriO+TF8mbmaV0fRMndIp6uzDAg9ginhJSx4rdlNq6kaPl/hvHRXOu+wiAGvlQ03zNppMjap5UHkFxRfs7m0ZM26Vqq8UHvWPF1gEi18wsAurXVF2J+anwn+d0EyVmPPeTlA5USWCFLC9P+HkLgUmCj3mnb6UEgSdlDOGIu5sAlCm4y00A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXrAVSWj34zkCGZDg+PHEGj4I3YKEtzVq0k37OBGxaU=;
 b=WhJVUzf/r9ed9j/bE72Tvllru0lgPj/oz9wYSw+6lWffBUlEFfI76bvg0kRext/lyJV60ytDsxoLiR2boPQPdJ90I3rQk5GJ/pmGwNLvgmMDZ39cHI+9zAZ6HjemhwNINEQck0aJqy6Q6N5OLi4rukDCbTwGWraGiYzmuj90NWnP3RTVOCuqLw2asyth9Gexq6NXJL3NR8jit1zDV5HdtIinpr+5/D1aAciSCy2k5COXQn5Z80yFc9yv0m3PFhrexMMB0K3rFK0EiGyRp8UKpi5MwWMX6jzPH4Y9THJJJaFvhi8h4CzxI8cl+27FmVvu7rwBm1VRab8jAQNzParkzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXrAVSWj34zkCGZDg+PHEGj4I3YKEtzVq0k37OBGxaU=;
 b=BpqKVURamTp9i9my81dS9G4BXJI3OJl6CZdsNrQjia+ZKh9YONlrx5uxreIhlRJeK8YpQ9LoJLXQzmPKPP2KkpMC+/83pogUcWVmy7lYugIQXfusx+BAnKmrQbI4FqFTd2FhTlcEUnA0TgFHJWHOeSmYZx/yXBuWALo/JieHfkI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPF2BE4E177D.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::798) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 07:13:28 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0428.004; Fri, 11 Sep 2026
 07:13:28 +0000
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-13-ankur.a.arora@oracle.com>
 <178908146776.2725577.2613699832033292946.b4-review@b4>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Haris Okanovic <harisokn@amazon.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com, cl@gentwo.org,
        ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        rdunlap@infradead.org, david.laight.linux@gmail.com,
        broonie@kernel.org, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v15 12/16] cpuidle/poll_state: Wait for need-resched via
 tif_need_resched_relaxed_wait()
In-reply-to: <178908146776.2725577.2613699832033292946.b4-review@b4>
Date: Fri, 11 Sep 2026 00:13:24 -0700
Message-ID: <878q58z2ej.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::25) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPF2BE4E177D:EE_
X-MS-Office365-Filtering-Correlation-Id: b3429a2d-35b7-498a-a618-08df0fd42d3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|18002099003|22082099003|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	g/Hv8+ZhmHWrBa9N2qcfe7VLUvjjMZrU9LXUSP0Py1/ZU6MLS0/VR+aCZ+vHB5yjRoE8EGF76Gtl9elNDU2uUJXEyK0XxW0OM8U2S/iarYHPl9JnDKbA4SxNfuVlJnmkzpTEWWrzB9nEQM5VO8mrVBu7ZJvLfwzWATG9BTJHa13JaKq0ntwgZmjX54auxWZ/A7qs6WmATsg179AvzdWrz7sc5oICGsnlPmhJZRVrILrNw6k+RHaGpCfDf8xn6A1ldAra8+m2UEjKtVqyWFZLgZCOlBcCLGGC7DBrcnqswh83eP0hUuU/qqnqUyH6dmpcgUdWPQddvgdGSy5g3EdI1X6ehg5HBRCY7KCmCbbfcxWLB+zlcsfgptvhCa0eWfvVS5e4oW51DQxL83wPn+XOt2bc2dwR7f7jkk4gu/D1LvSvGszuXg5Qwl1BQYOWW+HdK7ydaAEgiUT+zSsc9JGJhvJvNUen82lfrKjQwQEh/kIm2K42jlR7/yNnJKSUZkTtBgjVSdp5Vh1TVCaIhEfgNWuA0YjGcyMRzthJ1aMDP7LWOh90D7kDr+QUkOUCA0sPAv9yXjjIPZDjbipjHxvUSouhfL6q51+u54QnxTYDWtcAAGWZ/vvpl82/Qbb5RYADv6oAny7vG8Ka9gupOAFvKSOoUanILffIHNzYSigMJe0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NW+gvtghqoseVvD54CZg18Pi7jtmLfi9lGBjnWmoCu+AMyi9LTshy54Q9LKf?=
 =?us-ascii?Q?nG9ltJrA8vVCE3Y8nmLjXz/Xz5BqlwD/rEzMmI9IzpuC7TTmjzhJKry1KlgX?=
 =?us-ascii?Q?IAfKH6rZLV5Be2fmjZ0nRhhYc30v0z22fFwJ8KvKX8qVkyAVnGAH51IDOnx2?=
 =?us-ascii?Q?3lzb8m4i636VSjyWpllmOP47OLk11NFWw8jDjW5K/NfRTQxgBukcmg6wmhm3?=
 =?us-ascii?Q?an3uDgQ7NMo0Y+aGhQwZk6bdranihIURMWddT4gsaUkpzJE6FaW8iIKmBNp0?=
 =?us-ascii?Q?+cqoZg7R9zHaDozsP+KWKRoQahjI/XTlE/5BRonYKvXDRJCY2EPwo4MP5dit?=
 =?us-ascii?Q?g2l5XpydeF2vrHGeeY1kCoj+c2hJIKnRHcxtkeHd0QbukG/lwsSyv3IEZqng?=
 =?us-ascii?Q?NImVPE4yqs7WxbtK93NOGaFmoHFfwuh4I+j4Nz4tYmeuABWbkTTGrK2FzBv5?=
 =?us-ascii?Q?ddhzee43UMf9tdHF0AFh4h74PEmCNcbbQ6Vne1CIYrQkj4+l4Reqxs9dTnwA?=
 =?us-ascii?Q?bdU7uNVg4oyj4mXpObWHcqUmR7PDUkqMCGDMmj9P1oST8V7+nVCGxPUFqyQh?=
 =?us-ascii?Q?gGTEbVix85lOP8R+/5GuFJrRGA8v1v7geMzERm02xc2GiO5wXW4ixtrumNnZ?=
 =?us-ascii?Q?PLQseM7z6xBJjSx2J+m5TK3oZIVvmBIzLrc1Of+KIr3VxoHWKZvAko07v+TW?=
 =?us-ascii?Q?1/yzzRMPPusYcgQQgkhz27MGXBVPufj+2Jt1fQw3R5smI9WV+T+65q9u3NAM?=
 =?us-ascii?Q?8RO9LYiqhzvFlnrktuBnCDDCzRQz/Phb4jBTZwBfyOjkOTarK28TSbRTbaxb?=
 =?us-ascii?Q?DSLiKp5UJb38W9KLBRalLKSi9PAYqfbboRZTDe5SLhz1EtW84FK5ciY7tGhP?=
 =?us-ascii?Q?qiooIwo0rQo9bkhOzHkErFEH0wz7iIQiIZy2fWFnEttjjsOHW7pd/hTS/ImQ?=
 =?us-ascii?Q?mVYM0t5yjwUyXPs/sYm2I+/LD/Z1PJx70r4AbY8MNTNdOc1+Go2MlfJWyOt3?=
 =?us-ascii?Q?nv7o5azaA64VnzZ9exsae8cveo9jw6mxX6FJz7frplF87M8n8ks0k97Tg+c5?=
 =?us-ascii?Q?mkJAmZZnsW3/Qsav+LAFKoonmuQNRRei5BuPCdAPbnr0X5dqWGIow503Dgkh?=
 =?us-ascii?Q?aK/pQlvS2LFyROO9yO0L3sUOAT8BB8IJ/LPM5xMmDJjRsQP/xCad51JGxk3a?=
 =?us-ascii?Q?/IxM7s1eFl2CFPsE93kquS3hAHCkV8j00kgOErAJeUleWcyOEdIFjcDLU0/g?=
 =?us-ascii?Q?ojYVqxRx5Nhm110emEz9BV6hawvfL2o6Fl5g8UzQ95Q0wkqgfW2Q4p0B9aPQ?=
 =?us-ascii?Q?XyJQ+2tD4ZOC4R2CyrGieS25dFiJdi7h6+HGO+bsI0pKv0bZvgaPTvUs4ItV?=
 =?us-ascii?Q?waCwxNjciy6Mfeq6PZJcQ1P4dXf60VyDElN0fHzxlOboO6Mc3y2XdofigqIP?=
 =?us-ascii?Q?+jHXAfSEw+qxMZd0D4oGvwqZXQv+eegzxjIrmHS0vBMC7/J2tORycCfu3VEz?=
 =?us-ascii?Q?9vLpbHiPGk0yi1a6R85+mG86AHYwpDyjb2qXMpztyczzb2YOP41UflUn/48D?=
 =?us-ascii?Q?ba672+tNGLGcHemPzOPhXW5UGGDf3DhZX1stqM3LkgJiLQAWAziI8hhl4UuQ?=
 =?us-ascii?Q?wyUqK6vBrt46WJJ4ujwAv64lZgeNAkNqTpqltKEg/DkqO6Uw5NSeL3RknxrN?=
 =?us-ascii?Q?W4OnyzKLf01NIac4O7kqC8n+FLU70RiATC2ApqmisCuJojC3J2gq3+lIewuQ?=
 =?us-ascii?Q?mMos89t0jV0nFwGI9+khfuCrJWWWj/Q=3D?=
X-Exchange-RoutingPolicyChecked:
	Gg5U5Xl8ldo5dXXZHiLqXctPjofWShAUgZC4Y4VOnKT9hDRkEwRulgMySg92qMHxMfg6rYXN1/FtTO1nLA6GTideYbAu/9nQzy1l/b511w8DEVXCiJ55hpgi+BmNcjI19siAVmOab0IpQ07Zz/wou90VrePK/ShWYp6PFY8UyrhfFDaOOOSpglNXZw1/yfilDTBh3x8EK3yJrg/aDBLRVylZ94uVqU9hsYBYB5drsP86x3lYDuoW8C17XDANoaE8TFJVGUkr38A95//kOGYkxIuyHsK49H7BQEr43yh4M4Ou2tq0AseAa5YSRmdvP3g4Kd6otwu4rUveWPDcEjr/bg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qv51EHQVyTe1tvRCSYdOY2+ASXTgvr1jzpam8iBvo944/sKZWl3cAFEw1o8MQt3wUsumwepETCIlrDWrJbnFqbQNQrXYDRUdh3c2F5xtd9KMKgkN+uWcTiRTqANwaFTt+BjNd32m/GYoQ0E2U8MYnUefnsvJHT9zfdxoskZRehdnwGsCH6QzXNQIswS1k0qLGHWLBwQ22u4guNFnun9MbBeIJUb2EsfRHFvNeQgQcOPwJSoPrlPcjWASW9NsAkEkZylp2CeSgsw8/eRzd7hjczsaUBsuutdZFfCzjh3kq+pREUYPAVfzWfSZUEvcmyTXrBT6+EQ+v5G9IS2bi/q4novD99J8/JvMZxblrUAhsKKQE2t6uI64pYkPDRsUI7EO2RjfzGNK8k81ghhGS0U1LI1Cy/Ebr/sDTDYtIDRcWcGmAU9wtzospSbFE/gpPyRxHGzPmo/8mxn/9k62lJIgRAx/VqTvllyiEgj7ngzCRlyVybnTiewUYUmOdXo0KZvh049Ao+A1BZvouDzgm1FdY/uKNn6V40VSnbA/MzgDS7UBujeOstagxpfrA8A7Q6vhwd1GbKi9pFrx7dhU/vSVHoMNTxIBo9JGbU9KgwKzEIo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3429a2d-35b7-498a-a618-08df0fd42d3b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 07:13:28.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X92PJtMO7yCmWowQjrFdvcoTVQb4bfs7jk3ImSmqkXTy/lRaSHWROL2VBcn26RLONR+n85LCiZkeyon6KwChZxzattsauXnLUorCrYc92hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2BE4E177D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609110098
X-Authority-Analysis: v=2.4 cv=KNfPn1Fo c=1 sm=1 tr=0 ts=6aa3aa1d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8
 a=uJFUT-3x69M_IngTN_YA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12105
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDA5OSBTYWx0ZWRfX9NEe6K43Au+6
 BHz8PKipNfMS2CStstby5spz9WXNuLaxRdSK4gM5+C8TiR1frLq0+PcnKUDVyJKfMqshne9lhMA
 M288G6JcHdAQs0/EkH3smP1WA+PHnxtnUwru8GfWM3BqSvmIl0tBBM1fX/HQIQZCUVVUgXSzEfk
 weVmXcZ8q8iWSR3pyyL3bgQvL1GrK/UTf1fHaE/YNPMEO3OSST3bU9r7q8umNtWOFvsb3MlSGFp
 bRHtGQW/pZ6PKfdPDcAZtCTj96l2W6RZmLHY1v9c0MydO70pwCks4qM2C1xh0uUzUjiP9PoTncW
 SZy4CFrcecekD/mfwj0FVYMxAtdOahd9GhRapNBfqqqDD2mlRxs74Mvjb/hXEB+rxAiVjASbCzz
 PDnx6MCDqU3UTPRVVl3GkSNKF3bg0cWrJXGSVwXvyamAtgfoVklFTa725vDIiTuUpOJEJPuLagc
 ejkyo1SQDbKZOX/OGbyPiHj2p9bQh+r/e2HKowGc=
X-Proofpoint-GUID: P5IfiEMVn-gScUf6QEdjsHRLaUSydSJ6
X-Proofpoint-ORIG-GUID: P5IfiEMVn-gScUf6QEdjsHRLaUSydSJ6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDA5OSBTYWx0ZWRfX1MqxSQRxwRRE
 aRHnK+1l5xXZ9gZGOygrbRB/IjWDREHiPZlbvWB2fOIggPQ1r2X+O0fX5D60FBdZEuUMeAc4Hql
 +Wy4dLcRx/g6UMEEu6m76rMSPCRKBBWsu4JSpFCAczO3aj+rkvVT


Haris Okanovic <harisokn@amazon.com> writes:

> On Mon, 31 Aug 2026 13:22:47 -0700, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
>> index c7524e4c522a2..7443b3e971baf 100644
>> --- a/drivers/cpuidle/poll_state.c
>> +++ b/drivers/cpuidle/poll_state.c
>> @@ -6,41 +6,22 @@
>> [ ... skip 36 lines ... ]
>> -			}
>> -		}
>> +		dev->poll_time_limit = !tif_need_resched_relaxed_wait(limit);
>>  	}
>>  	raw_local_irq_disable();
>>
>
> Tested again on AWS Graviton3/4/5 (ARM Neoverse V1/V2/V3) with haltpoll changes
> atop latest master 8ab1afb2e: still seeing average 6% improvement across various
> workloads (mysql, postgresql, cassandra, memcached) in latency sensitive configuration.

Thanks for retesting.

> The new unit tests all pass on both metal and virt variants of the same machines.
>
> I hope we can merge this soon.

Yes indeed. I'll send out one more version which addresses a few minor
bot comments (and patch-1 needs a re-review because of changes.)

But other than that this is as mergeable as it will ever be.

> Tested-by: Haris Okanovic <harisokn@amazon.com>

Thanks
--
ankur
