From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] of/fdt: Allow memory node and root to have different size/address cells
Date: Thu, 01 Oct 2015 14:21:59 +0200
Message-ID: <1712345.yOlLsP4Oji@wuerfel>
References: <1443701901-362-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:64246 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933132AbbJAMWT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Oct 2015 08:22:19 -0400
In-Reply-To: <1443701901-362-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Rob Herring <robh+dt@kernel.org>, kbuild test robot <lkp@intel.com>, "kbuild-all@01.org" <kbuild-all@01.org>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thursday 01 October 2015 17:48:21 Vineet Gupta wrote:
> Currently memory node parsing uses root "#size-cells", "#address-cells"
> This doesn't work correctly when memory address/size is different or
> greater than root's.
> 
> e.g. ARC 32-bit systems implementing physical adressing extension and
> say 4GB of memory. All peripherals mappings stay within the 4GB (so root
> address/size cells remain 1 each), only the memory node address/size
> cells needs to specify greater than 32-bits as below
> 
>         memory {
>                 device_type = "memory";
>                 reg = <0x0 0x80000000 0x1 0x00000000>;  /* 4 GB */
>                 #address-cells = <2>;
>                 #size-cells = <2>;
>         };
> 
> This patch lets me boot a ARC system with PAE40 + 4GB of memory specified
> as above and fails to boot otherwise as memory parsing doesn't populate
> right base, size.
> 

This looks wrong: the #address-cells property in a device node is used
to parse the reg property of its child nodes, not the node itself.

The only way to list memory like this is to put #size-cells=<2>
into the root node. All lower bus nodes can then use the
normal #address-cells/#size-cells again and use a ranges property
to convert the register ranges so you don't need to update all
nodes.

	Arnd
