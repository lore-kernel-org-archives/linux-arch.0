Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010046.outbound.protection.outlook.com [40.93.198.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D824C3C65E6;
	Fri, 20 Mar 2026 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774020645; cv=fail; b=f1SYh1it7ePAUte0aC3W5a3niacVbZ8C0QYlWcoH2uXFe/NfJO2j4liZNTPIerskcp30JB0rN1Ez/xoDRZEKhrpmxzX+DiZy5Gu+Gl4Mmab17eDGhXHbrMFKVELGELO/aUuFTKsangsw7zp955HA+fQ08JXeleY/lw5kdeVtNO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774020645; c=relaxed/simple;
	bh=0oBy5GI7p6dt16JVkAe0jN2ehlrglfyKARnCEpUm/ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C/pV8HmNn/zzWlP7nEfaWmQ3Wcy/yMWo1Ka1yo9/BK0h5SXW9QSZS8mDwKUJ6NoFfEaQxS8zEbdLGqdKRyY5bW36RRMVI7Phtnx12YukmZ3ReMis26paqTznBfMVxm4ciLoFTRS8yA8PEBy2RU1PI0io8J5sJHYWEDbQ21D4BWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nQuLiOao; arc=fail smtp.client-ip=40.93.198.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nQuLiOao"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOG3got1E+eWc9FtvPW9Vdqf6TNLFXo7Q/Niiqu5Wf93qV6pjGWGp/D121+I929om4QKv/Ffg93Ma6DS2+spg8Aw9/SDpPeEznJacDHpNuoG9xV2C08Hrv9zCYLQOHxrlLYq4/j3MTw1mrTIMz3qw9vIPE0eRv1oEppWID/m5p4E+sEGT6SFx/Y08vESFIr12VW/lg3gwx9qDVkSsXX8mLdrmAuOcTQCj/ap9Y3ePwRltN3MIy+MgVlHNNRELtMjL9qsypPvCi0aSwlxGmWnNIqxln1M+La21BMRHN6cvYX96/BAiHolVgOK5nG6BUHfWc41iQk6yfmHsqV29Ko8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16ESS4KjxPlpCqLLAvbl3QVmliKlZo2WgdrF/MivP5I=;
 b=FzOMXdqlhvLpMLbkTa/PRWrQ2cC86gsdrmzZtdg1os2xs6G6csCygMFDy8sThMAZfGdA0gAmnmUCU5j6hvlTnmpG6tdwa5IV3GMBWau4Qi2lrn20vu5FTA6SxiYJPFt1NxQNoKRmIvjElNvqnY1LMMiaJmwo9NdaPojE4fJ4fJ2So+TCVas7lRETvTMRxXJgjO+BzkK1UxxgSJ3T5bF4oZi6sqQXJr/y0n4UGXBqA1RsMBvW8HpcnzgW4sJh7Zx3/BzEoBCyKwbzEFmhtQT3IhPB+GxCQArR9ZsyU3qW01+YX+cTOAHzv+iqfDMhnoQ6dYmtt1H13lnGe0bdzmOFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16ESS4KjxPlpCqLLAvbl3QVmliKlZo2WgdrF/MivP5I=;
 b=nQuLiOao11qqmggNOUay/xDI80/SI9tPmcKx5TZNpwKB4dWiNpqn1kwvrnp2V0OXGUsROGBHhBQp8BbUalZuziyZTaF0nyFMkA63q/oYTYnl0c3rWmfSoLfjuJSF5nZeII0zYUqpMUJBHr9rTQeOOry8ofV0uSKXDJSirRmoPlemqbRAcuyTsVPAlueJ5rCQwhFwNYPgqzRbFjLAeoZsFVQmRvbbF9EDkwmxxkeAFN78rhp/mu3hZSvHaHzPrH5ZgWnsx6MKQr7ty3W2E4yI7n0QruvLwie6JE6Z/UJG0jlnPDleTkAV+vW6HWbdCtJEFmu2fa/vD7vGPSkGx2a1nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 15:30:37 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 15:30:36 +0000
Date: Fri, 20 Mar 2026 11:30:32 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Kai Huang <kai.huang@intel.com>
Cc: yury.norov@gmail.com, linux@rasmusvillemoes.dk, arnd@arndb.de,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic/bitops: Fix a comment typo in
 instrumented-atomic.h
Message-ID: <ab1n9RP14FS6kdSB@yury>
References: <20260320075938.289189-1-kai.huang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320075938.289189-1-kai.huang@intel.com>
X-ClientProxiedBy: IA4P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::9) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a65e7e3-4daa-42f5-f6e3-08de8695a1df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5Y7CzpdERxHgMnZbA/AV8Xiq/oTf3O3jWzrsrDlV+LXeM+55ZaLeywAAyML+KEOxBL1wVVORn9yXL1zl2L0bywnKQ6W3xOw3EpXjyCVHi6FVuZ/FQSeE2e/ilsZIJCZMXDY526YZu6CPN4+3ZEiBt5O9KJQsmY9186BBHj63FJcMJ6SwqS5NGk/4iqOGp4XvLrEHgmw3pceNGSL/7+YiSzfICA+sjqCqO9JcUniAjOBMscTfJitb5PkUL9zP7O2HiiQk0kl2F5L3/l4FgX6VNZa6a2kbK+iSmzzZOhs9QYCt43edxKNJaQgD1nuFm1ekHMuhqwafWceupF2lcnbQAT19NE+TMx7TGXpUDEE93M8hAi1eyPJ4o42pJf+0C2lJzL+HmWdE3jN7FrC0KPV9MUlMLYMYPmNQbEYiQsF2pACIj6QBOVWThUjMjvvznjcAGJCBcmVpBWp2KXVBa9tc5i4k4PQwbWGGFW4RVSxkC+zc5XIwsJKMprrd6u08cCtW2TEszs7r361rsoWUrTIKei5/z8eOtOjl9n9LW0U2eW4COMBPGw358nujQoZWLWoYEFgplmRFqocm+pHiFPHjhHjft38/A6slILVbKbHBM6dNehzaD3/pK4lurwHB223ibwsNYk9w/f3Uuy6oSo0E1DYSqOoqIWlgjfPbcjTf0k2QSrbJibEOprdKV+YicAgsV2c8Slqo4QNgirZmZsAI9l9TyegscgORvS3s21PdaxY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eMpeq2DEQlVRBEL19eoBs8sBQi+SNfrJ5dxKIbIz3gO4rPWg1SJtcSopEGhi?=
 =?us-ascii?Q?pDdck2BUbOME7tnDZQfDFWT0Hiig/FiVMTa1LpVZsIs0nm/GhEpA12kY6ZTa?=
 =?us-ascii?Q?qkvJLUt7sShUPTdThRkq5HdrTxespIEzdgxlrwOD5PA+GyonTZryCB+XhHPm?=
 =?us-ascii?Q?b8GQO24+KuY0SfSMpvsmuu/JJWk3JxAKwy9Qm5kMnw9AtOWJjD7N83x1DgUP?=
 =?us-ascii?Q?kjoS0PlC5VhDGitnu+liyXHsk0IPx97N983hUGAMYq1b1VYXNnmOzeYLMwWq?=
 =?us-ascii?Q?YH8eG/sTBXl+PQK8FfBS0tDV69MszyC7yG+lYjF+zui+dO53BrGKpI2PrAZL?=
 =?us-ascii?Q?TJQJiDWxNsINDVu9+1oEVaJvAJmEoXrb/2rffB81jpSBsqORx7AG7hU9C/Lt?=
 =?us-ascii?Q?SuQdBSInYiV07nd227aFCow6omMg1/vOYMFW1++aXWnWjdDKldOdPhKFRF1j?=
 =?us-ascii?Q?8GvN7uRC/CgJAbkAdBqnEJWSjjAu1sC8ZsIuw0zpnZRe8WzM29BoOkFXLljZ?=
 =?us-ascii?Q?81gbikRgH7DA8irzte/cjfiVUWAvn8e3IEM41oau1EDKlb1Y1MGOjce2mnlb?=
 =?us-ascii?Q?sXtAJG3AuAEB/et0XpbK+cFZHyjCofcA/30b+yzRcF/74Ev+iiJb4xWHEXSq?=
 =?us-ascii?Q?M9bVRhANI86PPi/N8suk3o9bXHOF+w1h5gDCpt9k5NPMPUXyygjjAr3hKy4C?=
 =?us-ascii?Q?s8lvnB/fksNROGkeaT5pEnDXVosUkN8bBLLwiCDKgf7aT0Wab4UonIb7pvxA?=
 =?us-ascii?Q?zM2W1DEj/7iI6DrS66G5meHl7rKR7ALmTdcF8ple7cEMOZRBNVcLwPDYbvoh?=
 =?us-ascii?Q?lGGMKLEsJHUHAtE5Da6sb/oUMvkqn8a/AhRevW65w+c/kchvt5bGoO9CRMxq?=
 =?us-ascii?Q?yL3iM0JBtejyvnibqOhM0EHm7Wfpg/vGeARHKhmh6qECqFkwre5XfTJOsLwR?=
 =?us-ascii?Q?MSRd6bHTkxwjxKfCt18RnTmKn+Vb+7TMWm9P/UQh9wAHblZiaH2Tf/GP+Hqb?=
 =?us-ascii?Q?bEE2bUfQNXWREwraEPtDumNVzuYVLg13xD4V/nfZUoR0qo1QwwOsr30GpM2V?=
 =?us-ascii?Q?x5yxFSsiFRkovs2PZttUUQNpd7X0f7okytXUfQ9s44z5VIiN+pmq0C+4auR4?=
 =?us-ascii?Q?zyV/kndWGvpkIGs2aGOzA7ciZdjXTl0ZE5JtWOvFFZLfL/6gb7+6eU9RzNa1?=
 =?us-ascii?Q?VEdtrwA/3dWi331zEFve2FcB6i5pOZGzmhQ5CyueyEYHxrTJ4HPcswvDXzWV?=
 =?us-ascii?Q?rdx8TdmSyKHtrAigyO7pKcFini52ltK9/76G5KBS177xbI7A3WYnWPzlVflJ?=
 =?us-ascii?Q?4l9iRQQEpC+IFrhCYqzXyB7GXjKeyt97R/v/RbOzzdxIlVHq5smgqEk8iMrg?=
 =?us-ascii?Q?eH9rhqzllmrTnu9PZ8MHOtJ5Xvkjy30tHwzPmrwhmQztkVVEc9JJRLiYTDBw?=
 =?us-ascii?Q?X+I5/852GopwU2YmSpYsx6/V25x/JOWuaCbIYG+4FoQjwAt05HjZ+qRGBmqH?=
 =?us-ascii?Q?3gpElLJexwfd1yop8+8WQ8YUkGevgsfGlBhiW8eC8dpzjp+SuE1+9wPJipHk?=
 =?us-ascii?Q?HNZsMtZGAe6hIl8d7hMzD0UHTm8VV+Q9PR3fo7SwxCvpC3wMKMEeq/VvmRr2?=
 =?us-ascii?Q?M+5c59y8g6IyB49JNP6jgCufKXLZZBvcaBZfjABj6wao0MC5bGBvLcmQB6wS?=
 =?us-ascii?Q?v6aK4nU4AbtRK3+Acn/UJbrhpFxReM877fsR4DuV6iT4LHSx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a65e7e3-4daa-42f5-f6e3-08de8695a1df
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 15:30:36.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlwXqMeGOADSG+QMKoqq4UCErUuvVbvVa09EsxmPt5Lgqzq7uA/mqKaUDN1SUsgkvw2dSIymOHHZXsiBXsgi+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765

On Fri, Mar 20, 2026 at 08:59:38PM +1300, Kai Huang wrote:
> The comment after the '#endif' at the end of the instrumented-atomic.h
> is a typo.  The "NON_ATOMIC" part should be "ATOMIC".  Fix it.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Applied, thanks!

> ---
>  include/asm-generic/bitops/instrumented-atomic.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/bitops/instrumented-atomic.h b/include/asm-generic/bitops/instrumented-atomic.h
> index 4225a8ca9c1a..c010d54275e4 100644
> --- a/include/asm-generic/bitops/instrumented-atomic.h
> +++ b/include/asm-generic/bitops/instrumented-atomic.h
> @@ -100,4 +100,4 @@ static __always_inline bool test_and_change_bit(long nr, volatile unsigned long
>  	return arch_test_and_change_bit(nr, addr);
>  }
>  
> -#endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
> +#endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_ATOMIC_H */
> 
> base-commit: 0e4f8f1a3d081e834be5fd0a62bdb2554fadd307
> -- 
> 2.53.0
