Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801D63ACA65;
	Mon,  4 May 2026 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919530; cv=fail; b=TujhHabmu3BCMcY2D2LsnGWdeU7k5lIqB2P2+3gM83weqR5+yUIS1VSdn5gjPaV+1ZCJ6ywgxQgvQ9xOoUKHYDeFRzSIR0DaOdttUaNoMCHxEzFPcIAz6ZnR/tKSE5wbrqLoEqjXYibZmv2bVGEkcZRNF4H+yRwUnKoEomVIUn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919530; c=relaxed/simple;
	bh=8qEHna0BQChiwkWAU9chQvc3ppCH4aCE0gCZ7CBb5nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=heTSTGieGSOiSN07urN4UcTkWaTAeFS72vJY393DdOvGueGbXj8MNxIj97zU4D7/V3LRTqhSRbZMNxIYbCZjEark6IdCKLRqTviQpqM2IA2bN0OFRZRFOf79kj2TG1raT/JD2u8hY9Eu8nPMjYlwnAf4xblsrWblLBjXPeu02ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C8WvEPj1; arc=fail smtp.client-ip=52.101.56.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C8WvEPj1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFs2FYh7Vo4BqUCXih480TfE+630N95NMFlRf5QR3eqs2LJrDOUt165nNf4VzX7m+Foo3b5TDA4ONIk0zWCM099oQlX4e8kPscGbAmnYd4bwm929rwsV3ve2o74FGQ/JbCPxXcr3JuvL1b99+iMlZpJjZxV/afPgK0H8tVqydg7Gmqrvx2CYvDF+5mQuV+NVLK9iqdBm5XOC8IxlzQ8AQTP8gy2qR66Xsv2EFckunfKyxTphsp3tJBmKF/2UIHnSUGu18LL5K6lOd1t+g1Aqn4FgP9aS4L7fueIEACOZxxSat2A5ej3Su8E6KBUi6/KLD8rZf0mwI5phqNbJOzQxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBW7ZFI4MKlBJxx30Z8ejLX20Y+H39dCGpQz/YXPEdY=;
 b=vZi34K/6bwnB3x5jPUGS2a9fw8iiBzuvwhkn6TL8+jomGg5OcU/aT/P1sHWuLA9JQ5gVvyJ/10yzaOo+RUHQn65iKm3giG2DoclRDSK5Tgf4n9iIe7tp2QajeCvO0d0RopO405hu7MfgyyqKNsvFnOIBkq+XhKIHCENLyB1QAG26EpVVfFjSy8CewcduN3SdZjLki3s3wXhbqoX5vG8oDUUroUnZ7XOFq9Nws1fkzJr3KMOldsmNZuSPGkO7IkO5uTO1INy8TNGN0iLuF/rsMc/SQQ9Isd/JZfM9uLYuONbMhAAwltZDIWe1grdDc3JuGYSFb0ZPzY/goRmObDX/CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBW7ZFI4MKlBJxx30Z8ejLX20Y+H39dCGpQz/YXPEdY=;
 b=C8WvEPj1tx+QC7VuTC1pt2NskhzltUgRDxBje0OVLkEMp7kNKpegVxRDoaqXVJ78si1u7SF5pjjnpBw9efautWJM4kxn5XSCmR9iIzvBz4Au/Gj+Dx0hZXUhADrIx6TwPYpfj3LnIKgzRQH6+QTvoG+4QQheD2q5cm1siqqNG4CXdxMfXxN23mSODcdBSlKRhNxTa6vAzBzTeekmZfDKuub1g1l8szhYmhl96WzbyW5uaS5TqeOW7v15IKfn/q8PetYNcVusp1/jKxsCbajjR5yx9g4Zh4qjZ1ZDKfIBoj8eIOmKT4xPuyahl9cIevQCB8ixEdmbXTuwA+faTRGkbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:32:04 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 18:32:02 +0000
Date: Mon, 4 May 2026 14:32:00 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ruan Jinjie <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 1/6] lib: include crc32.h conditionally on CONFIG_CRC32
Message-ID: <afjmIK4mlCWeywuS@yury>
References: <20260430211351.658193-1-ynorov@nvidia.com>
 <20260430211351.658193-2-ynorov@nvidia.com>
 <ec4ed7f5-b1c8-49e4-b83d-e29c5414b9de@app.fastmail.com>
 <afjNaToyptiMogV4@yury>
 <9d45acd1-667b-4acf-9e2e-bcd79630d726@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d45acd1-667b-4acf-9e2e-bcd79630d726@app.fastmail.com>
X-ClientProxiedBy: SJ0PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::28) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|LV5PR12MB9779:EE_
X-MS-Office365-Filtering-Correlation-Id: d44c07fa-c92f-4013-00c7-08deaa0b6f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+yKFsHxbNKLnafRFPLrd8Ts8Zaq6EmJ0YGf/eYfUhjomUdDpyCqU2/2WcMNZWtqjKNRL7Q/pFHKCmRx258D8SOLHAF1mBjKNP1UqRISHwU3wKEB6Q5cuDh15Ib91GO9coLTabYOFgJ/dHhHf0OuVORC9MC6yAZrE3lRMZTgSCYKyf0bhmBHjboe5LquzwoPaB3Ps4ZUJ3Stsr8jt+cvNPg9v0uajTYqJBmqpgWLPdJijtz6BV3Q7fwQVnEC0TUk2Voe4Hmtd2/s30KU4o+hkurGf64OdyTkz8ZyWy9F4xWzE8fbrM8k0wIJ85Ke1R0ydPOiYrgLGXgJXGzNNp88twXAZXRdqMZiBjbR9yxp3c5kCUeTUjjeCke5tbMx8e5ud37y3JVrhaNgrjKjJ7du0nt7LSJY1mtXuktTye40Fi3w7D6q5ceTQ4iQLuW0gErYBEUisqwCiD04uqNC8W5W5AEzrAtE7GrORTF28B3tkTNZncOhyx2G/+Hhm6qJgbDlmpk/Ys5CrKo6dvpknmDL16zZW2AvR0Epwg2nYdwhdzJigpTaXCKaTJxKGmbPdBvGoo8OZcfCL96C+aRhJTMQ2lVisAd9eETxvFPkA9U9ERje5FLYZf1RI+Qez5oJpY2JFrgFwbgqojzYoDlqJzmYZ1eFWuidEbuArl11AhpmqrjICr7LHSr/2xp2WkP90bMaCaQBPwaiFeCbx9OBoycMJzA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y84ya5zJUOdPbm0F/Tyj0VA9daBoKJTOdJd6a5LqSj1N3sJpNkuT05HSH0c0?=
 =?us-ascii?Q?GKTYfiB1gNN7EePhsNtrLokvLaJuRL24d5FaaxV4442h9iocGr5xF58MLeV7?=
 =?us-ascii?Q?WLtd4xqlmSRzny2CF9OLLeVU3wCruL1SzF1lLfhEKVpLfJQTr9vE351SnsKr?=
 =?us-ascii?Q?KfwMrQsbocanuoAwsGesdjm4VkialHyMHuMw791hlqzVOB1eE6AO87yz9JvX?=
 =?us-ascii?Q?Zhi+nkplIi2zkBW97lOvodEfUJJPFQzVodRwT/sB+WjD9Bf0CQ4h5r7rqg4S?=
 =?us-ascii?Q?8IzhBlkpsOnEPqpRXtx4mBRn+Z99ZRdsvu1hY0xApD/4Y3Xwi46B55/smMgZ?=
 =?us-ascii?Q?N/WPWJyuXY6KQX6HumHb0zOEj7JPY/7H80IrmIk3YGBRJ57fMolfuP8ZZXsu?=
 =?us-ascii?Q?oVBwbb709q4SoqXfq0hdmc+s68rFJcpEJpgGluxibgXlplWW1PfNe4WI+U+R?=
 =?us-ascii?Q?Abd+RbKR5j6H9qDq4rRT366KT+Rt7dS8OP6PzKUAylAj59tTTzbZnQ6sBk1x?=
 =?us-ascii?Q?VHyz1I1yZmj1dGRR+TegSe98bPhkodgWHTQnXzSFS0Huzh4Sl+zyL0sUs86F?=
 =?us-ascii?Q?5SVkn94TiMieiUHufeTQ6CA1+u47F5kl+dVcQ6PLHB/aCIWXkTN7QjHXeNM6?=
 =?us-ascii?Q?TW1xNhilL74iELsA67u1VCgrNcaWKtTwP16eEVmG/nQqyyJ262v4qA+Lvi0o?=
 =?us-ascii?Q?EoEGqS8CQlhMGEcI+TTNZOPmXNZ+dIa4nGAvgAoiNdYJ/eHWeZE3GRV5DyhS?=
 =?us-ascii?Q?AZmixSTc3BZvnHjRBOZ0m8vCCbCSIfG2i+CKuPDX8sJ0T8Y7oi2vGdjAZQ50?=
 =?us-ascii?Q?wjHOqUECoBCzg9LlWTGf5zvKSy07ckcM7pX0gG9WtlzFBeNQKZzZKXj4xFx9?=
 =?us-ascii?Q?o93/t6B9EY3Hetqe5avbhppwPDLxfcV2MWU/LGkav8pLyrrTJGaNIfx1hvu3?=
 =?us-ascii?Q?vz4aNBeXWKhuzNlVWUJBmD+H98DYP3puu9BukSL+Mh5cFMQ6evo4nwsJk4lB?=
 =?us-ascii?Q?hm68QzveBjBqOUz/TnHRjCXegIc82B3lDy1HwJzlArnDre/Vflmh84kI3NT6?=
 =?us-ascii?Q?irNolNqRfOOh2qgfehG5NFu06fD6eWYcFrzZGBFvy6yYGb0eIB3FRgFCk/71?=
 =?us-ascii?Q?xTnNv83SAv7FDgXS7UHK3Y1GVe/oHcMmwg5wfGT+Sk0dyDhhBMDhCZQrnraJ?=
 =?us-ascii?Q?r+aEckTVajgcI5mLOCHBXta8WlQSjvSvHZNhlXRS9p7WD/VKex68IZweieeK?=
 =?us-ascii?Q?v2GZUYJCLpxMdGZzFIuHs4kLbDfskVsq7VsKEC1H/iHZB64SyBoyLdNHXibB?=
 =?us-ascii?Q?QQ8XGN7pKmnRHs8VXoRFBJjpxGT9MskMjzPnykcKAmJzOFt7j+Zp/maNFXI/?=
 =?us-ascii?Q?a80cf1Al0zsncHSo4/cZ3X79UOF3LqmDtTu8z/UmC/Xjo4fT/VaRov2LBBFJ?=
 =?us-ascii?Q?+XtiQn1N7CkVH79Se8ubxf0ODKUVzN36LmIeC1QHVvUBt0P69O/VAG5XCTrI?=
 =?us-ascii?Q?5/BLiRrJAmtxMvmPSY9IqqPs9oZfW1ukQZpS870JcsdaBGEJFQBfc+5lfLjS?=
 =?us-ascii?Q?gr5h9Z16yWuNM1CsaWasuZZACcYIsBEAosidttjhXozUKswjDwxmYe+zL4Pq?=
 =?us-ascii?Q?/dZV5RA8d6IG4lu5Or16w1CwF8zG7HUgShtRx8ssv2TUA8z1cIlgV4orczxy?=
 =?us-ascii?Q?zwgJbYbpB60VNih7dfVziibTHrcnRvvosM25aGYVMe/hNvkn6HJgqxAQEPn/?=
 =?us-ascii?Q?AhEzN0UPR3seHYvskkgI7pwtKB4IF7koehtVAnBXeV2pA40qj/pv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44c07fa-c92f-4013-00c7-08deaa0b6f50
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:32:02.6056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ks9ibU0ZDdaUrpWvb428KkpFFXXRujFuJihsFGJvgwa7mPyWyzCchj3HU9iOKcbgU2qYVy1X5VR6ncZ+U5KSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9779

On Mon, May 04, 2026 at 07:18:49PM +0200, Arnd Bergmann wrote:
> On Mon, May 4, 2026, at 18:46, Yury Norov wrote:
> > On Mon, May 04, 2026 at 10:03:10AM +0200, Arnd Bergmann wrote:
> >> On Thu, Apr 30, 2026, at 23:13, Yury Norov wrote:
> >> I'm not following that description. Why is it an error to declare
> >> a funtion that is not implemented? Isn't that how optional interfaces
> >> tend to work in general?
> >
> > Never heard about such a thing like "optional interface". And git grep
> > tends to second that...
> 
> I meant any library interface that can be turned on or off

So? If I disable CRC32, can I use the either_crc()? In case of that
networking header, the answer is yes. In some other piece of code
the answer is no. Is that correct?
  
> >> > The only header requiring the crc32 and bitreverse prototypes is
> >> > include/linux/etherdevice.h. Thus, protect inclusion of corresponding
> >> > headers in the etherdevice with CONFIG_CRC32, together with the only
> >> > function depending on it.
> >> ...
> >> >  #include <linux/if_ether.h>
> >> >  #include <linux/netdevice.h>
> >> >  #include <linux/random.h>
> >> > +#ifdef CONFIG_CRC32
> >> >  #include <linux/crc32.h>
> >> > +#endif
> >> >  #include <linux/unaligned.h>
> >> >  #include <asm/bitsperlong.h>
> >> 
> >> Don't add #ifdef blocks around headers. If the header cannot
> >> be included without side-effects, change the linux/crc32.h
> >> file instead of its users.
> >
> > linux/acpi.h does that like many othes. What exactly is wrong with
> > protecting headers inclusion?
> 
> There is no "protecting" here, you just add complexity to the
> build when headers are sometimes included indirectly and but
> other times are not, depending on kernel configuration.

Sorry, don't understand... I use the 'protecting' term with the meaning:
the functionality that is explicitly disabled should be never used.
Otherwise, what for we disable it?

This comes with the cost of increasing the config space, but that's
how it works.

In terms of build complexity, I guess that the more you disable on
preprocessing stage, the less a compiler should actually process.

> It's unlikely to cause problems for the crc32.h header, but
> the acpi example definitely risks running into circular
> inclusions when you end up with some other header that depending
> on configuration ends up including linux/acpi.h while also
> bring included indirectly from that one.
> 
> >> It looks like the problem is the check for CONFIG_GENERIC_BITREVERSE
> >> in include/asm-generic/bitops/__bitrev.h, which ends up
> >> hinding the generic___bitrev32() helper without need.
> >> 
> >> Simply removing the #ifdef there should avoid the build failure.
> >
> > OK, it seems like this is what I don't understand.
> >
> > We've got an optional feature, like CRC32, which is enabled by
> > CONFIG_CRC32. The most conservative way is to declare everything
> > CRC32-related in the corresponding header, and then protect the header
> > with IS_ENABLED(CONFIG_CRC32).
> >
> > I understand that from practical perspective, we can declare some simple
> > macros, like header size, unprotected. But what we've got now is a sort
> > of mess: all CRC32-related functions are declared unprotected, and
> > generic headers are good to use them. Compiler is happy while those
> > functions are actually unused. Next, CRC32 depends on BITREVERSE, which
> > is again unprotected, and it may optionally have an arch implementation.
> >
> > So if arch bitrev() is implemented, you can use part of bitreverse and
> > crc32 APIs despite that they are explicitly disabled - just because they
> > are implemented as macros in unprotected headers. And you cannot use some
> > others - because they are implemented differently, as a real functions.
> 
> I think you trying to solve a non-problem here.

This was reported by Nathan for tinyconfig. At least x86 and s390 are
affected.

https://lore.kernel.org/all/20260429202922.GA3575295@ax162/

Is tinyconfig important?

> It is extremely rare
> for any kernel to be built without crc32 or bitrev. Even in randconfig
> builds, both are usually selected by some driver. The behavior
> we've always had here is that in the rare one randconfig in 10000
> that hits the one driver missing 'select BITREVERSE', we get a link
> failure with an obvious fix. If you add the extra #ifdef, it gets
> a little more likely to actually run into the bug, and it shows
> up a little earlier as a compile failure instead of a link failure,
> but otherwise, nothing changes.

Except that it fixes the tinyconfig build.

The above argument sounds to me like you believe that CRC32 config is
really useless because it's enabled for any practical configuration.
And the same for BITREVERSE. Would it be better to get rid of them?
Would simplification of config space overweights the bloat of the
tinyconfig?

On the context: CONFIG_CRC32 is pre-historic, and BITREVERSE is 2006.

Right now half CRC32 is available if CONFIG_CRC32 is on, and half is
not available. The bitreverse is the same. If HAVE_ARCH_BITREVERSE is
enabled, one can use the API, bypassing the BITREVERSE. This doesn't
sound right to me long-term.

Whatever this ends up, let's figure out a consistent solution please?

Thanks,
Yury
