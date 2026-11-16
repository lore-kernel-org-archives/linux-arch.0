Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794817527;
	b=MQzwMdiG/kxilEQaI70bz04WAGWDTbgdfTKcK9OHSiwLs5L3DlDgyO3LOvGy2mvj+z95
	 wFFCvDmiOq8hei6iw6ciqrY8nHRB2NroCeRyIDB7EiZKCwo7h9bbVeQmeADcY/i8LwAIz
	 M/59b1CzyRHNJH70D9Pgt4WEBpvn8Fu2uhczlzykViyB3g1sj2gdJxNg+q94B0hpyO3Xv
	 eJ0uMM6gvx22CRrXbOCOo1jfQHPVAhr2Qo0l0s2KCQrksNu3tRjFLoiAJrMmerPcyFt5O
	 LBxctMnycAsM1LUiiQJaalu3szk759RZcVbsnxb0WvVhNHYMzMJ9YZ5YcVdQNfIlM7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817527;
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
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID;
	bh=/7zps7t9YR3CBezKw5uZn1QgP7EzunHAkkrwqocEPCE=;
	b=0AiK4Gg9Ec5nnVktBkZuoWrxTLFcWnykqcbfDRzWlo0gy8E4Y5mPgVTrgNX3e7Uj6i/i
	 2kZqhVKGel8vdE5o4W3Hr7HmgP8Fpos7YUNAfqjYWkLd4931u4/TwTANYUxcU4kb2REoF
	 AEefCujBBDJ6/qi4htZMfoqyYeV/7N6L41jS20wxxaVxPzR53KYzOPq9sImaUqvyQqFld
	 42vsSzBilMkMWSBcK0k+PcTN8C/L1ZnQ7woHwqfACud/Mcbfkn96Lws+IU5xQLXkyc+g/
	 i2ahXE2NrxuDbvs038ED2gz/vBo6wVCKnwaGqNNtuzZJK5kzgbjQpfY6e5S6Fb9u3ZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=a+iRT6m9;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=yAtnVfgh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5D8606A32A;
	Mon, 16 Nov 2026 08:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C5D8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=a+iRT6m9;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=yAtnVfgh
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFLb5Rx1152310;
	Mon, 16 Nov 2026 08:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/7zps7t9YR3CBezKw5uZn1QgP7EzunHAkkrwqocEPCE=; b=
	a+iRT6m986Cin4/t0OO04UOtaZAH0ueK0+JLncEE7wd3gOEE6H8G8y16JHjHovrP
	OckaE088g9Qu7RIiTbnZ9b6pLbOh4Cg/XC+KznpqyqDs1DwQmJWn5vfKnIR0+1cK
	fbyBTI404wEdBA2D0j7QPspDwLnooEAByEd3uexle0jdmGNU3nN81d32HcyIiUIs
	WRHowMg7yqHOyIYFI2Wt28jRebbt2LDRgS7blLFF5WIytC19Ed+Qdgd7Z9ztPnt+
	IR6fIuF+MwtB236kIaEZpvlr64Os5MGXX9mH0bsqnKQ/vYFrVMyegvonVfVkjRB/
	XrKb7QzxoarekeWkEjxh2g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxee41mgx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 08:25:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG8HRSv2181695;
	Mon, 16 Nov 2026 08:25:00 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hyv7pmb8t-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 08:25:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWm+2B89xu03g0YTLPzbAFln6nTzeHgZdXL6HvZ723W/NCwMKGDATAxH6TYe+HtoZK3eyp8tWsjDKetorwQfrA4WahLrcq9bv+VQIg3fcHTdpyazF+0MEe8wMq3+f7CBdyJfglzLra5lfIuOiWVrMvGMebordMGoMQfkpdDGiKxo7YwY2+SAa9lWwprSD2WZCoJ3+pcDPB17ziTaATsvgZKDJ4WGIEW/QOYVgaA2Pcd70pTit2elwueOJ7Vm9Ll4ZNf7laI29Ig8V7lFG6FPFKtahN9sMHNAAk+hiDwhp0Pqntk12psf6GJxNm0VhfvfthlTZUEfg9F54XGfTAHJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7zps7t9YR3CBezKw5uZn1QgP7EzunHAkkrwqocEPCE=;
 b=gagssUngUthpFyKGXquBNEI3UQvQy+ca+nnNSvK8EkEWUBiRbcR9ke2AbsJazQhDoYW3f00YiNtsIfvKTuJw+AG3/zPzXWR1az1z4dJx31Y7i85og1PfybCzG6w7bTiNm67tfUd2PrB2ZZpp3GIzTuWzXycJs0p5mdEKeu0GB7jeSHbCHUtUtx7oC7UM/4Wtt3YH0OpsQ29BQoEwcD4KbdM4WHhL+hdoiRaeluskDwcwwoMKHPkwWniZRK7iJglTiszAqcWDahJ2OnQdLvYFxS7ywG3wM+x4ouu4kblECX5xiHDGKOLFGkRKTswiZYrdo8D1t5xGUmsHytbwc+CbUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7zps7t9YR3CBezKw5uZn1QgP7EzunHAkkrwqocEPCE=;
 b=yAtnVfghEOFuaxcdRMhO6qBgqbgsponop/8bWkDdgIGOtQqjhrRdBXRRbRVKORn1O7GxnqzalAlH6ZFqX+Hs2dZ7ijYMFFXSpzt/Wn9z19ByDBqMSh5VBFDEirWmDm0tTgi3UagFjf6e7U7fhVhRXc2t/qVdnF8FD+wLzDxRLeU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB8216.namprd10.prod.outlook.com (2603:10b6:610:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:24:57 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:24:57 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v17 08/16] locking/atomic: scripts: build atomic_long_cond_read_*_timeout()
Date: Mon, 16 Nov 2026 02:24:29 -0600
Message-Id: <20261116082437.66739-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261116082437.66739-1-ankur.a.arora@oracle.com>
References: <20261116082437.66739-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:303:83::35) To CO6PR10MB5409.namprd10.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: 75601cb1-9cd5-486b-dab8-08df43bb193a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ExV47rMwBUHDEZB3SRD0Sb6lugYR1p0SUxhh4HM/MDFK7MO7XBinsGB+q2BIRrhBiyvLzPOdLGAF8XY/t6Z63gMYIqeyK2I9Wb1w1GLiL7l1s3DplVfsDv3e5I7+9U34g5a78fbXNDSQITppkMVEYyAe/WMhC7za9aEiiOeRwabjTQzNKCwbnF8RQzBVasqfUM5AGeIgpCTwd9mDjPC9hBJT8UapeODQU2ff3jAe4bATCV9dmuzdVNxy7hjE9sWz7vk0hVMXh8BCC54Y5LsnQo+ngiHZ6xvPSbzRYKjJSIY+SOq1hLUQ/Oq0BbpLmrqsMNa5/zKOL9C6+r12A3n2JBxmHevOX8qCH+r2rbqU6ybBQVkkrIhNpUZ0jYSirhpBbjIhuPz0ByLDFFgcrXpbOMeTQ+rmSQCRU7T9a9cH9D0GVXOyA2K8pOrWU2hWFyYIywIBeeO3F2UcFLIGeDZ+tJwdeH/mdONC5/4UD3qdVjeWSJPv/sj1xl1e9O9oXmg4gZ8JNfnHmWfJVLxq9Nx4cT67yQt1esrVjiPvQW+Fb5adrBomuWxG6VEYOxQM+V1wu8j0SUMmAH+OWXVnp0QHUwYEeN8eOLpuahgTaDGtdbynfU2jbVcgHiiMN8sqPelIVpmRRAZ76Qzvys4F7622rHs1NrMa/KiuMDpLMXWKlMc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x00SXjzN5psfs2Z9PG1e0KTMu5kuK8Ue6GK3UCgLsi9UvGHlMpVZpTjp0a4q?=
 =?us-ascii?Q?ncPyKIwzAcps05sdb+43JXwRryhWOctFAM1kRv8D8NFWowy6wqFdCjOEZ81W?=
 =?us-ascii?Q?rnAO2xRz/IP5qtUfBWuxsCKOK1N8/CPEOg+PLUkBA7u2/CcTyQ76V2so6P6X?=
 =?us-ascii?Q?ecm44LSJsfmsq0FwEI9FM1RjmtPglca4GwQnf4hjm/OwoFmfB94/n1n2UPNM?=
 =?us-ascii?Q?e58rsDUCkF6/Kt5dQ7dYplqC3Q8Zor7mGnAyNoMOwJjjh+uGvr7DZN5Adsg8?=
 =?us-ascii?Q?2V+rSJ+EG33QSe7cJo2RIdT+QisNRUkudI+wxXUCRh5c4a8R6G8DricgOogD?=
 =?us-ascii?Q?Ag6U8Z44u9gyQlP8NDCuhwZ0CMOwZ+IGVWKPhEvuqZozlaR/qGL7m3LhWutA?=
 =?us-ascii?Q?HEmSE+wwb3QgjN+JfijwfNyMNRym7fJ3wRKhM2f9TatrTBnux9h6iKPwx4/w?=
 =?us-ascii?Q?e0k0OQg7C6rqgmrk0Rx2R/PjXvUe0djssoEM3aB8ia84/ZvSKfqbgxHPbdIK?=
 =?us-ascii?Q?owRv/GV4h7lgKBL7y99NpnJJs58tr95cUcGjBjWSe9/9n375ir5uHbxNMcVL?=
 =?us-ascii?Q?AYBPax0VkPeAKo+SrZFiGHGkALgZcqxxutBWv+rQjNigC5YgzEck6NWx+gW1?=
 =?us-ascii?Q?viYpcVI3qneHPiB30VcndbDKljVMnT3Q3nvxbvaLjDjz+IDgXm9U3ylvO0r3?=
 =?us-ascii?Q?LeBGLsPh9WKeEMKFKv0t9GfQoQ1OABxu8D35KNqzlcB9mpx1YOmWrOdNjVTo?=
 =?us-ascii?Q?SMg/TT/bNqoDKtzZFpDBpEZRrS9Xj3gfYOJS4JZsEoCfyzPW3KhNSVvcU37v?=
 =?us-ascii?Q?57HnYJQAG2FO4o+Edc80IPxXTHswfn4GCA1ldV50DrMlxJB2riPKveCNy3Jk?=
 =?us-ascii?Q?Homy97ve8bwVsC/jn/g3ErWebuW4hdenmICavO+SyVmPcrKUDCnYNP4jOnGA?=
 =?us-ascii?Q?rk8W4YTTCqbP6DoIM/I+U0hvWXU+dz3yv1soGWDK63ymipU4HM2wCfXI6qWw?=
 =?us-ascii?Q?yXjnvEZaECs5kbJoCvm95VWU8QwghCIBdFS/NLFCmJLJ2+CfRN9r6TG8HSPQ?=
 =?us-ascii?Q?HaL/1EeweUmdBFdhibBKHcNnnBqpdfbwXmQdtuwqrktwV2Kc1zBufB3yuZ3i?=
 =?us-ascii?Q?G/C4Jb3QlMPaPTeeEveuMCwMkWsGaltGWc/HvYNJdIQ0sn+wk6dW6dmXrW/Q?=
 =?us-ascii?Q?ET3bFT4YQp0n+Kl0D1gDeeoOhLTtivOyrYsrWz1MQXw371joq0xhMyHZv9+x?=
 =?us-ascii?Q?rbePk7eePHpo8octPL1xgVBQ1aC9pA0F/BXy3fB3Cdr+NP7Jqe5ch9C5zJd3?=
 =?us-ascii?Q?o6YabXtb1B937ScBQxNW2wyYo2AdBzTFwRnVkvAg5G5zlDdUPLKNEIw7XvyU?=
 =?us-ascii?Q?5m4TANiH3733puCvXlPmZm23f4YFbcMAV1YTWft6KTxoGvk9/av9E9NVw0MX?=
 =?us-ascii?Q?84eQiRy0ZG0RizTeY/D/1sN8VNhwDyQUcV8qyzwJxfycF+C3h4woAn4EpqGh?=
 =?us-ascii?Q?o/aMcSnfxj6i8328N3x6P2f+8jP8NRx5L9pEgZtOF9S5iLCKqfJaGgxwjwts?=
 =?us-ascii?Q?8OjA9hXDfWoEtNGDM5v2EHhosWykBb2FBAmQBEhUhq8el76R+Gvot9iwIJnS?=
 =?us-ascii?Q?7PmHraxJTW7ULfHiK5TnOnP/VBFNFXicJ99Xu+UKiWphZ1UgmJ3ViKh0SRIr?=
 =?us-ascii?Q?t9Z2X2OOG2oJWdo7zERD1boB3n7Y0afTD58W88yq+JVXd63RZhvqRRVcHJuo?=
 =?us-ascii?Q?hzDzxxxR94TDzh8EcnX7oENK3E4X5lM=3D?=
X-Exchange-RoutingPolicyChecked:
	ifv42lQl+QMZ0BTIPs0hvM644vvjrgBrRrRbMamszXr/wkA6E+XhHybX+44O5RYi1BCne6D6ThVp2XHcK6eWil8z5zsFaQyoVUknQdBnN09i64GnXl/S0bnchv2qH39JTIwE05cEsZX08JTBTR+MVV9crIpK0MsLjh0zg8zg6CPoxgEhetUfE2AOshxh+Jy37NZEUneu+q45zqxCsTpfEXoPPmfXDgp6+zK9V6SsPXySdQYN1+k/om8LEnX39SA1wMPrWJsVRs16I3nxQXz2uSVCmUuvzPaYYgLN7uBuiE7qTX+r+dyg8a00cZq4IeC7FnXpLmCU80wIeR6Cjxr1cA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4g1SvxxYfKpVm3OK4G12eJbxoyV8j9PbcG89NAg1wsVCXTlA73gi8RWbSSSp2TJ68LLAT5Q2WxrwysoDtgI8Bt/vmigaTDwrz2bLXrV3WhJW9rJ2TrGRHEBsdS9ecUX1E/NlKJGngZhpttshZlJb3Vm03yoawqVBvkc9dJ/e13pLv/oKWqiwakVYJ6L3undbisClDM6OekvJI21bMpm2mQMOnponvoIPWwl+Nfk4vytU0mDGp7Jl5Jouy24tIolo8EFOaaamSqTWbO53LsRQ9FclLXvhEMQaBKvTM7pfG5W/3hXIy58Y2RW5cxX9xaRoIqkgieicLC2Oui23myPeI8Ji6mIlKdwg9xKNgK7quFmyOdK6+2CLpVbEYz+hR/0r8xeyrsoJqjZzLu7G+5rx0RyBOL6vtC6iue5jv+JqyTRR0Xa1dqobry4EX6pUoy60MivgiH1F7NNVVO+8oKg+QchSxUwExL7mjS+czBt1H2LrKuK16LqO2GNiPYcNK34SkpuotcjMdzjCQYJ/0nhvRvuRqljmbk75T4jILoIVaOLI7W3+Toj5qzC31oXP54nL+AFZ/1WczCL2eVsUmkadWUFis1Ipu7a7WRcfcuqswpw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75601cb1-9cd5-486b-dab8-08df43bb193a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:24:57.2547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KB7U0m3WNRS3tfOwXblICjurHf7iv/bnI/Cnth/2lBy+BqI0fChuJnle1l/nMfEw77FfxEVExe5E8TaLA6OrvCHDlsghyW6qZ1cMi969Gbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB8216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611160033
X-Proofpoint-GUID: DJcd7p5ZsRHEzzQbeOxtFEvlgzfe3JEa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfXwdhW/rueWEdT
 CzSgr+2Ht1/cpl1oNeDEdBjGNi8E/Rs5SikStTqlrvAHNg5UlyHr4EWIYKrzbJgT3RezqLM2n3m
 Om6c7K8p4WP402r0bhEal5owwL2RNHuuHK91nWEBUp6dNAKGqDEm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzMyBTYWx0ZWRfXwjMzjCFNIfjO
 fznSnl82FF9DKhSWGowrVMOItMIY3hMQOtKWDB0ODS/NC1x7dpOrkeiE+UXGq+ra3SSJc+ARatu
 Q5XMZ1Jmc9kncMEENxqaDDyLeTqGR+laEwOb9EU5oMxdZ+yMXi0esk3gdbavlNt/Wp0M1y8K3Al
 Z3dI5pLfQSXLM2YlnRt7PezCYbaVTnEdS8S8JmWzysF9Ju8wJa4hmqMengwXIgpBFjGmyGkQgvA
 nBIZGIChHTLpAx5fxC8Y+GCFtkNkjp8/ka6Q+I5CBhWgmGekhq8oo54TevXVhWBPGVlfXuxgxFy
 Rjq/rI3gBZMLP9yH5s8Esjj8E1tx6ljsr8qksppJzdD3tqbCnrj3lcMD0U46uBBqJ2LQix84XRN
 P3lTEEz/Tp9K0NEF40+TR7rJluXhvCV2jzEqAcjU+DYtoOt1OnL1/BBJhmh5E/hEZhMqex7RZFe
 +NmGsh6uL5+/WKTZqHg==
X-Authority-Analysis: v=2.4 cv=W7utxhWk c=1 sm=1 tr=0 ts=6afabddd cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=7CQSdrXTAAAA:8 a=vggBfdFIAAAA:8 a=yMhMjlubAAAA:8 a=yPCof4ZbAAAA:8
 a=LKnZA62imwlViN-40TMA:9 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: DJcd7p5ZsRHEzzQbeOxtFEvlgzfe3JEa

Add the atomic long wrappers for the cond-load timeout interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/atomic/atomic-long.h | 18 +++++++++++-------
 scripts/atomic/gen-atomic-long.sh  | 16 ++++++++++------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
index 6a4e47d2db35..553b6b0e0258 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -11,14 +11,18 @@
 
 #ifdef CONFIG_64BIT
 typedef atomic64_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
-#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire		atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic64_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic64_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic64_cond_read_relaxed_timeout
 #else
 typedef atomic_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
-#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire		atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic_cond_read_relaxed_timeout
 #endif
 
 /**
@@ -1809,4 +1813,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_LONG_H */
-// 4b882bf19018602c10816c52f8b4ae280adc887b
+// 79c1f4acb5774376ceed559843d5d9ed1348df99
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
index 9826be3ba986..874643dc74bd 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -79,14 +79,18 @@ cat << EOF
 
 #ifdef CONFIG_64BIT
 typedef atomic64_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
-#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire		atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic64_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic64_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic64_cond_read_relaxed_timeout
 #else
 typedef atomic_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
-#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#define ATOMIC_LONG_INIT(i)			ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire		atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed		atomic_cond_read_relaxed
+#define atomic_long_cond_read_acquire_timeout	atomic_cond_read_acquire_timeout
+#define atomic_long_cond_read_relaxed_timeout	atomic_cond_read_relaxed_timeout
 #endif
 
 EOF
-- 
2.43.7

