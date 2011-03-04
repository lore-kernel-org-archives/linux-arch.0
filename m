From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 16/17] unicore32: add (void __iomem *) to io_p2v macro
Date: Fri, 4 Mar 2011 12:52:57 +0100
Message-ID: <201103041252.57410.arnd@arndb.de>
References: <cover.1298821856.git.epip@hera.kernel.org> <201102281635.56528.arnd@arndb.de> <03ba01cbda54$a5c39f00$f14add00$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64630 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759397Ab1CDM4P (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Mar 2011 07:56:15 -0500
In-Reply-To: <03ba01cbda54$a5c39f00$f14add00$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: 'Guan Xuetao' <epip@hera.kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, greg@kroah.com

On Friday 04 March 2011, Guan Xuetao wrote:
> From: GuanXuetao <gxt@mprc.pku.edu.cn>
> Date: Fri, 4 Mar 2011 18:07:48 +0800
> Subject: [PATCH] unicore32: modify io_p2v and io_v2p macros, and adjust PKUNITY_mmio_BASEs
> 
> 1. remove __REG macro
> 2. add (void __iomem *) to io_p2v macro
> 3. add (phys_addr_t) to io_v2p macro
> 4. add PKUNITY_AHB_BASE and PKUNITY_APB_BASE definitions
> 5. modify all PKUNITY_mmio_BASEs from physical addr to virtual addr
> 6. adjust prefix macro for all usage of PKUNITY_mmio_BASEs
>   -- by advice with Arnd Bergmann
> 
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

Looks good,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
