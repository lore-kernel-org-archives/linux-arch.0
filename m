Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A406F2F2;
	Sun,  8 Feb 2026 03:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770521501; cv=fail; b=FKBxkOdOMBvHClg9fpy0w/bcg08BTM8DFMRbOC6afelzlOH3xVx8WZnbzz2zuRy8IR8AgyPPHPXaCqxrjbaRZxSJJEhiQWYV8xgy+jvROHGEn7Z/fOS61T8j1eV+HWhNG8bJbitIyNrF6sf3ExaVmKR4SVk5Bbp8NwJLF5MxVGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770521501; c=relaxed/simple;
	bh=p/gaqREU3WeOHipiFgAPUiJMEyoaXaP6CXcEFGPgN5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DudKsEwum4LgO+T5kOzkb2XWYjkxBxoUXqLSTcgKhtXgqPHwHi74GelKLu697y2syEEsKMLp8uKvFviS1f+JSFyHN41V1Cqg/DEDos0KFzmpSVIyNL0MfEvjIj4ic2jpiozkvuw4r+MMgXumR/5SttOCKHpopQ47xYsAPkeLDVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mN2MuIxh; arc=fail smtp.client-ip=52.101.53.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mN2MuIxh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FX7IwIBta5Tsw+ihhGfdjwfentwYtbfEdCzbEJpAsiAK9b/RxJrHCuA3U2amL9jHyrOtEdNTsSuSE9WfnMiPyXj9lUQFh1ZWne59hOdrdEM3fa6MZgECr12IqtjuoyX0szIqi577v8GGpnEN9Z42NDdXsPaaPfTSX1ThGW6pAGF46lqQZpqbky0NyPBLywjLzwk/Y2XRvX+zWDl8P9NuVwNJHDvUDn/EUhQvjN/5ESjf68C2zKKr3FTiAASCVX0/0rzh7+il5PllZu9hDCkFc2JudohsISQD9yg9IA23JcgW2TgMMq+JynJ7pwgTPdWXbawhFILy7NfCnhKN1GW8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEvNB3tSSWXAELkbvL3ZX8lhF6fFUqzQ8cRnZMDOd2g=;
 b=JbYCjzByZVaLvVCd5RuwY5cxMoPtmk8Cf+siILpfhA4/P0uuEY+DctTUk2Jn5o5GQ88VupCXv9Dps/BmmqJiZLKoGziDlgGyHrIs05Ukt1nXQm5gVioa8LKEApyBYpmD9pc/6hKnqBK5JvoWvLcFTecpyXOI0nyfYTYxjWXbQlicGQtxTd6eTXddxmgJZFgCmA3SlerlLomM6e281Jwi8Fk1UkPmHK2ANj7ySQEuH620SYof5t2J2OJOWgTrBXH310r0unFVYDuJgXvV7SSAxAAzpsfuPTurMQN8D3qYg0HUP43mMQiJu6z3CMAgC0Ah+YptzpMLnvGamCSRjGwfUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEvNB3tSSWXAELkbvL3ZX8lhF6fFUqzQ8cRnZMDOd2g=;
 b=mN2MuIxhcX7X0ZIR8k2jHd5GrRgF0Dl0phADhdpa6LgGDf65fJnjCAKJOiHMZvZA7tFTIMDDnj4KkUoEZEW2h1LndW1iO+Nj+ap8JKlycv56p1nNXV5PlHqLcuAXIKYygDy+cr1xFg7Hd75y6BKX+9pdGSKioJgNOTll+jSQHOmN6Zwl36DdNGJ0qqei7BSNkDHfb7iFBT7wuOAO6TV7iMmGYb1jUeQj74H0mfEJXSQNkQty3N+0HZ8QmEDomVHQtw8bmnFYQVZyhY062G3/G5FqSJBH1vpBCs81YPunpEFncGS5YYuqyrki79nysRg+dRGeo3PbfRPs8K5P8WhTpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 03:31:36 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 03:31:36 +0000
Date: Sat, 7 Feb 2026 22:31:34 -0500
From: Yury Norov <ynorov@nvidia.com>
To: david.laight.linux@gmail.com
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
Message-ID: <aYgDlpdXWqYvj3LN@yury>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
 <20260121145731.3623-11-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121145731.3623-11-david.laight.linux@gmail.com>
X-ClientProxiedBy: BN9PR03CA0550.namprd03.prod.outlook.com
 (2603:10b6:408:138::15) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: e05a5163-10c1-4c9f-7d49-08de66c2901d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5SYVflRlA1eRQXh5/+7nw5Dkb9xYASooGsWAEopAe1VEs6mrG6vfFJCqIWSn?=
 =?us-ascii?Q?bBGQxtcLEJ/MGyfn+Hhbudx/Mf8Su8hrnVYGMTCJdMrMWLT7a2+7LpVlv/45?=
 =?us-ascii?Q?RTPR0O192GTMwMNqWg/idAjk5yBBRpvamXM0KK7bkX6eYstpgqotCsqwxChL?=
 =?us-ascii?Q?llZuhwYV6+ys3JUfvVbaelZlVGmtAysS5fyVh8tdpUhim1P77hWgm79IhWAo?=
 =?us-ascii?Q?g0Rj/3lEJskxs7HVJLAlBte0YQB9PcHitZDF9RAxBey5VXFBMkD7NQjZ3Mnp?=
 =?us-ascii?Q?GoMJ0ovZHv2wZfh0v5x4xj836c0SBH/MXLilfOyBsFWOefQ8gLgoTucgvewl?=
 =?us-ascii?Q?9lCkuG+B1FQb5h1qZoalRb8jM/QynF4HuiUpMvIhbAV0oNdZqbIV7VV8IRTa?=
 =?us-ascii?Q?uo8yflGGH8EUwbfK5NCgqRmBUNwDcHJqktQb2QgaDmp/J2RUheLvuwfIZPnE?=
 =?us-ascii?Q?oZWsHHTSSb2LndlEWsiGjJcarBBCTe8Mv5oItT8rlp4waK8AAAmoTHHKjUvm?=
 =?us-ascii?Q?hYs11AUK/ciS0I/zGRaNlNbzPp6Ffl3YftPAAT9w+/dotvYzgjiFpWOzQxG2?=
 =?us-ascii?Q?IdGAH9FwawMdBcLXBhdahghZlzvdUD7AzbafsZXXhUT6sGtzYenO5hY0rseo?=
 =?us-ascii?Q?L2V9QlYdUX9T3aT5BdSUdzpAwCKAz/gNSKMc1gM7XKHSFdJTUXoazak4cg0h?=
 =?us-ascii?Q?NhQLonXXyj/3ccaoPh2JkYg9thZVRwCQbyMai22MoTUjaJkOQuMET2AqiOeC?=
 =?us-ascii?Q?OBamu3WN2TqWsONV9cThErH3e4W7gypPMY6T0gURnqryKTafdAF/SgwFNDcR?=
 =?us-ascii?Q?O2W6ugfMowShw/MYx+8gOpNtkU6SQmIxSnU8WJEUEPYyfJpmRg+OOjjcGLAK?=
 =?us-ascii?Q?EYXTZejkiNQs5QqVaq2nlXoAWbDSXGmVDQaiAsDTCZa7JLKur1CGwYzj6oLd?=
 =?us-ascii?Q?XOmvjTGCqJ1ZTOvLnBg3BhBo1RaW1i6kECBlFc1w+lf3PeUwwYLQTSzYv0xc?=
 =?us-ascii?Q?vTXfbTrjnqYhG10Yj6MqYlU8CeFlYjHy5oaaTMWEKQO2mh8b4wjyOPwndG+j?=
 =?us-ascii?Q?rKgm1Ly1qJq7OFy0RKchZ8RwYoSHvQNl6MrJxSCv1oF1A0yDeNN7yVM/UjDP?=
 =?us-ascii?Q?GQXIou8prZXlNizJaIlb+kZUP7b4lPvBK+PSSRA+Lmbqh09jB0mzmq/l7v+U?=
 =?us-ascii?Q?RwzqFMMM6LVlARJbKTTjsi8wkBKItPa5MJRW47U0Q1++REzQS5BvHHzsg8/Y?=
 =?us-ascii?Q?AHElqmhLzVH39YapCzV7ojDY6AR9lYFFii1WwyW4kSYeHb3ntkJVWmAOwpMZ?=
 =?us-ascii?Q?gulV1yyyEVRpG2InAQr0JOM8SjfiylmK6ApGRziTxd7BLW8BUno6U9J5UBF6?=
 =?us-ascii?Q?7opeT4mVfcmmEdOusnXc3SDi3Hhb4juZw2cstW+7bHUTSNfIUGE6gLi2vahw?=
 =?us-ascii?Q?qidMRTTWjRJA+AcRK0kIAbknYoAYFtkZCI2gQJyM2uymfOLQDRwS3TX2+A1/?=
 =?us-ascii?Q?CNpPmlmMn7KYSIYWkgLSDLhTSoNlNq0iNfeFS8WQjb6+AQepTfBpHD7hZTi9?=
 =?us-ascii?Q?/iumlircHFpPokRGROI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aEKZDrbmHcGzJxjAew1OtjRV25ztIkd/ivmwUZ548v2f8zl0mfRnnPrPASkV?=
 =?us-ascii?Q?djlM+u7iIUdwRzD8vIrGyKrOjot2WZKQUAWPSlND/MMgePPmcFdR0ehpWuBS?=
 =?us-ascii?Q?3SroePgBaCkRXxTCeNG2YPr4qpMyFEmGsrIWdO8DFVChMk8XfczHjYX4p4k1?=
 =?us-ascii?Q?0iU4mDg87NylVTeGAXWgXhugdZroOvq9ITVLHA30ASvA7hX8aajDR01vn6+3?=
 =?us-ascii?Q?KgfGtI5Uz/RFNGWRIqY9xMlA5/cwrAG18KeCZUMowaevWjKvwsV02oefflWV?=
 =?us-ascii?Q?6TDp/KW7kvdr56WZrSAVAr6gKiBa6Ge7dKUccFeotLBCZ8wNiu6n4lRTxS2s?=
 =?us-ascii?Q?p3BIT0H/9UET7IydNcfQngAc3jQeDWrbpUKtWoIA+NWslb+GjGX07cF+va0j?=
 =?us-ascii?Q?I0ygkkOcKYVuMkqUC4a0medZk51aW5XfuFaff+cw5sxAz0Y9kxmEoAZiixPO?=
 =?us-ascii?Q?0htCGMOdGMEcLNCzfGfQmEMIwVY154wDg8dG1vljP3hjtiSEHazufPdQOOoF?=
 =?us-ascii?Q?cWne3bMS1chwttdz9U085YHNlSSfPj8R64KVHyih9Hx6y4ETSTa+xaXLZXtU?=
 =?us-ascii?Q?GuDmhEV+SEgZt/hqMCSbdXB1WmiFKwenYFcNKN3HvPNRlDmqKavnluGwANPH?=
 =?us-ascii?Q?FbHoqjleVKDTYCN1J/dPbr9lqustYWA0GRzUJ6MTJOA5CdB2evkTxM4VnGUc?=
 =?us-ascii?Q?Rlmb5zWMl3pmXlawyudn0xMucNqY+F3+YWb43UzHkFsJKbaruaYDu2akGD+H?=
 =?us-ascii?Q?l0N3pqddAOSFAA0Nx4VpVHL1SZmSUnbFKrz35hv+oacG34qcWqjw3KAGg7s5?=
 =?us-ascii?Q?PA/eITY411G5EXf/QFDvH/qmB4Jsxp9P+RqBZiUvFdfGy4XC6ZbynHAjekaj?=
 =?us-ascii?Q?R7kEfdpvPZsSDJujKxdsqVcUsTMQ1BN0WIUYtsTmznlJCGc2+7OBCd7VhZns?=
 =?us-ascii?Q?UGah6yGzNVjfIRBTKN4pAeuz8FVhwWq5GNKh3IZsVz4dAozGP9/AQe8bWdxa?=
 =?us-ascii?Q?Dy/1nbhxbvFvT4Q9GBd9G+CMiMvKYGGjwkVLzyfkI9vi7JSFN8wHwmowKfAs?=
 =?us-ascii?Q?0kMSt1nPXNYVLRC82QNZV5kzD+5lXTICqjDi7DR4Prlcs8bd9HVyIX5nRUkH?=
 =?us-ascii?Q?2Ljbod+NXztcP/em7LXSmlgDkI9C4Ui61MiH21PColqTNOJQxlxlYimvZNC9?=
 =?us-ascii?Q?1I9KpSVuHj0Rqanh5KA3aUJbHXaYtxq0+G9BXe7cWzU+ic07akG3ktT6n7/z?=
 =?us-ascii?Q?3HSIHyJS+p4VAqVAUFh3RNll2U+nzw8l3TTB+VXwGuIdb4+uuDcVtaz/OhCM?=
 =?us-ascii?Q?foNs2fmx/WcXSfKrhoHexN+rXbEHwr1X8PWfxyRrz7XpGeXO/qQP+Usss5k1?=
 =?us-ascii?Q?0R7yZlH1ZsfarxH0U7+UkDBihY5z5zdmy0vFu7UJWPjYDvVs9HVVmCgy6nq/?=
 =?us-ascii?Q?Dy/bghYt3CJv0tm+gS2DZmn1zolmyrEdH/N3SX3JxaZlGYBDtAyz4GdnimVD?=
 =?us-ascii?Q?W0kz0eu9gscIlOF3tpm9DwwBKCvbYwz2wPN1Uj4hzbuBLx7NYPPNjMeqzgTV?=
 =?us-ascii?Q?c4fM64+R+tvzm4mCY2PQ5tAf54NZ953EvlTluPeUVBmefdQT/GxDV5BmMrOp?=
 =?us-ascii?Q?Mo8CaUwRC0r+S6tFXDq2RVEDXNaPBfiLccDokqliVJa3oxNbO+awJexVMK6f?=
 =?us-ascii?Q?lZApcAYxd7X3xwdw3FBw7XC9g+B8+ILVfl+k4h4qBhXEvBX0dI/W7ROeUelQ?=
 =?us-ascii?Q?AlG5QNNTCg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05a5163-10c1-4c9f-7d49-08de66c2901d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 03:31:36.2215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLViPThocyWb9LpCYhudbhQon9F36G2xmAYqrNJp+10UXCNDBM2vfi5MPMAOj8+MXh1692iJx+MxE+9/OEdjxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940

On Wed, Jan 21, 2026 at 02:57:27PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> The assembler only supports one type of signed integers, so expressions
> using BITS_PER_LONG (etc) cannot be guaranteed to be correct.
> 
> Use ((2 << (h)) - (1 << (l))) for all assembler GENMASK() expansions and
> add definitions of BIT_Uxx() as (1 << (nr)).
> 
> Note that 64bit results are (probably) only correct for 64bit builds
> and 128bits results will never be valid.

And this important note will sink in git history.
 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

This has been discussed in details when those GENMASK_Uxx() were
introduced. Assembler doesn't support C types, and can't provide any
guarantees. It may only confuse readers when they see something like
GENMASK_U8() in the assembler code, and there's nothing on behalf of
that declaration to enforce the limitation. 

That's why we didn't add fake C types support in the assembler. Unless
we find a way to enforce C types capacity in assembler(s), let's keep
those macros C-only.

Thanks,
Yury
