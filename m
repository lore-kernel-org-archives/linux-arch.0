From: John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH security-next v3 03/29] LSM: Rename .security_initcall
 section to .lsm_info
Date: Mon, 1 Oct 2018 14:06:18 -0700
Message-ID: <778ba591-0d76-f21d-165a-76db531a768d@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-4-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925001832.18322-4-keescook@chromium.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "Serge E. Hallyn" <serge@hallyn.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 09/24/2018 05:18 PM, Kees Cook wrote:
> In preparation for switching from initcall to just a regular set of
> pointers in a section, rename the internal section name.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>


Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>  include/asm-generic/vmlinux.lds.h | 10 +++++-----
>  include/linux/init.h              |  4 ++--
>  security/security.c               |  4 ++--
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 934a45395547..5079a969e612 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -787,14 +787,14 @@
>  		__con_initcall_end = .;
>  
>  #define SECURITY_INITCALL						\
> -		__security_initcall_start = .;				\
> -		KEEP(*(.security_initcall.init))			\
> -		__security_initcall_end = .;
> +		__start_lsm_info = .;					\
> +		KEEP(*(.lsm_info.init))					\
> +		__end_lsm_info = .;
>  
>  /* Older linker script style for security init. */
>  #define SECURITY_INIT							\
> -	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
> -		SECURITY_INITCALL					\
> +	.lsm_info.init : AT(ADDR(.lsm_info.init) - LOAD_OFFSET) {	\
> +		LSM_INFO						\
>  	}
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 2538d176dd1f..77636539e77c 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -133,7 +133,7 @@ static inline initcall_t initcall_from_entry(initcall_entry_t *entry)
>  #endif
>  
>  extern initcall_entry_t __con_initcall_start[], __con_initcall_end[];
> -extern initcall_entry_t __security_initcall_start[], __security_initcall_end[];
> +extern initcall_entry_t __start_lsm_info[], __end_lsm_info[];
>  
>  /* Used for contructor calls. */
>  typedef void (*ctor_fn_t)(void);
> @@ -236,7 +236,7 @@ extern bool initcall_debug;
>  	static exitcall_t __exitcall_##fn __exit_call = fn
>  
>  #define console_initcall(fn)	___define_initcall(fn,, .con_initcall)
> -#define security_initcall(fn)	___define_initcall(fn,, .security_initcall)
> +#define security_initcall(fn)	___define_initcall(fn,, .lsm_info)
>  
>  struct obs_kernel_param {
>  	const char *str;
> diff --git a/security/security.c b/security/security.c
> index 4cbcf244a965..892fe6b691cf 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -51,9 +51,9 @@ static void __init do_security_initcalls(void)
>  	initcall_t call;
>  	initcall_entry_t *ce;
>  
> -	ce = __security_initcall_start;
> +	ce = __start_lsm_info;
>  	trace_initcall_level("security");
> -	while (ce < __security_initcall_end) {
> +	while (ce < __end_lsm_info) {
>  		call = initcall_from_entry(ce);
>  		trace_initcall_start(call);
>  		ret = call();
> 
