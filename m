Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F565379ED2;
	Thu,  2 Apr 2026 21:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775166593; cv=fail; b=sndgsPHyn3F1KnwQAayEbjo9Hd/6WHtaJCaXxU/IMXKSV5ZoZ6hlMHI4Hi2Xdhq3P6lTkg1cx5NE49vA9PcZ8JjJFSNgC+DzZmv2x7q+3WfFTSlPfRqioGk/Lmf3i70xLNDVsUZDQnTh3WxZ0cd17Tc5T1iQHhJbsEy4ElC4iro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775166593; c=relaxed/simple;
	bh=j/SXI0Mcfgoj95BKSnpT7xUXpA7ZHJJWynsVgR9Vgsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C1A6q8KA+N4UcREN8bPEYxMEvqcojGHQzgY0kReZmpSs+34635YCziIkFcKmrhXYILoqYsL/uOosCAKXuVVuAoY6Qak7XfKiiE+Zmp1lTGXJ85Q1SU40zrY03xkcNyNrE6x5/i6afeKqrmKXr+UToJyUyHiVsWpVAUhU538cD8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bf51jM64; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bf51jM64"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCVkdKu7nB5xaBQbmn+l3Rcg/PuZZAocA11Mn0StyaCsEhbQqbYZ3Cvq39trQpiQAjHs2ChfRmq3HebTCgPJGXekGM2831raVn2gqh8eelG42YgFRF7NA3eu/dEEwjLVBdzjtg0VUFo00uKdfHJ2bdMETC3UPuM2wak2iYxvsnvgPvVBY/ya4RrJTwAipYjJE58kjImmqPkBPArhk9qderiCsiPyFUsjc6XK8bPqNFO1O+4bdR49FxdaUI3Mjo4uHh70CKj5iglcCbFz/HePhLoGYCwY2B/PV4J1PQcdDCr71g0E1PBIknlyeRKRabklClxRX3E+t5hqb7Mfo8uSag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooAk5Yysy0lu//HLVVNmodnDqw7SNKXJYicM6Db2vSE=;
 b=AER4Ij+miNkaV+N8SqsfUJ92pmR0PKl1LRSgC1qTl+kkEGHed/V6PIp7NMi/aYqMXZ4PkNZOqfCb/GeTtTddWj9U6znRpzJpadog+ulP7cmntSPxp37OyNkjwN8VcBHyTlNWEvNdva4ZuxYLo/MRZwZOs5752CuUoG0mN4dopaxgHLP/vxNIJoanBJMfMfQ8W9PAGMkAJBYNsqDhCXrLXd3XI271O1phH1m54aCGN2jm/KbuSbQE3u6juMi+rUQyjyIEwX7OptdcH8GMH9vZ2CtQhtQwwYcvUwsdGZjjRuEmZFTB+KWwy0OVNxMC2gSWOTvGbZ/yNTHT1TyvmGtlVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooAk5Yysy0lu//HLVVNmodnDqw7SNKXJYicM6Db2vSE=;
 b=Bf51jM64zpJeff/I/KxXUVXHbVJOKpqSxUi/rsd+VWSzYntPJ5ktGzHzDPMTFetXTev4EoA3ZcIrf4YK+641nhgiC+M48TdLkxncEQVC6wGT2dFpD11cCntcJLPVYvBRoPsSzWui8azG3n/FyblRcLkE3eBDgn3OqzfSbjcNZts7HtpM8PEDX1ExiSTxtfl4uRV02Do+oktNJbrOA2vVbzrsiXGIWshys9wuVNXWDBnR432tZJgy9spIEwaBA4pdiOlfGi9g0JI9BDHDBeuzRrD+YwO7MeunvXtk5KcSOzuGDkqDh2KCDGIxHkpkYTN+UsPmOq//Y/Ky0/YrHZtEzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Thu, 2 Apr 2026 21:49:47 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9769.014; Thu, 2 Apr 2026
 21:49:46 +0000
Date: Thu, 2 Apr 2026 17:49:44 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, Alexandre Courbot <acourbot@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	Eliot Courtney <ecourtney@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH 2/3] rust: sync: generic memory barriers
Message-ID: <620eaaf3-0569-4633-afd9-74ec18dccbf8@nvidia.com>
References: <20260402152443.1059634-2-gary@kernel.org>
 <20260402152443.1059634-4-gary@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402152443.1059634-4-gary@kernel.org>
X-ClientProxiedBy: MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14)
 To DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: fee3bf7c-0852-4783-340e-08de9101c1b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2lHenOiIyjSsRSEkdcmZPeAM36ssevvDOLElxcLcR1kAQiwu2O7FXRYYdcq0MgFCZ+Gy4B0kNPOK8RjoemUWFsNLEggrmnuRBMkF/X2IrMJpDmsYt0QcZasvyGkm5/awsy2BEnemUwROI9HHYRiv8lI6Q4Z5hjhoFsFnPOfUWV9YVTIz06ysHRIlgfoyOBY5t6zp2acHCGBGXBww7ryHFhgzBN4zoemlhiUw2OeYC3JoPW/y9albHkw1atImyuuGUNeu1BcsLIWKWAqx1umwMDYcjz1KdUT+ZwN3YKZ0sSlWwCxs5L0zDn5us625CDD3pRr9Nzvz7Y6yYd3VNkOiuReiYhtt80jhWTvcnHNq9vcatmM3e5eJRPiDULEAc+3oe09zrb2rmBMdr2TtTEoxjivK4uAm++G841qrFuiowe2YnaTn1OsI1yBTcN2Yz86jS/gOXiiEPGDcxSlbAw0Fu2e+Sh+ziuCQJ+yjPURV2XRDmntHySUhFqWM8OjLotVApYSU31eA6SdHOxJKuOtQW/21htD2lqJhIjxpgMAuDjmLl8Sc1h7knrFG4ee0JYJP9dyjxjOHSq/AK72fDlzfAKOCQ4Xj3m5dvO3GMG/pgsp84RBkyRR0SDr9eBvzidVZ6qmNMCMWU0mgMyemeHUaGmAo3261UnkcO5KJxD+b5cvwmnhO+TX78IEWmkKX8pByR93OG3z1olZJKEHucK+DRHdkWyIayNqNLv64vycl6OYUYlqujArAAHXBYAuBNp4DZQB3LLAoY0kdvVzEhu9c2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aHJpOJ2XxcvP8z0ORSm0CED573Taq114XdkMrq4tWwrAKHKdsC3nF2o5kFqP?=
 =?us-ascii?Q?ZY+WhgeIygDfjk379zfXd0kemCaQPBiTASzYM9SvNQSHT2gX0M2iLwJK3IUh?=
 =?us-ascii?Q?qkBqRu2CTEA43XfmbMDbho1/EfCnSQ7IgCpC7Bq6JHWQ57PF9DkjUcLtgZ7v?=
 =?us-ascii?Q?PWYzD8KmXlO45rXs2UNIEMdojsJmDwicJ6hpp0yp+48rMRh0MSeeUCoxlkfp?=
 =?us-ascii?Q?Shwvs+AhCUZq+sCzDNSawuzNH3O38PVmXmu/6k+y/9evv6UeeqlxNMsbT2gV?=
 =?us-ascii?Q?zOTCrvRhGEe9yBaX4xsmU+W6uWccEpi0bI9D/urqN7Kvy++fl/oiybidSRd0?=
 =?us-ascii?Q?RD8ATY8/+LDhauvrzrDIUrSflhtSweZg+REkjo0CKDZhbzHr2IJ+bBklQ2k0?=
 =?us-ascii?Q?LaupdJY/X43bSYZu9rfwng5CEHU8bh4LyYQDmYHahhEZxTu74RyNndV49RXL?=
 =?us-ascii?Q?gOMPNWkTECIisdaM/4wNOuKfAcYkLOe1hyX4jxyI0TgKpnewLg502/MbGcrw?=
 =?us-ascii?Q?zCA1ijX8kUNmk8HeeqiMV+rMDg+NRFfe7/ZFsUhAizp7FvxcgARFV09KutfW?=
 =?us-ascii?Q?y1DTEBCOITxbNELu3MnbT7lKFjtpNNC2QZuiiXYq8GUcBmw10PACQl23XLMt?=
 =?us-ascii?Q?Lwo6TfH8gEiAggJ59M9yrhCe/RveiHwfmKNDc14EGegTbT3L43NfHEWYqWSk?=
 =?us-ascii?Q?HpuS7vp4KViuFGYIsrlvkSb75sx1RMNhEJrO2Had1tOIfN7T3Oo27eZIgWUj?=
 =?us-ascii?Q?Hgjz/3vehIvsoDTNW8nw8s6WnWKr3iVRL+WkGtBrAIZytLFJqzM66VB1oynm?=
 =?us-ascii?Q?Bs1BUGUIIjIbWShJqZgpQUqQTkIUvpTusKEtqjZ2je/GKd+fQ03qIlcwHfSs?=
 =?us-ascii?Q?DiTLzrVYrNQa6AsPMQKJDdtr7mzlVzoDAyDpHzwlK02Yyr/1PqpTqU9zYPpq?=
 =?us-ascii?Q?ZzPceFClOl4f0ChbJEC9kwQfsyvs90PVrk+MCdh42+QkVvHmZ0InH9twlPUI?=
 =?us-ascii?Q?zBV8GOxxWRHa7HOHZrgBWla/+8yLzABFl7HZl874KVNs73lj2NZ02QfzI/96?=
 =?us-ascii?Q?ZJe7jqhWZoqm8OiMkRc8GDJ/7GgsF21D1hKeAT0dsJ0rsEWx0f34NdiPs3Xo?=
 =?us-ascii?Q?O/Rpy1BLlfWpEJYYJsECJ30W90bwmUgANpOJj4HoSIKqwZGwWns73kpV2ibt?=
 =?us-ascii?Q?ACWl52pWOAWr83Au5Dq/I8xMg1i6D4/pmESDNusSFONVDircq6kELIVwA0py?=
 =?us-ascii?Q?CZcql7HjS5l7q0Z2n+epsIi4gF9IkhbWsRyVg4k01NvNn9nMyn7mtiGDEnHx?=
 =?us-ascii?Q?YW7TYCUWV8WQg7qQ4xIx7MNBhKQ9gom7DonXwIKmM0bE0opy2+h3q/CFPGAa?=
 =?us-ascii?Q?nR7YsVqK5/vNMIJww19UFbpNom6ZTcK/8n2+a7W28YaZRqqXyr7+pVy21S6A?=
 =?us-ascii?Q?D5i+V0YCB0c7epRkBEsuWbnf1aKI17CUHFCPlSjnKfXu7EcyJRVVI+bp/bR2?=
 =?us-ascii?Q?FyDRWB5I+Nnd47MVBxYoygE4f2LHOmg2PjfC03fouFjyestJckPGtkmADBz1?=
 =?us-ascii?Q?/btTjBgKJy+0rzmw46LW0WIQyemfIRr7YBUZfO77FBWQCIz4v3IBP6SH4EAz?=
 =?us-ascii?Q?t3VULjSveXVRZyEDaJ2obbB+WbWFj4eJqq1eaoobznp0/gplQJ5XW0ZRkzrp?=
 =?us-ascii?Q?/cP+rgKjAlkBWSmg8VEcECDCwEd2tP3klWDx5XUiMpQD30sYg3+xfOphO4RR?=
 =?us-ascii?Q?FU1TmZc4pg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee3bf7c-0852-4783-340e-08de9101c1b2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 21:49:46.5793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSG9qU3ooWvjm9rwXS5oa+EG5aicRWIKIt0Z3a4YpIsiFSejsfGdgQYBLFykaW1r8LmyXXe5FkJPM6De+lwKgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806

Hi Gary,

On 4/2/2026 11:24 AM, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> Implement a generic interface for memory barriers (full system/DMA/SMP).
> The interface uses a parameter to force user to specify their intent with
> barriers.
>
> It provides `Read`, `Write`, `Full` orderings which map to the existing
> `rmb()`, `wmb()` and `mb()`, but also `Acquire` and `Release` which is
> documented to have `LOAD->{LOAD,STORE}` ordering and `{LOAD,STORE}->WRITE`
> ordering, although for now they're still mapped to a full `mb()`. But in
> the future it could be mapped to a more efficient form depending on the
> architecture. I included them as many users do not need the STORE->LOAD
> ordering, and having them use `Acquire`/`Release` is more clear on their
> intent in what reordering is to be prevented.
>
> Generic is used here instead of providing individual standalone functions
> to reduce code duplication. For example, the `Acquire` -> `Full` upgrade
> here is uniformly implemented for all three types. The `CONFIG_SMP` check
> in `smp_mb` is uniformly implemented for all SMP barriers. This could
> extend to `virt_mb`'s if they're introduced in the future.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/sync/atomic/ordering.rs |   2 +-
>  rust/kernel/sync/barrier.rs         | 194 ++++++++++++++++++++++++----

IMO this patch should be split up into different patches for CPU vs IO, and
perhaps even more patches separating out different barrier types.

>  2 files changed, 168 insertions(+), 28 deletions(-)
>
> diff --git a/rust/kernel/sync/atomic/ordering.rs b/rust/kernel/sync/atomic/ordering.rs
> index 3f103aa8db99..c4e732e7212f 100644
> --- a/rust/kernel/sync/atomic/ordering.rs
> +++ b/rust/kernel/sync/atomic/ordering.rs
[...]> +// Currently kernel only support `rmb`, `wmb` and full `mb`.
> +impl MemoryBarrier<Smp> for Read {
> +    #[inline]
> +    fn run() {
> +        // SAFETY: `smp_rmb()` is safe to call.
> +        unsafe { bindings::smp_rmb() };
> +    }
> +}
> +
> +impl MemoryBarrier<Smp> for Write {
> +    #[inline]
> +    fn run() {
>          // SAFETY: `smp_wmb()` is safe to call.
>          unsafe { bindings::smp_wmb() };
> -    } else {
> -        barrier();
>      }
>  }
>
> -/// A read-read memory barrier.
> +impl MemoryBarrier<Smp> for Full {
> +    #[inline]
> +    fn run() {
> +        // SAFETY: `smp_mb()` is safe to call.
> +        unsafe { bindings::smp_mb() };
> +    }
> +}
> +
> +/// Memory barrier.
>  ///
> -/// A barrier that prevents compiler and CPU from reordering memory read accesses across the
> -/// barrier.
> -#[inline(always)]
> -pub fn smp_rmb() {
> +/// A barrier that prevents compiler and CPU from reordering memory accesses across the barrier.
> +///
> +/// The specific forms of reordering can be specified using the parameter.
> +/// - `mb(Read)` provides a read-read barrier.
> +/// - `mb(Write)` provides a write-write barrier.
> +/// - `mb(Full)` provides a full barrier.
> +/// - `mb(Acquire)` prevents preceding read from being ordered against succeeding memory
> +///    operations.
> +/// - `mb(Release)` prevents preceding memory operations from being ordered against succeeding
> +///    writes.

I don't agree with this definition of Release. Release is always associated with
a specific store, likewise acquire with a load. The definition above also
doesn't make sense 'prevents preceding memory operations from being ordered
against succeeding writes', that's not what Release semantics are. Release
orders memory operations with a specific memory operation associated with
Release. Same for Acquire.

See also in Documentation/memory-barriers.txt, ACQUIRE and RELEASE are defined as being
tied to specific memory operations.

Or am I missing something subtle?

thanks,

-- 
Joel Fernandes
