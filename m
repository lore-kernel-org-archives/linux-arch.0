From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH 3/3] Fix M68K irqflags
Date: Fri, 3 Sep 2010 11:28:26 +1000
Message-ID: <4C804F3A.8020001@snapgear.com>
References: <19747.1283422807@redhat.com> <20100902102203.19806.39028.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from dalsmrelay2.nai.com ([205.227.136.216]:61616 "HELO
	dalsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751281Ab0ICB2r (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Sep 2010 21:28:47 -0400
In-Reply-To: <20100902102203.19806.39028.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org


Hi David,

David Howells wrote:
> From: Greg Ungerer <gerg@snapgear.com>

Almost :-)


>  arch/m68k/include/asm/entry_no.h    |    2 -
>  arch/m68k/include/asm/irqflags.h    |   76 +++++++++++++++++++++++++++++++++++
>  arch/m68k/include/asm/system_mm.h   |   25 ------------
>  arch/m68k/include/asm/system_no.h   |   57 --------------------------
>  arch/m68knommu/kernel/asm-offsets.c |    2 -
>  include/asm-generic/hardirq.h       |    1 
>  6 files changed, 79 insertions(+), 84 deletions(-)
>  create mode 100644 arch/m68k/include/asm/irqflags.h
[snip]
>  #endif /* _M68KNOMMU_SYSTEM_H */
> diff --git a/arch/m68knommu/kernel/asm-offsets.c b/arch/m68knommu/kernel/asm-offsets.c
> index 9a8876f..2433502 100644
> --- a/arch/m68knommu/kernel/asm-offsets.c
> +++ b/arch/m68knommu/kernel/asm-offsets.c
> @@ -74,8 +74,6 @@ int main(void)
>  
>  	DEFINE(PT_PTRACED, PT_PTRACED);
>  
> -	DEFINE(THREAD_SIZE, THREAD_SIZE);
> -

This breaks final link due to missing THREAD_SIZE definition in head.S:

   LD      vmlinux
arch/m68knommu/platform/coldfire/head.o: In function `_clear_bss':
(.head.text+0xa4): undefined reference to `THREAD_SIZE'


Without that asm-offsets.c change it works on my ColdFire boards.
I am happy with it:

Acked-by:  Greg Ungerer <gerg@uclinux.org>

Thanks
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
