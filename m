Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070C736195A;
	Fri, 16 Oct 2026 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167437; cv=fail; b=YZDiXuOPQj2Rt7wA3u0jroKu82/Kt0vB14ccnfcxr/9FopN0SZN/VyNo1s69IO/ogM+vIi0FoRxYwXJzCba5VOxY9UBN1oq17YCBWLVj3Cf1IAlKtOhnEap8tUXNEwbNjMNO5EpmLpL64tYOd4IMNno+kyGZxSNIUEd2DkjT1h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167437; c=relaxed/simple;
	bh=yVurICz8n83ukPOmWYXk86VJQ07idjgvGFn1D2fR274=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oUzvKaFSmR4vLvNNLi/eQo4lass33n51T+78rL1L+MkzMDjb28/DgXq8FIKKwea8YrI4mJ4b6UV79CDEZP4IHzC1tdXSMOaDJsrNDrPeqZRJ1XLwIsy6zTNze7aLZRI7R8le/6SOoCfJlWmmXpvdos8yoeibjudFWpfkxETxPoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ry9ZWeYm; arc=fail smtp.client-ip=52.101.57.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ry9ZWeYm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROqsmBiyo/GmbSb1YS+bnGRVW1AWt96iK3zRyyKbWczupuGlMn+YgsQlnc/Egv+Uk+KX/UPjFAOrthxADhU25idtExjjuCWBnGKHNwU6X5SKZPPjdNToFov8NOKVeQ6SfznUHxQJIy05U+U2VOEBLNzHVaL8ibrGyY3LRjgOaKHZJxApkpiIvuu4hSmkaV6ZPGrHsOLyAfzZRUShRSH01uQbcqMjxoMCChUrC5Z26dcMlfYqxOoiMDTk6kPWWBmrsYVxnMxdxw8Mf9lcfOSOmpEWb9Nwr49G+ynZceGXtXkr6iAsHovvzvZWPV+D+Tv+wJGRkX807Vr4go9DxjRxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1iVc80Mih3JaA2ejuE5YhYrWmfTTW33E9YQIFQYVQw=;
 b=Y1fXjdQP+BEjpxe9zqwVKv9QA71osma+OrXpIvGCLlMnMdtgKGOr0JyVIc0LjPDlMrxqCz0b2iaDuX8sq3HDixg+eDcybDxbBNQf+628tixDvWDuYYL6xwHvUTx6/Xd8WJR9G++3oU2MN8dKJFCWg1eiYr7F8vs9MhO14WkQ+gMt7fO+ggTJkAjUeOptXgtplxR8GvbNMy8rxza71NXoMkmlcluEdGy6emo8ldoAQvgSELpNon/1escGqsyxsam9irjZyysjrAMRMyjTPpj44rVSYZO9Vz4OiRBsUYjb72HyLss08nYcSqdgWbRfLua/6i+S4eu9T+LCeIFqxuzbdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1iVc80Mih3JaA2ejuE5YhYrWmfTTW33E9YQIFQYVQw=;
 b=Ry9ZWeYmptvwx8MrKKVjfqAbFW0T4RtkwNqiwMSjAHzpwKNf/Eft68HuAu1HKALnRp0L+jmI2n+79LJ8PoYRrZDl/XqXc1wrp+lXAvx019lMn45iODYZXIOib81EkJ17JQKyQ/HIn5zzAuAZr61YJLsKhupEQFDCJLu9zzsTeMWPqrQBnC2PLkR8Eceo9nWT7s+wpzAx2xcXdJ783cLp8JKwWcs3JM5irMqAbpWdSYknwL+epftvtcbbdxijv0HtMRgegXtnVp/04PyDzpuXHzfBL4Hu0xxVWOPCd3RpiICBgJ0Ctv6l/LUiCCRiEIII0/6i9uPE7dOy+SLrR35NMQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 16:17:03 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0496.015; Fri, 16 Oct 2026
 16:17:03 +0000
Date: Fri, 16 Oct 2026 12:17:00 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Tzu-Ching Yang <shingekinocore@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops: Share the generic ffs()/fls() binary search via
 UNROLL()
Message-ID: <atJN_MOFxvqOM9h2@yury>
References: <20261016025634.2690862-1-shingekinocore@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016025634.2690862-1-shingekinocore@gmail.com>
X-ClientProxiedBy: PH7P221CA0073.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::30) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: dba622f8-b60a-44eb-b3e7-08df2ba0e9cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|23010399003|376014|366016|260925021911599003|261009223027099003|56012099006|5023799004|11063799006|261009221227099003|10067099003|22082099003|260925021311599003|18002099003|6133799003|260925022911599003|3023799007;
X-Microsoft-Antispam-Message-Info:
	9P/OAsupvgKzg9Mq9ze7ZIOxIq+RTy4FGn1wbHNz/cXPTwjhcNMIvdsfZJbGkVGFLPDikdN97SCX9MIM8/cnj91bTvK7pn/59Y2cqjvGHnzCykXcFdz/cNQ6U6kDSZLSLy0gCx0E77D5n8KZ8aT0YaUUC7C4tVNzdv2YJ0ZljbJkcsyvu/lijfHK+jm/sPiELWs14BHkUb74tvbSEBkZfpGpXxeKmDPrbnuD8sgnqwMm2pQEaEAUJ1AIJYla8Z/sKToEaW95iw7qLL+hrbJvFuDMyGFhtkI0k8iVRBSYa34raRB0m6q2CpUEtRBI06hlNJbO4x6tr/udqxS4Ive1jUwpkL1Hw0wt49D0yvSS9DQcnaf/aOLfLxf4fb26tm+ZxHHMlftxRvuSSllsxSzRWaKzouKiHbJqeJio7z5N9WwcwLBhxS5DCJGcIkjCIX37leEGPR/v5HdmyZBmOM6J5+3QQGMdYa16fLMcNORLbf5eWZtHKaU8DVo+ZPRWxeKjpj6Wme5GRzMijyxy6m6IFTcfzTWdh1JNHaIy0+R/1RU1Idhwhy8hQE5dd4i4sH3rBEz8AooZvVOSA+gyw/9tvWX9xDh3iFNEyoBuEYldTc9K46NQ5iWoHQomJl6UM2LPjIohUnLWtL/iru0Jl1KLwfg+ooLECAJLVAMSzPSZ+yc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(23010399003)(376014)(366016)(260925021911599003)(261009223027099003)(56012099006)(5023799004)(11063799006)(261009221227099003)(10067099003)(22082099003)(260925021311599003)(18002099003)(6133799003)(260925022911599003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d4FpudMx7pZ6mutIIHu6K2Me5fspxLUP8YbWlyPSlaxBPtXP0zFU3fa8CqmL?=
 =?us-ascii?Q?+tjpGw1ifwx/8+LqekVPXumXJ0UOICIgcIH0MPzTzjHoCGNjXipIx8wKi7FH?=
 =?us-ascii?Q?aUpEneyyKljXagiyYbe6H+6eajBSlGsQElxy6AzHw0SJUv92XB3SaUY49Y57?=
 =?us-ascii?Q?+5K+8ntPAn/4oDXIS1OiFdVDzKnkHpUG0duzS2zmzT+KNu9HYlw1Rn4P0ZLx?=
 =?us-ascii?Q?ssiqS9HibpLpWjEGRZq/YptXhMWG4G7cAIOg33rhlOMGCwYsrUrKw0edAGaV?=
 =?us-ascii?Q?gLRHyN5vbvCug/m7QWfc3l6bISwN/CdHEKZZ9mqTbuJN3y0l4tm+FyVQSOOc?=
 =?us-ascii?Q?yhPX0eCjzqlq4kU1nDDke5Pd0fW+Y3+D9brM6NdCAF9KL/zzmkEUej+QpB6T?=
 =?us-ascii?Q?0DVQrQv1nURZC/NbCMU7x5QjEPjOA+w485rRa6mH7G4apfqIxN9pdbmZjTEm?=
 =?us-ascii?Q?s4XVi9A0OoPJu3dtoKOrEFmpDKp1dXk+zArNswJQkEOlTekab/17Yqpo+x2V?=
 =?us-ascii?Q?m/a+kfXsgFG6xs/hSFBRPRiF+1ErGJRMsp7qGqRy8AgqqXHvTfMOp7asQpvs?=
 =?us-ascii?Q?qPpVHy1p82wCrgwh0eYJdj1Y/B0pKF8v35m61+FUdhiMzh09sxcvfqiC4KYh?=
 =?us-ascii?Q?C1sOMkfHBAsbtOD/D1K9HCaPKlj3Rfp7VbE7gOxNUSDSeZMny/3gk8vRWKJu?=
 =?us-ascii?Q?vOWYcFyuxh4XX+sx1eBuDb/WnOjb3j90HP0lRu1Q/4+IE0M9qbtxTUPMqcfN?=
 =?us-ascii?Q?sYIaTchay0Q8jBxnBOQGBouVbVSWirygV7ES6aMLYPgq0I+Q7dZQwMdJV/wT?=
 =?us-ascii?Q?WHGgzFOrdGaA5537h+/KEDLn/73iuqAbc061xWXOEUR+OGTGW2bl4Ilw3ltV?=
 =?us-ascii?Q?vFJCA2Wuy4uvxeMkQop6RGFaIrofTtPqakaz/ZD7uBtrQRhIjIidXbDby20c?=
 =?us-ascii?Q?umSHBJkYhMsXSAnLNkExINNNwo0QlTquY4VsCo97EW3XqVoDbcFPgiXzJdli?=
 =?us-ascii?Q?07A493oR675oQHH6Nywgj7MSJMgzHrPjaqinRrQ2dIpokm9C0hy3bjplovtB?=
 =?us-ascii?Q?2aDOfVWD4X3j+kaKlMrvt9hQWflmJKA0qaq9MXpOMm5dDS4o8LSSjo6TyPnv?=
 =?us-ascii?Q?sxVmT2NT8q00Oka59h7ZCl+nKxQseeANLF/WJNfnj9w0VKXMyCSSimg0vUqS?=
 =?us-ascii?Q?/GlcTWajsLIcxa3SFo1qdEIiNDVrKf4iqk87IHuTmNbot6Uru6VHH2ESGoQ3?=
 =?us-ascii?Q?ab7dpxUYqtvBRdlcznuLukUG321JY3DuX+rT/rvv1jZ5/Ttn7JW2bi7OZg0l?=
 =?us-ascii?Q?eMCAugJrl9fqKvE+N7JQpVD9iL2GU4IOORMqZ/Dr8l4I5Yg6skvaRRDzlUYM?=
 =?us-ascii?Q?GuvQ5mYux2jQdYnE04SQbchKXS/HxjOygTEtvx95Q2BZNI73EeptpN73qXI7?=
 =?us-ascii?Q?dv6n7aXKLDGiFCrvN3rU4rvt1zW7YUK6+1f8k+mEaBwPZk/Au1olNt2XCWKF?=
 =?us-ascii?Q?2J8ncLaZKiVqVh2/JBZ2BGqwIYRjSkQlhMWGn9QzzkTEbWnPplz1y1RlIWWm?=
 =?us-ascii?Q?1l0ZL5Ib6ErI90fLGRkiFH+qP59570HwcUiDGUgXZFM8xBXtDYS1vRIFB21h?=
 =?us-ascii?Q?Ptg5krCTni6rfk1+eRfijN4pWdCMNagwEgrW12pLCKsqc3gQtdBIYMCMsRBB?=
 =?us-ascii?Q?jSlTX+8SEe7IEuCVpfme0GoiGFA107FcaiARmUR1Xu/ZqpsINTt4kSuhxv0i?=
 =?us-ascii?Q?9hom/es33zteizhKJhHVLXJL43Bo0JdPeF4yOfJK6zYFLH3MQOjG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba622f8-b60a-44eb-b3e7-08df2ba0e9cd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:17:02.9705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tgLor3f1qGRXxLaJUJC6urDVM4kNZDSVujX7787YH0hTocbguh3MMPLJmq8dKlAR/0uIo77TnQYro+qBRb7rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865

On Fri, Oct 16, 2026 at 10:56:34AM +0800, Tzu-Ching Yang wrote:
> generic_ffs(), generic___ffs(), generic_fls() and generic___fls() each
> open-code the same binary search: if the low (or high) half of the bits
> still in play is zero, shift it out and adjust the result, then repeat
> with half the width. Each copy spells out its own masks, the two
> unsigned long versions need an #if for their 32-bit step, and the
> copies differ in the order of the two updates in a step and in how the
> test is written. They implement some or all of these operations on
> riscv (without Zbb, and as the fallback with Zbb), ARM before ARMv5,
> m68k without bitfield instructions, sh, sparc32, microblaze, nios2 and
> a few other architectures.
> 
> Add <asm-generic/bitops/ffs-fls-search.h> with one search step per
> direction, whose shift and mask follow from the step number and the
> type of the word, and expand the steps with UNROLL() from
> <linux/unroll.h>. The four functions keep their definitions and
> kernel-doc; only the steps are shared. UNROLL() works in the
> preprocessor, so every shift and mask is still an integer constant
> expression. Its count has to be a literal, so rather than hard-coding
> six steps for a 64-bit word, expand the 20 that UNROLL() supports: a
> step past the width of the word shifts by 0 and is optimized away,
> which also removes the #if.
> 
> The shared step tests with "!", shifts the word and then adjusts the
> result, as generic_ffs() and generic_fls() did, so those two compile to
> the same code as before. generic___ffs() and generic___fls() adjusted
> the result first; GCC now mostly emits the same instructions with the
> shift and the update swapped, and Clang 18 changes a few riscv callers
> somewhat more (sizes below). Nothing was timed on hardware that runs
> this code. For the reordered code, models of the affected cores
> (llvm-mca for riscv) predict no slowdown, except 1-2 cycles on a few
> inputs in the out-of-order SiFive P450 model, whereas adjusting the
> result first in all four functions is predicted to slow down
> generic_ffs() and generic_fls().
> 
> A plain loop with unrolled_full would not need the step macros, but the
> pragma is only a hint and leaves the code to each compiler's unroller:
> both GCC and Clang unroll the loop completely, yet Clang then generates
> different code for nearly every target, better in some cases and worse
> in others, and so does GCC in some callers once the helpers are inlined.
> 
> As a side effect, every user of <linux/bitops.h> on these architectures,
> including every riscv kernel, now also sees <linux/unroll.h>. The header
> is small, but it defines the lower-case object-like macros unrolled,
> unrolled_full and unrolled_none, so a variable, struct member or
> parameter with one of these names stops building there while it still
> builds on x86 and arm64. With GCC 11 and later, a parameter named
> "unrolled" can even build, with only -Wunknown-pragmas warnings, and
> silently lose its value. No in-tree code uses these names.
> 
> Results are unchanged for every 32-bit argument and every 64-bit word
> with a zero low half (QEMU user mode; riscv64, rv32, m68k, sh4,
> sparc32, ARMv4T, openrisc and parisc with GCC 16.2, riscv64 with Clang
> 18). The ffs and bitops KUnit tests, test_bitmap and test_bitops pass
> on riscv64 without Zbb, and W=1 builds report no new warnings.
> 
> bloat-o-meter on vmlinux with GCC 16.2: no change for arm v4t, m68k
> ColdFire 5475, sh4, sparc32, openrisc, parisc64 and xtensa without NSA;
> +4 bytes for riscv without Zbb. With Clang 18, riscv without Zbb is -38
> bytes (assoc_array_insert() -42, iio_device_add_event() +8). m68k
> ColdFire 5208 is +16 bytes, from two functions that use none of these
> helpers; GCC compiles them identically with -ftrack-macro-expansion=0.
> 
> Signed-off-by: Tzu-Ching Yang <shingekinocore@gmail.com>
> ---
> <linux/unroll.h> now reaches 2327 of 2513 compiled units in a riscv
> defconfig build (Zbb off), up from 44. Test modules with a local
> variable or struct member named "unrolled" fail to build with this
> patch on riscv (GCC with Zbb on and off, Clang with Zbb off), m68k
> ColdFire and ARMv4T, and still build on x86_64 and arm64.
> 
> Generated code. generic_ffs() and generic_fls() are unchanged. In
> callers of generic___ffs() and generic___fls() the shift and the
> counter update trade places, e.g. riscv64 _find_first_bit(), GCC 16.2:
> 
>     mainline                   with this patch
>     bnez   a3,<next>           bnez   a3,<next>
>     addiw  a0,a0,16            srli   a4,a4,0x10
>     srli   a4,a4,0x10          addiw  a0,a0,16
>     zext.b a3,a4               zext.b a3,a4
> 
> Functions that differ in vmlinux, GCC 16.2:
>   riscv, Zbb off   300; 298 reordered only, 2 with other registers
>                    (alloc_large_system_hash +6 bytes, bpf_msg_push_data
>                    one instruction fewer, same size)
>   loongarch32      144 (LA32R), reordered only
>   parisc64         114 (__fls only); 90 reordered only, 23 with another
>                    delay slot fill, 1 with two registers swapped
>   sparc32 48, openrisc 44, xtensa 12 (one also renames registers),
>   sh4 4: reordered only
>   arm v4t, m68k ColdFire 5475: vmlinux byte-identical
>   m68k ColdFire 5208: percpu_rwsem_wait +8, __wait_for_common -4; they
>                    inline no ffs/fls helper and compile identically with
>                    -ftrack-macro-expansion=0 or -g
> Except on riscv and 5208, function sizes are unchanged. Clang 18, riscv
> with Zbb off: 12 functions, none only reordered; the _find_first*_bit()
> helpers use "or" instead of "add" for idx + __ffs(),
> assoc_array_insert() is 42 bytes smaller and iio_device_add_event() 8
> bytes larger, with a 16-byte larger stack frame.
> 
> bloat-o-meter, riscv defconfig with RISCV_ISA_ZBB=n:
>   GCC 16.2: add/remove: 0/0 grow/shrink: 1/1 up/down: 6/-2 (4)
>   Clang 18: add/remove: 0/0 grow/shrink: 2/3 up/down: 44/-82 (-38)
> mm_core_init -2 and dw_pcie_irq_domain_alloc -4 come from byte-identical
> objects and change at link time (relaxation). On loongarch32 with
> CONFIG_IKHEADERS only kernel_headers_data changes (-800 bytes).
> 
> Performance is model-only: no affected architecture could be timed on
> hardware. llvm-mca 17/18 ran on every executed path for the SiFive
> U74/E76/P450, Rocket and SCR1 models; m68k, sh, sparc32, xtensa,
> parisc, openrisc, loongarch32 and microblaze only got simple static
> issue models (and MC68000 instruction timings). Of 648 changed
> compiler/target/flags/function combinations, none is predicted slower
> except 20 riscv64 caller cases in which the out-of-order P450 model
> needs 1-2 more cycles on some inputs (-0.4% to +0.4% averaged over the
> inputs); the in-order SiFive-7 model is up to 4 cycles faster per
> __ffs() call. llvm-mca did not predict the slowdowns that this kind of
> reordering showed on x86 hardware (up to about 10% on single paths;
> x86 does not use this code), so this is weak evidence. Adjusting the
> result first everywhere is predicted slower for ffs()/fls() on every
> affected architecture, e.g. +3 cycles per ffs() call on the U74.
> 
> A loop with unrolled_full, against the current headers in userspace
> builds (GCC 9/12/13/14 and Clang 17/18, 75 compiler/target pairs, -O2,
> -Os and kernel-like -O2): out of line, GCC gives identical code in all
> 324 cases and Clang different code in 567 of 576, e.g. Clang 18 rv64
> fls() 33 -> 25 instructions but __ffs() 29 -> 31 and one more branch,
> Clang 17 ARMv4 ffs() 23 -> 37. Inlined into callers, GCC differs in 60
> of 324 cases.
> 
> UNROLL(20) rather than six steps: the extra steps vanish when
> optimizing, but not at -O0 or under Clang's GCOV instrumentation, where
> the four helpers out of line grow from 405 to 564 instructions and from
> 280 to 728 bytes of counters (Clang 18 riscv64; measured with the same
> expansion before the step order was unified).
> 
> tools/include/asm-generic/bitops/{fls,__fls}.h copy two of these
> headers, so tools/perf/check-headers.sh will report them as different.
> They cannot simply be resynced, since tools/include has no
> <linux/unroll.h> or ffs-fls-search.h; the current copies compute the
> same values, so keeping them, or dropping the two entries from
> check-headers.sh, is enough.
> 
> Testing details: all 2^32 arguments in 12 configurations and every 7th
> block of 2^16 in 51 more (GCC 8.1 to 16.2, LLVM 17 to 23), with no
> mismatch against the old code or an independent reference. W=1 vmlinux
> builds: arm multi_v4t, m68k m5475evb and m5208evb, sh rts7751r2dplus,
> sparc32, openrisc without ff1/fl1, parisc64, xtensa (custom core
> without NSA), loongarch32 (LA32R) and riscv with Zbb off, GCC 16.2,
> plus riscv with Clang 18. Not covered: hardware timing, and any model
> of the Clang 18 riscv changes; run-time tests on parisc64, loongarch32,
> microblaze, nios2, xtensa and SH-2A; other compiler versions in kernel
> builds; modules; sparse, smatch, coccinelle.
> 
> Against bitmap-for-next (a73b4d1fa7d3); applies as is to v7.3-rc7 and
> next-20261012, where the four headers are identical.

It's written in a great length indeed. I'm not sure I'm ready to walk
through all this wording, sorry.

>  include/asm-generic/bitops/__ffs.h          | 26 +----------
>  include/asm-generic/bitops/__fls.h          | 26 +----------
>  include/asm-generic/bitops/ffs-fls-search.h | 51 +++++++++++++++++++++
>  include/asm-generic/bitops/ffs.h            | 23 ++--------
>  include/asm-generic/bitops/fls.h            | 23 ++--------
>  5 files changed, 61 insertions(+), 88 deletions(-)
>  create mode 100644 include/asm-generic/bitops/ffs-fls-search.h
> 
> diff --git a/include/asm-generic/bitops/__ffs.h b/include/asm-generic/bitops/__ffs.h
> index 3a899c626f..ad5c014c62 100644
> --- a/include/asm-generic/bitops/__ffs.h
> +++ b/include/asm-generic/bitops/__ffs.h
> @@ -3,6 +3,7 @@
>  #define _ASM_GENERIC_BITOPS___FFS_H_
>  
>  #include <asm/types.h>
> +#include <asm-generic/bitops/ffs-fls-search.h>
>  
>  /**
>   * generic___ffs - find first bit in word.
> @@ -14,30 +15,7 @@ static __always_inline __attribute_const__ unsigned int generic___ffs(unsigned l
>  {
>  	unsigned int num = 0;
>  
> -#if BITS_PER_LONG == 64
> -	if ((word & 0xffffffff) == 0) {
> -		num += 32;
> -		word >>= 32;
> -	}
> -#endif
> -	if ((word & 0xffff) == 0) {
> -		num += 16;
> -		word >>= 16;
> -	}
> -	if ((word & 0xff) == 0) {
> -		num += 8;
> -		word >>= 8;
> -	}
> -	if ((word & 0xf) == 0) {
> -		num += 4;
> -		word >>= 4;
> -	}
> -	if ((word & 0x3) == 0) {
> -		num += 2;
> -		word >>= 2;
> -	}
> -	if ((word & 0x1) == 0)
> -		num += 1;
> +	__ffs_fls_unroll(__ffs_step, word, num);
>  	return num;
>  }
>  
> diff --git a/include/asm-generic/bitops/__fls.h b/include/asm-generic/bitops/__fls.h
> index 35f33780ca..1c439e881b 100644
> --- a/include/asm-generic/bitops/__fls.h
> +++ b/include/asm-generic/bitops/__fls.h
> @@ -3,6 +3,7 @@
>  #define _ASM_GENERIC_BITOPS___FLS_H_
>  
>  #include <asm/types.h>
> +#include <asm-generic/bitops/ffs-fls-search.h>
>  
>  /**
>   * generic___fls - find last (most-significant) set bit in a long word
> @@ -14,30 +15,7 @@ static __always_inline __attribute_const__ unsigned int generic___fls(unsigned l
>  {
>  	unsigned int num = BITS_PER_LONG - 1;
>  
> -#if BITS_PER_LONG == 64
> -	if (!(word & (~0ul << 32))) {
> -		num -= 32;
> -		word <<= 32;
> -	}
> -#endif
> -	if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
> -		num -= 16;
> -		word <<= 16;
> -	}
> -	if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
> -		num -= 8;
> -		word <<= 8;
> -	}
> -	if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
> -		num -= 4;
> -		word <<= 4;
> -	}
> -	if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
> -		num -= 2;
> -		word <<= 2;
> -	}
> -	if (!(word & (~0ul << (BITS_PER_LONG-1))))
> -		num -= 1;
> +	__ffs_fls_unroll(__fls_step, word, num);
>  	return num;
>  }
>  
> diff --git a/include/asm-generic/bitops/ffs-fls-search.h b/include/asm-generic/bitops/ffs-fls-search.h
> new file mode 100644
> index 0000000000..5c64364e54
> --- /dev/null
> +++ b/include/asm-generic/bitops/ffs-fls-search.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_GENERIC_BITOPS_FFS_FLS_SEARCH_H_
> +#define _ASM_GENERIC_BITOPS_FFS_FLS_SEARCH_H_
> +
> +#include <linux/unroll.h>
> +
> +/*
> + * Steps of a binary search for the first or last set bit of a word
> + * @i: the step number, from 0
> + * @x: the word, a local variable that the steps shift in place
> + * @n: the result, a local variable that the steps adjust in place
> + *
> + * Step @i looks at the low (__ffs_step) or high (__fls_step)
> + * __ffs_fls_shift(@i, @x) bits of @x: half of its width, then a quarter,
> + * and so on. If they are all zero, the step shifts them out of @x and adds
> + * their number to @n (__ffs_step) or subtracts it (__fls_step). @x is
> + * shifted before @n is adjusted: the next step tests @x, while @n is only
> + * needed at the end. The masks are computed in the type of @x.
> + *
> + * UNROLL() expands the steps in the preprocessor, so every shift and mask
> + * is an integer constant expression, as in a hand-written search. It puts
> + * the steps next to each other with nothing in between, hence the braces.
> + */
> +#define __ffs_fls_shift(i, x)	((int)sizeof(x) * 8 >> ((i) + 1))
> +#define __ffs_mask(i, x)	(((typeof(x))1 << __ffs_fls_shift(i, x)) - 1)
> +#define __fls_mask(i, x)	((typeof(x))~(~(typeof(x))0 >> __ffs_fls_shift(i, x)))
> +
> +#define __ffs_step(i, x, n)						\
> +	{								\
> +		if (!((x) & __ffs_mask(i, x))) {			\
> +			(x) >>= __ffs_fls_shift(i, x);			\
> +			(n) += __ffs_fls_shift(i, x);			\
> +		}							\
> +	}
> +
> +#define __fls_step(i, x, n)						\
> +	{								\
> +		if (!((x) & __fls_mask(i, x))) {			\
> +			(x) <<= __ffs_fls_shift(i, x);			\
> +			(n) -= __ffs_fls_shift(i, x);			\
> +		}							\
> +	}
> +
> +/*
> + * Six steps cover a 64-bit word. UNROLL() needs a literal count, which
> + * cannot be derived from sizeof(@x), so expand the most it supports. Steps
> + * past the width of @x shift by 0 and are optimized away.
> + */
> +#define __ffs_fls_unroll(step, x, n)	UNROLL(20, step, x, n)
> +
> +#endif /* _ASM_GENERIC_BITOPS_FFS_FLS_SEARCH_H_ */
> diff --git a/include/asm-generic/bitops/ffs.h b/include/asm-generic/bitops/ffs.h
> index 5ff2b7fbda..53705ba8c9 100644
> --- a/include/asm-generic/bitops/ffs.h
> +++ b/include/asm-generic/bitops/ffs.h
> @@ -2,6 +2,8 @@
>  #ifndef _ASM_GENERIC_BITOPS_FFS_H_
>  #define _ASM_GENERIC_BITOPS_FFS_H_
>  
> +#include <asm-generic/bitops/ffs-fls-search.h>
> +
>  /**
>   * generic_ffs - find first bit set
>   * @x: the word to search
> @@ -16,26 +18,7 @@ static inline __attribute_const__ int generic_ffs(int x)
>  
>  	if (!x)
>  		return 0;
> -	if (!(x & 0xffff)) {
> -		x >>= 16;
> -		r += 16;
> -	}
> -	if (!(x & 0xff)) {
> -		x >>= 8;
> -		r += 8;
> -	}
> -	if (!(x & 0xf)) {
> -		x >>= 4;
> -		r += 4;
> -	}
> -	if (!(x & 3)) {
> -		x >>= 2;
> -		r += 2;
> -	}
> -	if (!(x & 1)) {
> -		x >>= 1;
> -		r += 1;
> -	}
> +	__ffs_fls_unroll(__ffs_step, x, r);
>  	return r;
>  }
>  
> diff --git a/include/asm-generic/bitops/fls.h b/include/asm-generic/bitops/fls.h
> index 8eed3437ed..42625a0785 100644
> --- a/include/asm-generic/bitops/fls.h
> +++ b/include/asm-generic/bitops/fls.h
> @@ -2,6 +2,8 @@
>  #ifndef _ASM_GENERIC_BITOPS_FLS_H_
>  #define _ASM_GENERIC_BITOPS_FLS_H_
>  
> +#include <asm-generic/bitops/ffs-fls-search.h>
> +
>  /**
>   * generic_fls - find last (most-significant) bit set
>   * @x: the word to search
> @@ -16,26 +18,7 @@ static __always_inline __attribute_const__ int generic_fls(unsigned int x)
>  
>  	if (!x)
>  		return 0;
> -	if (!(x & 0xffff0000u)) {
> -		x <<= 16;
> -		r -= 16;
> -	}
> -	if (!(x & 0xff000000u)) {
> -		x <<= 8;
> -		r -= 8;
> -	}
> -	if (!(x & 0xf0000000u)) {
> -		x <<= 4;
> -		r -= 4;
> -	}
> -	if (!(x & 0xc0000000u)) {
> -		x <<= 2;
> -		r -= 2;
> -	}
> -	if (!(x & 0x80000000u)) {
> -		x <<= 1;
> -		r -= 1;
> -	}
> +	__ffs_fls_unroll(__fls_step, x, r);
>  	return r;
>  }

Alright, so the basic idea is to hide the exact implementation behind
the macro magic. This is highly unfavorable unless it brings substantial
improvement i.e. in code generation. In kernel we're drifting toward the
exactly opposite direction: getting rid of those macro tricks folded one
into another in favor of the plain human-readable code.

Please refer the recent __MAKE_OP() removal:

https://lore.kernel.org/all/20260914204929.240310-1-ynorov@nvidia.com/

In the bitops-related area you can find meta-programming approach, for
example, in lib/find_bit.c. Notice how the macros _help_ to highlight
implementation in there.

Thanks,
Yury
