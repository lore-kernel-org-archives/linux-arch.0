Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2829723ED60;
	Mon, 16 Mar 2026 01:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625070; cv=fail; b=tXmiugBVTaOdU05L35VRSvG0EH2XFZcSIGFsSxMlM2j+caj5rr60ZVAR7ARiJVunOckHGxu2tbvzmCWotnO9F/yRXFsvrDHC6UpsvpCQrXN3JM9XH7I2yCDZqiLgE/VL3wA7GGv225KlcIZyQvWuM0MhzXd5xu6YHouWerHEwJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625070; c=relaxed/simple;
	bh=46sJQDueFkIf+E5bE9BvltKHJ0/vgGoXnMyx7bBGGLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Amo9YrMirxHWtSL6Y5Dib9S2mr3RysrBKwKqrZXE9ARn1tjHkIosPwR5i4k4Hk83SYeveOOLjx7G58LWj1ybpnMQvgSrJMZCpuqatz+19hC2QhtFFpPzP6Q85tdHuYHTzbCna5YrOKduBVzeUuJGTgaxofWqx56w7CQk7j1vdNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Aa9yvGEy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QbMAF29R; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Aa9yvGEy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QbMAF29R"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G0Am0l1323668;
	Mon, 16 Mar 2026 01:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aG2lAbZ6LdnUqGted7YggmlE8+g53l/PXDoz0JMPvKc=; b=
	Aa9yvGEySrKxhqJiMQmnOliyr1d8MHMTIuJ7f6axs6yBassAvd55yb3VtiastuCN
	9cWtLJ5fA60BBSttrxRh0wKxdxkWHRLqMPxoo8lYyILxkMEJvRdbxSWiB5Fc5818
	7kDYy5MyhvrnuOpUTQwVzJj2v730Jy+fR+J5p5RJ2ftsi9U42grrz6YbRFnezcT9
	IrBzUcoTsne+NbemcTd8+2aaADauwcyJd5kJ8JwWYbPz7/D+c9u5enZbVsthkc4W
	wmbrVZjNoxOlN7rwMd2Sv2qwiza9wuvXOM4VtP9vs/Onc42hlWrXvW5uMqgiEV9b
	EjB4mlrl/GdXYXq9KF3yNw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx3b1bh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:36:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62FMZmu2030614;
	Mon, 16 Mar 2026 01:36:58 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx48043c-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:36:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqVAvPtK8i35x5va0EYZa+q1hPYWDj9vWYftdeaAiGoLVwvmV6sVEpUu6QjRzMXOLgNfNW9meb+TZMX3ZlTdxIX+mYFfdlxvozC226l0UH4ATxQlQFSkCtN4C1OLyejL6Vu9r11aHKRTRfaAPRfyMOkrgKiTUSKA2yFw0Rcqo72LTPnxGUtL5hD9aUlBX1hVFw6mGHDfoJIMVnq3S7FmiruC/kwseNU6S4m4x903Rgmmd8JTMjsLvpI2k9Mh/xRyNmNEULpm1e04Gp8KFh3BSGe393mumqVk4+EwURhptELLykuApqnLHWBx+MRvYT0AIJ2BBiI2JeOFr5eFfkY7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aG2lAbZ6LdnUqGted7YggmlE8+g53l/PXDoz0JMPvKc=;
 b=aQA1DUj4LtBwJoLKm4MG7RRDIg4MNRTUb6Jr1WIIU2dU6mhhTOs6OHLkNJXdhkKhaw9uxFeluAjqybdlF41pW/iBukew/3zMI8d38bSqaWApT0pePLEah3Gk07rQ3k/0hCodwWsZs8ZHD9L9pYHIc4F42NzSGEiORsrby6jwelwRg723XqICsmE9Ih2UWjcLzTNvrKFqNRGs9WPcJNGgBhYBh59lJYgpcxoiqIdT8gWwSFFFVUF5o1jTF1+86UF1SnA3leo/Dj9Bm9BgU+SEZcpxCwJHMDLFpIM8Ym2R4c0Ben1Bb0faom48aB8gdRE+O6CI//X091VSVvdKLfYwaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aG2lAbZ6LdnUqGted7YggmlE8+g53l/PXDoz0JMPvKc=;
 b=QbMAF29R170+42+sD+K1GaYDEiVRsG4xyuF+WSLzm8RS6IyJhFN01+4etOdsZh+lPkNs6LKxSENc2j3xU+0cMLCAwHSdZLLNEBZXwyYyGuWkvRMjk4v39WE63fcTxu+wykTw+mRBxVD7vXEBQMT0h+LtiBHNvYChVd/qw60O75s=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA0PR10MB7372.namprd10.prod.outlook.com (2603:10b6:208:40f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 01:36:56 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 01:36:55 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v10 01/12] asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
Date: Sun, 15 Mar 2026 18:36:40 -0700
Message-Id: <20260316013651.3225328-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0318.namprd04.prod.outlook.com
 (2603:10b6:303:82::23) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA0PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 377ac3aa-7496-485a-016d-08de82fc81f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	499GIxbwzOhjaOTyQvEbiUhhq9W5cOPSODlhp17uAezGej1vdcpn1ylM/pjayhtnW7pnfg3Yka/+0LW3i2eQT0JZYDjtzgc4puIWTilDoQkADljWTHj3ruSoOoIl5e4hS9E89s2Wmb4PZLDvRX69LVs8Tc3RBV3mrRFB0iNFQxGAUTYMx6QoZVyClYooob/25XkGonPobwtRFSnigH8ULbXA9/KqjVaILGM3wYhiXqFx1y3S8BGlyJwpRSmypH0j+ud3/qXompuP2j0TTCgAAfBJ1CWkk5h6X6wO62z/04m44N2h/PYS9Nwgq4RZgjOhqINO2F+wDfQshnA4Pp7YJiWCWtZ3NUPouyy9z/Iq71XwuFoYD4N5lCzLUUoHK2c6Xa5jZVwt/3udiQWtKktMP3hDX7Si/YqsTGtXahyRQZIuQR9bdaXdkgRdpTFMYW0cUiN7lzQ+yMTj9pS6EZ04TextXiD2xc4t0VsK37EECaUv2Eo7NGFFRyoMRRBDc3x3BZ1wtgyZ2PJzo9uxLxgLCbHOVAD2q7EeEiuipzM/hC/wjIyC3xR5wm5tHOQ9AewxApuq097KFyH1XpohRi+r1pqv00OvFnlYxBP4PpCg1qf4V7linonvL444Xm9i4+ZJ7hDSvMvs+MLtnDVeuDPOkoJYYla4E77UCERCZrvFbVazXJ4QtJKAbFierfc0463dlqQp1g10PmiBWB8lBOvgQs6j7x83gONSCjuX7iHLrW0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W6lyAJpeS/HaHuSb4U5xp9hKSk58C1dXPCPjG1griq/YKYtHB3aBwlnSNtu4?=
 =?us-ascii?Q?pXsgnnFQ8t8NNEgmV34DgPllJpOJqFAqNz2z0GQgU2VdS82d57P/ZtrWwCTJ?=
 =?us-ascii?Q?JKZhCd9jVkIGWC4Y1dFTiqp6cfq/2b9zPECQlJcD9r/PZy75HJx5rQJEatYy?=
 =?us-ascii?Q?/51mCrrWeIettonbDhM+rB80cy0EbeI3xG5c7AKqpkSWz8zVNXCQDTqlk6xA?=
 =?us-ascii?Q?UYO/D2Kz1UFEfnHeXeOFvewWSjQZCT3z5qsRsPnl5IER3dWgXSPc/gfBm2sE?=
 =?us-ascii?Q?4+P/MdUBeVXUjOnbOLbqsFRi8shwVRhN/MXYJUNPFdl0t2bnhvCCeLbMaRUZ?=
 =?us-ascii?Q?tivgRIlqga13bc3s7p5AEhwlsYQm6BtPMbEuzALEEsBWdsk1ubcVvbwDn81o?=
 =?us-ascii?Q?VywtM7oZUBOr5h2fKtSl6XgOdyt05JM9w9eVUuWhuVbYwkWpUjSB3+d/4/Uc?=
 =?us-ascii?Q?Z0/fQNYWTJUivwJj3/uXXaNSli3o9M6yGdn3jKTFJcyHlx+0fJSpgRn8cby8?=
 =?us-ascii?Q?d7zuxNMUI76HE0NLsxjh+FAxoWp/XWyQVoLMRiKGybWBzvsT3P3Ea05MffX5?=
 =?us-ascii?Q?OUjrQy74pUijyhfLIkGA0aVSsZtzhvemfBBINJrtPQ+gasF7PiPEN/j/Tt9F?=
 =?us-ascii?Q?/YKZc3Dc1U0w8+GTyluZxfITCdxsy/dBNmyQ5N5WP0d2WJp5VDomjUsjw6Ik?=
 =?us-ascii?Q?JH8Y0qc8Y30hpKFKIGxENRskUAF+tpTpjiechpf1DS80+NKDhkG1eB/BVjUn?=
 =?us-ascii?Q?eaUhNDfMaa+N5VJ61uTOqIDFZvm33rFGR0JR6d1wgTRyLmhpZwVKFpPJMWxy?=
 =?us-ascii?Q?8GkWJb9poZRFifrtvSA+P9B6RJce0QuwfV1N2m/eml7PV3cOqVjtPjGTuoc4?=
 =?us-ascii?Q?iJgZCFbtrmWDajJMvf8PhAFBM3Q3ku9Pu1eTRL7cHg2h7xBfZUq2EzLPVqgM?=
 =?us-ascii?Q?GJ5BZ+z+aaYKaUYj/yrGAXRdI1C1uGXj5+ZXx/6q+mjvNanxGiGDLzlOfH6+?=
 =?us-ascii?Q?VvWDjkt/0qAi6Qy/uf2Iwu4+6Fl02U7jye8419IY/xYB/AYwhh1PKoNO7HRC?=
 =?us-ascii?Q?CGOdmSyJNh+VS/r7dsnhKoDucg65L/yqnDeaJ8oXUmrdDvZpnoWgMQFjQIvf?=
 =?us-ascii?Q?W3DnMFgqPskao1W2grIoX0w+FMskUv1lx7OEh5NhGPzJw1KtuzdDQxlf/KjW?=
 =?us-ascii?Q?4moWXg487Db7QuAvcnrb08P/ivgBEaJyvrE7HpQ2kjU1Qxt+RyjccnTEyHyQ?=
 =?us-ascii?Q?vJ+rMVqW5QusHRziTE18XYpbtpnY21e9ontU7WfliBTvoMDeI5UUnIZRY58x?=
 =?us-ascii?Q?r1i6J/NRL80gy+e5f0igX0sWkirV/SEYhaNJF+Smitz9NOyM/ro7JQyTutj7?=
 =?us-ascii?Q?JychIbV3Zm/9yI+dmMY8cFBYJHTga9Wc7kiWr/K9uiWebPKKqQGyK4FC0YiH?=
 =?us-ascii?Q?S8BxVhyoVzd5TfLNwtr8jmBl3UanFaAC4XHjK9bUlY53WQrgdYcBPwW3a0//?=
 =?us-ascii?Q?Ek0O9NcQq1X90CRNtMrk0zyqMQBxpX18qU9IIWdoVFFEDOcjcc+gPX/uFU67?=
 =?us-ascii?Q?k9dq2SlbQw2JuqEP1/sLKtCEsLy8z6GXZT7RguPvWBcgc4Wtg0PWJeuDVvhn?=
 =?us-ascii?Q?Pd/1OF2JBiUR1DBqb4/zp5qMy0JsHxR264eNosltTJQnqxkm1jyEZ9cyaPTB?=
 =?us-ascii?Q?NpQO1gvj52UK1ZTOW+5YGKQ9AxcAB+N/hXjHcBFhldZe95Ic3CoPB3Flk06b?=
 =?us-ascii?Q?2nHjF9YJ/A36rbofbuowqnRguFtiKNU=3D?=
X-Exchange-RoutingPolicyChecked:
	VNxkxoy7SSO3aUyMBTNBLpRBYQdYMfoK/8O8sEXEbd3G9csmC2yUrR1a3eCwGyNwog86VlHDCSwTl1/xh18y7WNC52cLc98E0JGx+xmBOC1RAQHRztYPx4J7bmrPMEeswhboznrZzZx2IESCTAxFS2hwNg2HlfSEcGTuc0javYz1cU5G2YK/pZrcsgcSWMbFU3BcXTkfEw7pcHeFlB6S8qRPkH5VNWkS0lkkvy5sOuJuycVepCHZ/kjIotUCtEwM3acqpAF92xKW5giuzZg+WHKW+uK7oQgYSToz6NKVft1OAqDQ9EgFBLPzFcxOrPoHECEITt7OvJgQrgqU40vYuQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4Q4wgEQe8yc4TW3XbVphqGdMMScqyGgaLD40tvySjCrm6rW+XMU4H8WZDcNbHiabCkGau0CLi5HyjJVoG4OEAnu/iUrDX2rRlFdmIEg/XQL2EgSc5UYyRW+QqDonKU4L/QAOxmbsqj6wC9yKHbtu8SWD8Op7n88AUJ7IHodIdJZSlE8g8PVSsxf2ii5ax1y21EJMIqatZiCuDb+qOg5gMJBOO/c9xCypiaqedFxv8LCyxRjHHgM5SrG5eBPGJwGL3P5JiTzjOo7gOWyJNWltSOQVjgknforGKuI2sRtnI/Mh6FtZ3re+W1HkkzdcBUWhVbeyMWykiZ07EqR7OanIFmDcBZV1P+n7a51UWqFMDc6FPtvXFyvWhHQC1g3gKVrsFHsOiCN3lBTwsDN61d6Y26p/eh53omjkGLpzc+znS4NYkvTrUXESHJinHtrtzW6I7dmyok786rvh0d84G8TO+iNmFGlW36/J9flWKyEMIjucDnzHnuDxn4ze8ERY/2uGWhiCxvkqX/H7YrVMPLVVbnJqTUh1KX7C7O0uoTgwBvbi4VAREJI4uNIPGmmHRJKUomhYHawRgT/MobQznkwVYeEy+k0BY+DqAwyFOj15n5I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377ac3aa-7496-485a-016d-08de82fc81f6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 01:36:55.8479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+GOyBUUFl8btpCo79Rt79xbHYgrTby7M7ucrj0CVAyef+cWtu6OWEQznLzzTKs3wHXVosm+uBLOgon0j4IzYL6LKfyYagVPOhP8dMx2X4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603160010
X-Proofpoint-GUID: e6OLuY366rAFqfisoVHQzIY3_pktQiUu
X-Proofpoint-ORIG-GUID: e6OLuY366rAFqfisoVHQzIY3_pktQiUu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAxMSBTYWx0ZWRfXzebrgE3WOuBt
 VstcYsia+gGvcPI3+We4zZuQhpgdAzgHu64+LVPxFtCzmOIeqCoXfj7puILKW7EIHR9uxMQM93Y
 gh+Htd1tQ0qc7xhZRCuZbSldhEIz6c22/6Ijks/s08DrBzLADol95H/FIcuQAO6LSVD5y33GXvH
 DeSw8cdntwXVpQmC1elb1TMRngP0/mFMQT2v1KTy9wCBoHbYqB8mEdqD/POhwFNE7CQn8UcW3ii
 SnucISo2CwWs81AydCmeghbNTcY60vemlkOtT+sYfyeHHOK6dSb9p7qDJhIhGKuSn4i7rrNYczH
 iDUSsrKNYibe+ols7I4xggQnSaDP9MEPISNDAznNHjUVhtir0QPw5SxkjDyoRj+NKACnyEg1rK0
 qo0Y7DpC6aQpwnNftH0rBYq7I2b3V6X/8gnIQksmoS1rd0fLTNJvZogR/yG4wQC+VTvIDV/v6Ry
 y5UrbH0fcjpQrrE4itg==
X-Authority-Analysis: v=2.4 cv=IN4PywvG c=1 sm=1 tr=0 ts=69b75ebb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=yPCof4ZbAAAA:8 a=fV_dhAPnEWTPURU-wNIA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22

Add smp_cond_load_relaxed_timeout(), which extends
smp_cond_load_relaxed() to allow waiting for a duration.

We loop around waiting for the condition variable to change while
peridically doing a time-check. The loop uses cpu_poll_relax() to slow
down the busy-wait, which, unless overridden by the architecture
code, amounts to a cpu_relax().

Note that there are two ways for the time-check to fail: the timeout
case or, @time_expr_ns returning an invalid value (negative or zero).
The second failure mode allows for clocks attached to the clock-domain
of @cond_expr --  which might cease to operate meaningfully once some
state internal to @cond_expr has changed -- to fail.

Evaluation of @time_expr_ns: in the fastpath we want to keep the
performance close to smp_cond_load_relaxed(). So defer evaluation
of the potentially costly @time_expr_ns to the slowpath.

This also means that there will always be some hardware dependent
duration that has passed in cpu_poll_relax() iterations at the time
of first evaluation. Additionally cpu_poll_relax() is not guaranteed
to return at timeout boundary. In sum, expect timeout overshoot when
we exit due to expiration of the timeout.

The number of spin iterations before time-check, SMP_TIMEOUT_POLL_COUNT
is chosen to be 200 by default. With a cpu_poll_relax() iteration
taking ~20-30 cycles (measured on a variety of x86 platforms), we
expect a time-check every ~4000-6000 cycles.

The outer limit of the overshoot is double that when working with the
parameters above. This might be higher or lower depending on the
implementation of cpu_poll_relax() across architectures.
Note that this analysis makes an assumption that evaluation of the
loop condition, @cond_expr, is relatively cheap. This might not be
the case if that involves MMIO access.

Lastly, config option ARCH_HAS_CPU_RELAX indicates availability of a
cpu_poll_relax() that is cheaper than polling. This might be relevant
for cases with a long timeout.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
   - s/@cond/@cond_expr/ in the comment describing the macro (Randy Dunlap)
   - Clarify that SMP_TIMEOUT_POLL_COUNT is only around memory
     addresses. (David Laight)
   - Minor cleanups to the commit message.

 include/asm-generic/barrier.h | 64 +++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d4f581c1e21d..8e6b85c3ed99 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,70 @@ do {									\
 })
 #endif
 
+/*
+ * Number of times we iterate in the loop before doing the time check.
+ * Note that the iteration count assumes that the loop condition is
+ * relatively cheap. This might not be true if that involves MMIO access.
+ */
+#ifndef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT		200
+#endif
+
+/*
+ * Platforms with ARCH_HAS_CPU_RELAX have a cpu_poll_relax() implementation
+ * that is expected to be cheaper (lower power) than pure polling.
+ */
+#ifndef cpu_poll_relax
+#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
+#endif
+
+/**
+ * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on.
+ * @cond_expr: boolean expression to wait for.
+ * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
+ *  on failure, returns a negative value.
+ * @timeout_ns: timeout value in ns
+ * Both of the above are assumed to be compatible with s64; the signed
+ * value is used to handle the failure case in @time_expr_ns.
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ *
+ * Callers that expect to wait for prolonged durations might want to
+ * take into account the availability of ARCH_HAS_CPU_RELAX.
+ */
+#ifndef smp_cond_load_relaxed_timeout
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
+	s64 __timeout = (s64)timeout_ns;				\
+	s64 __time_now, __time_end = 0;					\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\
+		if (++__n < __spin)					\
+			continue;					\
+		__time_now = (s64)(time_expr_ns);			\
+		if (unlikely(__time_end == 0))				\
+			__time_end = __time_now + __timeout;		\
+		__timeout = __time_end - __time_now;			\
+		if (__time_now <= 0 || __timeout <= 0) {		\
+			VAL = READ_ONCE(*__PTR);			\
+			break;						\
+		}							\
+		__n = 0;						\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.31.1

