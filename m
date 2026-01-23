Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AE02FC006;
	Fri, 23 Jan 2026 01:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131563; cv=fail; b=R1qorI3CbMn2MXD+hTnQjt5a0Y+SAbSAZ8zqM1u0uT6ZIy96bSbEYE1XUpJmVQnez3vrj24JuyCE4EwfYbA4r+V+rvDn+yGp/K541CXif6d1liKUQHhEqpqsy5vQkmQs/OFcFnTG9y7RU9dWCauEHSVwVziLwPFHbwEYuGXDiRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131563; c=relaxed/simple;
	bh=oPX3LSYiPTNsPai47283iGPdQQ++0O+hRuaJwujOnXo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=caoKygjyX4n+uOAzxJF9owGnO5q6ySnKV5t7WxCSSyn65Hi6jwZuLkedfpK1bjDVKFcddd8mjUVNT3uapE+w3PnRX2QAM8rIpXoWxm1yp9SYPdgnrf2T4gwUwZshJ77kWrr+48Dd99BMhEjXjCOMlzmN/1uIXJHL44cuADcenoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7x22OWo; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7x22OWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769131554; x=1800667554;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oPX3LSYiPTNsPai47283iGPdQQ++0O+hRuaJwujOnXo=;
  b=F7x22OWoitSMjL9xK+pJmUHxAbG3iaIFTYccJ+3NLwF9/iQSZEBZdyZ9
   5UJ9ksdTacmE1rHgODhsf5ExHUUVyYsYpTONKvcw2nWIlhGlvloCgEmTq
   aH8MzkJ77saB9o05Tmr+51PW1zVTqQG4ArfX9U7oGAGYoGPUh99lKf74y
   evFFf6iqG3zZnN9vp32rTknZfe/j9IMn4sud6/H+q1++FbwP/pHY6vC5d
   1wI4VPnYCObyXo8mVHSmQP75fud09G51yNnN0O/pNeAPfZeIKB79rr/Di
   0uA++xYe55zI3diJkbpce2mNpmpeesCB46OFLih+OOdMmUMjz+tqqvkk2
   g==;
X-CSE-ConnectionGUID: Im/glBQsRGWiTqpo3Dcclg==
X-CSE-MsgGUID: J/khWbRGQCK9JWswe2krag==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74236665"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="74236665"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 17:25:51 -0800
X-CSE-ConnectionGUID: amFl+J4YT2+jKJB29MPWTA==
X-CSE-MsgGUID: 7XbxrljvRLq7rgKzNIvOKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="207313642"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 17:25:51 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 17:25:50 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 17:25:50 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 17:25:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZS8nL8Wu9ctYnzCIxvBCeZyGZJ9Gx3QSJ2Tbn9DkLbkb8Ez1llggBifnscJnH5hPWGsawjtaA66s5gw6E6W8adGGkQeZg/tbIANz46ClA05Q/w5jnm3eKR2pZuKwwQHMcNkx4g8OMbnnAKd+w9gY/Rdc6hjw9rBeKm9mrnj+uKevD8NJIA5B81DZAmZEQ8hA00Eghvg7gmx5HGKmtC/amDlQreFXJV14EMtbF3IWQ/SYmgqyKR5OHgljDjrBazYTGm/XuPxBxyXR4+HySWIHN92ikr5MgauQC+/EcWZ0L5zwS2vWvbE8X5N7Lg4mXQ8KFnPReT2EtGLoW9jvpWi/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnlcORZeHkMP7Yrif3sApd55y6NM+mLaoJd+lD/Q+uE=;
 b=weDtrEasRTXt0OhSYqLNiGHl8AemgLY8hHLIvl+i+3tVW6b21uBe97O2eeAyGmqIoUG6BLJ4f7ffLh6gMEgia09F3aAVHs+JPSBolCTLIneHzozgUixVdYgOKQc6icFPZxBYEfaXy7bfTj4odBRHAVEsXcCv8+L0Z7o4roUGaQDNxkgIefgZdg0dWuepOMEiTJeowqtViE0eQQjG5ZadENkBopgXGdyeMuAQC2Ybby7X2itDtdRir7Upo3ieaFWPv7Idf16picIP3EeE1QrRZPJ6TGDnM3lU17QqyzCGO07WCE13uDU/fWHh8bs5BrFLa7izZtPx6CxcP0GdAlsMrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8468.namprd11.prod.outlook.com (2603:10b6:610:1ba::19)
 by SA2PR11MB5161.namprd11.prod.outlook.com (2603:10b6:806:fa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 01:25:47 +0000
Received: from CH3PR11MB8468.namprd11.prod.outlook.com
 ([fe80::8188:d688:bbca:2394]) by CH3PR11MB8468.namprd11.prod.outlook.com
 ([fe80::8188:d688:bbca:2394%5]) with mapi id 15.20.9542.009; Fri, 23 Jan 2026
 01:25:47 +0000
Date: Fri, 23 Jan 2026 09:25:36 +0800
From: Philip Li <philip.li@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: David Laight <david.laight.linux@gmail.com>, kernel test robot
	<lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yury Norov
	<yury.norov@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Kees Cook <keescook@chromium.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, <oe-kbuild-all@lists.linux.dev>, "Linux
 Memory Management List" <linux-mm@kvack.org>
Subject: Re: [PATCH next 11/14] bit: Strengthen compile-time tests in
 GENMASK() and BIT()
Message-ID: <aXLOELiIG8MHKcIO@rli9-mobl>
References: <20260121145731.3623-12-david.laight.linux@gmail.com>
 <202601221237.soiAkwkN-lkp@intel.com>
 <20260122103337.26473d1c@pumpkin>
 <aXIzpC6wpdv47cSH@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aXIzpC6wpdv47cSH@smile.fi.intel.com>
X-ClientProxiedBy: SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24)
 To PH7PR11MB8479.namprd11.prod.outlook.com (2603:10b6:510:30c::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8468:EE_|SA2PR11MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1f024e-cc64-4a60-8b3c-08de5a1e55b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uP8Gv6WpWuV5aUMQ9NHBWs8fx58fBTp6cvzGnnlfa/NJfAJBxCeJCX+nGO5c?=
 =?us-ascii?Q?V28HSy/A73/sT5haZqOCV3vY6XeVAEWgk7+CTEf/+8RsZLUlCFoiJFChD4ne?=
 =?us-ascii?Q?kTjCY7DUuzlHStyJP9591zb+HXEBtZiQFMxRDgopTAo1SHJ9J5/9ILv9Lk8H?=
 =?us-ascii?Q?OE/JagrS38mjRDXaKcaeCd+kZrjr2GScEdNDAt1LV+Cgw6bUrtz0MWdOuYiT?=
 =?us-ascii?Q?kqBfaeYv1Tzw+GXxqA2KCJcHh1vkuGPlGX7y8tVLxfY6sMAWGmzp44ibaspD?=
 =?us-ascii?Q?n/NyiW8tZlcaI5Jtv2n/nwyv9Qb+uJPDX1G1E3Uys3sDy+wXM+tmIBHaLMdF?=
 =?us-ascii?Q?v/9l/qmOSY3v09EPO1bAWpuOBzCk4dak9j8tP+PSCGXhjox16g8ZQt08AeMu?=
 =?us-ascii?Q?D/U6mdrAKpY+XAYT1HxKY/osZJpKCZve0vFZ3P/o7xrXs0OZuie3uDwtviF0?=
 =?us-ascii?Q?38/DCvbElKHMdnesAvvDy41fsKMCi2/H9m7Eb+h+DeyWWJDN2XvYyK+NoBw0?=
 =?us-ascii?Q?rs4kFktb+vHWZOSnPZEEPmiuAtUeDoXuJCTDI+4dW04R6s6A4BiWbzW9yg3u?=
 =?us-ascii?Q?PzHUUq1XKCBvuBjWJLVzWCrMNY0Y7xhZZ+go5N7Q8wflQWVLd/N41klSWE1x?=
 =?us-ascii?Q?P2Q6juI/wxRRqLsyyTm0QDW9zIOF2p0tFGM5OFnRIyLDTc4pkvgm+QMP9FzU?=
 =?us-ascii?Q?W7YEK+7z/vxccxo3U/mi86T/Y4v8LcV8bHmNSwyz+Lofu4/jy+sGnoWjtvi9?=
 =?us-ascii?Q?OAG6ZUXQzjmpvNRKquikolR3ljkGFVsf2Qnc3djKeS4/rzzlkza39moahQDT?=
 =?us-ascii?Q?b7Id/RLpoXECAX2bMZzbdfK1lPjjLX/Xrhcy4RtvmclRAsz+sy67DdUNZacb?=
 =?us-ascii?Q?qFU2aD/ffOoIbYNHWOohI4/Kq4FrqjDhFixS7OSXA+gIL/jB9EOrCRuJ7n1u?=
 =?us-ascii?Q?GqpIYVm+dcqWwqRsj//AslFuP8Rb70DKcvKdl6FuJVVfBFlseXD0BOxDl76j?=
 =?us-ascii?Q?HRd58RuBsLqCx+IHy0lMP0M5Qkv3tKz1QpOn6k3Hhx3YmniR2I0H1BNDv3jX?=
 =?us-ascii?Q?GfrEVbahcNf/xNeUR3T3B8eD7aFlZ0pPqI1+jAto9ZwBaRmQpatFku3/QA6P?=
 =?us-ascii?Q?gBR7Q0nThygDuH4tq+7DuJ9wJ38zcA1KM023qPXpnqfYgedW+BDnIJgyz8l2?=
 =?us-ascii?Q?A/x4znUzoHzc1EGEBOhvb6HJRI0Ky3Pmj0pY30lnVxsUnRLuoqUiAiUhhiyc?=
 =?us-ascii?Q?9511Z/k9U5WzdH+k5M7O/leX0IXf1cnij+Q3X6AklyU3FlKeSnhSY8/WS9Jx?=
 =?us-ascii?Q?aNuMQu/kZPnIOslPL5h/R6FfN+B7rLcAaFCcC8llYzIGVPKY3YQPLd0/D36Q?=
 =?us-ascii?Q?rPHHlrUCDn8rvxUlX80WeRP1sJgUvmnFzb7N6F4Jm7seDxDb+O3ixyBklq5s?=
 =?us-ascii?Q?OkiapVIACixi9beZpXPNrvJbXSxP5RL4goPMYkWl2UL+isy6/9zTlMihZ6Y3?=
 =?us-ascii?Q?cGG+0ysx58Hmbyam1rQw96jGHX0P3WUx2iO7Hrik7E/l/46jTN2a4f9rgkLD?=
 =?us-ascii?Q?lVn7E6ZEmwwJrcHsVfo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8468.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HjQQCrYO65reue5JWgKXw7dzgUZ12p1Hnn3mGezypaUvRb1GC3leJ5npY4/K?=
 =?us-ascii?Q?jz8nG5vVMJ2R+tTwEAnh66RFBTypcossNIo+j/d7KXFh1dh379bwRBDwD+G4?=
 =?us-ascii?Q?L7hF0pHU8aFPq0tpxDKi47sVS7BovtJWy9LOrDtNQQMkyIE5jzpUkG25ywsz?=
 =?us-ascii?Q?5nI4LPgdLYwzZO0tl/YVYfAAa2creQzdWi/w36GLZJOHn2bZBmofZlSarTUk?=
 =?us-ascii?Q?oKh28LCzJ1Cu75X4Dqj6oCw+qerHwN0Bvy9UpIkZ0J8CKe/iaB74rd8udgUX?=
 =?us-ascii?Q?hj/v71HqbZJxOvuCHAkp2zh0t9eHA4Fn9rwkrXXBr/Ve45kSK8Orwq22S402?=
 =?us-ascii?Q?d2O899Iol36bLKMCDP+dMBiYCnEskyKTKjpnk71n1Z4Tq8NvnTEvRNAVZ1HR?=
 =?us-ascii?Q?yJShewKOzsVPUoxcgq5bVp9jfHLTgFi7an0F3+f68f7rxSKYa0GBi3iGl9LC?=
 =?us-ascii?Q?KaWPyimJAS1HDA+X49uhXvseoVEgQQlzdorDFdxsFk+U1k8Xr9OLj+UaCAkV?=
 =?us-ascii?Q?Dc3OpQeJ3pTFFv3OFnU6D7fP2ns0lGqZww8xuNGsf1eFpWPP8KA14vSYcxja?=
 =?us-ascii?Q?USonJOtoSZwVXskvgnl8H75ZyZLpHnRi5Fa74HFn5NxwoSeRdcWfZX7gbND/?=
 =?us-ascii?Q?r0xQThA/2f/liGOiJp1kOkMOg25gz9A8JrMzMjJkEZgDXJsPFQk4ODna6jDO?=
 =?us-ascii?Q?+ZG8KcVUwcazOl1ioCFha/iYrnBPrgv7oi2ye/M3x3oob8ZHGAijGGQYTlAi?=
 =?us-ascii?Q?fCqXt5yL+ovLfsTOkPdwkaF5GBmgiPKfg8B2Y1BVhp2t7+uKLkaPUH//yumQ?=
 =?us-ascii?Q?LuuffxA6LFrYPlcaVu+33vGMlkMAdaGaLo7VJZ+a25e+jNI+lJyv9hUDxekY?=
 =?us-ascii?Q?LrQe/cWz7msmVlfPK+OawrND2jeAW8Se93uLft1m07Q2byp2iZi2mPobjeLE?=
 =?us-ascii?Q?MvDOZ1Rxj9FL+KTMMbKQ+dxzmCCeHWoqjcsedVoImmUzca80c8ygcBXC3dFU?=
 =?us-ascii?Q?Umy5LWqaUYMV1UTOq7fjbXLvimU4JV0HcbZaHypFCQZu9iXkyBak302Ud/Ay?=
 =?us-ascii?Q?msk+pbkMgyjMiQGFQD2TPjrSolF3dqzo2kuM1tK6fOQSr+CY5zabfKmVPFej?=
 =?us-ascii?Q?F/qbcKNjh7EqFJkWxMdU0Ak5d/E6vqBMcvgdsvveGQ4ZZ7A8qxg79E254r80?=
 =?us-ascii?Q?wjzmFND3fFonjcTmh/1nwwdHkW0c1rBnH3c0uMGKyL6xTV/PL6k6nHN59aIY?=
 =?us-ascii?Q?fg+yOG9QCd15Cn9sC4TL9WgGZdqUFWcyYzw9F3io3/6QbC4+xHM9zFXbBpcd?=
 =?us-ascii?Q?DfHTT5P3nW8XmHIE/qn1WxQ9QnJ+1vX172KdypwjP/Ntbl24RR17rIKaG6/l?=
 =?us-ascii?Q?XAU0mG9oI2vAcc4XMHN6r31P5sOTzBAgnfy4cyNcWBunHctbmPWiZvB5IsKz?=
 =?us-ascii?Q?RYGL5wCLgavC1LViYaJ1CIYVA3jLztDeCfr8w6+YEMC9mpVndi6h5ENFfTYl?=
 =?us-ascii?Q?+q3077V2NgX1w1Q9F3wQHjJyqhVLFtEyIWc0YYvhfadwYD82A0ih2AM+vvHk?=
 =?us-ascii?Q?dxo/bKcicdAOV6Y2n0cTWLNghlR82AexQXEsIeHe/+NVUx+Q3UEm1jTATL0+?=
 =?us-ascii?Q?O8FVCyekRNdbX5+YDEtDj9bvBPgviJ5JcNRp6dTScYROqdNxxdIWXdyLnFSU?=
 =?us-ascii?Q?Mwz7619/KJPYIdbIu8aiK32kp9Bd69uajLgQVCDquSI1r567W8w9t4QS4Fup?=
 =?us-ascii?Q?lxZ0nifYlg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1f024e-cc64-4a60-8b3c-08de5a1e55b5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 01:25:47.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+qcYRPp0l2ya1vR082dM8isapZaUBtTz6yIBavRFJgahhXAYDLNW2biSWCbA+I/zS1QFNNf0EY1k8wkZymHng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5161
X-OriginatorOrg: intel.com

On Thu, Jan 22, 2026 at 04:26:44PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 22, 2026 at 10:33:37AM +0000, David Laight wrote:
> > On Thu, 22 Jan 2026 12:41:22 +0800
> > kernel test robot <lkp@intel.com> wrote:
> 
> > > sparse warnings: (new ones prefixed by >>)
> > >    kernel/kthread.c: note: in included file (through include/linux/bitmap.h, include/linux/cpumask.h, arch/mips/include/asm/processor.h, ...):
> > > >> include/linux/find.h:209:45: sparse: sparse: Variable length array is used.  
> > 
> > Can we stop sparse complaining about sizeof(VLA) ?
> 
> First of all, the LKP should install the fork of sparse by Al Viro. That will
> fix tons of warnings that are related to modules and speed up the process
> itself.

Thanks Andy, i will switch to the repo from Al Viro for sparse.

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
