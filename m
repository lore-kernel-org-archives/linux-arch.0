From: John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH security-next v3 02/29] vmlinux.lds.h: Avoid copy/paste of
 security_init section
Date: Mon, 1 Oct 2018 14:05:51 -0700
Message-ID: <6adced07-f3a9-a098-3f56-ba5fd2e03bcb@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-3-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925001832.18322-3-keescook@chromium.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 09/24/2018 05:18 PM, Kees Cook wrote:
> Avoid copy/paste by defining SECURITY_INIT in terms of SECURITY_INITCALL.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>


Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>  include/asm-generic/vmlinux.lds.h | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 7b75ff6e2fce..934a45395547 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -473,13 +473,6 @@
>  #define RODATA          RO_DATA_SECTION(4096)
>  #define RO_DATA(align)  RO_DATA_SECTION(align)
>  
> -#define SECURITY_INIT							\
> -	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
> -		__security_initcall_start = .;				\
> -		KEEP(*(.security_initcall.init))			\
> -		__security_initcall_end = .;				\
> -	}
> -
>  /*
>   * .text section. Map to function alignment to avoid address changes
>   * during second ld run in second ld pass when generating System.map
> @@ -798,6 +791,12 @@
>  		KEEP(*(.security_initcall.init))			\
>  		__security_initcall_end = .;
>  
> +/* Older linker script style for security init. */
> +#define SECURITY_INIT							\
> +	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
> +		SECURITY_INITCALL					\
> +	}
> +
>  #ifdef CONFIG_BLK_DEV_INITRD
>  #define INIT_RAM_FS							\
>  	. = ALIGN(4);							\
> 
