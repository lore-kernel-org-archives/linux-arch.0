Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793259143;
	b=xFgc0D6Vno/IVrGJfX7/O2+q66CmUPo/vP/sVTab60fzzo+qMythw44oM1iwRQNZluhK
	 wShuUFjUZsLCjtue5lFPD4Y8rNdS512LOthjHkZ+2qsLzjIke+knqLdYcpkXgmTb5dGIc
	 eGAeOR0VV0Xrgqgpqq+9ZcWTwwYH9vO7MMEOSky57jLdgq6EYrZJ1rvICvqfTkYxo6tGf
	 0sDLl+IlGZwy28V42PGIyd5UxRJmIYEWZXE9xLe4X/4iswZ4LuH0zk3qNW4SN0id3+G0D
	 AejEE3hugN9/38O4CvzTsntU5NSpQxEhINBMR63ffkw3UvpFgaVvC5DQ+KbUNhmQ3WA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259143;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:References:User-agent:From:To:Cc:
	 Subject:In-reply-to:Date:Message-ID:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-TrafficTypeDiagnostic:X-MS-PublicTrafficType:
	 client-request-id:request-id:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID;
	bh=RgIbnyqZACky5ENbz0i39fBw2J07WUrD52ASbF2+tME=;
	b=CqYnpGHwmvbHT2c20q6dOtug3vsUE7FTUJ3gW7I7AbcaH3CXutU7dYcAOY+Xl4jfol0p
	 VeMyLOzS7JruKLHOcgmbzUwzqhgwbAbpDZ34IPTzFuzNzThEBoHncWyAFxyapHCxcqU0W
	 ST2jciFV0ybUgx44OxSHUYuzV1q901GFa3KEhNbukoghQRKAblcTelsCxmZjKItPoXEvS
	 32Y8sY1JxmQ06/DXv7cLhIL6BMIbOMV1czl9/IFYryqpSn9VMMJC5X6CoZHLGA98lDOZA
	 EhdDWlu5UsX+dOtJb/NmVKC/qnS+xbHNCoShD8dW32vJ1GXcq1DBA1YjlQ5fuhpFsfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=X1lQ37RD;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b="GWZt/SJu";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCE606A31A;
	Thu, 29 Oct 2026 07:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCFCE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=X1lQ37RD;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=GWZt/SJu
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SMuvsO4171489;
	Thu, 29 Oct 2026 07:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RgIbnyqZACky5ENbz0
	i39fBw2J07WUrD52ASbF2+tME=; b=X1lQ37RDV86z+EzCHoCdaayYj7DzT3HSBb
	GIZb+OJ/+3lSPJ9OeW1Upbpx0LufWB2hU8yK/ZgxGONxL+vBFC5QxNBFdZXK6hIa
	8csrdIZuZU+y+0r4HnarIic/jbvfKKyu9KqQ3CIGZLemABfXsVCWDZsAWaVWNiBA
	JR1Ls8MwsJn0nlliuiw6PDuvL1XiAXQpN8u5E6a6Lg/ElNfE/V7cH+9QVABB+ZXG
	veFjS/8rJFnRMA52UdXUz2W4UaZXAsZF6CPynjreUX3Url18RjN6Dgwzt5mhYL5S
	nqxB3RNx2+kC91tDA36m/Grs+R1sfwAcpy8lfiXQ3uP7vBYU/fvQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hgmj7q0aq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 07:31:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 69T5rWLd1064767;
	Thu, 29 Oct 2026 07:31:15 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010001.outbound.protection.outlook.com [40.93.198.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4hm0d4tvhg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Thu, 29 Oct 2026 07:31:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6v0i89Ah+pJFFRIRAcCtXPErQJHzoJaQ2lDwC86ruiIm8vGKZ6YAxRKG4k6jY/8k4m4oDlBD4SalKwRnM8LnRZdbBaSHR18b+uoR9Z8a5hEcVNNa61cAc7iUyEW9+jpFL11ooOBmiG3KVBUwALT0Oynp2nxxF3p5MCIqf8UJlI8CT2G4TqIOD6pScsaabybOuH6eVCKMfsTTDI9aVvaY9zTp9tj9H3vQZFUhuILMLcjFLGHjKoHI67Sc+gW4/6g7chpVz3He049x+yVUa5QH8WDZfifz8zEAb+3WQAJUeEON7QQ/fRyDoQXv5j3jdbFnUELvVmHUhSm0jZIxF95ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgIbnyqZACky5ENbz0i39fBw2J07WUrD52ASbF2+tME=;
 b=ex/nkkkIKJsjBFdjR5tcaWQ/TN7arDg5lOec6IW1QLGkNW0R7yLUDcp+twgGMvaL11U9VvSz/cDjqJEsl+DZmyub4zijaRrVkz1GZ6l7ti8pJFmwAjdYnz82u9cO8jZ11pJEykgWQbkSPs9CHzgIc9+YeqkUJYN49atGiXoMuj3krJ6Smke3eNK/iXcCCQ7AsVcSg2+rkwpLxO4l0WNoQU/o91+o6fRqKHGNThBZWfPZ090sYn/fVcLJzdohe3NoJU0bZRZGBXVp1teyPECo4Oo1jYBJOUZsmP0t1ZymtPI94JaJbVam7xOXasbx7Ck38kmTozvDqsou+3vUwCmbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgIbnyqZACky5ENbz0i39fBw2J07WUrD52ASbF2+tME=;
 b=GWZt/SJuobTlZ+N/nG7G/gTvqI8qE0ezqRp/xvWQCXQQ1z5MqkSQPX0f2KS84xVqM4OvpxBd5s36F9edgqKNMuWVG1vkkyaBfzY1DcTwlK3nb51IZi4E3RFXaifyJq1f43dbAwLdwMgESsIC/xdGEVDPNa3KV+MgDFQUq79DTUI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM4PR10MB6254.namprd10.prod.outlook.com with HTTP via P2P; Thu, 29 Oct
 2026 07:31:12 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 07:31:11 +0000
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
 <auLHZnaCIajW1kxX@kali>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sahil Chandna <sahilchandna@linux.microsoft.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@kernel.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, rdunlap@infradead.org,
        david.laight.linux@gmail.com, broonie@kernel.org,
        boris.ostrovsky@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v16 00/16] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
In-reply-to: <auLHZnaCIajW1kxX@kali>
Date: Thu, 29 Oct 2026 00:31:09 -0700
Message-ID: <87v76lezeq.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:303:86::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM4PR10MB6254:EE_
X-MS-PublicTrafficType: Email
client-request-id: f23852ef-5b42-4b78-85dd-5bc710442c7a
request-id: 7b877991-5d5c-4b3f-48b2-08df358e9ac5
X-MS-Office365-Filtering-Correlation-Id: 7b877991-5d5c-4b3f-48b2-08df358e9ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|4143699003|56012099006|261009223027099003|10067099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+0FA3RpdcyivdJN/WSpcmEmTJGwuvvIV+nLcOfEnot8525wBPu6udzgO7s5dq5xu/7c8ZAVxe9vKqd4x8602jat2Haj8Gg8kMv8lmVegJAVWZ8kdNobwL+w9cFifW5hYdQ9ezJuPgliuTmBTmOaC6Vx7E3nKW9h61s2WjNKb2ApHkSYqMORwHTgiAWkfSlE47MZkF7GAcoB2DWeTLCoj60TS2hGO7PneQiBN1qsRYBgfh7CIfLopEM/yGPoQ7GGnCWpZDwB6obYf4V4tZeoxdeb46BPRcevRzKX019DArD2fanfU7SWoHerph4og7Oa1O6ldWmDV9bdGOYXFPBJyLN2mN5I3BP+dZ3XxYUA58UCqbYIJO9KG4M7Fy46DY/a5gOL3H6QP3l/MdzGNvsRjLj9G5NoViPtWmwlvwv8PR8O4BCKsytu2r2l1n99K8ps2Q3uevj1CizAXBvfexNyOUB91YIBZ51Lge426V44Xqt7zu6OblKzNepiaz/TeVWBj7trl8Gi3UzWgvPt/l1O5u0Md532Ly0yR6DWNdz0G2s43YyfJCeRc/OeIGKVgl8d8X5VqnXiP4egM1rpU8clo70v61SYExIv8ybZN6Z0D1pb3fLrC5pw57lfWwfhbqORK253uDOoOgwQq6yGWNhV5tPOACWgAE0esVCFRAVqj1II=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(4143699003)(56012099006)(261009223027099003)(10067099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1grRCHtYxJY1UstgriLUfWQVecEsPr93s274UcADBDGlxQe8IwvFMgoCSaj2?=
 =?us-ascii?Q?JX9Vec7kehTX0ZuM7XsGtt7UDkkwrxigWcb+e2LMqwrcAnACPLgxbCGZ79uG?=
 =?us-ascii?Q?qvs+FWrH8mB6k8qqoeWjXAxSWCfor1ADduxPl1HBOhtRL3hdrtAq2BZIuj+/?=
 =?us-ascii?Q?jooxBEPo08hpzTr8SDsIQedLmznEXXl2xsr0oeEX0+nckxRSfOkYKG4b+Fpu?=
 =?us-ascii?Q?sRNM4V4Db7nloH4poxGSzPP4FFoo4bogIIwhcrLyjtKKMTsYREvYfMuFFAAA?=
 =?us-ascii?Q?rSx10/wxnlfhP045jDE7mgHNHUu+S/X6+pdzEhyMOpjLP6DznfrOUUGhsQJH?=
 =?us-ascii?Q?QP56Qz9gg4BX10Ai9rf+VyAryIGRqYCnCG3P3bQdf9BSPBLpbzFiGBR+6Djl?=
 =?us-ascii?Q?QkvBbTqxzw7jKbIjxm3l0K8B7I+5Wm30zV97hivv5H6lVI/bKrHo9YebhVwJ?=
 =?us-ascii?Q?9SK7vspZEiyI+HA43TExn/PE//xqagqs0Rnrfn8OGyS6dLqGjDNZKlw3abcD?=
 =?us-ascii?Q?8DsUmbCsokIIIadZf2E5PBLG8o8jvhHroN4VME2FG4Y+b7bA485wVgcDreyP?=
 =?us-ascii?Q?ClP/hyWMiAlisE5Pfk7APAeev8Atyh5uj9VyZBx/VZGQnjshcNuFXoAEoaPO?=
 =?us-ascii?Q?0Ps+bxpa1oSmjyZ66fpOx3A9eEGA6mzjGRnHok/u0Qkvw6frKi1U0N8o8UsN?=
 =?us-ascii?Q?uIvFq7Y/QWdDx2fcaUkxVxpq01IsxLuumx4+aqcsyMM0QiE6FWDtN9JFHzq3?=
 =?us-ascii?Q?LqYmnybJMUB14GRdvrxfad+mOW2KIaHTSOF0WKWEbJ9JrS+q7Cm2uf4M4c5z?=
 =?us-ascii?Q?tL11NlVp5moAP2qb5u4GuU2rdqoSAr4BgbXM2OY56Kz6QnhbxntDjtCo1bEu?=
 =?us-ascii?Q?AP/EFNPgz/0+hek6824mNFuioBZvnc4VFWfo2JYkj3G+TKnwRFFaduuv2+iR?=
 =?us-ascii?Q?7NeKOiYkQu++raEu7sgNHu+iNaT+i3EbyiUwJ0nJmpI1jSNxy6h5DKVJQKmU?=
 =?us-ascii?Q?iU0COhthbYbFD3NsOucVdUlzFV4X74ZjW7c7FmfmvL8W9jdP4558QmQs+r/W?=
 =?us-ascii?Q?rG3UXgDtTTrXvEeWrfnIIw/4O+B7NQqI19OLF0VFpThvyTDTaDjlokRqhnZH?=
 =?us-ascii?Q?39yGAdJcb0CCUOCnQpZ8r/hWTfgF4o2gLcK6LGwuiLM0cui3aja0U888Bv1T?=
 =?us-ascii?Q?3FV16s8LLtAc65aU4ZQj9dEgvzPgh9y703VRXsyMOoNtzjlg6vcv9iZ4oUVx?=
 =?us-ascii?Q?LrlMrBzUXfUqJGZE20CjoCkouUmZ+AOc1yngD/MFtPkLbvoBPnu8kLnGADzv?=
 =?us-ascii?Q?PgzDaBrG/Zy5LUpwZ73ezezhNr0cseuPYEwbsNI0lky8bA5H3N7ePIN8B1HD?=
 =?us-ascii?Q?ActAnIZ4iqmIQhkldbhPVBI6LMWGAW0KZ5LvZ1iLfCwZZnPaE1YgMZbCBX97?=
 =?us-ascii?Q?uX9/aOW78Rb/J31s6kmKg+hL0tHd10G8AqI4SkBL49dSxhfzC83wn/H5Zxq0?=
 =?us-ascii?Q?iram7bb3nnZ216ru8JuxCZYuVvIHCJO42XumABw2SQuwR0MmOVtpQvnA9SQz?=
 =?us-ascii?Q?2QPCOAK/xJSUcSVBRQBrWuTCBRwPf6FhD8TWmnMdzNjjQ9qllP2oMDHfggR3?=
 =?us-ascii?Q?5WXCCKI+hDgws6XQiQ9ntOKVVcWrCwGiTlL7RFv+3QYeflFZ0OMVasCDCYPL?=
 =?us-ascii?Q?GlPt9CltpZSRo0GxaaNjr0ftFD3vPlUy9dOA34iKnBgrdR6vsJOfGIsxMgnt?=
 =?us-ascii?Q?+TGASep4X7E2XZH8J3XAIdc49zSBU64=3D?=
X-Exchange-RoutingPolicyChecked:
	RGPjSfCI9+IWqeNNgMGn6yGdhtex+U0v0hg9Zvb6Ubhj2po/I3cALgS7qhjRiFGUDE/E/Fz6h6K+kbS2egSTR/j0Puqj9jiKSpy59g0N66ab4FY1ZZ89QQIRbWkUysIash6jDy1MEHCXzLyFR/HiK3UDtRVYsfXr+MTPrR8TG9gFZLdG0le+VAYe67LeOK6SI4gW+7nBHSozLpONoCxRXC5SfxJPvnM5kY3RxVOUQNSfVuJ14EVfl5SOpCwtiMrmyPHJTsm6Hl6CPl2H42CmLiyv7gp+CkkPRW7HYGIcuNfO9vAdu+h4lq4+E5LC6RaoU2iyzQ6FZ8o/tLzKy7BxoA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0kK9OgJfk0pOJH9PrgPeS3KgBmiddOna/yh9XCigziaqX2NWLYFwDL4OMIH7k7YhthBSN5NJIlX+kJoUbVwxFUURIS3i0jyW8qOeF4YbllKaOA/uGJ7BzUXTgaHzLFgakL1WF7AI9B1hjHBM5aLo+ypcxtIhLhUd6w9hxqpuhH8xtrQUgVLZWcfpx2LGJWOdQaDTw5s5RKe3G7gCDivvAiban6lFUSW4tGLZiyVL8mSjAvYFApqUiRGkIRK5liOYlSOfwtbDiYhJYmFA1UQMloGZiZTHVwQIZMpvuY/h6lpdSVXGDQgBB5xzgItdXy+y1qOFMXduGIch8ubCJt/hRjsm3mePbISokzVXptOF4CX+FAwnL+lvtpHUte3V7e7B2voN79jce+dZVZNnpfxEJVCRo95D4p753Idov9SFO/kN9MvKVhKYFUd9Z9iLGAIPLl5QUKYYCgEyhXPyuCAnUcrUvgl/FZ/pukfLk7uq5EZG9uRvBc3scShay/0N/pbNhinm2ocxrfAYMKPL9KjQ/YQkX5rfA7hN/6L5FzWnBlOB5OaJIRy5enauINGXZGLVMdesNVpdSDe3MhGzIqsJL8SqADZUnvCO66WaSIrimx8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b877991-5d5c-4b3f-48b2-08df358e9ac5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 07:31:11.7518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pu7ehX4OH9PtBZ1ZOrV9QSzh2EPd3mdrrkZZJgDGiKmq6rvAafNkd6ZzFJMxpeeZXLl0D5SpeRAx8y4lEqGrrDZBMMDjU4FSvzsA3czdCik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6254
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxlogscore=968 adultscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290028
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyOCBTYWx0ZWRfX2xccHHijIDIT
 lqLby2nTLmZQ19bbJ1hF67Rhb5pQZ0Q461vDKDO27ViKvk7WPSfwLSd8nQ5NlgktU7dQrd/+0wE
 ETnwrJndybCL/anECX5PEL+NT67To/cpO4mGQagskAlkMkf8jlkWGWjOApjddKgt5Xb3tqxmXm2
 BGTq24bxpGfimlBNaKxJQgUFXZsJ+ywgOkne0NoXSzVWGERi0oA2c7j5YnYhxoeWb5CFTIevqcf
 QNlST6lzGKX7xc0ayKxXgAifPX9kFXhRmi4WQQSyIOdB8P8yVlTkXdrJbNaQU2wca4Z8AAziDSF
 ntKeFkqB1853Ez5cVhwacY3BzRSxEeNYWhUuOxXkf4MQK3fwwMl5JirYiIXFkzS3K8bUB+osyBD
 PgUimV1egXVssrQtmHakn6m3faI6c0M4dgCztL0He2kuTt+zmJ1vDgb3WqTuazE4l4vREV22hTB
 FE8Lt7NnrVFkF/Uwn5UIFMGsA1ZaD9Redo1va1L0=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyOCBTYWx0ZWRfX/w9vW72wYN3F
 ohusXOcwP14Nj0ktOyfAvML4EdioUmUseg08O7Q3ASSJ5sd9N6Cj8xymBWcE5AU9rJ3LR9R7U0L
 BqXcepnAJxA9Z865WMUKz3qgGKCBx1W6zutzte7B+dJEmADocoOz
X-Proofpoint-ORIG-GUID: TVnfuoFUJa8N0K1L0vO3ebenSrvoTqSe
X-Authority-Analysis: v=2.4 cv=cKV1IVeN c=1 sm=1 tr=0 ts=6ae2f646 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yMhMjlubAAAA:8 a=gIPyvA0aJkosq4B0VWsA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-GUID: TVnfuoFUJa8N0K1L0vO3ebenSrvoTqSe


Sahil Chandna <sahilchandna@linux.microsoft.com> writes:

> On Fri, Oct 16, 2026 at 12:08:21AM -0700, Ankur Arora wrote:
>> Hi,
>>
>> Changes in this version address sashiko comments [17]. The major change
>> is the change in the exit path in __smp_cond_load_relaxed_timeout()
>> which allows us to simplify providing ACQUIRE semantics in
>> smp_cond_load_acquire_timeout():
>>
[ ... ]
>>
> Hi Ankur,
>
> I tested this patch series on an Azure Cobalt 100
> (neoverse-n2 on 64-vCPU Hyper-V guest (Standard_D64ps_v6),
> on v7.2.12 + this series + arm64 cpuidle-haltpoll enablement[1]
>
> cpuidle-haltpoll loaded with force=1, guest_halt_poll_ns=200000.
>
> Baseline: no cpuidle driver(only WFI).
>
> Workload: PostgreSQL 16.15/pgbench scale 100, client and server in
> the same VM over a unix socket, with single run:
>
>             with (-S)                         TPC-B-like r/w
> clients  base TPS  haltpoll lat avg   base TPS   haltpoll  lat avg
>    2       38658     +89%   52->27us     5299     +86%    378->203us
>    4       72987     +99%   55->28      10305     +87%    388->208
>   16      300895     +91%   53->28      42035     +83%    381->208
>   32      590987     +93%   55->28      78319     +85%    410->221
>   64      987749      +0%   65->65     130675      +3%    490->474
>
> Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>

Thanks Sahil. That's very helpful. Btw what's the (-S) option with
in your first heading?

Just to double check: was the VM  created with any special option
such as kvm-arm.wfe_trap_policy?

--
ankur
