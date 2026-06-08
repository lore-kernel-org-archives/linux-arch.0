Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E0839EF0F;
	Mon,  8 Jun 2026 08:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905930; cv=fail; b=eiW9DyEcOULfnGXl3NSuJvms6bQFZdaUndnMokX4ttaFkNdb9FJy5s/IKRLwB6xALNYO2EZeqqyePpw273rPBWvFWPmgVECVdgsyqQrDvpdVchOUujAQNKaxRA72d/BetSI+DGQNX7qxfLf5veKSVKeijVJ6ti37Bova0QFccg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905930; c=relaxed/simple;
	bh=1NGAlTyuy5/nklLZBJTuXxw4k1QISkNA+ebPo1LWYNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lc+SzKQG+IV9NEZ+Fx2qwV8DFUZo/RWkYb2aPMFhv5vZA3y0Gb9Xumio+R+M+g/hDStIcMY96a35ZkS4V82rUIRlGP10oomWmd0Q66LwZHnfBp0RvNu6ph9kiRG0ZK0micNPVXvNDdDtgjbyEC5oTejvvfymOUXmQLZIJHJevE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=doQMuKW5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tAbsslJa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="doQMuKW5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tAbsslJa"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657NP0NR3893572;
	Mon, 8 Jun 2026 08:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=r89xWj/Kj2WKvY95K+JkAgfThnxCUMYLV9rdd7Hhit8=; b=
	doQMuKW5sZhezcrm1hzlXUPb9c+6lZ4a/bpDwxgO0q2rHEZnscERkPRlZyEP7eSP
	eqRZhmrdC1qJQbu0mugmc2QKEQI8NupCjePT1lJEzUAOLGMYyfsqSZ29PwnnHDlj
	YONnDqtZAmPMVMnuBerCi19mfTnyv20MNNFQdhK00qZJ6vEKOJt8J+l0QHdOIRfW
	BmLmjUJ5E1IwSYT1xGbv7RjeIXIabn5kQAX0rBc2p/XsihHz6OV+JESzqv9lXjMG
	R8TauC0GgFV7P+XDt0f+69OBf3QvCVg1Ad12xVyJlk5NtswNpRhBGW3Y8i5wdtJE
	HelN1hYnUUFZzmCJjWf4Iw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emb5st0f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:04:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6587w6h5040442;
	Mon, 8 Jun 2026 08:04:55 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0dg6kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jun 2026 08:04:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDGhxuWcikjpx3nogLk+Fbwy5vF2ZvxfnZXC7GZYVlInOs70yTAHG4LnquB4uNb7NN45aeySsJigxBWMn/C0DoIqU6JIIYVeEd1XQjgh+7svXhHRo5KK+VpQFwyoiWkynMwBizcOndGstt9B+SNUqxeOBgcvtZ8+Y4pPt8v/YFDIzUQsLZmfvwz++wSmErf2PeSiJOGpWIAqIn0uGFXO/RVICwxLqAKdl8FOitGufl7F1FVs4itCwsJAcDAbnODEhDY2BnJVY4hOZy7sIr+9+jVbwbD427Nj7wyUcIl9Jmg0wgfI62bXHk/3gY7E+oNFEuTJGlTFztcTRMD4ebvkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r89xWj/Kj2WKvY95K+JkAgfThnxCUMYLV9rdd7Hhit8=;
 b=yc1t2WMvTyq0J6Haxdz5JZDcNCDdcBTu0Q4q1kKhja4W/J9LwTe3c/6Ko5ToagzcgDfGh6oDKqn+7mOwev/Kz0Wxt90CKoavSL4NjSNxY8QV5Ayx+8eV9RfzxdtmK0xX/N0KeERZxPHmIZhPaOqvcdULeE2MNQKcLWvGn3rKXaQGLrteMDjgRZ1oLgU0LKf8EjZbBKuXcfaScn2dpu4yjHfTueEN34Eh5N+D9FLlx2GfaAKy1TVIUGn168ju0b1EEUafx6Q8xooLwIScOQG21wSG7YGuuebjQB58P6pHY0aidp02z16rr/Zj4mcTkw8z/nacLjKLzGWwqPkUoEv+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r89xWj/Kj2WKvY95K+JkAgfThnxCUMYLV9rdd7Hhit8=;
 b=tAbsslJaEAe9bBaLjjxS8oEoAwLldym47L0T0TXjoIaXgbQoFJPau7QR8wtuuxKBIm6ZYU4R5NX9saNV7qhysj/EXFF87HWZ60ukTFwg1OPUofsy0E5eRqw6ETYo0r2aCdQ3Vo6vEV7BF/Dtrso1LyCejVLVACLMlHRA4No13V4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA6PR10MB8133.namprd10.prod.outlook.com (2603:10b6:806:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 08:04:51 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:04:51 +0000
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
Subject: [PATCH v12 04/15] arm64: support WFET in smp_cond_load_relaxed_timeout()
Date: Mon,  8 Jun 2026 01:04:29 -0700
Message-Id: <20260608080440.127491-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260608080440.127491-1-ankur.a.arora@oracle.com>
References: <20260608080440.127491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:303:b4::29) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA6PR10MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfaac27-67b5-4b5a-4d12-08dec5349e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|6133799003|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	TcjocJsrKIS3bG+9G3dBtBmhHDAWLcb4FA5oy1gJ1Gcqyb2i1zaTDlLu/3m/a1mfWYAMbAnp153omDEtlzKoUGmSBYQ7uxl3ryTOo4A4M1JrYKWfGY38kyjLYrg8H23JujQH2LLsBr703e4rpQAvO+S25DVCycTph6Y7W2+SXWxednSWtmio5A3VSC1nFGZYfN4XqyrDzJbUQsQeJwNkP+rca5P4q5V5XAtOBadfZi2w3ypRFw9Dg0jWFDqrW4UXWpSF9tnVHRhogiOjxNK2pdg8p8r091jtA17rC7P+N19+5vTBHs5UFsIb3gb5wZj+VguTkDgfnqcKtT8ZNYul1p46bY9gQE+LfLCUApnHqbTbBlcU025X/qY4ZM5lY6FlBkT+1wRDtZ58BoAsukbALn1kcgHjua8Sw3UhMMzxWBp+TBU4HU08/Ma38NTDVDu+Y2bQew7Qq/tP2jTskZiIu2xAAJZmBMUraaQ3SrapO9T/6KEebpUHxC5qgTT+oNeTB36/4tWJO+pHUaybaTs4wXjQyOhPx7HwO9x/5dqD2ISVNzjf4zNAZqY70G6KlDlbO8Ed6DXICMoFWzV3a6lRfU6Eey+X177nMwlCBJFmSaTGD3fkD7mw3mv3FZFq9mFDAFMX/yigthokq8+lVgUu1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lOcjwQil+j6WXrsIsxBWR1IXpwXQhptiF7HfB1CjKxzWcGeUH5M1UQe3osm8?=
 =?us-ascii?Q?dcKMFavhEizNsvIufk70fMGg98q92vbERE8Zms48YZ+tlFuE9w6tZbPpWWjc?=
 =?us-ascii?Q?7JpLCXUWQyE2KEJTlcmXAtDihbLou7IfAI5UQs7aKqN9BSCzKhy+0uIsGDcd?=
 =?us-ascii?Q?OWY/5QKXy2PDP9CDP/RD2qraT8euuZjjRAJmHjfCwOoQ/cDNf9UlfswWsBF2?=
 =?us-ascii?Q?Q07avQYGDjqqNb75Y2x7qPe+3ZzVqOvInFkR5BxlE9p6xHM5vWorFPerqvVs?=
 =?us-ascii?Q?a182x68LnnBZppXF6oyDbIAE9a3A/qKHFRGpT7eikL7yQ8zH6FJLofOrgnsO?=
 =?us-ascii?Q?3s2GGzJ0e6gFQnvxv+tGWVfQDNMPSyT8ED6DlhvsrHIPplK07Y+mOnsyWJGE?=
 =?us-ascii?Q?03BZPbvFQ/I2/7QjByv45zciES2MHnbBRYnFx1YGDkK2EENw55S5FCnJuFkX?=
 =?us-ascii?Q?ab9EonYG2CUHE+AevZeaol/60GPUQn8ujFz8nrwXSCgUjomt2ecUzrb3Nplm?=
 =?us-ascii?Q?iSMK9GzjmVSCzXUeUAcZ7QaNiWDf6ODnqce2Y805wppeqhL/2uyvFPCyatES?=
 =?us-ascii?Q?coO0TNAlnQ0qeOe91AqPONj2BduQSJ+RPchkC4gdhmc7qxFFwvKvrL/1LReQ?=
 =?us-ascii?Q?9kKbkRer4mHTUiQnKZXHnNWaYjANgT+t07pGTM3Xt/SauXG3g8uTao9wtwN3?=
 =?us-ascii?Q?eM2ChvgNRFyt+ks3FELrdliqIVwDx3oz4r6GFI/EsUs19NlZw3GXJpJjvPv1?=
 =?us-ascii?Q?935Ub4+9hDcpBCjcS7pvsW3aRKEAHgDqlv8nw+/QFYJ+zUR/3/9S5Y2Uvz6G?=
 =?us-ascii?Q?Rc/SMuBaH/zUO5abMEnLe2ikYdXM06T/uXWsO2gWYdNrLoBb83dvh5JQ/I1y?=
 =?us-ascii?Q?56icu/DFUaRff6USv5qfU7uSxda9ngTiiTLkuOSK/Jihc6RESxhEFQmL0O5T?=
 =?us-ascii?Q?eHGNJxwn+R6Spch71UV1BBQqwRSjMrGugNAIe1OK8ha2f6lILMiYgnm85JEv?=
 =?us-ascii?Q?3dpvdbkXuaWmfNDlByAIY8sWSeGLi4nT9IoyzSLQF11FZpoEk3Na2iaMbnL7?=
 =?us-ascii?Q?+uSMVpp5Xl1AGPkdEJMLqOLYjWaRo7CNWMas7xDTiuaw7kgs/w+2Z3vSrw6Z?=
 =?us-ascii?Q?q/mrbCM63ODwl8R8datTuzNsN7ObgUKldE21b2yQpeXH51YLue4Wmaha2Ulk?=
 =?us-ascii?Q?YIO9l4mJV9pNxlXtpxfxEwoo66CdiR+vjO5+6gJq9mgxlaZUJ/XBanC7nPbp?=
 =?us-ascii?Q?Q2HHbnm9QPC7SB/Bi81Wos/RtJob0XCkwGQlxgEyb6PZKdunUCpkuZ4JaQ+g?=
 =?us-ascii?Q?51ivKJr44/HvO30/qwOeQuME3zbhnhyITHh7D1uu4nkQ/Dkkw6fA3odrWqFd?=
 =?us-ascii?Q?uIfBJw6o6qNoO6SA/FXnPbDZ9UQs0pWs3ty4ikaNbrRtTzSl8PNczb8VsuRK?=
 =?us-ascii?Q?M6WCozDKbNrGWvqj4G5QbmUf82oRpc4j8+AbNTGFGNi7f8lA0SMA2pVu6euA?=
 =?us-ascii?Q?jsPkkOY0t0aBduU3UDY1TdXiQisjOyw+8gq90X46poDbytjlCX4NRkw7DfiG?=
 =?us-ascii?Q?k535jk8f3RB+CtvEPmzW2ZBHcOzKGKyI53PDXX5ixZcngIK85BZhjLSu7JkN?=
 =?us-ascii?Q?Jg5gJh9I7pe9mcQFJbu7/Aor9DbhB6/QP66JUCIVPxJX1uUeQ5x2lAjeKw1V?=
 =?us-ascii?Q?ydGfXPd7Vb0lvhD7i/N6JOJEi22SEVxk4b5s2hB+oyQlB6UYjC39IlyVanDS?=
 =?us-ascii?Q?49ijgobMFw=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	KZ4IdRtrbJ5ydhNC7kA+OqnQ9pmcTAiIk32pl57vBnstalh5xRtT/cRopNVtBKlzu1PpAyqLXOWjl7ebsRSOuFFFicEzgaIpHcvIL1LGbECd1qGoQLQTy0UtZvTJTLEU4Cbf2MaE0XCFoo/gb2iz0tNyQKwCNx7Pwdpmyh8S2NZVWDavyrIlFnbd5TQyw6gtVwp/5ouWa30zAASQxeLcM82LoqZa56LccgGb1lcxc057RRpw6lm3eQzgefMvowTuY+Thnr8U4RXdbuGSL+D3E2Z9KkH4m/dATkTUNPzG0l0dLCNkyH23sdKAWnBvQbHGv307EqfT8peynfiqCGAl5A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0DqDE0OBb6C7Awgc9oR3IwKsNs5x9kdNPDMaSl8b4cqB6LUdlNrH4vfqfj3UNvQbaS+YWbTBUd5Pn83RkqKM78n1cdyjQWU1puGmxuHO+TaGlePeX1hih/D+Uomfyq20huRPToxHhFU8S0UxlOSFyx401Ih06iY3oJtvW8myX2veogmDe9AdJ4T2yNfxICvtM6TrR2cpUM1FhMRnS4XHt7rLGPGA18ApSMSEiQFqrvqgzjPOyH7EaWEZMWrsIDK5tdFgxiW5Ab4OYQ1U1zZ0QLfTSh/Gh3k7FAt5uzRQPP90oyaW9LBi3nHM12RfXkmRnB6HSEljWXsVELvSz4+FEk7PPkf4nnXC/XkQtjecHR9JEEjFr4fGM1doeojnGO6+EJqnoBd+ImHnbiD8486CXLbbpH5g43MDYrJkX220TGRSzqZDcVVVZesZMRN+NvyVyONvwKHYh1ASwcEKtsg8NebovKMaUc+vUMkJgfq/90lHaogcFQQ10PH/iVMtcZ0EzMrbQJsiVTo1IOxksPmet2O1S7PlBCFnpOrsHKX3RPCYKDwXaYsk95hfE0OgpKRs05yvDGnokJJSzLgdhJG3vHNX9/xfvUEB4FrZJqNGgA0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfaac27-67b5-4b5a-4d12-08dec5349e37
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:04:51.7513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIWn6T4fm3PxWrTmhj7Sm2MG+7q4Z7ZaDgKqKdcgDkD+j46jSQ11eU+YbGJG9EqAkyiKxL1MPvbhC1nEsjsDMtZqu55axPvMO8RforLvkN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606080073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfX9gtDNsTPWDw1
 npxJZfr2q8Li0HIzbkTOKW1xC/g4yJaAdra/mxI+1jzpispAYc2wy1xhVe+uSc2D6TbVDMuyL4u
 8ziQAJWoDoDGoAzGVZaNIXVYPShkXhQKTfGnYj8vNNMfCAF8YyLQqNGW0HzK4fGGCIZRim53Z/i
 DGHyIwrvWJ6lpNlX1d81x9DVrlunzbYSJMN/z12HTpCq+j2tfcQ8s2Upd1wQ3tfQj8t860TDpeM
 fh56xLpP6S95jd5ucyckIeLKKVwzwgBeTDUoQ3FHxUXi1T61qpkv7tV4pLPoKNQnpYtl5xyYAvz
 w3YGWp0Rzbz7yXhySO5jnBjJo/4lCUVToeguRgBZiFj/ggL9eAyKORuBkkNrA+a/7mL7nkZ7p53
 wKrK0oEuy4Ed3oY3LGpFV91uGDbJroA/j/ZQCotmacF7S6C4GhSOZpGcsVDCZ0hwOjQRPlxPEbY
 t8+eJ69A94N2wIGk/bw==
X-Authority-Analysis: v=2.4 cv=XeC5Co55 c=1 sm=1 tr=0 ts=6a2677a8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=c92rfblmAAAA:8 a=yPCof4ZbAAAA:8 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=h2j_Ys_cKJEXrGAlRtsA:9
 a=GvGzcOZaWPEFPQC_NcjD:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: zQwpY_6cnv9EMml1kvG-VTJkaFdGZRPu
X-Proofpoint-GUID: zQwpY_6cnv9EMml1kvG-VTJkaFdGZRPu

To handle WFET use __cmpwait_timeout() similarly to __cmpwait(). These
call out to the respective __cmpwait_case_timeout_##sz(),
__cmpwait_case_##sz() functions.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---

Notes:

Does not address sashiko [1] comments on:

  - timeout overshoot: intentional, not meant to be a precise
    interface.

  - range edge cases: as mentioned before, better addressed in
    code review.

  - loadable kernel modules using this will fail to build: niche
    interface, not worth fixing unless necessary.

[1] https://sashiko.dev/#/patchset/20260408122538.3610871-1-ankur.a.arora%40oracle.com
---
 arch/arm64/include/asm/barrier.h |  8 +++--
 arch/arm64/include/asm/cmpxchg.h | 62 +++++++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 6190e178db51..fbd71cd4ef4e 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -224,8 +224,8 @@ do {									\
 extern bool arch_timer_evtstrm_available(void);
 
 /*
- * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
- * for the ptr value to change.
+ * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()/
+ * __cmpwait_relaxed_timeout() for the ptr value to change.
  *
  * Since this period is reasonably long, choose SMP_TIMEOUT_POLL_COUNT
  * to be 1, so smp_cond_load_{relaxed,acquire}_timeout() does a
@@ -234,7 +234,9 @@ extern bool arch_timer_evtstrm_available(void);
 #define SMP_TIMEOUT_POLL_COUNT	1
 
 #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
-	if (arch_timer_evtstrm_available())				\
+	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
+		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
+	else if (arch_timer_evtstrm_available())			\
 		__cmpwait_relaxed(ptr, val);				\
 	else								\
 		cpu_relax();						\
diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 6cf3cd6873f5..9e4cdc9e41d1 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -12,6 +12,7 @@
 
 #include <asm/barrier.h>
 #include <asm/lse.h>
+#include <asm/delay-const.h>
 
 /*
  * We need separate acquire parameters for ll/sc and lse, since the full
@@ -212,7 +213,8 @@ __CMPXCHG_GEN(_mb)
 
 #define __CMPWAIT_CASE(w, sfx, sz)					\
 static inline void __cmpwait_case_##sz(volatile void *ptr,		\
-				       unsigned long val)		\
+				       unsigned long val,		\
+				       u64 __maybe_unused timeout_ns)	\
 {									\
 	unsigned long tmp;						\
 									\
@@ -235,20 +237,52 @@ __CMPWAIT_CASE( ,  , 64);
 
 #undef __CMPWAIT_CASE
 
-#define __CMPWAIT_GEN(sfx)						\
-static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
-				  unsigned long val,			\
-				  int size)				\
+#define __CMPWAIT_TIMEOUT_CASE(w, sfx, sz)				\
+static inline void __cmpwait_case_timeout_##sz(volatile void *ptr,	\
+					       unsigned long val,	\
+					       u64 timeout_ns)		\
+{									\
+	unsigned long tmp;						\
+	u64 ecycles = __delay_cycles() +				\
+			NSECS_TO_CYCLES(timeout_ns);			\
+	asm volatile(							\
+	"	sevl\n"							\
+	"	wfe\n"							\
+	"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
+	"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
+	"	cbnz	%" #w "[tmp], 2f\n"				\
+	"	msr s0_3_c1_c0_0, %[ecycles]\n"				\
+	"2:"								\
+	: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
+	: [val] "r" (val), [ecycles] "r" (ecycles));			\
+}
+
+__CMPWAIT_TIMEOUT_CASE(w, b, 8);
+__CMPWAIT_TIMEOUT_CASE(w, h, 16);
+__CMPWAIT_TIMEOUT_CASE(w,  , 32);
+__CMPWAIT_TIMEOUT_CASE( ,  , 64);
+
+#undef __CMPWAIT_TIMEOUT_CASE
+
+#define __CMPWAIT_GEN(timeout, sfx)					\
+static __always_inline void __cmpwait##timeout##sfx(volatile void *ptr,	\
+						    unsigned long val,	\
+						    u64 timeout_ns,	\
+						    int size)		\
 {									\
 	switch (size) {							\
 	case 1:								\
-		return __cmpwait_case##sfx##_8(ptr, (u8)val);		\
+		return __cmpwait_case##timeout##sfx##_8(ptr, (u8)val,	\
+							timeout_ns);	\
 	case 2:								\
-		return __cmpwait_case##sfx##_16(ptr, (u16)val);		\
+		return __cmpwait_case##timeout##sfx##_16(ptr, (u16)val,	\
+							 timeout_ns);	\
 	case 4:								\
-		return __cmpwait_case##sfx##_32(ptr, val);		\
+		return __cmpwait_case##timeout##sfx##_32(ptr, val,	\
+							 timeout_ns);	\
 	case 8:								\
-		return __cmpwait_case##sfx##_64(ptr, val);		\
+		return __cmpwait_case##timeout##sfx##_64(ptr, val,	\
+							 timeout_ns);	\
 	default:							\
 		BUILD_BUG();						\
 	}								\
@@ -256,11 +290,15 @@ static __always_inline void __cmpwait##sfx(volatile void *ptr,		\
 	unreachable();							\
 }
 
-__CMPWAIT_GEN()
+__CMPWAIT_GEN(        , )
+__CMPWAIT_GEN(_timeout, )
 
 #undef __CMPWAIT_GEN
 
-#define __cmpwait_relaxed(ptr, val) \
-	__cmpwait((ptr), (unsigned long)(val), sizeof(*(ptr)))
+#define __cmpwait_relaxed_timeout(ptr, val, timeout_ns)			\
+	__cmpwait_timeout((ptr), (unsigned long)(val), timeout_ns, sizeof(*(ptr)))
+
+#define __cmpwait_relaxed(ptr, val)					\
+	__cmpwait((ptr), (unsigned long)(val), 0, sizeof(*(ptr)))
 
 #endif	/* __ASM_CMPXCHG_H */
-- 
2.31.1

