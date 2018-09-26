From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH security-next v3 04/29] LSM: Remove initcall tracing
Date: Wed, 26 Sep 2018 12:35:22 -0400
Message-ID: <20180926123522.4080d9eb@vmware.local.home>
References: <20180925001832.18322-1-keescook@chromium.org>
        <20180925001832.18322-5-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925001832.18322-5-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>, linux-security-module@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, 24 Sep 2018 17:18:07 -0700
Kees Cook <keescook@chromium.org> wrote:

> This partially reverts commit 58eacfffc417 ("init, tracing: instrument
> security and console initcall trace events") since security init calls
> are about to no longer resemble regular init calls.

I'm not against the change, but how much are they going to "no longer
resemble regular init calls"?

-- Steve

> 
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
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
