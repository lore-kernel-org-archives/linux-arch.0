Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4175621772A;
	Fri, 27 Feb 2026 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195855; cv=fail; b=pDOF/V+6hAa/gZvC6drdehkag0rloLQsuwQ4NLy42Fttvd2I0iu6gp0Q1YUBg4bkM1b+hZhlEWTz8Owro/qm5iQKBSB/ieYdb5kwKL+xHRW1XNK5kUayFbE44CFOFC2x8kakXOqvsv6pWntlbsv+Quy7lr14YFF1mnaqS/9VyYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195855; c=relaxed/simple;
	bh=DlwqcGnGfohTmjfBWLrnoFgTB9ewhy12LQSgw/RyYm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NTsMgzklMEJ/dBnJfSZdUDM7wJAyLYez8C8iF3YuyTS6XdJJnJt9pIWp6+4KZvJ5HBF27GZynvtsj6x7ODSct7aJb5Ag3ocy/ISubzev8s0mFUygtf3fbVo9nnJ6v10pPu3Du/mT5cJeHkyjExKZ5bRzyh1tuj8MTGNYfvs06qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NNSE/EHv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wztcKyZA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NNSE/EHv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wztcKyZA"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9ulNg280115;
	Fri, 27 Feb 2026 12:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Q8ZMZjXEWIuY6+IgGF
	bvzI9kzyjWEB66/SqBMP7ul1w=; b=NNSE/EHvmGDWoCAe/7ml+A1WZyFiF4uPxw
	6bp882DchlieeFDG9mX7CL8S0ZyI0G31J9Ym9ckwrqtmx056zCueLpLpsEaNAdQ5
	jRJiKi3DYZnxwLYnjd+UlCEmSF6wGIzGgMGqE0ReekSchecmgW0lgZH+pUn93vXB
	X4kO6KOUnXHJvzT4aY/zk92U1Vgj5fTvrGj+3HVJjtgT+ehVp6AZJZrPF2xU2zHI
	t+WCV9LLBT6dvJBa5icBn7Q3xtUGk/RbYom2bdbsSpSjpaF95tfiTzDy5pQqAEaR
	OY53GEmXMtgysoWhx6Sjha6xUbdsE6DQj7TAOKEfpxudW0BhygDA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjgs02kku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 12:36:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61RBeF08028662;
	Fri, 27 Feb 2026 12:36:54 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35dsww7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 12:36:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1FR78p97X8UkmTPvsy+0DdCIT6CHRjm1hor6kkrzfc6CzGKsFQ2gg8NvM1D7LQeND+64S86bY66BGdtmTf21YD6lu128ZANBl92v+tKXvaWbAue0UkDTmpXrGSFDDCSYDReIO2G4IoEIigBPF3sKw3+eyF0COPpehcQfTH6lkGYX9KxqYO6ZGO5GzA9eoznBqczqIxC/LHaU0yqKd8/GykUkedVLe8sn9zhTs6EBtSBVMBYjvbTXwzbJAlavKRi2FoAamGKfen15wBz7doJmGiiFVA4USBKSfVxt/ECEwTOLBKukPGHIPEZd+5jYjl87y0TxSFBm8dR4oYMalKL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8ZMZjXEWIuY6+IgGFbvzI9kzyjWEB66/SqBMP7ul1w=;
 b=Hgi/Uk7E9fRZ/T5LuKV6dVBvaDFbfhmUOogIPlky7Cbzt5+9Q5nRkdbJlfx7IQtJ7YkoGjhxNcdphoEMK60dzBA2cJdQlFzXmmiGkRKAjpvwqobeo4r1wMc/m1/djwSUSjGv7tYbFR0hdV4s0EPpRxorARBY6KD93tA1pI+rRldo4V6ESZNC/335Qxtrv0KWTirH1N5g7Ylp7UwdSYCgNX4Xkx6bXs7kqA46Rs2YrATmdHY0cfM2XT42iv7CE6rxmmt0n47ABxNsr0Lls+ct9VT7ke0Oik1Ew7anNtb6ZLnnxxO7oBS3d8sDux8AKJgvutLVWdB1TlrWFGz9L4r2Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8ZMZjXEWIuY6+IgGFbvzI9kzyjWEB66/SqBMP7ul1w=;
 b=wztcKyZA8C0sKiB7Fm6ktsCSY8jb/Ub8NE2URWj0BroecOEl9fPpVNafKS3ps1VlY+xNy7y0uDjkcZyQ3x9TveV/iN32SrUJ/4RBvKxELj2kyKMBrqdp+vHo83o3M/8V8bCa5p4Br/IeIzm3ho0R25724j6Apj8w2JMHhiIiTBA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV8PR10MB7824.namprd10.prod.outlook.com (2603:10b6:408:1e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 12:36:49 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 12:36:49 +0000
Date: Fri, 27 Feb 2026 21:36:37 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-mm@kvack.org, Dmitry Vyukov <dvyukov@google.com>,
        lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>,
        Daniel Lustig <dlustig@nvidia.com>, Akira Yokosawa <akiyks@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        David Howells <dhowells@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>, Boqun Feng <boqun@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>, Marco Elver <elver@google.com>
Subject: Re: [BUG] Memory ordering between kmalloc() and kfree()? it's
 confusing!
Message-ID: <aaGP1Se8vkBhn9uj@hyeyoo>
References: <aZ_lJAqxh_hNGr_v@hyeyoo>
 <9dcd02b9-42da-455d-aa08-165e6ff0b921@rowland.harvard.edu>
 <aaByMLSAIJM8HdbO@hyeyoo>
 <d8308828-ed28-4650-8c8f-22a7e5cfd1a0@rowland.harvard.edu>
 <aaB-1e1LoxkcYl2f@hyeyoo>
 <9240040d-598e-48bd-b802-bf91cce92d0c@rowland.harvard.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9240040d-598e-48bd-b802-bf91cce92d0c@rowland.harvard.edu>
X-ClientProxiedBy: SE2P216CA0140.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c8::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV8PR10MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: dd859243-ce31-43d0-feee-08de75fce085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	t2JnAmMTMTcz2kbKp0FlfGgSoMCKpcGTqVDuXFs1vRK5v90whixjpK08iUE9+qeyuWLfeYVAJIva590LeLkOF5bQ3bnrjpw4uP1YdD9DL6z1DkOxPhreu7cFB2jHSse6MERFjAadzekzZkQZbbfe/ZjiwvgpKkZGzIE231vQ+MZ3MXoUbJ/zc0Ijfl0dHjsJGQNLsH+zMo0BRaSbHK7xBA0NXNfIykXI3bLYPAIVSY1JyEPYcdqdcdAmEUnROQepb+R9r3/yy8VFl+DYPUMFiZQGJNd4MPiQ8/VNu7CiUqAIhMF8KiJIQyWb5HS8NKYwJe9DUof4SWvBbpADswejBCUzlYQU8Rg0lKQqqmrOOoVUZJ3BbfN9EiZJpBvGKgGYL6vfstVY8KgI7ASvgUWr71MNNX/QZ7cWlOlnYJ/WQv4h4PSsHupHCSN4nmy6HENvqyLnJhlRji2RLMJ9FDk7flfTLGZDUQ0xBdUCdYbgx2QSanX1fNFm8vnbREO6rws1dgV/E04A9pPwLLLGErBh9PIZTv1vdWgUzpo99FKA6BSKJFCf4zWX6mWkOs8g+AgN9a9xjNmEfMmf5fUOKJfmsB95KQrNgQsO0dkJUsjKu9RfYdJfyqvMd5FdjhWBWgZkCGpTRN6/wgv2KiFDwBf6eY52qa7BoVm4VRMCC9d+zIOTX0zCMyWc/NcKwpdGdgkeVErLGs1Qxwh3zksZu/jzrtRjIBrDTYCOElt+2qm+xno=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YQggLaGfPcHIaNYtggXiJuRmyhyjybsPMXIcpcdX0E9MN4NGrX38yRZG0DHP?=
 =?us-ascii?Q?qYrjGHPQa5TT1I0b9kGAorBAUU3ws5Be6USgQk7o1U8IfQNjwTw1NUkwbc77?=
 =?us-ascii?Q?yWkDSAfhOvlm0AlDKOVFInZzGbK+NRog8LbY9aQYSquATesQDMn2MgSvYmM8?=
 =?us-ascii?Q?JRHllWxUlof+Q9iPMBlDhBNRHFNir4m8tD7F1+PqmBItAG9hiUfy34blOV/g?=
 =?us-ascii?Q?U4a64WJfxqEt3jqq3OSGEdkhWWw1wSTKYBkSsot0I/pR5BrX4FWpLOMgfDQh?=
 =?us-ascii?Q?8blHaGQSbEGrxk6KLtk2zE8fD6LRr5YXWiiOLOmrAXwK3AKQptZCIutgj23l?=
 =?us-ascii?Q?Jizd5FWaVFs/x1Q+llx+/xYF/VAs8Kf4tK8/ksmVnPwnQ+PlOEP5e461g9up?=
 =?us-ascii?Q?hBJ80QNLicgaE6ZS0l9NTQydLFmIbsNRl2LfhyKmbHUtuzdhgxab1nb4c1j2?=
 =?us-ascii?Q?xXFw69M6+9N3QeSCfVo9BIQgfo0zyCGVyDRjUkv/tIBFBjzia+f7KuWLfNB1?=
 =?us-ascii?Q?PUVpnedaoAIcapWYG++vlrkaXDlS/vy4wtMHfLOjuvA4vnzxOIiS/z/sPppb?=
 =?us-ascii?Q?TEUkjXOturtMYs/Su4DNLOD7f0Kpv1MrOHMABfk5zK6dnDMEBNNgXZ2xMpNY?=
 =?us-ascii?Q?T7bng/EqMd/jmCuRDMsHKCPeItmVjENPZMexASQjNTri+0qCQQvPnyvAj931?=
 =?us-ascii?Q?EUBSbKXLFEPK8JNm8C8zrGRnJXreYaA2nNRrv0mo0MqvwbxrEvI+g8mDEBVH?=
 =?us-ascii?Q?G85jvFJnQS+80FGbgse3W1pKH1J6rP5L6IkWpLQ4BiednATziXyld5751uS+?=
 =?us-ascii?Q?MgQCD/S/UiLgvuqwSLPcKL+S3NqdsIvh96Aa+wwMIun/MrNUdcKOjFi9rb0H?=
 =?us-ascii?Q?EP0B0eAz4j8RaV4W/qDKjZYPoi2ejWR19z6lj/9sd3CnQ8PZvrcaqTTWk5ZN?=
 =?us-ascii?Q?Mxrqs2Y9JY7OO2/thf8Eis8nl9gpT3xcxzjWCulCKmqK6SnMYPutuUXv6Raj?=
 =?us-ascii?Q?xeBtta2REbinw3FvbqPU5cvW5ULCudTQaicUN6kUrtKDY96FKII3wuzLowEA?=
 =?us-ascii?Q?BVOLWLAV9vZG2qIpbuctyFdydFIgvRXQ9TyuRK5mRWP5ArLpiVUc2nyHg0uO?=
 =?us-ascii?Q?JDwGbpy3ST4Zf53VseHiNHmTTAHchelB/pDex2CzJ7nx6xBm/OSxl1g+pj6N?=
 =?us-ascii?Q?LYYkNpTZ3Oj5cUEbeewEQKeeFt4K70xSl2rVoSSa0mg4Pdy3rdpgrxkaXhZz?=
 =?us-ascii?Q?9Ue8XO9OP9a1rBIRVQAtGzALFOsdCzPCx171Atk8bK2oXT3KYTpZ+GqVvNqh?=
 =?us-ascii?Q?jt0am3B1gtNnHA6NIQRvgGU0EoJ46HwfO2CgHXKavMKyjdyM5HxULon22B/V?=
 =?us-ascii?Q?0dwwDjIUP1GL1jkVakQgfhhXpHHzSB+g7RIEcKtKCMhcmv/VT6/Zvbn6VGM/?=
 =?us-ascii?Q?Phzk4rH/a3a53cyEID49r9L+gSinqpp2FbBHoIfybLfIfAl/kBDS7mmoOUgu?=
 =?us-ascii?Q?nod+iEVpqENkPu/0PV/9Sbg2HT9tZrRDRyAtekH1NWJ7IPjdIlupbI0qUlYk?=
 =?us-ascii?Q?dHhMpr334KC5v9HyYI1k5oyu67OSsNU80vA5O+94KAnfdLakbgTB3iE6H6hi?=
 =?us-ascii?Q?EPAkWohySGMQlimeoszD+X5gu/r0LWsXIDIdspWEWfDFmW/JbAxkDp3eQxDt?=
 =?us-ascii?Q?EZTNPYJ8szCzIF74iq1fXW1a8bsUlc7ZmdYx5umVtd8u4eubZAOnC6KJojT3?=
 =?us-ascii?Q?1VuZT4FLxw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cPIPinMTtPDVjBwMYPgJSfCKnkYwNxmUsp4Gx6lD7ZFeKBW72qZJU89itMuOzUyh1f8lA7PnciYX6hmA2zXJUvnxSF06JEtGEiUs3R6uf7QljoQWnT7anjccdvvewVEUzZrlU8W/xXiRPYY9Nsgk0yrSG+12SwfJVw4CC2aDUeyaTrNIkliFrbYI4koDYj+q243T5akJHNCwfXIUlnIjNReQVfZyxBd6FW3Xhf4XKiOIacBvFxaDYf2MYn0lGuoCE/E7XQIhF61UasP6VR3jhFjLsxivlY0yzbASI4JpGzDQPtN5uL/M5s17VvM060lLLauVr3AThE4728JdbWCH9k91S5pqh1hb592Fk4vAMgftOqZ48AcDHrSUGhiFocSStvXiFGCENTnj+RqNksscR8ILYzQrO3L62wruz/225sSiXKDCwAyT04XlNA138G2Yhl8+aE37ez464NMx70LDxlNe1S5X5CtWFMNI5Lh7bR1BgtEwi5bWonR9IioQbK7OfJeHEDPfnqo/2JWe/7fDMZKtuSCLTeTILubfVPmf1Ya/PSfrDxEY/qRgPzKeFoOKacqqjEtx4CHqQ4XZfT5SL1k4MULR/iIdHbd4hYbR1/A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd859243-ce31-43d0-feee-08de75fce085
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 12:36:49.4520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /siukIwOayRDcl+kfhFijfuQ/YdgBZfW750rUV6JrGiaCA9XcVH/OcK9/TKcx+NrZAfOZJMpaNS4gBLEn3ey/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602270111
X-Authority-Analysis: v=2.4 cv=BKK+bVQG c=1 sm=1 tr=0 ts=69a18fe7 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=N7TLsKDBxxqSg6ekNNkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDExMSBTYWx0ZWRfX09qsH6V6BNln
 yrEGgAxwnppocOwCLmaKrKKx79cssXlBVsigjqZYfg0vxN4eCnx1/U5286mF7wLnmKd6Q9cNA4s
 wItg4X1D/MiqRW1AeLE9t4t/pICQvldKdHPo5jXmM8tGNp949r5Wh/1/dbJ1k6wwG9EzUdKBcC2
 fseJLtxLTBrSdsfLLPEXViac/Bwj5Mcvw1avH1iszgoBpYwH9zVdXxzu7EtQrnDjRv/X1zlWolS
 OG6aZeicGxyptsJ2uwA/q7I5OrS6TGwBGnfoTT38Vp9kZIVe/poSbHb8hIeON37AJZI5xpu6Pr5
 S9J7nD5dsETHSc9X9wCEiOfMdBI4eHGrB/WEcLC7P2lNvatjwUfGPcOZ15RO/vZFcEuxy+xC01s
 olXjyLdbSWRwUMSx91N/YUXxvuBj+r8nI8Xi1iufqiH57q9oCAM8HpglVGOWv51H5+4/KdWm+L0
 yfbdAf16XUCxksnq0uA==
X-Proofpoint-ORIG-GUID: ezEhKLEEEhmjySv5VQfgifCXVCY2FdBZ
X-Proofpoint-GUID: ezEhKLEEEhmjySv5VQfgifCXVCY2FdBZ

On Thu, Feb 26, 2026 at 01:06:51PM -0500, Alan Stern wrote:
> On Fri, Feb 27, 2026 at 02:11:49AM +0900, Harry Yoo wrote:
> > On Thu, Feb 26, 2026 at 11:42:02AM -0500, Alan Stern wrote:
> > > On Fri, Feb 27, 2026 at 01:17:52AM +0900, Harry Yoo wrote:
> > > > On Thu, Feb 26, 2026 at 10:45:55AM -0500, Alan Stern wrote:
> > > > > On Thu, Feb 26, 2026 at 03:35:08PM +0900, Harry Yoo wrote:
> > > > > > Because the slab allocator itself doesn't guarantee that such
> > > > > > barriers are invoked within the allocator, it relies on users to
> > > > > > do this when needed.
> > > > > 
> > > > > It doesn't?  Then how does the slab allocator guarantee that two 
> > > > > different CPUs won't try to perform allocations or deallocations from 
> > > > > the same slab at the same time, messing everything up?
> > > > 
> > > > Ah, alloc/free slowpaths do use cmpxchg128 or spinlock and
> > > > don't mess things up.
> > > > 
> > > > But fastpath allocs/frees are served from percpu array that is protected
> > > > by a local_lock. local_lock has a compiler barrier in it, but that's
> > > > not enough.
> > > 
> > > If those things rely on a percpu array, how can one CPU possibly 
> > > manipulate a resource (slab or something else) that was changed by a 
> > > different CPU?
> > 
> > AFAICT that shouldn't happen within the slab allocator.
> > 
> > > The whole point of percpu data structures is that each 
> > > CPU gets its own copy.
> > 
> > Exactly.
> > 
> > But I'm not talking about what happens within the allocator,
> > but rather, about what slab expects to happen outside the allocator.
> 
> I understand.
> 
> > Something like this:
> > 
> > CPU X				CPU Y
> > ptr = kmalloc();
> > WRITE_ONCE(gp, ptr);
> > 				if (p = READ_ONCE(gp))
> > 					kfree(p);
> > 
> > Yes, it's a crazy thing to do. CPU Y isn't guaranteed to see
> > up-to-date version of object content or metadata.
> > 
> > Instead, the code should do:
> > 
> > CPU X				CPU Y
> > ptr = kmalloc();
> > gp = smp_store_release(&gp, ptr);
> > 
> > 				if (p = smp_load_acquire(&gp))
> > 					kfree(p);
> > 
> > One reason that I started this discussion was to argue that we should
> > have a well-defined a contract between the slab allocator and its users.
> 
> Yes, you have made that quite clear.  But you're missing _my_ point.

Okay. Looks like I misread your point...

> Which is: The same mechanism that the slab allocator uses to ensure that 
> CPU X and CPU Y won't step on each other's toes if they both run 
> kmalloc/kfree at the same time should also be able to guarantee that the 
> metadata changes made by CPU X will be visible to CPU Y if Y manipulates 
> a slab that X just finished with.

Within the slab allocator, I believe there are sufficient mechanisms
(either spinlock or cmpxchg) to prevent CPUs from interfereing
with each other.

My earlier statement "Because the slab allocator itself doesn't
guarantee such barriers are invoked within the allocator, ..." may have
caused some confusion. To be clarify, the slab allocator of course uses
proper locks and atomic operations to avoid CPUs interfereing with each
other, and yes, those mechanisms should guarantee that the metadata changes
made by CPU X will be visible to CPU Y e.g) when the object is transferred
from CPU X to Y within the slab allocator.

What I meant by the statement was that the slab allocator doesn't provide
enough barriers to ensure correctness when a user performs a drive-by
free on a different CPU w/o proper barriers.

Hopefully I'm not missing your point this time :)

Thanks!

> To put it another way, ensuring non-interference during simultaneous 
> accesses isn't all that different from ensuring coherence during 
> sequential accesses.  Doing the first should easily allow doing the 
> second.
> 
> And if it doesn't then something questionable is going on.

-- 
Cheers,
Harry / Hyeonggon
