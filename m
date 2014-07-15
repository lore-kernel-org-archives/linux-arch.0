From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 23/38] metag: clean-up uapi Kbuild file
Date: Tue, 15 Jul 2014 10:22:14 +0100
Message-ID: <53C4F2C6.8050303@imgtec.com>
References: <20140714150609.GA28358@ravnborg.org> <1405350546-28467-1-git-send-email-sam@ravnborg.org> <1405350546-28467-23-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1405350546-28467-23-git-send-email-sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-metag <linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On 14/07/14 16:08, Sam Ravnborg wrote:
> Remove redundant assignments.
> 
> Signed-off-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
> Cc: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

Acked-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

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
--
To unsubscribe from this list: send the line "unsubscribe linux-metag" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
