From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 3/8] x86: stop exporting msr-index.h to userland
Date: Fri, 10 Feb 2017 12:15:51 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1702101215320.4036@nanos>
References: <201702022242.toNVsxyq%fengguang.wu@intel.com> <1486724338-5389-1-git-send-email-nicolas.dichtel@6wind.com> <1486724338-5389-4-git-send-email-nicolas.dichtel@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486724338-5389-4-git-send-email-nicolas.dichtel@6wind.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, 10 Feb 2017, Nicolas Dichtel wrote:

> Even if this file was not in an uapi directory, it was exported because
> it was listed in the Kbuild file.
> 
> Fixes: b72e7464e4cf ("x86/uapi: Do not export <asm/msr-index.h> as part of the user API headers")
> Suggested-by: Borislav Petkov <bp@alien8.de>
> CC: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Acked-by: Ingo Molnar <mingo@kernel.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  arch/x86/include/uapi/asm/Kbuild | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/include/uapi/asm/Kbuild b/arch/x86/include/uapi/asm/Kbuild
> index 3dec769cadf7..1c532b3f18ea 100644
> --- a/arch/x86/include/uapi/asm/Kbuild
> +++ b/arch/x86/include/uapi/asm/Kbuild
> @@ -27,7 +27,6 @@ header-y += ldt.h
>  header-y += mce.h
>  header-y += mman.h
>  header-y += msgbuf.h
> -header-y += msr-index.h
>  header-y += msr.h
>  header-y += mtrr.h
>  header-y += param.h
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
