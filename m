From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 1/2] powerpc: Discard .rela* sections if
 CONFIG_RELOCATABLE is undefined
Date: Tue, 28 Apr 2020 07:31:38 +0200
Message-ID: <55518443-1ab4-1961-beb5-43e9e41e3227@c-s.fr>
References: <20200428014900.407098-1-hjl.tools@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:9824 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgD1Fbt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Apr 2020 01:31:49 -0400
In-Reply-To: <20200428014900.407098-1-hjl.tools@gmail.com>
Content-Language: fr
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Borislav Petkov <bp@suse.de>, linuxppc-dev@lists.ozlabs.org

Hi,

Le 28/04/2020 à 03:48, H.J. Lu a écrit :
> arch/powerpc/kernel/vmlinux.lds.S has
> 
>          DISCARDS
>          /DISCARD/ : {
>                  *(*.EMB.apuinfo)
>                  *(.glink .iplt .plt .rela* .comment)
>                  *(.gnu.version*)
>                  *(.gnu.attributes)
>                  *(.eh_frame)
>          }
> 
> Since .rela* sections are needed when CONFIG_RELOCATABLE is defined,
> change to discard .rela* sections if CONFIG_RELOCATABLE is undefined.

Your explanation and especially the subject are unclear.

 From the subject you understand that you are adding a discard of the 
.rela* sections if CONFIG_RELOCATABLE is undefined.

But when reading the patch, you see that it is the contrary: you are 
removing a discard of the .rela* sections if CONFIG_RELOCATABLE is defined.


So I think the subject could instead be:

	Only discard .rela* sections when CONFIG_RELOCATABLE is undefined

Or maybe better:

	Keep .rela* sections when CONFIG_RELOCATABLE is defined

And the explanation could be:

	Since .rela* sections are needed when CONFIG_RELOCATABLE
	is defined, don't discard .rela* sections if
	CONFIG_RELOCATABLE is defined.

> 
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> ---
>   arch/powerpc/kernel/vmlinux.lds.S | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index 31a0f201fb6f..4ba07734a210 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -366,9 +366,12 @@ SECTIONS
>   	DISCARDS
>   	/DISCARD/ : {
>   		*(*.EMB.apuinfo)
> -		*(.glink .iplt .plt .rela* .comment)
> +		*(.glink .iplt .plt .comment)
>   		*(.gnu.version*)
>   		*(.gnu.attributes)
>   		*(.eh_frame)
> +#ifndef CONFIG_RELOCATABLE
> +		*(.rela*)
> +#endif
>   	}
>   }
> 

Christophe
