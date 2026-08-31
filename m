Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210B43B058F;
	Mon, 31 Aug 2026 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207837; cv=fail; b=Jb8BwemHHWchKSX7PbUzPNCiDa13Jevooke+OplND/l2ImkonPvcXjbmXMnm2NTtuLZ3p1Nm6hTI+3kjMOwGewwn31RUIQGrJxqNwvfe8OJYL/q5CUN02/TRzThlmpBvCbgaIdhzP8JtaWqr7NYUXPbnJFT1XBWLuu2aAQzaujA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207837; c=relaxed/simple;
	bh=bWIMRAw4aFCddKERQNaX0CMa1naekBt+H1NtmwuV+gE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uIyZuXMgVZUHJdAwlweh1uLIi8Gd0W+/fd/dxhTCtjDAWbfLbR/U1FCSOGziU2U4GjqQSZtLI2atAtz1pEM7e79zHDQA6mhtp/HbSZFU8pCob80esVKgVTZ76SjUXM87hfcv/H6nmIm2udYzuL42/AWBWrw9G5lUJ0jgr/PpXnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XNRMgQw6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VCcTpZMU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XNRMgQw6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VCcTpZMU"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VGBlmi1783774;
	Mon, 31 Aug 2026 20:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bV8N2QIoA6qFMdyMFwvqedStsZzwALk+PcXU/i+ExoA=; b=
	XNRMgQw6NJnLBak9SfX7CDEOsZBE8t28mjPI19GHKIr5xIzYuWPSB4+KE09vTAxX
	LQgQfOwAslkQxjRcsY0N6qlXBynSe2QkF0klFwkxTgDmTKO2+UXgDx1xG/vtugXU
	BCAZqjd5s7+EOGt2gL6klQhjZUi3gLXQs90A/MyjdEEtcJ7VA+DTBH+LrRUuTtdE
	llneK38EApEZArDLGy5KGwTOc5e6dYxoviF1o9s9LW+YhHusGpPw2bK2ABspqIRM
	hRsdqbddNZTS3hB4Hif0ZcYMeBW4ctmAldbrSNn1WdYyDCf3wkfggbzgGP7WQ44B
	Uiu8N+D4MaeXFTNulcMflQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbp0xud5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 20:23:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67VKK5f8033203;
	Mon, 31 Aug 2026 20:23:30 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvdc4um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 20:23:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aqex925sh4F23PJjvQ4Rt3yURn653hiCfTovJFFIn/dvowWOkdKPmGz9v3v6dih+PD4Duenl8s/B1xZlCayMjLtdxOFQB3dI2SqZHMobaXaQfUimF0JN99SfpDqB2IAE3qidRHwuj0XxHzihcJVGLZboapoSX9kOBX7JbdOh8LL9rjOjreTqa2aAM5+X3ZZMRcXix8TpudMdbmJht6UekHX/Dzv1Q3sea878JnPRjB0lkFVpgIaoCyyZEIjhZjeYWCc6BIQwXR16Kag+MkJDRY2Zp+iHJhbMsSi1rK5DQgF5FkksPdOv/EgxGc9ORQ1Y09I1JOWnn5TSEEHL39ERWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bV8N2QIoA6qFMdyMFwvqedStsZzwALk+PcXU/i+ExoA=;
 b=oYzQfkk1nwY0HGnS8AMj50INRDd1FivZK1B7GRGh/N/4efs2vAh/c5JgzULy8YjyddgByuZ3Qf/VGMtBQF3eloMxNp6WuYLfghddSHpYw5aZ6asHlI3Uf61cXhFTA4iHoJ66kgnLjfpYtZL82P3kxc9K70iyjdeIOjhM4dPwejurSiRYsUM+jjEuuzdA8IrIb/CR3oZ6Ea2qzHzH8UotVfHSL5/cMJsiki20FtihAP3l0+l3kxm6kGP2H6ExzGxLeOmMmCB1lUOyPlkFwMk+cYAzOBnzWb7dw9Hr5+Ba8ftz8sK+j8Gf12rMUvV832YQrKNJygasIJu71lsr2WJnVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bV8N2QIoA6qFMdyMFwvqedStsZzwALk+PcXU/i+ExoA=;
 b=VCcTpZMUuPhWfENxFzNZligDV6JZxTBh5Pp0SS4UVRQ15QuNEc8vA8TCZv3sjzuQM9utL0JHibu8CHTlXBRiS3O1MYkQWun9nuhIYFifSXhcFB1fYwmm8NbTgXM6+djnOpSNslL30mfjrFqbNGg4JG9Bden3eg3DGR94UIG4ehk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB964822.namprd10.prod.outlook.com (2603:10b6:208:5ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 20:23:27 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 20:23:27 +0000
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
Subject: [PATCH v15 13/16] arm64/delay: enable testing smp_cond_load_relaxed_timeout()
Date: Mon, 31 Aug 2026 13:22:48 -0700
Message-Id: <20260831202251.305046-14-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260831202251.305046-1-ankur.a.arora@oracle.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:303:2b::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB964822:EE_
X-MS-Office365-Filtering-Correlation-Id: 8515c1db-6664-4003-7911-08df079db715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ciDJ167O4dlA2GUnlr4AgMKkBnJQEHTDvmNd8NlZky43IeNmxSB6T5HzD6nDzHoSmG05YPhfhc7ZA6o+wVXEDtkCASI7YQkGPjkTMNSZtl3z/1pL563w0EMwpIvnQ+y9n82oZ1/4pO7jorWTH+7H2Y/EhZYKICXeCvFC8XT6Z+6qMirStoc+UJVHQ2dGGqHFexiQjHFBnb0zz9r7Q02VexNUjJsXkQSgzm0GeJbCAbpR72R845RHvBvJ/YY8fH56+Dt4UlyAQUXznEYU5hf9NLQaXtSe6JfWIyxWVIaec1LEU9/XuMt5k5bzOVNLcD+XY7jrsQpZ2sxLt9Jo6zE29EgZR5YJAr4fi50OnICYUXncWFpIOpYT1iqgWfzo43+39yf3mhRWc7QAmrqWsdg8pzkMlCeZ5JFBE1JY+M/eXEOWPAF5WQ7Z+tClcFc1pUcp9iglZwSj6a4tm6r82UVQf7Lau5ITQOuPsl+s8rAR3/bheDKJOR6gDsc9sTwTJTnyuR41OcC56UOXt6uO6f4oZBJBEKdxX1fNYrryr6R+6/Lmf7OTroEpfOFybg4XXAoD2MusUkasKaa+E5KrjCAs4bq6M+K0X7T8Amy7BgLm6+4parSlYXEz65jUe0zMuXe7I4mfXQaM0MTAUVvjhRr3c57QIIICoMBOkHqyWtuhRAM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JPlaavy3hEIAEWsCX94RDlVlUeqb9lXHxu1RqA3WPsTkG9z+zzjRev47MpAE?=
 =?us-ascii?Q?Rd4XyzVSdzCb4dvJ+AXa81hgcoa/GMhPGJve8Bhj6SjCztho8UYjeMtUY25F?=
 =?us-ascii?Q?CGA1GUaDLZhfezirtXoFkcrxjkpsmsuOZxGXYhsqnWiBeMoXnUj1/0mx2Gdz?=
 =?us-ascii?Q?Spm9aXRDxgZkfe+r28kJOFksFsuD2dnlr1LsBxu4VB9R0xD32nz1t0IAaCHc?=
 =?us-ascii?Q?nUCCCnWZOl/x1h405lVmri3ssIuLXehfc/+ZxNJXR6zhkaRDrJeB/WbVwZL1?=
 =?us-ascii?Q?ONYZ4jDD8yRb9/CNZ2P4LYS/Wim79RZAnUKqpD9gqkDZNYzlQMTJm6TtgOy7?=
 =?us-ascii?Q?HuGL6fWBJ4ziEDjqJAZnAJAWSYevlOtJqKIcusTUoN5o9yI+a2XaWqLZwuva?=
 =?us-ascii?Q?NLgGjZKbV0F60ycBxledg1wnnWFwIvNIw/r86Xownd43yymXC7Vxw4dUPMMW?=
 =?us-ascii?Q?qFn66uPbgAYUukomNQj9tj5cS/YMMmMP3InHEcnMQ8wM6z80PQ7FpJKIIjPb?=
 =?us-ascii?Q?oHuuqGVaa4zrh+/e761s9lmDu+tGvlcy6lJdbLcL0dAbfva8iwtRTGjIJyxQ?=
 =?us-ascii?Q?vsDRvXfbUc+CVKCxn82fYUuuPNTIEio1ZHex806hW3q4O7LeLn/OOCHSdEtL?=
 =?us-ascii?Q?jtyypYIAoqofUK4Ed1CUmxcdv5qgDb8MAPdrhpPf7bUmo/QeHxJkPD8u1AEE?=
 =?us-ascii?Q?srxfy6MQsMdu65BRrFzJ/+bLVlYbpBRnhepVvKGKKz/Wh9lih3O2BZeIeADl?=
 =?us-ascii?Q?ta8GJekS+si6FMQvEg/rc2nPJZ+1mH2rDGye4qVwgbl8mKYejKmBmD2Oann2?=
 =?us-ascii?Q?Jog46JJnqlPdhRCZ/gV1mrjIXbruJbUMNsHM8orINt+mb7cBF1EOCMcKtRKs?=
 =?us-ascii?Q?A6d+HH8eySdhtC14iJq7wdVKFvdYkPEBX3ymW4m7WNJEmYI0zWiSMyhXc71y?=
 =?us-ascii?Q?CWyvkfW4WglvVBO58B1wwRxFJueCO6Q9mTYuQaNcG+MwixxCyazuY7YaYPCj?=
 =?us-ascii?Q?RxcyjLVnR3p/oEm1LOV0uzFg3HOHg72pl1/CsHWo1bkSimF+UsUlGWE9VmYu?=
 =?us-ascii?Q?fugVgTMcGkeLknntk8Okn4Az6ENKaTplkC01M1xFVSHfrXlgmkMCDGAEfOc9?=
 =?us-ascii?Q?Ox3W3NpUO/QCGxAO0RyEoNqGEQLx/7TCYq5oHzaaBomDmVAlBldhxrub0+DQ?=
 =?us-ascii?Q?WkpyCAizpBtU72+h+g6O40TEbl//orM4SAMZURKRv34Tt0OjrsgjUB1GoKQj?=
 =?us-ascii?Q?npR8iyvEAtyHuk+QvrXTXQl3LHeOrtLz65WtcT/lpvjItpEmXQL42wL1dMe0?=
 =?us-ascii?Q?yY2pu7Jcc9FnoZuMguVhjRc0PyG8CHNOEXwCrCoHqDDjCfHllcOt0k3Ka9tc?=
 =?us-ascii?Q?0pqTu77VH1yO4vQooVkvoSGY40Tg3rog/FtfTUEaNj9JTxkpAdToblS/o6oG?=
 =?us-ascii?Q?t4a5Dkuz3pvc11N7zu3cxw0gwPW+5P7AOh8Ho2JyPhEIC0ioIPi+ZOIgMiMu?=
 =?us-ascii?Q?OvK/UbSD2WqBG75d+il9zU1VpYU6i3OqfR8V5CWqnAcyfXKbCrwFQw5n2OSt?=
 =?us-ascii?Q?FHv0PNPJ7xK+u0IQ53noOoEClZWCSJ8YRVAJsq+JaUSRoaFJL9/6FvafEhRd?=
 =?us-ascii?Q?00CSY26+/0S5LDlpIXrIDDGa03qBlYqfTCB4DU7X54U436r1aWXnLeVYK/x2?=
 =?us-ascii?Q?IU9qv1j3hvIV1hjLNQsJh6naeYMnKx86xWfl5peiAe3mUqHt7cD87+p+hnEC?=
 =?us-ascii?Q?U8PMRDY8LapbBEbDu3O5GuQ4oVTfKY4=3D?=
X-Exchange-RoutingPolicyChecked:
	WS/x8E2o6PjTN2HZYkHQsqzVsEwYv1FTQgwy1cA7VnZZc9yKu3JhWrIXBl50nKyMmTNpViHAUMYDp2qMrgEuEFP0Qewp10zqLc0dAT2918g4O6vqxmhDSM6no7bTApBfatGOU4MtenWb+Zy4wk19Kr8kkHerOTcIyXSLGcBCjFTNFVDtxSUNKx+tnwJp03hkhQnqbyb0XU+4FAddKJyUo9kbZZHKdgf99qcVBQM2D5tW87Ans2bnRE5qGgcGCbtlXnjWRfswJp5l6oswipPCDN7b+lJTfCdW5MjWrzmWmiLWIj/YCRLs9STIC8kS2fSrLweS7YSWoZnWIU1NwAWzVA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5LjbLlRVkQW+WaBVK0bjAIPYRGS6q/rMaPbEw+eVppTYLYMpGcuzLPS4tI/V5nrZWijvoSP1o4lGzX7eIxgalJuTS7DL6JWR6pWDcYAs6hgHN7eMk/vXdF/6VYYtgFJTgqsvdPyhbCw7vSsNcQh6dVzNgXiplOHWdNQg52p+NOyl+137/HkixvXrYmMN81dXnx23swXdbsA6hD2gAfbPZNq1Zl+g/jvIgbXtnUNaHr5rf3ww7E4p4TmIPH8f+zoxJNrYbLa2GJYnof6ckdd/CMzcsm4TIpHzPMdqV4Uxghfh7vZLOBvG2cG8/kDABj4+WG+829j3ZYaBjwUkxHJI4VhrY9gmD6NxGSsQ3bNK4WreHhyBj0JRu+/1ff1mU3OHi4H3WZciliLa+WGcI0pkol+bYDZaDjNuVS0VlC4ky6jJfMw1XO7gbHkasEzctZR1+fQhnOR2aLMdiexugfN1Lq4Vl19nIa1cgBvwVaBSu6UGSapViKdUOMprbsFlowQmUGMmTJjL1xZLwOY8NW0tY91UvFjM0LayrRa9xbrWfJs01uILc8g7KdZ4SussoHGJLlsBY6sp4J0sAUBqDjRuw1iZgZQz3rKCdm5cJ7xR3cU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8515c1db-6664-4003-7911-08df079db715
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:23:27.3528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fb+7nv5zvJG1XuNY1KQh8+NTWwP7Hy/usOFO1QZr98MmHrAjCMNn8pqdsupyCziRcvG4pspqNTXCe33nmHMMCNZquxr3Uc/1L7P/+M/8ZtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB964822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608310176
X-Proofpoint-ORIG-GUID: ZGfTdVIO4mhaVkD77sCJKimBfOPh7vbE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX6mtFmma/rQNr
 S6mjqIL7hdzrm8X15vH62dTXD91uyEDDh0Ed0jei9K0+Pf/khOiHazh+4c0AE/YeXC2QT+gIEIf
 E3QKE/2Uo8TL6pURziwo3wCB+IB3pNk3ovpPOuJ1gyKHYgorX6uvKS8iBkwHxiYlCtEg95Sn+m7
 QPbyYRJWYM5KBRA425rLrBpzHaGJVj+Pxu5NRq4rRMnUxb/YB4haMg3uGqQTspsJZv37pgkpJV6
 U2F2N3vP5fy2XaYa7IbHLlUBgG244ckMnQzpmbs233/KJxOK7YKjeCYCimMYm8ie5O03+1BlpkF
 RIOZBDXsyPa9jSb6petYdcdP18QtTG0geMfyfmjVTL0QQR97KGmG3e9MuvmV+jn617lEnzHOWP8
 hvIx8h4sz6soMR5kveGRXacR1p+PSgS85lxkwhHxAvun9F3Fvk7pifUgy2DP8JqIal+UU83g4OH
 hJ/CxlwJa45tjnV0siQ==
X-Authority-Analysis: v=2.4 cv=Ebb4hvmC c=1 sm=1 tr=0 ts=6a95e2c2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=bb9Fw_vXVJAL2FTmegcA:9 a=WmVTiCyuxqgg3mnwYu6p:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: ZGfTdVIO4mhaVkD77sCJKimBfOPh7vbE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE3NiBTYWx0ZWRfX371mii0v0jnL
 MVeR0mGihgMrWJZsmePeUmHj8TftEgDdcQ8oqDrJijyg1MR/VfM6ERABsy2y4zyaeBQbAv3E5pf
 dpbu7iMvygF0rW3glLKPFbKjUzYlZusAoSYOBFCaComSbIa2KGMO

This enables the barrier tests to be built as a module.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/lib/delay.c               | 2 ++
 drivers/clocksource/arm_arch_timer.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
index f08eacef2f0a..20bc2894b65b 100644
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
index cc9a8b399004..227447b19b14 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -28,6 +28,7 @@
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/ptp_kvm.h>
+#include <kunit/visibility.h>
 
 #include <asm/arch_timer.h>
 #include <asm/virt.h>
@@ -893,6 +894,7 @@ bool arch_timer_evtstrm_available(void)
 	 */
 	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
 }
+EXPORT_SYMBOL_IF_KUNIT(arch_timer_evtstrm_available);
 
 static struct arch_timer_kvm_info arch_timer_kvm_info;
 
-- 
2.43.7

