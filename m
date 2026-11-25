Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795590923;
	b=d0ukWjP+bNycZtG21ZuUMeTlNeIA2zgZTVmfIzcJpj7xn1GIhqvbwr39wlHlyEq/+zZz
	 Jdax3OtLqvFrq/bn5uBXH0xkxLndAkyBrC9oXceHhykseJx951Jj8sAx3XFWeE78Dm1ct
	 TDksYI5P+uDyWPZrR3W/cKOcDaHWXcRNooEaD55q19hvMahmhoTUt3Ygt9wv6T8n1mD5k
	 /r0gw1L+aXg9Nj+sMWZ2f5TacOtbjeFmbKMFl6auTw/edog712OJIOHSNterDcB3o2qZ6
	 tfhomirDgl0hHvmYijCh9xaktTLnfDwDO5YnfTKHKuwai/W7Ip7HTvRarPqLvLq4Bqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795590923;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID;
	bh=Y8JfzhuyfKwqPqGr3+xVj9Lb0vF8It29vG0eBsQaZn4=;
	b=d27IqZKjNTtBendklZ2rkYOrpDUT3VyNRiypexNj1KjaT0MdUTOioFNSxBTdAkO6kJW2
	 kIL1Kdn3Y87OO464ZNHAPRzpzJTKcl4l1c2+BRUUXwOhNohCv8W8YuTtfgmYoHM49Lfui
	 81nLNb6T6gxUUrJfBjbKqbkWWZoF/QI+o4xdriVeRgrXxJXQOADmyDZ8UyQ4WJ8LwBSGG
	 6FIFhn7nJqrFZO0zX/YvNYDvtOcoW9xvZkrafAaHrpB4iF2DXibO4lfvkZtLl2O0tsmhm
	 cR44WsmtPsZFAk4hPVGDdv1DzcwtOPRPq+/742u4iO+KQMTBEtaruQsXpuAS/Y0ufZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2026-11-19 header.b=CEeWJcv9;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=gi9AvyX+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECF0606A684;
	Wed, 25 Nov 2026 07:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DECF0606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2026-11-19 header.b=CEeWJcv9;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=gi9AvyX+
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP5taLI1047522;
	Wed, 25 Nov 2026 07:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2026-11-19; bh=Y8JfzhuyfKwqPqGr3+xVj9Lb0vF8It29vG0eBsQaZn4=; b=
	CEeWJcv9MmTGkNpC6OvGkKBj1UNDOYF6WJXalpxnlBqqCaNfDnfh51AFLSzOmFw6
	RTqLlkVbE39urG9MKuSkwr01gVWYkODmypXKswm0j6AyiZsrwWeoyu96+Rh32nB+
	vhj7bTN+DHA7Nrh0PScFItpm3x8pFa7BMw44QveGk++W77iCaujpyEU0dzUqYAXr
	j2ZGrp/gP8+mc7289itvXXCrgaaDDPI49FbYpxJVb/1h8mbTQ4L9frszpAXjZObs
	4xXRdaRVJ+8CXgN5Ho5X6duD/g065MZ8yK9ytpYejhTvs7UbPV/gJoytXDCfmS3a
	7U5nYFJChpeCAeBuPc1e+w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4j34r6we5g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 07:14:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP68u3N3575807;
	Wed, 25 Nov 2026 07:14:45 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010065.outbound.protection.outlook.com [52.101.193.65])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4j5r5cdste-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Wed, 25 Nov 2026 07:14:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4XY7KonSFTDWlaNKoceHNuawf3Imrc/mwepELQr0pho13du3ATz2d5uET46LvKIeTnxrycgXNJJ2Iw1kkylx7Sv+SeeoENYB1k/AcaqlIsnx6Z/L0xDFAvUSJXkDK2AtgpXhxqKktDmUNorkC1YSnzYIrYPCCSQ3OveExi4DBYJMdo9S2Xx4Nh3sRrJlar3R8XglUV3eeWlvD3HvXlXtODE4PHbcD+daUy7e0zUrK9gShuHJixyqqm1OP3pX4d7aaRvKT6BRst8zCssh8ac7aFmi0vYQqc40mwSNEGSyt67nNoNYWVCuQrsMWFMDZbrYYzV/vwpOaxRWjWktDuGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8JfzhuyfKwqPqGr3+xVj9Lb0vF8It29vG0eBsQaZn4=;
 b=s5eqbfJ0HmVvhAhxkaYodwj8wdg0+0zvNu32Hwr+5zve45woEJ88KYNFiNEqqetsHXe9sfz9h7r0ussxdk2Kh0GVA3hORLHj0N3sv42bro+9eKOt2stkhsSio3KE/vn9og5Rcft9le44c4GvcHA6bzaB0OyRTdYtxLncDle3HpOzP6lFAdxM5x+jEeA3F/w7iz2z0a8kZYDXGhAJX2rGml4nZSwdSI856r90uMskL4DddwoJYWdgjgUALMy/ellLvtSgd/ChQKXsONtEAdavxbyFBotDpRectrgcm1rkHrJYIcV5lACbXJ0Fvp7mtWahR6fMVSMJYfiS3haybWo96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8JfzhuyfKwqPqGr3+xVj9Lb0vF8It29vG0eBsQaZn4=;
 b=gi9AvyX+Mtlqw9ojkaqeUbLES6FDRpkHllAxBlanPveshGf8ZpQddI1H7uHw01Fn8qqkmH2BOcug86QFj3qp7BvEVbVd6oPaP7bZWc20RTY8gbKEqVDoz1/RiIBo7Lc9v16FffNKXJ5Bdv/sKjizGmlV45grWuotkY3+rToGEvw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MN6PR10MB8023.namprd10.prod.outlook.com (2603:10b6:208:4fb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 07:14:43 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 07:14:43 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, sahilchandna@linux.microsoft.com, cl@gentwo.org,
        ast@kernel.org, rafael@kernel.org, daniel.lezcano@kernel.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        rdunlap@infradead.org, david.laight.linux@gmail.com,
        broonie@kernel.org, boris.ostrovsky@oracle.com, ashok.bhat@arm.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH UPDATED v17 06/16] asm-generic: barrier: Add smp_cond_load_acquire_timeout()
Date: Wed, 25 Nov 2026 01:14:39 -0600
Message-Id: <20261125071439.10379-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261116082437.66739-7-ankur.a.arora@oracle.com>
References: <20261116082437.66739-7-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::17) To CO6PR10MB5409.namprd10.prod.outlook.com
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MN6PR10MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a612b6-8cbf-4c21-4b30-08df4ac3c6f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|56012099006|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261028144727099003|261021135927099003|261021121427099003|261102123227099003|261009221227099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	X24EqeFcq9PAmcnOLmLK5lGdbBQry/9nW3/aU/6g92dBctxOdyR3lYmbsKefBZFVsEUCxJkXuAA80s2781iOwS1cHZowaz6t5NL+1keGOT+9+2BuUFsm/q3G4FpFX9mUvwkLz5+vQf5Z20kJPXsgIiZj8wviPONYSw5oxug0LF+Q6NYb/gbQMTu9GdA1MRQKl9GDYIV8tpC98bZhQW4gLTSXY43yEO/GCmZj9hTMX7SuURw2GjipvyWjI1LNMyzth3QU5Bs4EUd8kPMV1FgrcNw0la3He2AlSfCeVro4rlC5VaW7RK2PH8Fwirrh75hl15sON7Jper/FTYRlkfwG6p/0BLi/QMXa891H/7koXygdsCTDyszXInsg1/HLeGEoJxVm+dahPgm+1yRTjrPpQYA1EFD1Q2dGx935RIbxsVe6gNIMFpJnTvHXrLeM/WrIVypWZRT9IaM77l7w4FBnJbhujadXl+t7gJBBDmjn0St+qsm9gzbiWwVFex6H9UEGeplcLP35PZwuRAS5onOyZOQNoIx+3TDnoAu1fUyELZROvuuhI1QIvS+ziqY8DEuGyh7etJ/JL6WZxTMI0RxRjPLi7PC83pDG7WscCq2FKQAP5YZRAB/MzzDj1Vksc1xOYhuQECItn9KfjrC+uUcy0qDrx5tPO9GRqZPDxd654Zo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021135927099003)(261021121427099003)(261102123227099003)(261009221227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pPI7J2p9juERAsUeRpN6WAc1YydcLOIRd9lNtiukmk4F28aSQE40SaaejX8d?=
 =?us-ascii?Q?i/gprXO7wOZh9biUPV+Iki0RZn9qfZ0SpYrITPSVrj5uRwVI3LQF6Waxrx7i?=
 =?us-ascii?Q?DrkVeBriM44jzgt0VD7ycxIJMws80BTu19/4ClAGempW/M2rfBLpu3jZVF7q?=
 =?us-ascii?Q?JDniXquBKpDWKFawmmAzFB1zdpDmJoxMG6tU9Y5mFBbyITQdT4k+tXrlqph7?=
 =?us-ascii?Q?RdgbpW7kqtqy4PxE9wNtM0YXDAyD7560UcQM0eMPiofMwojTByDcEqlkDBAV?=
 =?us-ascii?Q?+QAyGLvQIP4vZRNANOAfPfqtLmzkocf5gfho8vqtQUnT8zbE8o/2/phfyeBy?=
 =?us-ascii?Q?nGfFRV6MSelH+PXBXbfgvCcEXoX5K9bH/2PHe/kUFkFm+R9+aMO8olg9TfbN?=
 =?us-ascii?Q?3AwDchskPdIYQmVvQx1nKlcjC8AAC2i/UMQcSgd3lVkGjN7tNuOwpi39RCu9?=
 =?us-ascii?Q?bHpt2wKQgSTdqNW96N4tFyv0SP7YEmdMGWNr4RfWc3gvGQnJtzaC6yWqmQFk?=
 =?us-ascii?Q?RS3Aa2MKbh9M0gzljTYS8y/dgpSD4osB9vrTqYeSavE7ntVYJsTI4iNgNPsB?=
 =?us-ascii?Q?7AsKl214AKEZMZvcpLevyZXtFj4IZQf60AW11dvPn0YodSXIr+Ev0FmVhfv8?=
 =?us-ascii?Q?jKb8yigPjDoIScoNkezUP0G7NdqQ3b1FtVj6xVkns7geybtF4RiiYM98iSK3?=
 =?us-ascii?Q?x3dDb7JkI4GZu3zgV5aDXwSOKuU+XBo0+n2LNLSoMg0zbdyZUcTcEIqhsjWu?=
 =?us-ascii?Q?HWtT0oHg2kd5WU5AN6gJ/ns5t1baatU1VdvL5vRBQlCdojMsAGh213BH87SN?=
 =?us-ascii?Q?5JM8kb7mHcx7L7KlBcHjDPgc6hfVs6zEtFWeQ/KYrOKx6Cf8oQGNuLMZhzHL?=
 =?us-ascii?Q?+gf2w1NfHE3Dw1YMdT7k+N2Ijotbc1HwbccWYvn0g1DsW4rbO04kNnyryHWW?=
 =?us-ascii?Q?oOIBAtaEGXtL1pFk2//gbljt/hz00tn1ewrVNNODWa94mAI4/9ht2aLKO+aX?=
 =?us-ascii?Q?DZsYvNImAMEOBy0F381PcWKnOxEKSTvxe61j1EVKVyloaM1g4gKJk0XdTPfu?=
 =?us-ascii?Q?j8AHzbhIprJJTK6J1jTWkBq0z81NJ227tHRPXpG7QcIcRsAzvt50j2B4gY1e?=
 =?us-ascii?Q?g3YjPuiDmvrTP59ZLw+CbSSCVFlJG7Mv1h4l5nM9h++CxcqYppN89uTtSc4i?=
 =?us-ascii?Q?7WRHlIqKbx2/bOqtErbQJljS7V0uj5D/kthl9dgtsB0v2KPm3ZsYHp6PZglA?=
 =?us-ascii?Q?glq6AkzXMVEBHSZpJtobx7jVrsDXRBelQXSAa/ytPwU6fwHC8GmmoWKuCBBu?=
 =?us-ascii?Q?hlhBKHNBMrbLS0aR2x+6CGczBvqUL2sHRUAdu18o9vkQMdhIKC8qMWPl0ET2?=
 =?us-ascii?Q?dGiNyr68MgBxKmIXDJzHrjLOUYzApDleXDPDDpzrJHz+HAXrabMkWioO/Mfw?=
 =?us-ascii?Q?Ot6BSe3+60F9xEitff21rI5kvlzw28tuPF/2mbobp5EwLRz6eCbTjUr4pcSF?=
 =?us-ascii?Q?30z8gllBcAunYi+12gx4EHz6ewd5ASkFbE7dBYMARU83fhSaq+IAm5yB8Ogq?=
 =?us-ascii?Q?CG1KgKBhTg1AhB8jP/RMYwlxQzJMap6z9oq/a2gB6bL3tEFt8ovU80NJTD7b?=
 =?us-ascii?Q?qa30khRInNbpdYLUDlm2WytkzC8b5MDPGGu68oCCDcL4OTL13abKoPUA6zq/?=
 =?us-ascii?Q?SLsjTRlEZb3TAp1Q/yJ0B7DaIPdKn/HXHL0TOeU1PsvpXnlaKtzq1By2e40e?=
 =?us-ascii?Q?Lb49dT0kpZueCgA4EbSbCMcRtbTdTRc=3D?=
X-Exchange-RoutingPolicyChecked:
	Hixu7ACeXh77IVsWOBtBAYfI4r6UEdLbLhDK279u+Xn3ZJ0BgHsiTr9XVDXdEcf/p5ulnlK3OX8Kv81JK8pQIXTOazdNkoAJi+uciUO5G4QpfEz04MRYeJjxyJw0eDwDlkdxzzFChpwJ9jf7t3tgoF+PNpStUd+lBS81x6jQZTNrZbss0PT7h+wjy4Xip9gN/ml2r5e3RIB3R/YCaVCbrtxx2v6nGusEPN2UGqk/wzLrLXM9R8ezYAZpFP3n79fR9uvCDIeH9+3cCTSDkEBjAEw/wzzUaBV227FQbZCP4g3WE0Cf4PeGN8ACOVFjf8YDSPs4b4KxBB4XSkmU5uFygQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yfjTBhDOFTSLvsvqpYNaZdTiXrvoAxlsaca6JS1tNCupZjlCvpNNvBv2RNCSXPKM97iBccHHH85GxsNfkCo72VRMmrwnks6aJmLm8cR3tKKLBTRd4j4m1OuBe7xflyQHgVwsr6ZAr7x5ZlCeq0lB49bA7ZYN12CmiNi7VLK6PWQ8oZ+BAOBwZzJeGLglYy0SI0tgd1ygU8nIj/l7DmMsk9YCFZ+T/9Du4oV07Q02Zp1zEnT8rhjcT//9PSBtL6zDCjiI1EpEmACUWi5kpG1xfsaRZJbsuLNEShQ8zGVK1YwrnBqRswq22c1rK9zXbI//tbMTVVroyUICzeaY50KwNhYE7QvhxjbYHprEV9Kltaxx22zYN549VX4ttZpnj4qo9o4dJjAqVr97vzaZMkQjCQFTteGvmGM6JZSrvUiwUWw4YlD58wqZ5CFxJs0rjEmsqkTTEFjPnzS+cd+1t+EPL+9eooQXNragCKZz451sQuvWT/xxQh0rw1/AQBBCnb8CMDeEacnCkFjafCGtYs/bTUbANlpa+Y28kkI90cu0Gs7PUsyuMCPuKcEQ6UtP7KHcuKYqbA++dr4xoqbADIgsjmGJFrYVjWWTP7plvsC40Gk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a612b6-8cbf-4c21-4b30-08df4ac3c6f9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 07:14:42.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BMUFdx5Ra7IuZj1p0W83Cw7WNcaT6eK/2XEK+XRT7hkEGb93BN4/JAEpL9BkRkxthW38JScJ4aH3EajpEYRY/ikLl9dasOvDGrAkqwc3GQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8023
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250028
X-Authority-Analysis: v=2.4 cv=M5bYuCws c=1 sm=1 tr=0 ts=6b068ae6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=JfrnYn6hAAAA:8 a=vggBfdFIAAAA:8 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8
 a=bAMrUmItZINb0xDQqvwA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAyOCBTYWx0ZWRfX6eP+e93zSBMP
 xzgWg+zGBdw0q0QvKy0Y0QLsd9m7QZio6EJxYB1qRHM7ji1btrAVN65zTymVUSjv4xc5u7KwAVX
 RrsqNpBqmDWlNqT10D5VSS6QAmPLb630GI09AlMWvztkJs5C6dbz9pKl9/c2NLz02qODfdCz50P
 ISLlusX/+Auj53EEECKwXoh7nz2aVNJA1paikICOaa/mzwXgEe4Upy8bY8EKKplwi9pb+B4Vvw7
 lpPTThgUfyGDdonibx5fKUfmDi8RyRy2p/xXRJi+9eAsjUbg40DcUZBvLLpCPGbESAGkx+UseQj
 K8kSKW3Dnpk4qs9QPLtE5OH33lN3jV4JXDnQ432H+X+E2qN3gU5ZmNPd1q0pDQwjartGlqRVrOv
 uFEJ8QV0PHW6569/neGdy3yPe9GBiSl8ZOiblFqDBSIKY3thTqJ4poI5fO0T+v4Vj0ilZ5Bt49r
 IAWwXxB2AiT6T76eG3g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAyOCBTYWx0ZWRfX5jYzKTsIo9wF
 YUTwx4kGAiguD5bPt7vVKapW3RWWXRA88pt+Ia75s0/NO0n+UhpxvT3baN7FIlEVDk8cc7OeWeq
 mq9c+KP8OleBcpGWgi+mTYycjOxES/jV/BzCi8uiJW4gcMUB7mnL
X-Proofpoint-ORIG-GUID: 8qdf1BIQR51Pe-Rx4e1RfycPGslLIViC
X-Proofpoint-GUID: 8qdf1BIQR51Pe-Rx4e1RfycPGslLIViC

Add the acquire variant of smp_cond_load_relaxed_timeout().

smp_cond_load_acquire_timeout() does its own error checking but
reuses the relaxed logic in __smp_cond_load_relaxed_timeout() for
the actual wait.

The success case (no error, no timeout) guarantees that we have
evaluated the control-dependency. This means we can provide the
additional LOAD->LOAD dependency via smp_acquire__after_ctrl_dep().

In the failure case we provide a full ACQUIRE.

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Cc: bpf@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Note:
 - provide full ACQUIRE ordering for the timeout case instead
   of guessing around if the control-dependency was evaluated
   or not.
 - don't reuse VAL in smp_cond_load_acquire_timeout(). Switch it
   with _val which is safe to do since cond_expr is only evaluated
   in __smp_cond_load_relaxed_timeout().

 include/asm-generic/barrier.h | 52 +++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index bafc8eeff132..104f38197942 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -385,6 +385,58 @@ do {									\
 })
 #endif
 
+/**
+ * smp_cond_load_acquire_timeout() - (Spin) wait for cond with ACQUIRE ordering
+ * until a timeout expires.
+ * @ptr: pointer to the variable to wait on.
+ * @cond_expr: boolean expression to wait for.
+ * @time_expr_ns: monotonic expression that evaluates to time in ns or,
+ *  on failure, returns zero or a negative value.
+ * @timeout_ns: timeout value in ns. A timeout value of zero is treated
+ *  as the minimum wait so we evaluate cond_expr at least once.
+ * (Both of the above are assumed to be compatible with s64.)
+ *
+ * Equivalent to using smp_cond_load_acquire() on the condition variable with
+ * a timeout.
+ */
+#ifndef smp_cond_load_acquire_timeout
+#define smp_cond_load_acquire_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	typeof(ptr) __PTRA = (ptr);					\
+	s64 __scl_timeout_ns = (s64)(timeout_ns);			\
+	__unqual_scalar_typeof(*(ptr)) _val;				\
+	bool __scl_timed_out = false;					\
+									\
+	if (unlikely(__scl_timeout_ns < 0))				\
+		__scl_timed_out = true;					\
+	else								\
+		_val= __smp_cond_load_relaxed_timeout(__PTRA,		\
+						      cond_expr,	\
+						      time_expr_ns,	\
+						      __scl_timeout_ns,	\
+						     __scl_timed_out);	\
+									\
+	/*								\
+	 * We return after a timeout or, having waited on the control	\
+	 * dependency. In the first case, the control-dependency might	\
+	 * not be present so we provide full ACQUIRE ordering.		\
+	 *								\
+	 * In the second case, cond_expr provides a control-dependency	\
+	 * on VAL, which orders any subsequent STOREs after the LOAD,	\
+	 * taking care of the LOAD->STORE ordering.			\
+	 *								\
+	 * Provide the remaining LOAD->LOAD ordering.			\
+	 */								\
+	if (unlikely(__scl_timed_out))					\
+		_val = smp_load_acquire(__PTRA);				\
+	else								\
+		smp_acquire__after_ctrl_dep();				\
+									\
+	(typeof(*(ptr)))_val;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.7

