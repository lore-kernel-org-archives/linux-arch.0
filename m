From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH -mm 5/8] m68knommu: fix implicit declaration of function
 'PAGE_ALIGN'
Date: Sun, 06 Jul 2008 14:36:09 +1000
Message-ID: <48704BB9.5060003@snapgear.com>
References: <> <1215079171-22637-6-git-send-email-righi.andrea@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rex.securecomputing.com ([203.24.151.4]:54226 "EHLO
	cyberguard.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751120AbYGFEhs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jul 2008 00:37:48 -0400
In-Reply-To: <1215079171-22637-6-git-send-email-righi.andrea@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Righi <righi.andrea@gmail.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, paulus@samba.org, balbir@linux.vnet.ibm.com



Andrea Righi wrote:
> Signed-off-by: Andrea Righi <righi.andrea@gmail.com>

Acked-by: Greg Ungerer <gerg@uclinux.org>



>  arch/m68knommu/kernel/setup.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/m68knommu/kernel/setup.c b/arch/m68knommu/kernel/setup.c
> index 03f4fe6..5985f19 100644
> --- a/arch/m68knommu/kernel/setup.c
> +++ b/arch/m68knommu/kernel/setup.c
> @@ -22,6 +22,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/fb.h>
>  #include <linux/module.h>
> +#include <linux/mm.h>
>  #include <linux/console.h>
>  #include <linux/errno.h>
>  #include <linux/string.h>

-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
Secure Computing Corporation                PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
