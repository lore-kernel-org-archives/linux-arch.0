Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E93C4A8426;
	Thu, 15 Oct 2026 07:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048190; cv=fail; b=WcIypVx/gDIqM20W53asj/G0GqSUcHJzkuGp0dUOLxVltSdJf5TDnhv7pC3+2dK6CUFOwfiuyXOPPapAUWGiA47j7n/sa12EM2DYsfXe0sL76CN3Urb4Obek2L8mE7UIiYz8IQ0ikrOAP7t+yTV6Ly5a1ymKd6PY9mN3W2A1+x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048190; c=relaxed/simple;
	bh=Yw4Th0rGpQdTHeMI3A8AZEZaQo1iJqxej9fCf8vziBQ=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=LjS2ClK8Odv1ldz3kd/8MY9GHNViHODkiJtnPX/4GKRLD/lBnXSjVSorEZRDjuIsbIMe5r1YVWKihgJoYqR8wYEBivCaLe9bm43yNvmF4tWA5tfYsg7CsEDz9ldPcJOs2bqly0CFVBi6LKnVjIY1k32IDVzWYrJQXJJRjhLx9VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OZ7zclZ/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mIicKPa9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OZ7zclZ/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mIicKPa9"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ELg5AX1678523;
	Thu, 15 Oct 2026 07:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Yw4Th0rGpQdTHeMI3A
	8AZEZaQo1iJqxej9fCf8vziBQ=; b=OZ7zclZ/2AcznkdpaIjvj7YCiXFrJMJ9t7
	M+n794XSmPIpzLUccZnn2nGKykExmBBWiOD9hpqTQeG9DTzYAYvSkM6qRaX5CfHT
	vpf7+4HkHu+lvxIwzRf/lAIL6jrIL6fWqELRZ8oN2HtRzoj6hCmaPfO/EZE7tFVM
	1TuXjXGB/1v3qhxqWcQh0VRGDDSDnoN/lK57eJyki6+V40zMRYcFM/TgdM/4ghnL
	eJ/YuLufXl3FO3Vh3SA65NyZjbJAps2XJI0YmMwap0mP8W8xBBP0//gVF+hrKVqf
	E5oYv761TtifXNNKFPp5N8uWRnMoc0WYHcnYphhnb3C47hfrSTlQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7df7yj5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Oct 2026 07:07:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69F76g82031889;
	Thu, 15 Oct 2026 07:07:00 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btrtmck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Oct 2026 07:06:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtaANyWyqUz+VuIrlzLDETgWrP3yOPg2HxmfBcxt8g5rI5WXYjWb4PvHG7lns+U0qN1tetiLWeX+j5jOO5SDC3kr5Yd2zgacsN3HcygPvRAxAZyrEc6bPpQfJ03mKdWvVyyF4cxkqWTuGjiC6DP39UZNEnlnS5oDXRwg+htMWW/5DGBYffsh9egfqpzwO1mX9farM12sQ3e/FvKG51LXWkAS76XQhgm8GYJUH+D44Fklafgl10wRQlxSZWEuzwFjAAL1QUvB+TtHTe9792oYiIWGzdSekWMUu3znYEJcJcDPHVWuUXEiKzc2SpB8OwyXnADhaDshSxTuN1T0l0akgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yw4Th0rGpQdTHeMI3A8AZEZaQo1iJqxej9fCf8vziBQ=;
 b=KUvbp5CXkTc9LbTNfl2EJmeDa8VK/oU71qUAeDfwLpbqI6xSy8BGll73sEqSA4DJdHoQTK4neIxEzAY6BBKcVlodZfc2iCo8ABevvLKBfC0IbhaoE2RtuPBJgDNT14ssYYY0ZClEVbGTHv70njCkBO/uty0ANWLC+6Ktq8QQhVBKuBbPfMc8xyQ+J0mpXW3ITFXqL3FCtZTgxIyZRX7gExsZ2X8WCmjDpMpBCftZIcqonxyXDBpLjkTBjY6EHrGzqTDmgzbTzcQH2/PUV041469YRlPl9DHlCVs5AE+DmZ9QktTDYEIPTAMdMMQaajabpIzU4HXi9n1PDHneov52Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw4Th0rGpQdTHeMI3A8AZEZaQo1iJqxej9fCf8vziBQ=;
 b=mIicKPa9Jf8lO6msfB2B1WTGM2cMWRrpmHvBVzyVD3GZyPwPEjooEnWpynZx9UCQBBAoG/5Y6s4J9KRT7+n+fi6egIK+K44doeJr4gst+I2vYAjsft3B8pzKHN0dlTmOZ0YMXnzItyeLdxKxIHVvzem4YfZjPDRbKHBFJ/irjWI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB7936.namprd10.prod.outlook.com (2603:10b6:8:1b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Thu, 15 Oct
 2026 07:06:50 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0546.007; Thu, 15 Oct 2026
 07:06:50 +0000
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-13-ankur.a.arora@oracle.com>
 <178908146776.2725577.2613699832033292946.b4-review@b4>
 <878q58z2ej.fsf@oracle.com>
 <3e8bda45-0aa7-d0be-8aad-dab95902dcde@gentwo.org>
 <as9EospGcR2e1mpO@arm.com>
 <20261014130306.GK2009045@noisy.programming.kicks-ass.net>
 <as-eaNfjOAUnfvVF@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Christoph Lameter (Ampere)"
 <cl@gentwo.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Haris Okanovic
 <harisokn@amazon.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        will@kernel.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        rdunlap@infradead.org, david.laight.linux@gmail.com,
        broonie@kernel.org, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v15 12/16] cpuidle/poll_state: Wait for need-resched via
 tif_need_resched_relaxed_wait()
In-reply-to: <as-eaNfjOAUnfvVF@arm.com>
Date: Thu, 15 Oct 2026 00:06:48 -0700
Message-ID: <87qzhrqw6v.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:303:b6::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f35cc8-4dc9-4f04-ba46-08df2a8ae274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|18002099003|22082099003|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	U4Wx9mWHo58RYfOXx0HbGPYOAzxYo5aueMIheljUQSsgur+xbK9H4DpV6uQF42arVoxqjSArbEHhbMGe504hPus9w2TPUrw9R8gyv3kCfZIDsxlT1wsMgxFLN2CwUvh8J9fuH4oq+NJ47qOfyVtGqVTZThhvsROejrRWTlGH5W2KQ3a1+MnqiEDg96Ku/kNzlw6SHTmJvRrA968wxVCQTt5voY7CnwzZMhiD6k0Y9eTpqYi5L8QP4bw8oQsW8x04sb/xAwSug0IqPDXHkESfJDDjRm1glTRU7jLsyYeF+Bs/ke9WhoMNh5KYpJHI0D1rVI8ge+wNMsrZkzrQqTOr9exQ++WeX4A9Yl+7R/f4ooR8tD9Awuye5XJ5Pwj6xviQDKEMqY3cP+np6Iy1oYFNuA4OQYB9rFUeFFR3FMvDBBo0YJvtkM3wPYYtLrbPhs8qeYKD83lqBzwzj3+L39sE/c4HXhD2COgEXYadbjE3oNAQGlFO6QIApAVafPoX2IHTkmIB3gB6n/P5loAf3/HIQRZksOhTKap3RlfzWnso3QTPwZuNm/5bNFjCJApNVSuAUL/gUYkFA1jlqx4zedmJVCnKxKhn5FzILBW5y6mB2U8+qjuTJ3C+8UIriGu3Lp0n+JmSsSTcuBou83xDrn4n7DNjIfcPBmV4qSLl87V3n/M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(18002099003)(22082099003)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4t+UnIZIHNgXk6fZ7zzUS3dYLBHW2tp6JojEII9euBVQqsQAZjVdoPhMG+eM?=
 =?us-ascii?Q?945E05zGy75odsRjp+9tqpK5Xlz/QCHUAXRIFTzr++4bgjMu+97/ODAjWX+L?=
 =?us-ascii?Q?D8PXVR3ejJW1pcnqNyzyRUMrxqsMwKw1fqTqa8u/36bhT7nMynlAPvm3XkB2?=
 =?us-ascii?Q?l5+Jdf75wbELd9N0fYxZQfJbG0tbH3eZXBfX/351aPb64mYIrdVUs13n8Vsq?=
 =?us-ascii?Q?I+bTgNIxUa2bgh8EA6UgxNI+299sHBqkUw322I7xFLgZTjCnL2IWAvMN/u+j?=
 =?us-ascii?Q?r1fPh4jRbXhA+RomRXUggN8I+6gDQTbWNdY8FF4KR/Or3Gz5aeWexBll59Ep?=
 =?us-ascii?Q?6xDFAusuLDQvCLmf0zKT8y1SSL4+kibzauM9AD/zKoGvMRxktfjkHl+Br/Vu?=
 =?us-ascii?Q?R27Z9JZ1LAhBq2/AACkkX/fys4PSWgSr5idvb20mA+Sl+60TKb/pfafAmcpc?=
 =?us-ascii?Q?cOmZtOc3QF0AqaEWgLU7MQFP+BsanyPWAQlkIxen8ADCjiAF6OmilIDZIjbu?=
 =?us-ascii?Q?Mi3ubudGz5IUab34URgrW+FteQcMky5rnnDPDrNc7KNtuPbTGm+L3+Gxk/Pp?=
 =?us-ascii?Q?bZIQDOGzjI5bg+En6lBsmultFhza+/BNVd5XF7FwS+4HRSE2U3ET7rmBnlUW?=
 =?us-ascii?Q?WOEKdZKrudkgDFukYrf0mcd/EC17LcDXUX9etHGZ1EALoLUqSooGL90UN3id?=
 =?us-ascii?Q?gFZOdbfjVcW4HH/KMG/A7odHYVgjPNALccEy2AorgzejuqsxKBf7wTZknM/m?=
 =?us-ascii?Q?yJV2Zckfg9t6FUlprXo37mnzNEiWJDPugWCHWpRLWY1wGkxhqLLsVk1z13+3?=
 =?us-ascii?Q?jsUN6y13q4F2csklaf7DgiyA5bOOlI3jXYdsbUJFIp5vf+8xG1LHikhigEQU?=
 =?us-ascii?Q?BrxxA55XO10a7Iv8Bk18PFxmCYZy3wSoSXwwcFpUxRuY9B98GyT/8efIcqvO?=
 =?us-ascii?Q?hINXlsjzvLvKj2KGxkvgqfpIV1z5A7GDxlfrEatrvxj/uj6gwgbcifPt2qNb?=
 =?us-ascii?Q?YqDIHEns2fag4f/QOzUa4wuTFX3hNz77rrvzo+edLrExA73VaSQtjAjNvsft?=
 =?us-ascii?Q?FiRrR4KDxYs+84uAGR3dDe+UZoS8wmwa0wpRNTMNHeOJYQ2MST383bEBLPd0?=
 =?us-ascii?Q?cTQKDYA423uV4N7jjYOPja8PkeB31X9G+6pNVFczDKWj/X9DPohOsZrQjhQO?=
 =?us-ascii?Q?X3eAqKja3/6/HAe1/V20rCw8hUrLy6fAENTRebHQSoPRXmH5Z7lIk8I2Fzjy?=
 =?us-ascii?Q?bOExeER0vyVfOiQQsGxxpPq7043SToEFXd0HudUI05ym+4BKYnA4j0DMzCXS?=
 =?us-ascii?Q?/BWYw9n33ewx2pOpyeAN18amELQrhIVf4qRdpDoVUOUrxhl+w9rwKlIhNc2Y?=
 =?us-ascii?Q?o+Dj0NbtX2PF7MDatrJXxAtxjs51BMR9VMoBXO9R1xQHv1xqgc+9o/lQgknB?=
 =?us-ascii?Q?+uvw/TXOav3ELYkpZLwtLT3HgeyOOP9TWI9xBUZUBICnzhdVxDA52zdxWjcB?=
 =?us-ascii?Q?noXHug4ZzbF4DQ0EhyKJDOUZ3+k3uizE2pgwCX94xiM9BoT/WiHNEX5qt5np?=
 =?us-ascii?Q?j/NkKkZqZvHPrxWKJKTZXR5ktckaeUeDjPpQk2eq/zzM5X7NY8Enrc/EcFuT?=
 =?us-ascii?Q?ytJbx20RraoUuJHdw/ZydJaR9t+Xe0fjvXLzec0bCK6kdjWe0In1ZQni44IK?=
 =?us-ascii?Q?GWaS2Jm0TisVgDEV8GRQ4SZk1BoIqU5+uzf1EDGOQKaDMt1PLalvn+ygIwpG?=
 =?us-ascii?Q?MnPswa3CRxwIiUUBA/vI+U58R8j4yss=3D?=
X-Exchange-RoutingPolicyChecked:
	EtUwiTNCLHTCnyg3+Rs+FsMSYk59GxhK6eJJJwkQPM8VryB02n7oy+nlUCDCmMn04Yt0pwRZT8lgH6f3cSKCBCKJsrIYGdlQfSAuQ5XrKqIX0ksRuJ3rH4n9to6/GIIifm2BhIfuZVq/xVBYYYGihzMHEl4LbcwGtty/4U0y8v6CrdrFuwodfIl8+mFQBLOt4IjfIAHSVhA+Atz9SsuhuO6X1J0XbwTpklDVyq/sNgqS2QCQPmUEM7BvpOj31UNKloJdiWCfNow1VN1qoAgRBQ4nDwuUzNLw0M7eafizU2QFQ5uRg5CPiMwnZBKN3AZL13DDXstGAJF4dWly2pf28A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SMStGRRzMZQ2NBGAO9fZvb0Vgb8dlRKVxH0kAlQsxlx4k7qH311xJP8vNDebm0cu+KqQIRAkXKJXm57kpDY+BZX4PKkwsyHONBxBoHt5gvzTwu7C9sz5a911Cs5AWSJXUpexg2R0uCV15/AVcQABcFYaou5CgDwuz9ilYQN+K15cxOzBNLdRCBJegeo49qQFueRuyUUeelMOzI83jLEcz9aLqgPKF9mBtvZTPkzpe18pNFkbMQWTEpnxKw9GFHbQzCWsRXqIi73jkOehHFOEBoDKzeG+x0fweOqvGt2TKc3aeCJpEExChC/AD7sWkYNHuk0UFZVJZO31G2TwFJRI26ptD3CSeSnkTlypHJXh0RHiL7+jfrGoRoNuzLnE+ApAhfNcpTPVqUqXyMxzMoE+cH3KYhSJTmqcam3/WI+FPkKLFNbxZs0R8r2EatOtBXDaTEfAiGN/905RTUwrrC69XP8Q4NowcxtK7qOy7Pp1A9Sp8c5H427+IF6vmZToy7pGWkPFn7kCemXnBCv4cJyzVp3QUfCMxnFRJyKV3sCpBSfccZNYGOZ6sXaOnVQkEfeJcNapI8SNzQ4VpOYeN4AgcyegIkkc6coMJbR6pMhaRes=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f35cc8-4dc9-4f04-ba46-08df2a8ae274
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 07:06:50.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gXNVZkFmE/RjwpCRc2z/MOdN2VVa5ufVmAkyPDcxL5MyY1Nca+fOa2Jd+3y4mZqVnpc9XIcSKMxr2Uok45Ak5PBsGyO21ng7sU2peVH0AA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7936
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=693 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610150028
X-Authority-Analysis: v=2.4 cv=N+a8hG9B c=1 sm=1 tr=0 ts=6ad07b95 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=7CQSdrXTAAAA:8 a=rNdUdHOxaLLsWLYmxfkA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyNyBTYWx0ZWRfX/qsk+EuM+XLF
 R5L7mfxXQ1EMx6A5Z32rz0powAZbZ7nuYWMG3vNq1dd8YD9aNIhtWWVmhaEXeOJwzQ+LFiEjsGY
 uGe877Y2EgnNK7ORUV/oSGzqri1dCJgi5/f9HbkkUQaLtLDOz++CmPIhKKOwr7vBQu76HPwYz9l
 EQooXWf6OoWRxVdZbL0jQGIRClr3kNvFg0Gzam2Xj23NVBSupnx5psTExcePZO0OlSmbtLvpBie
 ImbQjPy2PL4Ct5LBs7Nd+yx6ozIetmoxQd2ekRKb+ESj4hNxj9li1xUE/bxpXvPFaoPyMXeY0fa
 sme5XaHGgJd7sunYJqb04HWPpcDEMmDiOnByGUi1C2eG+dYKGDYqL6YaZosadt1YWfMzTBSAoU6
 89lXyMO/rIsaMFmxYJ+H5kGHkx1qSExhWJB4x5ikxVStXXE22vaFas6BoqpRX6WFHsKWmEhodSC
 u6wZUFD28iotIkGHhSwSaE+nLj5ofapl8rMeIlm4=
X-Proofpoint-ORIG-GUID: Fvjd_-IAoczJncxjGXNeWIw2FFXgB_07
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyNyBTYWx0ZWRfX2mySrC+aiYLG
 OA/99RMx6Mk3KHogPNnSEv4u4UcjP1uOUfn0bJbEJuJVBu8cFlR8IkOe7OiLcT0kNrcKF3EZOGn
 RKiIhVAkXLp04QGNQ9USXfmXg9Z3F19B49St9TZy0VxlNRbbfjlL
X-Proofpoint-GUID: Fvjd_-IAoczJncxjGXNeWIw2FFXgB_07


Catalin Marinas <catalin.marinas@arm.com> writes:

> This Message Is From an External Sender
> This message came from outside your organization.
> Report Suspicious
>
> On Wed, Oct 14, 2026 at 03:03:06PM +0200, Peter Zijlstra wrote:
>> On Wed, Oct 14, 2026 at 10:00:18AM +0100, Catalin Marinas wrote:
>> > It
>> > would also be nice to get some acks from the atomic infrastructure
>> > maintainers.
>>
>> That'd be Mark and me I suppose. I don't see anything substantial
>> happening, just plumbing the new function.
>
> Thanks!
>
>> Now, I really rather dislike timeout based schemes, but given we have
>> users, I suppose this does improve things. We should however be weary of
>> new ones I suppose.
>
> There's some arm64 precedent in commit ebababcd0372 ("rqspinlock:
> Hardcode cond_acquire loops for arm64"). This one went in without any of
> the arm64 maintainers' ack and we've since been trying to come up with a
> generic interface instead of reverting it. It was fixing a bug where
> arm64 smp_cond_load_acquire() does not evaluate cond_expr unless the
> pointer is also written by another CPU. Arguably the bug was in the
> rqspinlock code for not using a plain cpu_relax() loop.
>
> Anyway, we had several incarnations of this series, some with a default
> timeout but others objected to it (Arnd and Rafael IIRC), hence the
> proposal here that pleased most people (not all though ;)).

:).

I have a new version that I should be sending out shortly that fixes
the few bot comments.

Plus there was a edge case around the control dependency in the
acquire variant that should also be hopefully resolved.

--
ankur
