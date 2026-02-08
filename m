Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013049.outbound.protection.outlook.com [40.93.196.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBDD346E7A;
	Sun,  8 Feb 2026 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770585651; cv=fail; b=ChQcw4yiz7w6pXsQWJlVvNcn3SGU2YbPEdVZj6AxYWylSdzttWb1j2HCFaUO9/Jp/p1qzs+4RIindBHbKxezUTRTWCKfIY0AzIhb9jioZ7ZYV8gdtiX0FMVTHPdyj7zK8i3NvSW9NqIk6cC0yiAtg6rD2PWAT58UXCCJ/38qlPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770585651; c=relaxed/simple;
	bh=O5x9xBKiDNSv96nohoerv/NlIRJipFfu/2XzgJ2qMQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tr5ME3l/HA+5yKKs3rrsx21kR0q+WMMYT4hYrPUEBe9wWpDdAw7pBxWE45Fj7mYm3az3wX4VYOoI76q0a8nuDEJqn86U5ZqnFpMhX5MyMKWBdOd1RRO/9wtmcQATRP1U+Tqke1tRWmW9T3/YeXhCHRc+IwZmuGh71hP6cNC+7cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q47EnYnC; arc=fail smtp.client-ip=40.93.196.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q47EnYnC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGN6eBo21G9VIrpZQUa5PX9X3kjxgw+XFadwdJ2/HHo+C8k+O0POl6D9aEGbUIXkawpsNW9V4Q10ZBW92Xq5eXCWiXcxNyL8GasAmdhjiCDHI77JXIGO7LXVKSM0oGl7mzyF2jVh3NcwpIlvPLi598Nu7GjJB89zNcUF3G4+QYxS1+URIytTnxvD5iMeFt42ego9itOHZettgQI6OVkpwgSnv5/0oH3ygPj65Lvhr9QhX4p1NV88lwOlEyPVFavglvXE9RqJ+Ttt7AQpPgAXKyDYrwTHpAis3uEXPxk7Zk1vmNkZ76nuije9qtij0k+y/vIta0oR7tUws7X3PZ+aaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnnKYcnrLCN0r4qkR5eHXNWYZXD1jMmfhaNF1pr/QCw=;
 b=F9wpodaHFsQ3yjDohjYwlTYN2/T7tmPg1Z5csck1I8smv1zrsLyOjMUd3jF9gNIfncqy2ahPKuQZvZelanlvneGsbhW+OB9vMDV404IX5oVC44K/c1i08oRVdxt7RqOUeFfahJOESXW1XrYvgChg0nR5+HTcYkEON0PiYkklJI7oNCVz3XqoLflskD8+Pc9sor/KA3hOUZWwgFQ5nVggoHHABqgzaLMw7el/CkaXkR7mA17hVClU6V5+os6iahnEEFFQErgjNiV7C+hGrNx0ZSq6sxO32ZKKycg73lbRWDRxil7P/Ovz6vi5dNH0z+Mo47fVboCz74C3eUPuM6OPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnnKYcnrLCN0r4qkR5eHXNWYZXD1jMmfhaNF1pr/QCw=;
 b=q47EnYnC/o2DIfN7gmvHmQIFdSDAz4fhUQ5Psoc0OmqPhAHueGH7d6jsyBY+IBhhgotNHN5v0rYq2hfRA3Lrx4O04C0M3BWbj+toHNXp1Co+ddYVSCwLvuDtV6KYgazrTLikF1m51pltgVrKTTNtt3TUdqrnp8Fr46iv3vGC6tPZ70+aNXcjIO8Zqa4Z7kY5nUDxUQm/tK3dgoHNpejtU13RuAy2kaEHvYQ9VpKUBGga/yu0nysZsNVCWM14M6ItSPoxheAldkFo9NuYNWVzA3Y8NTvbF+v0v+Vthw9Aqh+Vc0cnm01Q2/WDcs+9q26xd8q4q209X3aVECMioSTSDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by SN7PR12MB8435.namprd12.prod.outlook.com (2603:10b6:806:2e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 21:20:47 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9587.017; Sun, 8 Feb 2026
 21:20:47 +0000
Date: Sun, 8 Feb 2026 16:20:45 -0500
From: Yury Norov <ynorov@nvidia.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next 10/14] bits: Fix assmebler expansions of
 GENMASK_Uxx() and BIT_Uxx()
Message-ID: <aYj-LdTWwvGLJP4O@yury>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
 <20260121145731.3623-11-david.laight.linux@gmail.com>
 <aYgDlpdXWqYvj3LN@yury>
 <20260208114214.270b4982@pumpkin>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208114214.270b4982@pumpkin>
X-ClientProxiedBy: BN0PR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:408:e5::22) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|SN7PR12MB8435:EE_
X-MS-Office365-Filtering-Correlation-Id: 132a2d20-ccde-4d7f-937a-08de6757ed0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xGY2rLW/vCEVqSYfJUKqgMIeHpjnowSQ0vehJvX3wHTmzC1OmREuJEz6pFyR?=
 =?us-ascii?Q?yqDvBB4bfAPVmhOW/nEPOfCbUbVGWmHPD7r9mOhLgmx+z5/6Qb4GQ0yhwukZ?=
 =?us-ascii?Q?gd3mkuhJhP67si4ndRTLAFu84tivTUvkLBCFyBCRt1ZgNEOYe0chCTPoF6LQ?=
 =?us-ascii?Q?ZgTsZCqrw0uks41p/4pPgf/skzMNxrGugtVjuHwQAF3rS9LLBj0E63FRg6XS?=
 =?us-ascii?Q?gnnU3l2hjQ4fFreFMgepuGyUYod84U0V+5xlDHrwOKFooHrjM8z2GGbs2/j6?=
 =?us-ascii?Q?8qDgTLIorA8b6HZCuEhna6ybmGoVPLrIo83YpwrBPqRNaGE2vx0/1zhzhO6a?=
 =?us-ascii?Q?Ddi7tO4v3jXn4c18seEtM9wppZRm1fGZZcgEwKvS3+jZwn4y/bEvAK06T5PC?=
 =?us-ascii?Q?ecDs41mNHDLvljSeTTi6gw/xtOwHCVMJGVXATxJ4MOH1WgGjlbPgeE90oa/H?=
 =?us-ascii?Q?XNczp1SbkJhglinu4PcxzEbkP6fWR/ocYfBbKOjWfHrPsnoGb5xoIhh+yXb0?=
 =?us-ascii?Q?vJuVxA6XEhJ+tTlSk53gw/jj6+qvfpKdn6U9KwBlobQ17tKN8Uwx7RNjknlR?=
 =?us-ascii?Q?X5kRn809U6IRxKbhA2pIb3eCT18s+SI/VhZW/MtSLZAKnmoV75F+bDUll6iB?=
 =?us-ascii?Q?Vu88Ude5tScNDgjb3Bfzk+NDkCG33nemYf/m+oEcpRsF6bF6N2zVNhmgesJw?=
 =?us-ascii?Q?r84zQlH0ZOyPF+44pIx2kiPdyNeAFsbnYAFy31LVqlcZeLMXe9EeMxQxVmqc?=
 =?us-ascii?Q?yPySrHd7ycMtk+mGzUIOTENjRyS6Lx5zF+4gUG0qa/Mp+Wp0mp+Vj3zktmYz?=
 =?us-ascii?Q?SqqglIzjQQAvkqtFyXaPeuFlDOuEIWsUbVAHYG1kZRgMxHSRbC8laIRpexmk?=
 =?us-ascii?Q?vlx0hxp1zH6Sy6mrcAlDv7NPLt9rhpO4ivS5ymas0VUlHjvUOfwqt63Gb/u4?=
 =?us-ascii?Q?RAfiKoCaZSqwjQZTE76mD2E8FaXz4TObCNLz10Gsn3sfcDxry58tiP6h6ZGi?=
 =?us-ascii?Q?UK79OgDtrsqH3upPq/JO7b8WSYu8Wsr/L2hTOGFt9M2oaDctHlRB0q5NxEr2?=
 =?us-ascii?Q?R2F5vKbcdDEBw8Z5OtfJjN37soKgD4zCsjbq3Kp8C2bV8oO2zTIm8+77xWr3?=
 =?us-ascii?Q?BGkdQMRuSQWRAJ9RrSEatbgtbgjPAN+sryltV+Hkfg7cj6JmkmDlMjAOwSDI?=
 =?us-ascii?Q?hg8VAUh3mluzxMQvaBnUGoMPTVlPB72C1YXNtNdEShLxX1nZoXdO/WY8Z1np?=
 =?us-ascii?Q?OL5oUPQbTX0NeqCSN4Dz5CllbeEEQYJLkc1/OcbU06FRo1s3p0Mhcm52TnVX?=
 =?us-ascii?Q?tXaqbCNoG7cjtDCJDe4YLJKUpTdU+l70eXuEIYY50gdEfRKLhoO/ImGtP1Tn?=
 =?us-ascii?Q?/tE+rs48kP4iul5u+iuprr5Do00tSd8odsDyPIOmLu76O0A4V83XpSCzo7iq?=
 =?us-ascii?Q?VtoCRGfFLCsS98dLg7HEJiBNGTihVkto57NdPYoBaybFtgCeZMU/pOcVRT8L?=
 =?us-ascii?Q?Rrw3sb/y5XKYi0Mvp82AlOck4mUQDsLnNiJoPpeAt6mjYc6ETu1mSLWbVrFc?=
 =?us-ascii?Q?XU6Jn1ojD+PF/2aNERQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2y6Tv+4Pr0woja+F5xnQ+bUaSAMw83QoUB4Hhed80sSqqmZonw4lFb8Ay8HV?=
 =?us-ascii?Q?DpA6Fz2heywrpCNwiblwKOVEfmLNdUKh0onBycQ95Cnha0vmLJ1lB9w4vlna?=
 =?us-ascii?Q?2mL1iQFbStGX/3yTsV5wwO5lcOaWslGEPjGyfPsS1WGyhw0HmPixGycCy/Ps?=
 =?us-ascii?Q?dLD6+ObrTN7Mr4fjDOtqw+2RVatc79Xiobl36hM8NCG35ynChTUrPFq5LaBB?=
 =?us-ascii?Q?ykLHeeFG99mz3RlRaBtYV53PjsPMDvvW7S58v07ox/L9jGpPOdGbwxtRtggy?=
 =?us-ascii?Q?2jEyb8nXXSMBMPwqlB4SJ91X91EsyjRPxob7Xo33hR2dPCSZVnIZ56SCzW4x?=
 =?us-ascii?Q?UQBnfA1V9hUXL/hbDCqCE3aQ+prPrZ0GlTjfxuOQdkZCMLuVJ2e1VgHFvldp?=
 =?us-ascii?Q?1H+iXsjkrDWrnuoZ2u8FTME4XaPPmCIytPL9W7MuY2TY6THYtLPtzEBN7N9p?=
 =?us-ascii?Q?HHrk5sVRKVZnogwKDZq4BtRTo8/c6UGVoxehFUm7C2NMNPK1DpJpIyfQkl8k?=
 =?us-ascii?Q?0pu9apot2Ad6xjx0VlIf9cFltwss3R5btWFmLW3YvNPzfOW49+4wYAzoqnoK?=
 =?us-ascii?Q?MIAdcTJfnoxxAKzYX498BHltAx//W61eLzvTY1Mc9K0GnWE2yZ9d4QLecry2?=
 =?us-ascii?Q?qrz/CrIk0+Z8cZwnEY+Mp0vSrLyYrzySM+KfOLoArmS/QHJN+syeS6RjrOnp?=
 =?us-ascii?Q?dxz3uw4DjobRtbLMIxxUA5mYnbEVu1VGtDs/Wr+ucY1zosRrsdrxkk/mPSqO?=
 =?us-ascii?Q?Ha0fFkH2OdiA0Mf6KJdxa8Glayx1SkYGawyBnj9T11T2uxUSr1N/Nr1/hA8/?=
 =?us-ascii?Q?HRWUAuniuKQ9xRwFhl1VvBLEaFYcgXFYkkdOAH5CnZj78jeSnMKkJju0dSHh?=
 =?us-ascii?Q?6tBUFqRaiebi7rhPHrF9CCyy6b5YkTz6km1mYEFz7LSNZ7fXOqzvjvDfGNTu?=
 =?us-ascii?Q?WvMYb9hnPsaAiFKfO6c4/36xBFIuqhkVvcVL5IWfgBtjr33RwRWkpnWtRdf9?=
 =?us-ascii?Q?ZxnzH5WYMcGj5fG5jj/Tv2F+UGvEn4j1J/b5RsIDfQh8hPJBKmbSNeHYys5r?=
 =?us-ascii?Q?whz6SYmJmrIm+HEmaN+f+o8O2FMOQ8897G1TJU/6Su28WBESvxJB1G3GndSa?=
 =?us-ascii?Q?MOC6qxGOUIjThdQ733PYwv8X6nMsrbPGRP4IPXZ6GguKi1oxfGGuPzVXqDij?=
 =?us-ascii?Q?bDsc3qX3Xhg55S0zkoN7U0yulQv+4LsBcF8PIWTMoaykBwchGJAyc8C070xA?=
 =?us-ascii?Q?OZIKK3NMv37yjyEwTyRBpycr8VKdl98AgIQtZqzVwpW7PJm4HFNzB0yjM9Ad?=
 =?us-ascii?Q?V+Bi44OeDTvaNmLloLvpbVMUHsTW3LCF+RZObIygO9hS0Sf4V5BCRLjROaAk?=
 =?us-ascii?Q?QGW6ZOXssyq5Fi46EMHTwzr3lVhXkv+V2OSKKTiswQBCWT0kmUhe/A9cra+v?=
 =?us-ascii?Q?JKbho6CVMIohqGSRRZgDKHKULNb+OQBE3TEA4Re7a6N5G2jTGfVL9OGQiD/+?=
 =?us-ascii?Q?AMS61qMXmsK2i0BM5Y6bFYDKjCI8+J1Jc1Vh+NKyYUrFJVPJajwlFjP1wqRq?=
 =?us-ascii?Q?HhWBBOYGD2ODDV04k19qKfSbjhMAs6LiuKaBum3wojt0FY2zXnmkCnEtfeA0?=
 =?us-ascii?Q?GQFLbZNVoxbcV6bVYj3Pk+O9PWE1i3q5jknOX3IoEo4BtcIkS8FwmPqnuH1n?=
 =?us-ascii?Q?VY6ezYKM/oT0wcINF8A2Q08Dp7gxdMninJ8jA5tBN6+41n20hyrAC6+IJxv5?=
 =?us-ascii?Q?jYGBOX77eQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132a2d20-ccde-4d7f-937a-08de6757ed0f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 21:20:47.1853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQGceMCCoBTk3ouLZvYzlsAJgnaRqvgZ77BGfcTww2LMqR7fa3c0ldE22MWSo7w2uqQOu9RcV1eSj5oSZFS4EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8435

On Sun, Feb 08, 2026 at 11:42:14AM +0000, David Laight wrote:
> On Sat, 7 Feb 2026 22:31:34 -0500
> Yury Norov <ynorov@nvidia.com> wrote:
> 
> > On Wed, Jan 21, 2026 at 02:57:27PM +0000, david.laight.linux@gmail.com wrote:
> > > From: David Laight <david.laight.linux@gmail.com>
> > > 
> > > The assembler only supports one type of signed integers, so expressions
> > > using BITS_PER_LONG (etc) cannot be guaranteed to be correct.
> > > 
> > > Use ((2 << (h)) - (1 << (l))) for all assembler GENMASK() expansions and
> > > add definitions of BIT_Uxx() as (1 << (nr)).
> > > 
> > > Note that 64bit results are (probably) only correct for 64bit builds
> > > and 128bits results will never be valid.  
> > 
> > And this important note will sink in git history.
> 
> At least it isn't only in the email archives.
> I can put it in a comment.
> 
> > > Signed-off-by: David Laight <david.laight.linux@gmail.com>  
> > 
> > This has been discussed in details when those GENMASK_Uxx() were
> > introduced. Assembler doesn't support C types, and can't provide any
> > guarantees. It may only confuse readers when they see something like
> > GENMASK_U8() in the assembler code, and there's nothing on behalf of
> > that declaration to enforce the limitation.
> 
> It won't be in asm code, the asm code will be expanding a constant
> from a C header file.

It can be included and preprocessed well in any .S file:

#define GENMASK_TYPE(t, h,l) ((2 << (h)) - (1 << (l)))
#define GENMASK(h, l) GENMASK_TYPE(unsigned long, (h), (l))

    .section .rodata
fmt:
    .string "GENMASK(63,60) = 0x%016llx\n"

    .text
    .globl main
    .type main, @function

main:
    push    %rbp
    mov     %rsp, %rbp

    lea     fmt(%rip), %rdi
    mov     $GENMASK(63,60), %rsi
    xor     %rax, %rax
    call    printf@PLT

    mov     $0, %eax
    pop     %rbp
    ret

In C this doesn't work at all as it throws overflow. It doesn't even
work in asm volatile section.
 
> > That's why we didn't add fake C types support in the assembler. Unless
> > we find a way to enforce C types capacity in assembler(s), let's keep
> > those macros C-only.
> 
> But GENMASK_ULL() was already there and would generate invalid values
> (for small values) on 32bit.

You continuously repeat that GENMASK_ULL() generates wrong values, but
never submitted a fix.

Anyways, if you think GENMASK_ULL() is not needed in assembler, it's
even harder to advocate fixed-type flavors.

> The only reason for defining these for assembler is so that .h files
> that use the definitions can be used in .S files.
> As soon as any of the BIT_Unn() get used the asm code is likely to
> try to expand them.

The only reason for fixed-type GENMASK() and BIT() is strict
parameters checking. This is not possible in assembler.

Thanks,
Yury
