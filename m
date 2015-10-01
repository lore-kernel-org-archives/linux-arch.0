From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] of/fdt: Allow memory node and root to have different
 size/address cells
Date: Thu, 1 Oct 2015 12:20:15 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075D781A02B@IN01WEMBXB.internal.synopsys.com>
References: <201510011957.uv8v1XRj%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:40552 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933134AbbJAMU3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Oct 2015 08:20:29 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Thursday 01 October 2015 05:28 PM, kbuild test robot wrote:
> Hi Vineet,
>
> [auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]
>
> config: i386-randconfig-i1-201539 (attached as .config)
> reproduce:
>         git checkout 84881842f801639b80c8f6a0d9afbc582b33be01
>         # save the attached .config to linux build tree
>         make ARCH=i386 
>
> All error/warnings (new ones prefixed by >>):
>
>    drivers/of/fdt.c: In function 'early_init_dt_scan_memory':
>>> drivers/of/fdt.c:916:41: error: expected expression before ';' token
>      dt_mem_size_cells = dt_root_size_cells,;
>                                             ^
>
> vim +916 drivers/of/fdt.c
>
>    910	
>    911		endp = reg + (l / sizeof(__be32));
>    912	
>    913		pr_debug("memory scan node %s, reg size %d,\n", uname, l);
>    914	
>    915	
>  > 916		dt_mem_size_cells = dt_root_size_cells,;
>    917		prop = of_get_flat_dt_prop(node, "#size-cells", NULL);
>    918		if (prop)
>    919			dt_mem_size_cells = be32_to_cpup(prop);
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


This is really awesome, Thx for the report. Corrected patch v2 posted.

Thx,
-Vineet
