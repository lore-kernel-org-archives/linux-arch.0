Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012027.outbound.protection.outlook.com [52.101.53.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996CC218E91;
	Mon,  4 May 2026 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777913204; cv=fail; b=gc2QuICXDLnBa0famGCtyzX2j0Z+PHvwyhimwBQ8bCHE5HSS8nLLLMY7pscU+Ya+Q7+knPXnSM/Cf8POLAAKyeBF054TQJLyuV2/U/MOsPPVcMMZhiFNaVqG+DP+n/qaWFsiCo5uZo6L5LcTXjL+mwvDZCwdggY5cOudC2a40jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777913204; c=relaxed/simple;
	bh=hJmGNyG1AyuN/jn4sAM0FDaxToTj3Xc1OUjQZBEvQPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RhaM3R9YrD/eeCUM8IUviXyYvsa3YhxuhuC4y7e6AHAv/PBGGglKHn4ktqWdfXOOxrAaIfmsmV3XwEiEVhqi7DjFbZ6rFCMWoSoTz5ThnplsmWicBF3otI8poHlUZWgD/hZq2rGQQHvL1mNLY/p9Wl3bon5+LaYMbTzOzgp4QwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JUd+Ia5i; arc=fail smtp.client-ip=52.101.53.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JUd+Ia5i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUxpyL1mzNlgYbiSIr9+Bhr+mxbXjeYt0uyMjpYZXkRo9mpisxseUDtUO9Dbj7VbJv7EyNj9QdstWLhi1/Tqq94KyBraDsyr5lDGvXRrZiqMTmheLvwjLmpatoCZpvlUkVJbYSh4AYhlO7iKprqbdP+2+JyXHyMjMyLpD2GxFycOx7P8Gg3RGqociP64DaagtZLSh5nnaLYgwEhaN2Re9cq6Pqp7zNrcqoW/AZpt4+UwDsqzrkIA2HeDQiUn1EnmK2xFFIQDkUj3kq+yonNcua7Jh7NTp4OHaeE65mHY+7is7ty+uXXtpTkcUjZh2x0p01t8/Qt8s8pChWsRXOenYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHuERGd1sK4CdydouUCBXL5vCSbdgoTx8VciQd+tgP8=;
 b=oNX5fwtiCGJ9/yVUM0hEKJ88dlmbazsfpXoZavdE2NN/MQ8QsKIeRy6nftJOIm2p57arVSv+OyD/Zkwa7mxJtcUcOQQ0e8m2W/AsZZKNzmdxwI951i4wImJ0rcofUJTq2Wyixib0ydJSA9JH8nBOq08aUxCIJH54zNkv4BNUiINufqHOvVMKkcfhehph0rMeJniTZdy6mTBtTyc68WF1IjpTFZSTJco4eaD/xgRuo9HX3wVeE1U+jcryeH77S9yFWGASKzeU2rsqB2zETug/VDYNa50Nf7w1j1RII89DwTAdCNsUtbuBz4S9bqgRwR1U+VEnmGdgZ8nOx/z38I6hGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHuERGd1sK4CdydouUCBXL5vCSbdgoTx8VciQd+tgP8=;
 b=JUd+Ia5itdel5OXuVl78KMBgBCWZmjnylBybRYsDW9Yb43++0rUT9GB/54InWcgGnEaepJRBEEk8keZDKahwyY99OL1rjdvxUxk5taC13BMm+gU1CGbmmwVwWLQKPi9MVeNQ6qMk472aowSigRFCBaRYqAgKWpFjJIUE0cNIGuaV/mgRamS1sNAyCqJaHETev1YZQq8/JgcQ+JbvSGolb5CsjU3CC6nyGOCeFBb7phjeeVu8OogvYwA5VFxsJcnZPTXBuEZwMsofIygMf72w5s5mYsW+ujFd5x2wl+Uwh75mIqv6KHoKgTlWmwcBJrxWdMjIFMBufPG/Jq3+IPlYIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 16:46:35 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 16:46:35 +0000
Date: Mon, 4 May 2026 12:46:33 -0400
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
Message-ID: <afjNaToyptiMogV4@yury>
References: <20260430211351.658193-1-ynorov@nvidia.com>
 <20260430211351.658193-2-ynorov@nvidia.com>
 <ec4ed7f5-b1c8-49e4-b83d-e29c5414b9de@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec4ed7f5-b1c8-49e4-b83d-e29c5414b9de@app.fastmail.com>
X-ClientProxiedBy: BN9PR03CA0978.namprd03.prod.outlook.com
 (2603:10b6:408:109::23) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a27bd40-65c2-4216-10d3-08dea9fcb43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FaZ9sRedoW3ImLrwx0HkiodscazAtwnekX5u6lKKuZ4N4E1pz/OCA1FaWWeVrAtevIzuFxNH5X5QLMiiPz5xUC9chVNbj7xGepByzxcjaJx1FQPzU4GBrKS6I9uFPZivEBxKJn29dHSY59i8dLaw0lXSNTu0r8i+MmrHpyj1QyF7bRIRJuGEjPaFmVPGbq/jeCIdM6FTywXIxoOv0KZc4bJwPUtIjcHa+OpQjKjls7paMOPY09wqMJHixxEGPW83inio3RcJZdP+YELHUciUcJgB+z5enbW7RaRCBPT4LPTQ3j9mZUK9ZVsiLqSwd6YOAqeZzu/5CF/fzL5+sOJpewVUL0jwc5G9wqkFtqn25MhSqfmCJoqVDc3c2uSkQQPJ7DYY9Vh/v8+0d8OpgScrdhMjOxpEuFdHa5UsyZyE9GjhVMpfShHpv8gkIAqk0ShTfPNdcVXjVpV4L4GSGn9Uy9Dnxak2lbtznPOBi9iEC9uqw7KhKFhxrkK+c13se46ru0+YKXNH699RVs+K/X9YJS+RMfKW4GDJQjZw81L8FT3cwtWCxKFeY7RxhJ7NRRy9loXwIyC3B+DLkZN6vUpkxCgmrKOP5o6aeZMSfMXjfLgnMMdOpwUhgU1CT0ggRP7BSTNBhkQ464RbGAbWOFjS20sm4I/B16fB7+gXdbZNgCw5vaIQBDsDXczqfM/57mVs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S/0c4CyBAIC8r4lJHinFy1JC/Af2dne4JwPlJ7fQj+o4s74+TStVS1DdcgbP?=
 =?us-ascii?Q?3hBssJ4xB2nENMIgwAnkHuRHAG8tLjiTpQ9vdIp9jvxDNPfZXbn0PIj4+pk9?=
 =?us-ascii?Q?AKCuSCVTZFI1oz+7GFOJ+1ouvCxOSojoQAVZbwfOzAXIULshKbXO0j3JNDWa?=
 =?us-ascii?Q?QlGqiD+QUDoaviSshW3Q2Ha2gBzJBS1C3lciq8MB3VeC96jTdXlMV+VSUtx9?=
 =?us-ascii?Q?R+IyOV3mBq0NrbM6V0K/cJCa7aOryGAXhun8XD8qNRj7OsF3TJlcVv7coxYF?=
 =?us-ascii?Q?tzVXnG0Ci5p2sTGbK3fgF2JmRP9lihMC+qP/aATV+sQxVQm1oKDVGqFLyurM?=
 =?us-ascii?Q?J7T+RrO5nvbNtPnmScwkehCGSHkud3CTt7BXn5Uvh/lXUm7cUsfCBu/ScdJv?=
 =?us-ascii?Q?QJ4QvKaM3XT0cQ/ob4iB2AB5PHs2zBMNmxNo6iY34DCJu6NlJKMk6lbEZTqb?=
 =?us-ascii?Q?O2txobyG5GDigFIVp78zpufYqPtr1Do5PTN0jtLiwZ2jvLg+SNC1c5F/LfSN?=
 =?us-ascii?Q?0RV5LD2zn9exZqhys1aJpteg9p9FdbLRCgdTQTR5osyqB1f/qJ3PQHH0kTLW?=
 =?us-ascii?Q?ozA8wDITNe4eRvALClpLDovvuMmdhbzHfat5wkwgfr1m4C5T0IR5aHOUoyhe?=
 =?us-ascii?Q?eokKWA2FezxnTqsyFC26/2nmGfOiXUXaHRcLqAKR73oUO98QwlutifTPTg2O?=
 =?us-ascii?Q?5K5yg6sx6+Fs1X3AL3Cp9U5MS4Bu7jz+6zRbkyOZz9C5mxEcakd2+nnMFVmr?=
 =?us-ascii?Q?BqLQq/DsHpnu4yhQNVaFr7n/1ZnlsiRrjvfcqerqKkWW9alrZUXGnrDaBvZF?=
 =?us-ascii?Q?OAMZVxbK8C2pXNCncrbbiYvFv+zMRRbFOm6mGFb6vBcjXM1Q6IIQeQA2SLg0?=
 =?us-ascii?Q?5kT/RoWZnj4vlh4/6ghY/Y3430dkl8rbLvFQnQvOfXtj4QNAnEBfk+Rwwnyz?=
 =?us-ascii?Q?wv9yYA3Y5mBg33ZMleys3nD/dIYoeAm99Cft/4sQ3ZHDUqrOlPBnJMCICzy/?=
 =?us-ascii?Q?pK36DPFE7VnBMiULvtT3XcgaqLm0ex2hvQeXMAhxd+Iuo8+hjK31y93NY7G7?=
 =?us-ascii?Q?Ll/rUz1TcyFNOiiZ/6AzfonTAcDDWRtNA6vMe1hzd1zXBSXS843vdCkOxueA?=
 =?us-ascii?Q?+0OHIXacI9dfhGxytZxNm3eTTtHYPqmoy+kqkRwXROltYb4qsZDKMPLJE4DJ?=
 =?us-ascii?Q?W0TiZBh6eJdPYDySTY7FJgDu9qc7nxm9QtDEDZpimlHgk119IRGyp46lkEhx?=
 =?us-ascii?Q?SwLlj9LBVoHXtOOxz+7nBpMtx+hjC3wOC9UqkUsv1g0wuuoH5s3nSNeQz+ct?=
 =?us-ascii?Q?TslwNWp/2RQWaklGxUWpsw+8CpZN82map5LtD6/fcB89aX9WxAGZ2JsmPK/k?=
 =?us-ascii?Q?S/uXIbXAcA2Tk2HHod450OEhDu0XLbIEmfNTv70f2dCfzATKfA4xaqKmWYqk?=
 =?us-ascii?Q?wxsW7JWOk29wH8ezU6aZMZDductwnUUSf05Xy8qocZuQY0Lg+NZU0pu/BXO/?=
 =?us-ascii?Q?pwbvU+CDSID9gVYhvHUrLGurxahlDvs6eRw2ffhV6GvD7lCrykkspOChvW0F?=
 =?us-ascii?Q?iWU3gmUhNrYrET51KyUtgdgr2fPOtQCY1JKL8dJFHSc+vbDEg7ic0C1D/N98?=
 =?us-ascii?Q?BDozNYTWzwlqdwgLGR5JemVrniA+JVUlP61fAztZkyVa7oRdrdto4HO9VO9V?=
 =?us-ascii?Q?JSFC44vMT56CXoTXYhTA+DfkV+6i++XIiRzOp50Kh39def7fe6Si1MwWCDuk?=
 =?us-ascii?Q?6lkfgMOgOIqPB+7F2g1dMQEaA8lMleHll9S/fv1SP6CoBWCgG3bq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a27bd40-65c2-4216-10d3-08dea9fcb43e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 16:46:35.6394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Djyr6J6L+VC2xMACqmD4nArtqyrUHGPwYB9QIX3TMBmBwQZT7vYXDFUwYYHQPcnm24TemnhUDmflTfviiEGqLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972

On Mon, May 04, 2026 at 10:03:10AM +0200, Arnd Bergmann wrote:
> On Thu, Apr 30, 2026, at 23:13, Yury Norov wrote:
> > Currently, bitreverse API is either declared based on
> > CONFIG_HAVE_ARCH_BITREVERSE, wired to arch implementation, or if the
> > arch has no bitreverse, based on generic implementation.
> >
> > So, regardless of CONFIG_BITREVERSE=n, the corresponding API is always
> > declared. If that happens, the functions become declared but not
> > implemented, which is an error.
> 
> I'm not following that description. Why is it an error to declare
> a funtion that is not implemented? Isn't that how optional interfaces
> tend to work in general?

Never heard about such a thing like "optional interface". And git grep
tends to second that...
 
> > The only header requiring the crc32 and bitreverse prototypes is
> > include/linux/etherdevice.h. Thus, protect inclusion of corresponding
> > headers in the etherdevice with CONFIG_CRC32, together with the only
> > function depending on it.
> ...
> >  #include <linux/if_ether.h>
> >  #include <linux/netdevice.h>
> >  #include <linux/random.h>
> > +#ifdef CONFIG_CRC32
> >  #include <linux/crc32.h>
> > +#endif
> >  #include <linux/unaligned.h>
> >  #include <asm/bitsperlong.h>
> 
> Don't add #ifdef blocks around headers. If the header cannot
> be included without side-effects, change the linux/crc32.h
> file instead of its users.

linux/acpi.h does that like many othes. What exactly is wrong with
protecting headers inclusion?
 
> It looks like the problem is the check for CONFIG_GENERIC_BITREVERSE
> in include/asm-generic/bitops/__bitrev.h, which ends up
> hinding the generic___bitrev32() helper without need.
> 
> Simply removing the #ifdef there should avoid the build failure.

OK, it seems like this is what I don't understand.

We've got an optional feature, like CRC32, which is enabled by
CONFIG_CRC32. The most conservative way is to declare everything
CRC32-related in the corresponding header, and then protect the header
with IS_ENABLED(CONFIG_CRC32).

I understand that from practical perspective, we can declare some simple
macros, like header size, unprotected. But what we've got now is a sort
of mess: all CRC32-related functions are declared unprotected, and
generic headers are good to use them. Compiler is happy while those
functions are actually unused. Next, CRC32 depends on BITREVERSE, which
is again unprotected, and it may optionally have an arch implementation.

So if arch bitrev() is implemented, you can use part of bitreverse and
crc32 APIs despite that they are explicitly disabled - just because they
are implemented as macros in unprotected headers. And you cannot use some
others - because they are implemented differently, as a real functions.

And this is not covered by any written rule - just the implementation
details. And to make it worse, this all is available to drivers, which
may simply fail after the next kernel update.

Can you please elaborate on how is that supposed to work. In my naive
world, if I disable some feature, I'm pretty sure that my kernel
shouldn't build if I try to use it. Can you point to any related
kernel docs?

Thanks,
Yury

> > +#ifdef CONFIG_CRC32
> >  /**
> >   * eth_hw_addr_crc - Calculate CRC from netdev_hw_addr
> >   * @ha: pointer to hardware address
> > @@ -291,6 +294,7 @@ static inline u32 eth_hw_addr_crc(struct netdev_hw_addr *ha)
> >  {
> >  	return ether_crc(ETH_ALEN, ha->addr);
> >  }
> > +#endif
> 
> I see there are only user users of this function, neither of
> them are performance critical. So the other options would
> be to either open-code this function in the two callers
> and remove it entirely, or move it into net/ethernet/eth.c.
> 
>       Arnd
