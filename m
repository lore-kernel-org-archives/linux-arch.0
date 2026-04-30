Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010068.outbound.protection.outlook.com [52.101.193.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A940DFB4;
	Thu, 30 Apr 2026 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777513642; cv=fail; b=hj8UxcmCJaVSQsFnuW/XwUJCdDq5T3oh70DVsMM67N/t79JkdGkEzJ29Xii0puE9bH76+QJIuWCqxYOOnZ7Sh7MTKPnEIpnYN8mhKTLGt+rK0rvESQz6gYwndjpndfUoI8H9f8UCn4CJmEYMhGIilmLoZs6oy/5TSZ+HXi2WiZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777513642; c=relaxed/simple;
	bh=xGOapE1OMWvVoW8NXHDPe75R8aBG+zTf/nWG30dgQVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZBOSwQ1ThSrrJ6dpV0+qBhEOCb0NUisIo55BxMDo14Hw6uUbv6iKqn5PGPvFZ/K1LrLxpvkwXS8qw2w7FOdAPvCqjgzZCZR8fdT8TAhZi6/wQdD4uWVb+gu53oyenzIrMQmjFeN7PBVGQ5hcn/uL/deJ3btAZgRFX354Yl7aWdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YF7xODsM; arc=fail smtp.client-ip=52.101.193.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YF7xODsM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JepKP1oFg9KbtFxn+vNYfH22JDNOxkOrtZRz8XKKF1dKxABslZUgQ5oYWyUPIE5WlkPww9QPcPN/+r1HWL8Za6AfMrygrRyn1MatzswLnq82whwuQlXl9M0Ma47rNRR3QSSn8lt7pBcMF5elFHuO6h0R3rWh11k6f3qmjoi5g+WRyiM+GIg9nP6OFI+IPJaUNPZ5B4HYKwCq6dMJHLrJvVW4yxk5Ub7MTUam5U2WTWB09GckqVh+sF9PEQBiWlMD0GEQBv8CivNURqe3vpb5R3tLxLtLgsvVtxkhdymXEAVzCTFBr5eRQnzlY3mG3SUf7EtDkwhhoUjGRj4sGs0Q7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waKW6NL2HZaFlS/XvbRlolg0hQOuwLZtFsrPi0WPvMQ=;
 b=HxWm3RGp82djmgGSzThovzvpp0tS5MB62oBQvLv02LsSs7oXQnYU+gqUSt71CzCx66GEFL4O09Vdoc6esSXns6NGyw/VUFwJ8sL70Sc0aZgMrdOV0OpXXjab85ayll/aYw5XOlse1He/AU4+Hosg5WQDeEzQb7OKMF4ThOzFlvav3MzB7fsmbyuSId4aJTMZHhI1JBbB4/hg3QpKfnmgWtF+BZlyYOgzrz/+agkPj+6o7QkoiqIYX/BLBVgixF9gPvyixvHRmNjwTviOs/l2xwyTmZwvWv97LAs/cQRct7+sCK9SJ+5gMdOLUfF3eZU0EZgymV9jfWB8NAata3f+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waKW6NL2HZaFlS/XvbRlolg0hQOuwLZtFsrPi0WPvMQ=;
 b=YF7xODsMlevrr//KB9QgQxbd/PNU4SvQs459QSeUNaCCDHess3x/OulDTZthrWaBEx/VgusoUqjOEJdFO4Xk/3/oAm3oMjajfQ41kU9ZO2V7tQ1Aa1MNF0c0M1h6JQR59souItYUAbeqEsFOD/eEBZbDCpspu80+n9nB80AoIWBbDociLhdWsAX/D4NhBBHmOiDzL7zfHo2DK5uTrjLRFowYnwspUySuTXYVmWrudwVvEvO26jq5DoFPvRUtGTUQo/Ge3gX4zc2WOmIl7qM3YwO7I/YL2kJptktd0W6gNQnGqUUYm2bVMEihm92uRgQn9CPIk3MQ9wmVpHayHayc8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Thu, 30 Apr
 2026 01:47:15 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 01:47:14 +0000
Date: Wed, 29 Apr 2026 21:47:12 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, arnd@arndb.de, akpm@linux-foundation.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, david.laight.linux@gmail.com,
	cp0613@linux.alibaba.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v5 2/3] bitops: Define generic __bitrev8/16/32 for reuse
Message-ID: <afK0oL5FS8eLobpV@yury>
References: <20260421130752.607500-1-ruanjinjie@huawei.com>
 <20260421130752.607500-3-ruanjinjie@huawei.com>
 <20260429202922.GA3575295@ax162>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429202922.GA3575295@ax162>
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|DM6PR12MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: 09dc6e3e-3c97-4302-5692-08dea65a6752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bkwYoLjnWTizsh/D/oQIVzfQ54OGsqHuqVruX7thaeAWcxVHPayEpy/61Q5Umi+jEW5OjoVyKcXuck2xtJ6xn77sKDK/BZhyS3nfgQQ8CGDc5jlKvaxj7/BoTFmdolNiAz5VuSBRDVveKKojBQB4MAI7wsrs2nnhfFvRSaFQ3QRlJlyErq2CilXkdnLDAE0uj1+LjhoMIw+cvXFmcJiXPMrWVjFhgxJWyOT0Gj3lhsBFkT1htHp4ETHfMhAt/emVO3/uZSIURBFhMz6wjNRZvg0XrhtEF/EtH/JD+ostlpRhQg8iZN1fbn6O7PdNacPcuXgiqmaTXJM/jLsiOdMt8xY798DlExHXfsEWpqvpWYgffR7NrOMxP64SUZ7Sjtj47Zwa1HFDcZWnwH13xBut12wvrO3eZyhVy0+IDSP0hYSfCFDe/e9NMhMyZl5Bpq/cOQrGR/wXgCEGIf5Oc1/1V7v205FXxYmpfStLDgY8T8Lp39wuOZQJ8/ylFt3tfCSUjYJGTaDQNsl24fIETTMQVFUSFHN7gkLhFw+W8JbuNwuQ1+NFyDH4jq8wOkKahVWO3mM9cNXm4hpcGHoOIc4gwzaSTTcbWoT1weXzGEsBbwV37XYhIPGzZUPYhfKnpEwvniu+JW6yk7I/2fy99ggD1/UazpFhNO2W4Nxder+CCQ4vI/HsBxXiXYuV48pH1Nao1L6RE8JxioPzrP1RLFRvIcLYdYP1TQRRX1rhqMvppjo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2gKXgLsZN9xoBVFaGnzjFsymJstQ++cV1fNwhMCTIZUPTqll5ZBoBm9G4Mcp?=
 =?us-ascii?Q?1g8tNU6RmS3P8B9eE2VXYH/RyneI2mmnb/EjWE9WnJzEvSWRLPvFl1rpe4LZ?=
 =?us-ascii?Q?3P2kYDhgjEIRjv/4T2kIBrx67OSc955OUDiLDuuNnxSbWAnXw7IOmxvvCLb+?=
 =?us-ascii?Q?V2+A/KR1HUywhkUQ+mHjst4Z/Jn0iVrGXBDw7ZSuMJtWeJzYIt5ED4Wxvsek?=
 =?us-ascii?Q?HAfiCowM+nVcPW/I4UCBgTnw0kv+xdMReywSLxPN8aFcdESOGEZ2txAYKk9/?=
 =?us-ascii?Q?9TymfFmlSlcaLg0AvDUYTAgz2JJrs41iwVZyrGwGAWWLtiV5fopwRVLFE69w?=
 =?us-ascii?Q?vmWAvs+yUYtFG7VtxMjTrvXxdbCAsy++FgStvJV5ijqTtVpywebkoKjQXKRN?=
 =?us-ascii?Q?cnVH4ebtR/1mKd1EmlAuG2HjdJ+jX/z4DI1xQxGkryAkio/TCHAyQOcuRvf+?=
 =?us-ascii?Q?j6K8oNLHpnQGfFPtmwhrgKwwl+5ZkzPU6cKbYDvfmtCLb9YtCz1qrcbWhuIT?=
 =?us-ascii?Q?aSsn9uxEChN3gQnhZm8t2rE9jz0dmgR/Se7c8j5oz6xCa4eF8Ag4mUP7puFX?=
 =?us-ascii?Q?FYoZBe9+TwF0hwaVCCNQnMEcJJjJkO3I45Ec0KDi8MauoK/YJ6A/Lz760DTw?=
 =?us-ascii?Q?365V8MRtXVF7Lf/vG+yTxLSBqiZ6IfN1O5yhftcOMp3vgXIMVJcn+4xT6NB5?=
 =?us-ascii?Q?AQ3BsB6bCcoPovHWB5b6VdETNyh2WBUYEAESDCndcK17ZZ9eTrj/oq/4k5nP?=
 =?us-ascii?Q?QHyJaTv2zArqGh48sz7cpc8kn0//qXGjlZqYRUnN5RLXXSrns5/qKHg9VTtk?=
 =?us-ascii?Q?FWM6mD9uV7IFhfkNfr9R8K+xk/1iZmwCxfRV7oBxQvadA33o4R50weo02K4H?=
 =?us-ascii?Q?lXtlzpPzmN9xwMmYZYAqUEpFD6X7m5ia3l6tDfDuozinjpQpPVPVJpqnG3eV?=
 =?us-ascii?Q?bm/LylHrJ8jon/Jw5G9MhIkuWfluFOGpRpl6kiz5hh6mp+mi5odHX/SJybdj?=
 =?us-ascii?Q?KmUxyNovTr9m4k0/4JSys92zXBV6/0tqOnaBK3KIHyTruDou6+z90ScTIVOI?=
 =?us-ascii?Q?J8y9GtXriAY35uNGCbwNHy8PQcp0F+MRwWbALWMwv+iqNrTBHo8FhlFxNQCj?=
 =?us-ascii?Q?Qy05k2shsV1rBGPIdl4pdUyngpNIwKsSiAAAmynjc7G+lnl4z/l196mUYWQd?=
 =?us-ascii?Q?R1OLN6+WTd5K6iwr0OAiN+kOwiBKy10SECt06Bx5YCaKo6zHcOU5VSYMgRql?=
 =?us-ascii?Q?jLdgphu1Dgpemlf45nEohjilYLbFZtkocKD3nNxvW6heRhGiHN4JerPxq4JP?=
 =?us-ascii?Q?GWCLICQIX70yEyHvyi4/l4AEd7oSDKGOMoL90vPxAokqrbZbst4qZ0PxORWC?=
 =?us-ascii?Q?/xiytGV2lBX0AvOh8Y+Yas3tuDnHtfCZXjTjLbKm1qqDUIzvggIKgoPYNBD+?=
 =?us-ascii?Q?9+D0heneqNLkNAR/JM9FB1aa4uMNpi62DJxcsl8f89NOfbTYYLlwowP/uhBr?=
 =?us-ascii?Q?yQ/G/3Vxh/VtMpAOlvgYPfadduBVfKc/EWuLeCWutOHxxus8oFqGboz6ui63?=
 =?us-ascii?Q?3P+6YhpV5sRIDKpreKNCos5gFPIlCcSwXEB2FQZN3MKC/LamIOiAigNn+zUN?=
 =?us-ascii?Q?utfI0fxY5CfdFGkkxiMRe8A9Gx7Z2inSv1yjxavpPu70klsN6h8qerj0keuu?=
 =?us-ascii?Q?6OcbdFLoBiSnNEH7buzMwrQIVH497eMgSwqJVfTTyQWwx7xWG2B9XHOdv20x?=
 =?us-ascii?Q?uW+zWmKhiI9JJXmJNa31wbXIZv0G3Yr3mBoYK93zwWVIY5/XOA3g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09dc6e3e-3c97-4302-5692-08dea65a6752
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 01:47:14.6367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3rX2jT1Tg1qLI5jgAE9rRDqntwGFk+gZZMYI1oI2zk0Ep4IHHdfLsqPiFvV7VeNRjBJLTiQOUe80PqwhIMRtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107

+ networking maintainers

On Wed, Apr 29, 2026 at 01:29:22PM -0700, Nathan Chancellor wrote:
> Hi Jinjie,
> 
> On Tue, Apr 21, 2026 at 09:07:51PM +0800, Jinjie Ruan wrote:
> > Define generic __bitrev8/16/32 using the implementation
> > in <linux/bitrev.h>, so they can be reused in <asm/bitrev.h>,
> > such as RISCV.
> > 
> > Reviewed-by: Yury Norov <ynorov@nvidia.com>
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > ---
> >  include/asm-generic/bitops/__bitrev.h | 25 +++++++++++++++++++++++++
> >  include/linux/bitrev.h                | 20 ++++----------------
> >  2 files changed, 29 insertions(+), 16 deletions(-)
> >  create mode 100644 include/asm-generic/bitops/__bitrev.h
> > 
> > diff --git a/include/asm-generic/bitops/__bitrev.h b/include/asm-generic/bitops/__bitrev.h
> > new file mode 100644
> > index 000000000000..f06af929678d
> > --- /dev/null
> > +++ b/include/asm-generic/bitops/__bitrev.h
> > @@ -0,0 +1,25 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_GENERIC_BITOPS___BITREV_H_
> > +#define _ASM_GENERIC_BITOPS___BITREV_H_
> > +
> > +#ifdef CONFIG_GENERIC_BITREVERSE
> 
> The dependencies of this symbol seem insufficient, as I can trigger a
> build failure on next-20260429 like so:
> 
>   $ make -skj"$(nproc)" ARCH=s390 CROSS_COMPILE=s390-linux- mrproper tinyconfig fs/select.o
>   In file included from include/linux/crc32.h:6,
>                    from include/linux/etherdevice.h:23,
>                    from include/linux/if_vlan.h:11,
>                    from include/linux/filter.h:21,
>                    from include/net/xdp.h:10,
>                    from include/net/busy_poll.h:19,
>                    from fs/select.c:33:
>   include/linux/etherdevice.h: In function 'eth_hw_addr_crc':
>   include/linux/bitrev.h:16:20: error: implicit declaration of function 'generic___bitrev32' [-Wimplicit-function-declaration]
>      16 | #define __bitrev32 generic___bitrev32
>         |                    ^~~~~~~~~~~~~~~~~~
>   include/linux/bitrev.h:67:9: note: in expansion of macro '__bitrev32'
>      67 |         __bitrev32(__x);                                \
>         |         ^~~~~~~~~~
>   include/linux/crc32.h:107:36: note: in expansion of macro 'bitrev32'
>     107 | #define ether_crc(length, data)    bitrev32(crc32_le(~0, data, length))
>         |                                    ^~~~~~~~
>   include/linux/etherdevice.h:292:16: note: in expansion of macro 'ether_crc'
>     292 |         return ether_crc(ETH_ALEN, ha->addr);
>         |                ^~~~~~~~~
>   make[5]: *** [scripts/Makefile.build:289: fs/select.o] Error 1
>   ...
> 
>   $ scripts/config -s BITREVERSE
>   undef
> 
>   $ rg BITREVERSE .config

Confirm the same for x86 tinyconfig.

The problem is that the patch makes generic bitrevXX() conditional
on CONFIG_GENERIC_BITREVERSE, while before they were conditional on
!CONFIG_HAVE_ARCH_BITREVERSE. So if you don't have arch bitreverse(),
and dont' enable BITREVERSE, the generic implementation is not defined
now.

Luckily, the only user of bitrev() in unconditionally compiled objects
is CRC32, and it's not needed if CRC32 is disabled.

This is the minimal working fix for me. Please let me know what do you
think. I can prepend Jinjie's pathes in my tree with it if it's OK for
you.

Thanks,
Yury

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index df8f88f63a70..245b206dd38b 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -20,7 +20,9 @@
 #include <linux/if_ether.h>
 #include <linux/netdevice.h>
 #include <linux/random.h>
+#ifdef CONFIG_CRCC32
 #include <linux/crc32.h>
+#endif
 #include <linux/unaligned.h>
 #include <asm/bitsperlong.h>
 
@@ -281,6 +283,7 @@ static inline void eth_hw_addr_random(struct net_device *dev)
 	dev->addr_assign_type = NET_ADDR_RANDOM;
 }
 
+#ifdef CONFIG_CRCC32
 /**
  * eth_hw_addr_crc - Calculate CRC from netdev_hw_addr
  * @ha: pointer to hardware address
@@ -291,6 +294,7 @@ static inline u32 eth_hw_addr_crc(struct netdev_hw_addr *ha)
 {
 	return ether_crc(ETH_ALEN, ha->addr);
 }
+#endif
 
 /**
  * ether_addr_copy - Copy an Ethernet address
