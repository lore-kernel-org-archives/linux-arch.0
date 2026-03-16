Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971452868B4;
	Mon, 16 Mar 2026 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625076; cv=fail; b=gnqjrvrEPCRDLu7/xbJ2fYEMSHwUDaWwGlz9jZL/+1HwVIL0NwIW/octjK821i5JtDqyzI2H6fUUzV/ysANrtLxwi2al6wDWWN4LajCGHY7iBk2iSDujFX9Kd7gODpeNidBWBd/V1gBBISPK6PhR0dci7ZsMSojU8BUCNrNBu7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625076; c=relaxed/simple;
	bh=5x2tK/Ql+7Zqf48PmfkGIoyFtOYoEf2nKlcIq33DQWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D7ESuUyY0YvU5vallkY+Ly3/HPbAh5+6/1GZ0jtJIwThKftnq+RotDN6JurtZQjBJCNz/Aapl9Xz4RL/87GSS6DbYcK9HC5VssWpdSwOQ7CBj9I1UMagI/3l9nO4ojvgmU8CS+qXaitomZx4cFwB7SrmqcrjjvEmJWZvaut1KkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OKzzg+aZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ze8Pn/dV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OKzzg+aZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ze8Pn/dV"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G0DUHX1869187;
	Mon, 16 Mar 2026 01:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Fe7QSbuiQhAvxYsAtxLdlN/T2c5ItPvuopoCfg1hU9k=; b=
	OKzzg+aZ5RepWvwhwiCOrZJAcJ9YGyYm/vBUusCFCmwSIBCOrbhtlDhXm5l9Uncy
	X22swz0kztK179pi7YnBRpck1L0PYjzSMwgJnl2N3aYzCEDOCYUyCMvUCVYi9brL
	D1iOpfmZWiMmV+VTJbxxfmW1hB9uG1M+lnpHVp98ZEw24q4T3i7CcdVTipcbuNia
	Ic9YJJCWRI+aTGbMxLv2LPF3Ls1CIXAAsznWNj2/aVFSA75/RxVFpohXYwZL1uqb
	99v2yQkoQ90Q4PIZAVKi+j7lvX8XwhRdvnN63vTIb8+vmS5FS6q00kgJlHZjVdWe
	wU/sVmMoYdgZ6xjeu5pQ+g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxf41bds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62G0L5ad031891;
	Mon, 16 Mar 2026 01:37:16 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx480spb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:37:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3jUE6JnxxkUJgvEm19arXlN3fd4wlf8Y4oohB+JWVdjiM6ksyMecXtPGNQGe7PitTadKLyS0Pi6zkLwbQw2rsL07mjgmT3Jw3HKjhVHxMHBcpXELNwbOjR5qnwqop/7Ncb4qarfjx5N3EiEHZBuHa5utFUMboolvn09V0CR+ySnzZ1kEQ/ERlw/H/urdu46Sw2iD2jeF0WwF2CbLT8rsF1TxSQC9lKIPIxZGs2ALbCE+K/MJfEFSfX2r5iZvKzjMJr0XMjsmebLb+SLK2wQVRhKizeZK9BLxjidOKZY/woHagBoBCHpeyUZQ5d8UPST+xwJpZajaUCP79U4p/W4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fe7QSbuiQhAvxYsAtxLdlN/T2c5ItPvuopoCfg1hU9k=;
 b=YD+eEAbX4M7tvhP1utJfCiC8zC2yvfY/klmQ1Fi0VJwS8kdXiAC6If+tGmqu9cW/fmlYF69kf1bXiVPfVo8Gj0/5HCo7mNki+oq+4hl441FOc8CThwSm2UFKtmriobGEVXHvVThujrH9apXP9xa3lP3bltxOJ81r82bUVzS95cV0WI02yUSLdFqi1IFqs0VW4/BGR1x0E9tADhp5otvrj2FNnyQsokdsSlas6v00zfjb8giAZYUgDjHLurbwHCUZJTSell2wakcEaOiS8CAf0nZNpMEbQ97eGU+ebyRJtMqXc3wVZpKTwLTWnSE1hqSZQml1PtJYPpas9Pl+WSnW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fe7QSbuiQhAvxYsAtxLdlN/T2c5ItPvuopoCfg1hU9k=;
 b=Ze8Pn/dVZ98OJoSpEvTbiewAERL7eFjPieA3y94n5iKqrh2akmucwy0LHv7/zK8JgwypBWeakUncFF0MpmenDJgYqa09MdW/udKxmFm1k6tHiR6MCGPmU/TfftZ+XPesCP7xf7QpIFSWrP6HduLbMO22im3ZMjGw37on5b1om88=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA0PR10MB7372.namprd10.prod.outlook.com (2603:10b6:208:40f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 01:37:10 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 01:37:09 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v10 07/12] atomic: Add atomic_cond_read_*_timeout()
Date: Sun, 15 Mar 2026 18:36:46 -0700
Message-Id: <20260316013651.3225328-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA0PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: b4702f9a-cfa7-495a-f8ae-08de82fc8a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hwlVM9/QRZDr8AUhZaAmhhO/IPKIQEIyLUvDul0EnvFtf+Cr9OembwrO/uA2fpMQll5tCh/zN06fA1VJxI0bWVKUackTlBrk3/ME/tLW0e4SDe6R+konv6On6U2nCcJOufHY08lq4ETV/XWrwKvuAizM4bGuzyduB/EgIq+jmpDZSfAITOzdhf/a/+/fmZiNNIiGoPdkXcVwizeE3IC5OdIhmpGK9c7F7Epia50bVMPZq1ikV+NBKxrhyZ2GxL7/pW1t4YMytwRL8IOm/+DvO5kxpGMYScXu2qU9cYlJ2Ew2ywTH4cG5mpzasJ5iMgUJkPU/vQONVFhwEuPsj8UHnD/YpC4FcS2+gtKFIS+TgrVZb/vZzUfrCjTBWEhnptqxcL/dsJRkfa3Ua5ngmkFeqFhc01ebahb8RmEGujhUyrH6sIY3LOPMEuTc8KGbBfYJL8F7xp3MMMEkDfGuosmiwU4/J1hNDxw7gRKcXqKUy6f2jncPoy6uiLT0XaiGporojlwLWNoITC33Zme3uWcpW1qPVTsmfnemwkpWcKf4KMpM9xa+ELsdrv/DIk6e5nHhxRz56D0c88TEB5KfnVYwCGZRl82M7PYYow9ygvZSqqnym1V+evLChM+d2ZVGFQ8MHeCRHULQjJG7ddkntYR1HfRXpv0ZU/veqR2DPnwqBfRNfizov/4PN+fAUrX3clQ2LcChIT2OZzQ9eGDnxZrs5eRSkJbeMwekwA84dOFrC5I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IhRTWrFOhbRTwv+jEB7LXIfbLvax7CwN+3AhD7vmQvohzx2z73T2UBFX1MER?=
 =?us-ascii?Q?N11DO5mFMBtWJI5o9h9twcLpvJWujBvTMRi8lFsG1j5o3hWzLHJUTRxYLEEU?=
 =?us-ascii?Q?KXa+0F6y5IqTHfN/wbd9vUMtON/eqKCTeVrYM8a8wOARdyGbXp/ID0P/sGH2?=
 =?us-ascii?Q?cQf2HNLRl0kneSEd+ERevaS0PgVHQyNa2G/GRvBAxK4c61XDmaW3ZjJ1oTBZ?=
 =?us-ascii?Q?SEwBirGFMedSSaa+hvVJMkKmKbIMVC7VDKCvCUI7EE9cDkFGdVu2BwZ6N8F4?=
 =?us-ascii?Q?C8OvVHu96DKVhLVj/7l7427wEGOzW+EARObngiVoFyu+LosKczngN3KIidES?=
 =?us-ascii?Q?4FD6WYggsOQGW+tmTnkc9175htQ7CBADTEsvs9bnXCy9mNSvqdi4ued67j5E?=
 =?us-ascii?Q?USFZi194cy2s4RYRsg8YStxq6UYizehFgcEubo6wHkekNWIB57+YL1oC0Lm+?=
 =?us-ascii?Q?XS66BYhlwF+510FtPm1GXw6pl+zaVueZBqcguabTdeFIl8k400/qURK1DfFs?=
 =?us-ascii?Q?FD447vH9cd/mUkUzkbu6YBts4XmNOn4IXWMWJE+nHM7cx8qeL23xUTvGZk3W?=
 =?us-ascii?Q?Yp5xuUwgXORuxMvJPV2r8L+9hvDlrD6izos39+RWDMRjIdpPlBWDZXzamnO7?=
 =?us-ascii?Q?KyAI5F+8Ja/HtLyT5+B95yL34rsyjtIhALS+6o6qNc5DYouLdWShOJpA+6Lz?=
 =?us-ascii?Q?bzH3FscOodvfxXS2dhwXZtpOoCz+uMMzhg1kUn4Rh9PnfaM9FScj1InB+WFV?=
 =?us-ascii?Q?a1aAnPpLYBGtTiynvMeElJjybyLvIW0nT1jD4IyAE6j4MyqxjKWhbl8trrYK?=
 =?us-ascii?Q?VhD3XcsdymW+ng2RHHqEx+4QNwARbtU4m9TdviUGZoxomkQaW6mcnb5potvY?=
 =?us-ascii?Q?MHdUrTokb/9b5w8Rfy0b4GuL8wLhasLlBc3eeWZmlOQDTfJZADXr7kjuIdlz?=
 =?us-ascii?Q?O8YgFJZsA6ENfJCLtTYstKzDsTlb/cLFnT4nE5HMHKYH2OXrrKMxFgzurZ4s?=
 =?us-ascii?Q?xWgTZXLriO9WDfl01YqI3yBTAWrdp29D9NBb9I5hMAaE32g2di7lLSfvMnww?=
 =?us-ascii?Q?Ez+RNUoUCknJRNXM7WtFS33MMqoJZqiEd2FOHVp5Yg5jXMOAh37hG4fwltsC?=
 =?us-ascii?Q?HXZm3yt/4R69AOQbxgRNykickuDt4GgJyZJXBgrzf5CgMRn0mwwoT64CkaK6?=
 =?us-ascii?Q?0C3Es7uhRshs4Kyxalz4Px+YSC/bwNWOCi25GIaCZ9uXU7yUfGiBj9a+W5NJ?=
 =?us-ascii?Q?hYEEccfWtTTvx/OhTGfYHMCEG39a57wmWkdyX9Ju/Lh3KXCFYWp4pIQ3zWoC?=
 =?us-ascii?Q?BfqEgT7K1xdCAR8RRBqulClGarGDgGhGcMkQ1gJW0Z+aHGoEL47+acrdb3qk?=
 =?us-ascii?Q?PMmi1clF9DQzbJEaW+qkoSwFL2gtuHq4aIpL6gA2Zf9q/J9xBbTGCEIx+7dY?=
 =?us-ascii?Q?fW+WrqA+D4heheNOqR/bhqBXr4zwvkGn3OMol38ZAkRJ6mnOAXb43O3jZq98?=
 =?us-ascii?Q?UVdGXFlG/VQQB2V3WxrD8YudMWjTikFNSvdHH5IXXjMW2AsxF4SuV0xScuyM?=
 =?us-ascii?Q?MZIbgvIqhnT6QscmidKIqMX8RuEAF+KoHQlevHOm4PxpjzJSUDVOqMLZSc7o?=
 =?us-ascii?Q?UMLSJIfFyyiw51e/Ku4ztrTglZL1gRELs5hgBKC+xwbfpCq+rLuO8GeQm3Oq?=
 =?us-ascii?Q?zrrF3ukIeToUJ96p0Ez1ZUstn+ctWw3M+SQlgR0m3v2cAGfU+GMjhxvlRqAz?=
 =?us-ascii?Q?5Lexcdi009mnruyLFQsJQjynk33ec1k=3D?=
X-Exchange-RoutingPolicyChecked:
	EqPxrLvUj5nDJMBmjJEAwSuPkX1v9HBqgRlEGFL4nmXobbjWIHcJNyJuXeLOKkqVObF6gO21MjF87ffMCIE9jnkvHHvAMhpFGgvyjOVVA6eiqiSPgu5+44n77OTRJOIFUd847BW0JzNXXed2NNTbIWIgZP2ZyHn+PRBJCcBxA40dQh6ZY3/JDmRo47FwZL7o3i19IlcCKTTdHGB7O61hF+dEhgNnH4sctPmIo7f6RIJ2Hi8Xi0D75efjEPnME2I4wZFk9NsnvJka7pbziFWdVDTqDQSXbfWlAOKW0wqeqbt6HFeXJIalkotU8du3etS8Z48jpW8Bm6um4Uz6m17QdA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZhVscMchLfFHmSMk5UEoXX0ImotMgfV4MNR98KFPbac35GxdYuI+FCMRLrCJhT1lwEcSHziKzzck9XN7Y1i7UFchi+mVxZFb6MR0/+ITWhHx7gUMOqwOwjQ4+Hfdp9pYhDr7Pp0EJ6E7BTAw2DKjfIlFabG3sjQh50xRIDdSqzubLrqCCNDBtT2VyVRNzUfBInFbNIETW0hnJL5L5YlNfo4UBn8Gi+DM7wBVtJmwJomDT5GN7nkmUg/F7a39TTAUpajCMYGA8m3lsgd+myCPU/Xz+hwyv5gFenwJ6W1Rl7lSuMJ8aSkqV2cY9boEFGhikFv3dYcFLPNb5MsigFTSjVG6Wvqx3Hg4Eb8YN4Wqr91sVGlXooVuv3C7qKNE+uTJ9JgsjGUzRQh8u6+CiFHQfZ/Uc6U0zIVcf0Ce4V8EEmNly/kkWKGFJo/VCYi6HvCajL6dRmpHMHoZ/jnFBWbZTYjYt9kvAITDh9QiMD+bc6GkFEMQ7EElCEtf3tC8uPK25UQXna5MsnfSaSwJqeMksfThS23Nd1sM4boIJve01x7p/s0UPbAxucXP3Ch7xrcJU/o0PpTcmlZt91AWyeGYNaRU1+Sod2KWiXqQ3p5w13U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4702f9a-cfa7-495a-f8ae-08de82fc8a5e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 01:37:09.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWxlrsfXKyNqiH+XUzHzm4JC52SA1NaxOtmrV5/lBWRawnK15t+KZ1hs+JeB3WaCqUtRl3hDwhMbqfqnIdRCQ2wlHdN9UnjjYv2q+RWjmHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603160010
X-Authority-Analysis: v=2.4 cv=ftrRpV4f c=1 sm=1 tr=0 ts=69b75ecd cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=RgR6v_fFY-8vhBXvnRcA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: CwBbqA1AXAKBgHHt0bCLe7MO7SN52Esb
X-Proofpoint-ORIG-GUID: CwBbqA1AXAKBgHHt0bCLe7MO7SN52Esb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAxMSBTYWx0ZWRfX4OH5lypJqn/1
 04rcah9KODu/v4CpduTELBG7KuIy1bmc8YwStXV0g1YfRb6vk0wKYxCr39dKL+rrnd7kWRhkurU
 rBWplJk4338t9FJjMNelBM3ZXCAFz2lqmzkIUyN2iIP1Owwn0u6cFT/2iXoxpk1n0d5g+c0g4+U
 CTDZoia0PMd3ievRgJY0wkhniEQhrSX9ejGDTS5kNQXiBHuRJw9SQrnKQJOErGbkoNLjn4N1jrB
 BIsN7/JUFbeokIEFJOFIN4aCpESPZ9p4aNTosqZdqBVg4ZwDH/bmEZNjMfcTV62Fb5zlT5/DelK
 BXwrwMG+JOr6bN4D4OhwVqPHnf4CqsmNyxHjm4uZ9QO+4B9Id8C817iAwVTw/2QpeUXGLmoOAG0
 UG/2V7am+mSz29zEL3ww3FsxAy3qz0sDg0oK0IUiLkymMlOQmHUOlOERG4S9g7PBW9NbOXoUdTV
 s29caMvUXDhTy0KZthA==

Add atomic load wrappers, atomic_cond_read_*_timeout() and
atomic64_cond_read_*_timeout() for the cond-load timeout interfaces.

Also add a short description for the atomic_cond_read_{relaxed,acquire}(),
and the atomic_cond_read_{relaxed,acquire}_timeout() interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 Documentation/atomic_t.txt | 14 +++++++++-----
 include/linux/atomic.h     | 10 ++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index bee3b1bca9a7..0e53f6ccb558 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -16,6 +16,10 @@ Non-RMW ops:
   atomic_read(), atomic_set()
   atomic_read_acquire(), atomic_set_release()
 
+Non-RMW, non-atomic_t ops:
+
+  atomic_cond_read_{relaxed,acquire}()
+  atomic_cond_read_{relaxed,acquire}_timeout()
 
 RMW atomic operations:
 
@@ -79,11 +83,11 @@ SEMANTICS
 
 Non-RMW ops:
 
-The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
-implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
-smp_store_release() respectively. Therefore, if you find yourself only using
-the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
-and are doing it wrong.
+The non-RMW ops are (typically) regular, or conditional LOADs and STOREs and
+are canonically implemented using READ_ONCE(), WRITE_ONCE(),
+smp_load_acquire() and smp_store_release() respectively. Therefore, if you
+find yourself only using the Non-RMW operations of atomic_t, you do not in
+fact need atomic_t at all and are doing it wrong.
 
 A note for the implementation of atomic_set{}() is that it must not break the
 atomicity of the RMW ops. That is:
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8dd57c3a99e9..5bcb86e07784 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -31,6 +31,16 @@
 #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
 #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
 
+#define atomic_cond_read_acquire_timeout(v, c, e, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
+#define atomic_cond_read_relaxed_timeout(v, c, e, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
+
+#define atomic64_cond_read_acquire_timeout(v, c, e, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
+#define atomic64_cond_read_relaxed_timeout(v, c, e, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
+
 /*
  * The idea here is to build acquire/release variants by adding explicit
  * barriers on top of the relaxed variant. In the case where the relaxed
-- 
2.31.1

