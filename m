From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v5 1/5] parisc: move __IGNORE* entries to non uapi header
Date: Thu, 18 Oct 2018 20:34:27 +0200
Message-ID: <3571b003-d603-9ec5-01e3-12dbbca692b1@gmx.de>
References: <1539673418-7279-1-git-send-email-firoz.khan@linaro.org>
 <1539673418-7279-2-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539673418-7279-2-git-send-email-firoz.khan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>, linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

On 16.10.2018 09:03, Firoz Khan wrote:
> All the __IGNORE* entries are resides in the uapi header
> file move to non uapi header asm/unistd.h as it is not
> used by any user space applications.
> 
> It is correct to keep __IGNORE* entry in non uapi header
> asm/unistd.h while uapi/asm/unistd.h must hold information
> only useful for user space applications.
> 
> One of the patch in this patch series will generate uapi
> header file. The information which directly used by the
> user space application must be present in uapi file.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

You may add an 
Acked-by: Helge Deller <deller@gmx.de>

I've tested it by sucessfully booting a 32bit kernel.

Thanks!
Helge


> ---
>  arch/parisc/include/asm/unistd.h      | 6 ++++++
>  arch/parisc/include/uapi/asm/unistd.h | 7 -------
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
> index 3d507d0..93fd9f6 100644
> --- a/arch/parisc/include/asm/unistd.h
> +++ b/arch/parisc/include/asm/unistd.h
> @@ -8,6 +8,12 @@
>  
>  #define SYS_ify(syscall_name)   __NR_##syscall_name
>  
> +#define __IGNORE_select                /* newselect */
> +#define __IGNORE_fadvise64             /* fadvise64_64 */
> +#define __IGNORE_pkey_mprotect
> +#define __IGNORE_pkey_alloc
> +#define __IGNORE_pkey_free
> +
>  #ifndef ASM_LINE_SEP
>  # define ASM_LINE_SEP ;
>  #endif
> diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
> index dc77c5a..bb52e12 100644
> --- a/arch/parisc/include/uapi/asm/unistd.h
> +++ b/arch/parisc/include/uapi/asm/unistd.h
> @@ -368,13 +368,6 @@
>  
>  #define __NR_Linux_syscalls	(__NR_io_pgetevents + 1)
>  
> -
> -#define __IGNORE_select		/* newselect */
> -#define __IGNORE_fadvise64	/* fadvise64_64 */
> -#define __IGNORE_pkey_mprotect
> -#define __IGNORE_pkey_alloc
> -#define __IGNORE_pkey_free
> -
>  #define LINUX_GATEWAY_ADDR      0x100
>  
>  #endif /* _UAPI_ASM_PARISC_UNISTD_H_ */
> 
