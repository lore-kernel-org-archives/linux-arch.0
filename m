From: John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH security-next v3 04/29] LSM: Remove initcall tracing
Date: Mon, 1 Oct 2018 14:07:55 -0700
Message-ID: <b169724f-c6c2-f4c0-806b-c8e23819ea6a@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-5-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925001832.18322-5-keescook@chromium.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>, Steven Rostedt <rostedt@goodmis.org>, linux-security-module@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 09/24/2018 05:18 PM, Kees Cook wrote:
> This partially reverts commit 58eacfffc417 ("init, tracing: instrument
> security and console initcall trace events") since security init calls
> are about to no longer resemble regular init calls.
> 
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>


Reviewed-by: John Johansen <john.johansen@canonical.com>

though I do think it would be a good idea to add a new set
of trace points, but that can come as a separate patch

> ---
>  security/security.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 892fe6b691cf..41a5da2c7faf 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -30,8 +30,6 @@
>  #include <linux/string.h>
>  #include <net/flow.h>
>  
> -#include <trace/events/initcall.h>
> -
>  #define MAX_LSM_EVM_XATTR	2
>  
>  /* Maximum number of letters for an LSM name string */
> @@ -47,17 +45,13 @@ static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
>  
>  static void __init do_security_initcalls(void)
>  {
> -	int ret;
>  	initcall_t call;
>  	initcall_entry_t *ce;
>  
>  	ce = __start_lsm_info;
> -	trace_initcall_level("security");
>  	while (ce < __end_lsm_info) {
>  		call = initcall_from_entry(ce);
> -		trace_initcall_start(call);
> -		ret = call();
> -		trace_initcall_finish(call, ret);
> +		call();
>  		ce++;
>  	}
>  }
> 
