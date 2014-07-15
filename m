Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:18357 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbaGOJWS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jul 2014 05:22:18 -0400
Message-ID: <53C4F2C6.8050303@imgtec.com>
Date: Tue, 15 Jul 2014 10:22:14 +0100
From: James Hogan <james.hogan@imgtec.com>
MIME-Version: 1.0
Subject: Re: [PATCH 23/38] metag: clean-up uapi Kbuild file
References: <20140714150609.GA28358@ravnborg.org> <1405350546-28467-1-git-send-email-sam@ravnborg.org> <1405350546-28467-23-git-send-email-sam@ravnborg.org>
In-Reply-To: <1405350546-28467-23-git-send-email-sam@ravnborg.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-metag <linux-metag@vger.kernel.org>
Message-ID: <20140715092214.vRHY1Acoe7GzfEH7H7ZkwkV3gRI-O70CnwRJ3SR4qjo@z>

On 14/07/14 16:08, Sam Ravnborg wrote:
> Remove redundant assignments.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: James Hogan <james.hogan@imgtec.com>

Acked-by: James Hogan <james.hogan@imgtec.com>

Thanks!
James

> ---
>  arch/metag/include/uapi/asm/Kbuild | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/metag/include/uapi/asm/Kbuild b/arch/metag/include/uapi/asm/Kbuild
> index ab78be2..1f7f43f 100644
> --- a/arch/metag/include/uapi/asm/Kbuild
> +++ b/arch/metag/include/uapi/asm/Kbuild
> @@ -1,14 +1,9 @@
>  # UAPI Header export list
>  include include/uapi/asm-generic/Kbuild.asm
>  
> -header-y += byteorder.h
>  header-y += ech.h
> -header-y += ptrace.h
> -header-y += sigcontext.h
> -header-y += siginfo.h
> -header-y += swab.h
> -header-y += unistd.h
>  
> +# Wrappers from asm-generic
>  generic-y += mman.h
>  generic-y += resource.h
>  generic-y += setup.h
> 
