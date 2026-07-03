Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BD2284693;
	Fri,  3 Jul 2026 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098453; cv=fail; b=LqarS5ieRZOhl0AzdZVdqUCC7eXHJzmL28b57YkCJ7PppuVdXcN5+A//VxFthMqd8BGG2XNJH2HK8gW4oZIvxp3t80u5c3DRYEXugLhTyXAki6E1QLB7E/9NdHzlK/LJeVdwTjWjYP5xHL8H7rWN8/OsBuTLDEsU1hmx7MdNuso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098453; c=relaxed/simple;
	bh=ZoZReQrYvF9no9R806m2QgXtfdOhu9AEKj1JR7FQXsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CKlmtk0HK+L4UgWOQmUKcq6sdpMmK3glIpKhHVmfUqiNZfCSMzruWFhNCn09RIXkZhxM6mV3l8Gpx/c+dwpaB01XAWprXtGBeLlre71pZfl4RhedxoUy5szDU+wDQdSXWcYxEQifDi+cQUpWmJm9cLA8jkdzMS2QYd15iSs+/bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R+QSvvm/; arc=fail smtp.client-ip=52.101.52.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R+QSvvm/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEkwCMe9zzYl+vfUzMRt6mXLyzAAZ3yWcT0hsnPLKmAorF/xdTsPHB15TIELchQe9/vzBCzQDFm2t/UR8eCojL0iYPvE4GGLcSWsMp7j0dNuYcTp6l7H4mm4/4vHdxLON4eRjIn/fBzDvy19WO8933zePbGyU4lxam4uk3kxZ0fYhJkyMpDFOxv/Wb7fGnAk3Ox7MDxuuzuICUMlp1kj7uWCA5pghv6nrm3F4w5Jgu+0Z02b1RXPCiZHypbAoKLuNI12GoiMo4y7VQhE16SyaBKrjimXqc70NXTO9FlI3J1vJdcJjtCIEo0G0j7fk1TlxAayJzfG9oZX1Yv2sJVrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAzzokcqxBBrf57TTie5CwzlPx9Xn9op91mSx6jU0XU=;
 b=i8P5LbWuBNWLtveMlxQyBDLDbSaFvsCpGf65sAFG7FQe6bP7U7F62jPFm3hF73GWWk/6Vm+HpTddm+I1+OfXTLAuwf2E27Gy2mCfBhEnvDSKY3Ip1mB7a2lfI6onba3RuCu3E6F+iGQ32/blRJcoVZ3F9XUVfbP4ntBYUpn/ZupObjXr5QIJk+cTxBQUI+FNM3T4KWtuKl4gZa2tAKfiz09IB20h+BAMmDvvNhMIdANwAzTaWsvVkvnqDLzGXN4/PI8iI45l97LWA4KK3a2IfYodkfduG4T4J9mAUUgHkwpQglVc1V368rhswL0wGwbUXqqIZQT5W98Xyw+fUlp29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAzzokcqxBBrf57TTie5CwzlPx9Xn9op91mSx6jU0XU=;
 b=R+QSvvm/dXEL9xxJjk+ZLqqkCzlS4N4rojpBICpnwMNCjyk/21dThIfOtjVVx1bNJ0sS3aFShKSKXBqDHsATIm1N/vOE+PrzNdzZkWv8/NaKj+v/32nyvQj1K2eRfZ+h+rUIDHL1qZeS7AfyV4cXjeFk34GVgpy1qK9Bi20/IXH1UlDDh5S0N/2vJ2zEVBj8cRFdg55k2N0oGO17nuMkl7SHNsWmRKD0g4CP9LAPyo4ykVlZhmUSsv9NBDZVnbA4MCpUDRc89yXZDjjeXSJh8bPedaZ0xBewo62GWLyh2A1Fe3OrCFRWP1ql9MmRcheesUIGMDB6a7vMDKCdcDQfrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 17:07:23 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 17:07:23 +0000
Date: Fri, 3 Jul 2026 13:07:21 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: Yury Norov <yury.norov@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops: make the *_bit_le functions use unsigned long
Message-ID: <akfsMU0h5BOvLOei@yury>
References: <20260702194307.1805533-1-bmarzins@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702194307.1805533-1-bmarzins@redhat.com>
X-ClientProxiedBy: BN0PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:408:143::6) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|BY5PR12MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ccc7954-1bd8-4cd3-6a68-08ded9258cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|32116099003|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	eaLo44GOJLNO06rdEvoi3Pg/B1XWVJiSGAPdpbuTt6WR09vq2iVkZGb2x8EMQy6Pw25u1KZ/iNpx3PDrIcIVtdoEZE51tC+QQ+Px0omiRp4Be3v7Xk1a9l/mjIlXmxeBA7kcWYjEsU2OMkdbTagZkGy/F4h/BSQT9hSrSY3z9T4DVj5zFpt/wsif5BQdJKNPTv3koG6lnKudvjfsfdoq/5IFuAfnB7JVGppq7CEyIe8yi5ECsRUtHhUJ/njSy2dsS2l76h+JPB5K97sLRq/VP5Ez+e3199gzL2PoqgJxsOGGQAoRqAPsCjnrLzO+dspOSKZvAF1UdWW9tTPpSNVo5NVxV40+D5ln0+Lv85EyO9DQfyZmLyEAqVZ+ERQIp77hLk/6kDhFgyLdI2w8cI8iC+v7SWahY2g+pu0WYj97LT7dXuFdo8Vs69Q/tY7nSq2ddq20pFP0ME9fmXtucibMj3RYwVyclHq1bGh4Jq6AclhFdUgr8wn2/IKbax9DvqBslelOXGjKRecnhksKV28ighrs+1Fa1EJqPC7+OAq6NqO3+wQN9x2U/lA98LpX0oANEOpYNfQg5beHiSb0xUcS9LUWQvm4JOjPpFQcUV747rLHFLoqvC+cIunIkf9wsNiTc/7EzQYdAxvdxjVql7pa+JtexKXLN6+rtz2AoqTj4Os=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(32116099003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AUOhyYs1DBvolsB/jtCt+eDNrRV0u1NZO6inkU+nPv4lXFRoqZI8buV4MRcv?=
 =?us-ascii?Q?UiH3kXGkw+06Ss2IYoKautaMZiPj8S/6glcPITIZeL+Y9OPzgd26YdGytPRP?=
 =?us-ascii?Q?jRyJftm7zCCuIDZJHWQDJaIXghB6rZ2Bj2NBvUinmoj+cylV++F38PmMODWD?=
 =?us-ascii?Q?i53dgsnhQ9jY5aZbQ4evfXlf+s9hi5sO1QZFgKBYftHMBtt6Ocg5uSTBB2iB?=
 =?us-ascii?Q?RwthG4JLD8xxSPTCdHicOVpAJyDKp+ObrKSCUMX3X70VvoEpN/NEVOsdIyFn?=
 =?us-ascii?Q?n9TCKl1/Fv2O8kLotqtuAjp387/zdUe+iGmK1nalq8NUbCnrX/zOOLfdfKRa?=
 =?us-ascii?Q?vl2Jmw1I/B9EtH0oFDX48Qm0RTvg5akl3NlQ9NDNJ2yxJZp5MjqvZwc7laO3?=
 =?us-ascii?Q?p0DjYg6k3tnxG0qLyg/vzE/lZJMNKYAv9JrGaaYXVXL/J9OTMlarQNIj//nM?=
 =?us-ascii?Q?aVD8Z6YAodNh1l+opekNg5jPEX3AK/Bpp7TuIEoMKrrvM6j+Vr60uM/HM/tT?=
 =?us-ascii?Q?D2gQxkEDHpeyZScGGPDYYAxQtZqo6RrPEm/7M4aPM/ktXUCaT0kjMmhwoMVC?=
 =?us-ascii?Q?/+CoTFWcw6Cc84NRbaZJdxuqB0+5ZoPdMqDxbh6BuIJQK4CmEuTtBEMiS+q0?=
 =?us-ascii?Q?4ahKpCanPVyVQXBfTWP0PFmqDcMobxadyNVRr0C7L2sCqozD3Xlf5tWPW0eg?=
 =?us-ascii?Q?5bZVrOmY7cmQ0w0cWxxRNK8BCeEKejkRokxgJsej2y/U/J4czzM5OSNpOYkR?=
 =?us-ascii?Q?WTboq2I9BfIjfcgAhbEmE+N2x5VSbS7N9aFdWLHejVEWaN3c5eFTZ4IOeLtr?=
 =?us-ascii?Q?oj3mT8khd/qsl6N4HLESNanEfUicl8hApvJ3E0CtX8dKvIE5gfKzXSVAb7r/?=
 =?us-ascii?Q?LszRISjTBTh6NA9Cx2b9D5QnjnV+lKYW+Ox2JwvRhrKEQdr3Ce5vaZQrIoCn?=
 =?us-ascii?Q?XE0Zc72D69lQRvS1dtSNkFJxuGgJ7yCTWdQ9a7DZpIjC7QPst0UAkv9VJvHy?=
 =?us-ascii?Q?7UQHnsfJktfDrUtHusrNeBXw7RmALZYBGsYj6OYt+TvMBCiU+vTm2fdgTHj+?=
 =?us-ascii?Q?RDhTB3i/Il7I1RKmO1kNJUiBGxih6B178p9cPaehkg8I+Gn+3viXsgVZsNsA?=
 =?us-ascii?Q?KgF8KrRvVcVx4QpTV2VF6ezTcIRYxzQkKXM4aCxPtgjFYGIGb2tFDluHYMoo?=
 =?us-ascii?Q?abBjXWwMX8d4HWtT2HTtAhUWfF5ir4WD6Pv31iGLZFTB1BPzdEHc6OOb3mj4?=
 =?us-ascii?Q?5c6DQ+Qyiu6QLfvKcjsiJ/+tkilsUlQ9/2fQGHzuBUkOehfms8zHM5C8vBbx?=
 =?us-ascii?Q?k4bYW8nVJQq6Tpm7+f5iK5cWCR8MjvcJCi2uPuphwcTdK31+i9HDrf/oYmlg?=
 =?us-ascii?Q?J5x2ugzvFb1ECftyNpagddpO4r+u+nXKzvb1SAjaT0XDTxeyDlbnplNw1HqR?=
 =?us-ascii?Q?0/CsgPX5DVRl8EnDVb4GV2mWFYj4yGa+ktAxUAq+2fVhAkThsZk9GHTi8qtn?=
 =?us-ascii?Q?7V2MuDUpmE76dz43QjWiPcuJScTbYfJU0gdzr6Vcnk4a3mVOP8BHMLvEquvu?=
 =?us-ascii?Q?JTB8cUX3U28FEYKr/zasa0j4xWRE9nlEYiaimZZXuW6ixZIKVTRS3KWrphnD?=
 =?us-ascii?Q?OxKGHbQIFa8wx7NW4d7DB3vL5H1iRHbKvwylUdrmikDYa3/QdKjGVOBQ8sKN?=
 =?us-ascii?Q?/muM61Uh/CQrfmEgQYAZVMgvT2Bk66aoY3fZYotEFlXwr+HK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccc7954-1bd8-4cd3-6a68-08ded9258cb3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 17:07:23.2612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gg8jsuTEXqvPqZnuGB9n+/273ziY966+wvacUh10b0XZk+EWgch+xOYhebTew4Sw7bqDOASvbwNuQhLXyu+DLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209

Thanks for the patch!

On Thu, Jul 02, 2026 at 03:43:07PM -0400, Benjamin Marzinski wrote:
> The *_bit_le functions use a signed integer for the bit number.
> However, the *_bit functions can use an unsigned long. This causes
> problems if there is a large bitmap and a bit number > 0x80000000 is
> passed in. Since that is a negative int, it will get sign extended to a
> long when getting passed to the *_bit function, turning it into a huge
> bit number. This usually ends up with the memory address wrapping around
> and the function accessing memory before the start of the bitmap.
> 
> Avoid this by making the *_bit_le functions take an unsigned int.
> 
> This can be triggered by faking a huge dm-mirror device, which uses
> bitmaps to track the mirror regions:

Did you miss some part after the colon? Can you add a reproducer here?
 
> This will access memory before the start of the sync_bits bitmap, and
> likely hit the guard page of the previously allocated clean_bits bitmap.
> 
> I looked and didn't see any crazy code using the signed int to
> intentionally try and access bits before some address within the bitmap.
> 
> Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>

Taking the patch in bitmap-for-next.

I'm aware of the int vs unsigned int problem, and already aligned some
bitmaps code. The cpumasks and nodemasks are all signed, but that's
not a problem in there.

The 0x80000000-bit bitmap is 256MB, and I was not aware about bitmaps of
that size. If that starts showing up, switching to unsigned ints would
only double the capacity, and that may become not enough quite shortly.

Can you please share more details about your case? What does 'faking
dm-mirror device' mean? Is this a real case in production environment?

Thanks,
Yury

> ---
>  include/asm-generic/bitops/le.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/asm-generic/bitops/le.h b/include/asm-generic/bitops/le.h
> index d51beff60375..e3b0da9a25f1 100644
> --- a/include/asm-generic/bitops/le.h
> +++ b/include/asm-generic/bitops/le.h
> @@ -16,47 +16,47 @@
>  #endif
>  
>  
> -static inline int test_bit_le(int nr, const void *addr)
> +static inline int test_bit_le(unsigned long nr, const void *addr)
>  {
>  	return test_bit(nr ^ BITOP_LE_SWIZZLE, addr);
>  }
>  
> -static inline void set_bit_le(int nr, void *addr)
> +static inline void set_bit_le(unsigned long nr, void *addr)
>  {
>  	set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
>  }
>  
> -static inline void clear_bit_le(int nr, void *addr)
> +static inline void clear_bit_le(unsigned long nr, void *addr)
>  {
>  	clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
>  }
>  
> -static inline void __set_bit_le(int nr, void *addr)
> +static inline void __set_bit_le(unsigned long nr, void *addr)
>  {
>  	__set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
>  }
>  
> -static inline void __clear_bit_le(int nr, void *addr)
> +static inline void __clear_bit_le(unsigned long nr, void *addr)
>  {
>  	__clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
>  }
>  
> -static inline int test_and_set_bit_le(int nr, void *addr)
> +static inline int test_and_set_bit_le(unsigned long nr, void *addr)
>  {
>  	return test_and_set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
>  }
>  
> -static inline int test_and_clear_bit_le(int nr, void *addr)
> +static inline int test_and_clear_bit_le(unsigned long nr, void *addr)
>  {
>  	return test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
>  }
>  
> -static inline int __test_and_set_bit_le(int nr, void *addr)
> +static inline int __test_and_set_bit_le(unsigned long nr, void *addr)
>  {
>  	return __test_and_set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
>  }
>  
> -static inline int __test_and_clear_bit_le(int nr, void *addr)
> +static inline int __test_and_clear_bit_le(unsigned long nr, void *addr)
>  {
>  	return __test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
>  }
> -- 
> 2.53.0
