Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAAC322A0A;
	Fri, 23 Jan 2026 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131524; cv=fail; b=OaeX3e6rG0qEBJL0tkAo9h5RIi7OCtL63MZd3CVuc4H6RiovMJUNdu4V32rEGhu+qhseLvKmxZNxo+zu53QXTqploeetISR1TupYRjiYuqm03kCpZS+vQHAx0hJESnqfXMZcpeB60bBbxfeFMmOoWnDgcYqrlDkf92E0cXu7tLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131524; c=relaxed/simple;
	bh=6trf7U7kLVEhHfciocSLItkF8Uw+DSQrsF7Jc3kn260=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mkxNSQqJDU+nMAnnfZ7OmJrxBIfL4GseIw9R/4Cp0y/+jMuQifDbOriydpaE7hsgxNq68dylps/fcY/y86d/8p9j0vHCjQh1rO1H8x6oO0YdQEjUIzDqxcAuEkJtUkIveJnl3F6qHb5uV2vNwKLnTz2nJHeY7+J257BLZHM7ADk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KolooYj5; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KolooYj5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769131521; x=1800667521;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6trf7U7kLVEhHfciocSLItkF8Uw+DSQrsF7Jc3kn260=;
  b=KolooYj5VhkbzTZOCuOZ1ZqfLN9pB16rf4sk49IP+HJ5Q/OTaagT6wlz
   vWXBwDJ9spG5njkNUXboeZEevO4xdHoh2f/+BFH3zB7LnC5zPTuDYQyXs
   yNrWylhkHxuEMPH5ne7pkOvt8GVyyw0Wre4e92v6ZLeTCXCVyjmalW/VS
   HBSlyDdfMt+lveQhzbPpk2Z2dQUR7ndbKAhNixwdMAu/FXVWh4T6IYL6u
   /nJ9Jpu/58EjXpVkRSPNEYMoG3FOq6DCE+L/blsSr0kpSVZH22aPhg84p
   g4S4kkUXSwX8zFq65aWNwKDpHzBp0hkQXmj7WpMhJ5qhBUlOm9eBsQ2BO
   w==;
X-CSE-ConnectionGUID: 2cq+fk/pT1ukcwxjx4TfaQ==
X-CSE-MsgGUID: hT3r/icmSeOpiZawEcLamQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74236570"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="74236570"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 17:25:14 -0800
X-CSE-ConnectionGUID: uSsav1eeQmapjwRkPMKVDg==
X-CSE-MsgGUID: V/T4G2mXSuW8cRRNUpTxwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; 
   d="scan'208";a="207313530"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 17:25:14 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 17:25:12 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 22 Jan 2026 17:25:12 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 22 Jan 2026 17:25:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G168vl3KvhUUk9bHld70IdqPwaHjQCdcWAwH5pVUgnxPCvoaVVXozG6rTijp1wfblndosVxB0Ubw9888ScAmzuo4JltcUVdKL2EFC4jFRTius9At3+uTdM7Py/MeQoc032HsVNkUgVypioD1dnU8kifCimhBlDHtswKoy5eWR3Mit4ORonCQkOch5x2cJ4cdwym+hTwgH/U71WYAjzV5vbS+FTwJwHIjf5QCKqVWDUhXeoKvRSnntd6Tu/4kavNya9sKuxyPvfJojlyXa1tKYbK/IOojPtZB99Q3InQEMbXy278dUONazl4A5kRsBYumf3Y7RQz6nomRXlEmRxQztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yy6+Yk+pE8k0E4cQNfGzs5+qQ24Uyp4WI7aZ7isNDRw=;
 b=zFVhIT9esURN+hrTYbcGMBNxqC57kaLlSfi40GDEYvHSGY6H9NG4LjbGSPFTNiYBT+47OkfLGE92hXstId5yeIKR5Hn1TYFrFCBtKFUArB0A4EHACIipOR0k+sBI8gfoDeRr1ngfBX3LVAgU1xci7/ewd+AUT7IzeEetvUgyTBDbfZ275U6YzBnVEf3zYYl+hh9QqcsSaOz/xnL9l9xF6k29k3w1k6vS45poXFTVPwEURIRTNcU6oKERsLIOBJ8tqeqrAfuUdSmaVsUJ1kyLfXKP2c0e14hb9CPXbyBYW3t5fp44nZH/7pJJdnuDPMdmYcki++skDMCISBnkvYnnPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8468.namprd11.prod.outlook.com (2603:10b6:610:1ba::19)
 by SA2PR11MB5161.namprd11.prod.outlook.com (2603:10b6:806:fa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 01:25:04 +0000
Received: from CH3PR11MB8468.namprd11.prod.outlook.com
 ([fe80::8188:d688:bbca:2394]) by CH3PR11MB8468.namprd11.prod.outlook.com
 ([fe80::8188:d688:bbca:2394%5]) with mapi id 15.20.9542.009; Fri, 23 Jan 2026
 01:25:04 +0000
Date: Fri, 23 Jan 2026 09:24:50 +0800
From: Philip Li <philip.li@intel.com>
To: David Laight <david.laight.linux@gmail.com>
CC: kernel test robot <lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Arnd
 Bergmann" <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yury Norov <yury.norov@gmail.com>, "Jani
 Nikula" <jani.nikula@intel.com>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>, <oe-kbuild-all@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH next 11/14] bit: Strengthen compile-time tests in
 GENMASK() and BIT()
Message-ID: <aXLN4iUVMczH042p@rli9-mobl>
References: <20260121145731.3623-12-david.laight.linux@gmail.com>
 <202601221237.soiAkwkN-lkp@intel.com>
 <20260122103337.26473d1c@pumpkin>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260122103337.26473d1c@pumpkin>
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
X-MS-Office365-Filtering-Correlation-Id: 22831885-2373-455f-e4c5-08de5a1e3c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AI2+TGk3e4biGK2ng/tq2i8G9Nx9ZjC+LS6EVufvJ8TkBPvwQFtd7w7+HF88?=
 =?us-ascii?Q?paNmEUgGcSZCX6qgsFGVl7pWmLE2BfkVHT1suWnqrdHctsmucYnmD7nDH6kG?=
 =?us-ascii?Q?yXLdB5YQIXJap9JK+2lVPUaXZSKLAMLfXZsePwNu3wS+FisMOPl5NYbdpbxZ?=
 =?us-ascii?Q?cJ9tYMZaMz8dLnOOvliaSowEzCz1KrhZHqLz8oM7r8Xp/+d04vKNSoaWcwY9?=
 =?us-ascii?Q?N7rMV9gR3B0JnFhpduH2jhto1F7q1TSDk+tfDYs8Z723E8NIi7CgVOlPF/7T?=
 =?us-ascii?Q?uKoAXRtOhZORf46uxc1lZrbXqEgh01maIEExvqnk7cabM9POkQe0EU2bmyGt?=
 =?us-ascii?Q?5Np/eKMeL1G+xqk5AkH3iu3q3eyANsOoMnkYjntppoq7vvZXrMe0EI6omXcz?=
 =?us-ascii?Q?5drd5CBTWYhpwqacQVvR1KehKN/Qmg9Fcto/HKycsU2OBK0EgU96d7T7DhmH?=
 =?us-ascii?Q?Kh87BxB+uD8+021o8rtpoAIAIiroAcwuD7xG7RParWMglvRl3OQTvxI7rp3x?=
 =?us-ascii?Q?J88lvLLNSyvmzXF2JZefRabrhignwrRLL1wsbs/bE1T5SQlKWWlwU20817Aq?=
 =?us-ascii?Q?6FzVTw5csz3JQ+MulR/pjggTtN6QxIMJ8GpM3kit04OpZFjlVU0Iq3r4qW7R?=
 =?us-ascii?Q?42VcQ82UQqvM0NQjD9cjb60z8Ib3Yn24TBpuV1QNEGFLCqWMunJJyrbl/Btu?=
 =?us-ascii?Q?vYKO1OnSdqfRnJUgUrO+/SUG8Amp+POtX8CV2vlme+/FCc0LZMnntYZ8nx4J?=
 =?us-ascii?Q?8YFZRA5WsDr41F1mDxg/WtAQAn3sdmgNK+Y2cmiG4lNUadg6s4MkQIhvn8+I?=
 =?us-ascii?Q?aVqsk9T0KzO6++i8apNxO0kgR/lGaoCmYej4ZRw9+eHfMnQrQ8fj2N0tdwPS?=
 =?us-ascii?Q?PFHvcVy6TspJUTyF07ZwgPuViQCPw2l8BjrlwNTgcnAOBr29agG4bsuRWRbI?=
 =?us-ascii?Q?zZSi7HHBxoBXcuiwzrG0TYwW7BF5XSdeQf+NWLFlI52UZFQVv89Ps2pmCFcP?=
 =?us-ascii?Q?ODKSPCbMAyHTeuBCbGqhK5BErPSh37PhynrDFP4gEXcIIw4357o7ddGeWQaQ?=
 =?us-ascii?Q?tssAg4VlTfP88cs4SEbJ65B4fBJjuMdu/IaOjj9GUySyPQZIW2qMPU1JA+1p?=
 =?us-ascii?Q?pzn7TMj8cbyAVEu/wtJwWl4azGY38FbMT8iAAb+AU20xzzP5XQgde4lwaKhP?=
 =?us-ascii?Q?/2OADhA7cZTa99tvf0bG7O55dJifEJB2Ik6dGNRxBPiVgm1dezZP5TgSL6xD?=
 =?us-ascii?Q?VrJ1adNZ+7xsZfuw1yHRN6qvSshQH1VJ9Q9SLQp5vLwPVhvpukHVUY8L/S7i?=
 =?us-ascii?Q?nl35mFJDf2uZzJCs2RgiwPdCiy67fmnW4nRXnmgnlgtPvhNgZ7URt9iyHaR+?=
 =?us-ascii?Q?K5ag/FWVRm5yD/EJbP1IkBjSV1z1n6Pau9L85qJvrldm1qtKigknuvwhSkGm?=
 =?us-ascii?Q?q5/H1/69YCOcduxrorM3DVr/jXMPykueaH3KJdscdlfl8YDj/H1/fS+WrXEC?=
 =?us-ascii?Q?xYDOcPM9nwN38L2ofk8Sx1W4W/iX+ik67xGuxaJ64yITty7z4Qj2EG3r0Q8L?=
 =?us-ascii?Q?dCdVOgYYTz+HgQg7otEZ/WeL/1PELbN/fvX9IDaA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8468.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SkMSKvAq0bSXwZnrEbLWslcHoJDTBlLkbsP6gIM7HgzwKDpE0MqO56ypp5I0?=
 =?us-ascii?Q?ijQfM1BLDn2FY174oDj2nrWvnpmSUT1JmMlxAWaSOI1HbxDNJ7DC6IcSo1eC?=
 =?us-ascii?Q?fIevfBUgeEjk5qM8A3sXhZrU49PX1P8nVClWN7wgn+34sKq4dRhdtpjWpbb8?=
 =?us-ascii?Q?IsMuiFp4N+ig9nTvg9Vlo/33Nrg6le4uASS47geAZD4/xjBTyycGrYyf0naE?=
 =?us-ascii?Q?wzIisI/2PoJB6UA+IwKLCud4k4zZCO9Cw58z9ZdcOguHc9jN3W7QVRBIzacF?=
 =?us-ascii?Q?9Ymg0/O5zJfca7iRXNJFKFYz+CWMYiE7oiOXaZwc+ZdC6GmAtajt7KB+ZHns?=
 =?us-ascii?Q?Ul3ICI5PQ339xxaoMPpEDf4+DjcDsMLtopaoCbBmbV3PCmrNuFe18eggHeAW?=
 =?us-ascii?Q?brXjny/vZ7pCddSV8WSGtAPNkSR1XlTMCS0p+w7n00tkTCvjJtGgP72LhsVr?=
 =?us-ascii?Q?d1ymTBUB9rHeSvFupfQOmYUHMWiNtbOfjDs/PGqz/z3VneChNdV8xtpLQc9e?=
 =?us-ascii?Q?JxAGL8e5irz5bUEZJS0jE+zlTDBM5ZMRA4246fHihV5HB9SyyWI6jbydLpr+?=
 =?us-ascii?Q?8U5UemFR8myXKfV+klxMwi88Wtc28uohYC2669n7JEOaTEYj4KVl8vNhEbn/?=
 =?us-ascii?Q?orK9VvxLTlO80jI8/L9J0ppgdWIVBEvIgelAB+VuHX3XAe7iu4JAnYiSdknJ?=
 =?us-ascii?Q?5zXEScXN7/S20t1F2nz3r/EQd620WjJhDrIUA0JTdkRZf0ntPXYihw2ZaLTW?=
 =?us-ascii?Q?9+/pmbYwKjkWVbzkYL1q6BwhmzRyJGrfn4AfqmZTzw6Oxt2Q/jaeK3I1Lbag?=
 =?us-ascii?Q?m3kbFBZyuAak9DVvd5Jd31PmtgY1T4Lr6+ujossab15J7H89WZk4NZjMtAZX?=
 =?us-ascii?Q?KeNKiKbUYT5nuq0uX3XF7YHB9E4XIS7xeihFm19Zp1ODMlqEPnpLP+/Xx9AK?=
 =?us-ascii?Q?fDX0vsHyqGy7gbJml5k61zLLQf1yI6QbRNSiSVRm/vbJHaFrMi3G/tY4Qnnl?=
 =?us-ascii?Q?A/zLk1UXZKGqbNP9Oy4iEb8vxyptejcTfcN92q6YOPWXh5M0Plexh1+dAtTf?=
 =?us-ascii?Q?Em2d87R8GvNe9eYzTRz/NG4xlu9VFbGN8BvIKurShXUO75x/fBDH0hA7dS8Y?=
 =?us-ascii?Q?Qlm4bUzifovt7nzwth973PA44TZmWiCVLiv1yhUI2CtOWcpyXnywWLhGx+Vi?=
 =?us-ascii?Q?ad2YqmZbVr0dDGqtZWAO4FLQEeYtyGzIqW5A4QgyVWM2zl7uh9Kt49/8FMec?=
 =?us-ascii?Q?A0XpdwAVV5BRIssX+QZg0iSlBVQABce5jBqj696fAkhVkEFckfhL1EiBz6go?=
 =?us-ascii?Q?KwMLhgjOXSyML5Po/ko42zO/zCfq8ofsnwZBLP6S8dw3Xg/buw6jKwK6tGFL?=
 =?us-ascii?Q?EE7YeCtsO6UsasW5hIUKyVhKzdE73HRU37omj60DhhAQHynlrM4QJsTb08U8?=
 =?us-ascii?Q?ubHYUK7gzncfwMyfORvRjGDoxxjO6hGFPZlKtzmAOdyEGZklPz/+E+5+pPPH?=
 =?us-ascii?Q?5qXxe6PKs6ogXT15sXYc2ZHuGYa9bazIC2Yj7CskrmgleKd6fdxVJM0+f2km?=
 =?us-ascii?Q?dlwc/HTIJU/6Tg+0lGU2i32CefwRLtRMIC1qgPD5l8OI7ncZ1g5DZxCX1N/m?=
 =?us-ascii?Q?Y3xmsgkVDC2GinVSac0wmYOXck4Ad57l9+nDttMP24mTIkcQ4hGVgLu6zkow?=
 =?us-ascii?Q?S8pGIkuU8UgDU7shsIYF4K/oZPIDm+5WK8hBL4MopUQyc1LKdHjpuz8RvBvk?=
 =?us-ascii?Q?vc4fXLDK6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22831885-2373-455f-e4c5-08de5a1e3c08
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 01:25:04.5269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0e7vtB+x+K8T61YTan0TExnuE1HGaJ7Ck5ryjrG/6CYKiUg9+g2qP2K7onoWhUEbtGKRrnPfwTHorO7E9RaQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5161
X-OriginatorOrg: intel.com

On Thu, Jan 22, 2026 at 10:33:37AM +0000, David Laight wrote:
> On Thu, 22 Jan 2026 12:41:22 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > Hi,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on next-20260120]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/david-laight-linux-gmail-com/overflow-Reduce-expansion-of-__type_max/20260122-013456
> > base:   next-20260120
> > patch link:    https://lore.kernel.org/r/20260121145731.3623-12-david.laight.linux%40gmail.com
> > patch subject: [PATCH next 11/14] bit: Strengthen compile-time tests in GENMASK() and BIT()
> > config: mips-randconfig-r132-20260122 (https://download.01.org/0day-ci/archive/20260122/202601221237.soiAkwkN-lkp@intel.com/config)
> > compiler: mips64-linux-gcc (GCC) 10.5.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260122/202601221237.soiAkwkN-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202601221237.soiAkwkN-lkp@intel.com/
> > 
> > sparse warnings: (new ones prefixed by >>)
> >    kernel/kthread.c: note: in included file (through include/linux/bitmap.h, include/linux/cpumask.h, arch/mips/include/asm/processor.h, ...):
> > >> include/linux/find.h:209:45: sparse: sparse: Variable length array is used.  
> 
> Can we stop sparse complaining about sizeof(VLA) ?

Got it, we will avoid the direct report this 'sparse: Variable length array is used' warning.

> 
> 	David
> 
