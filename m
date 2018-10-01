From: John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH security-next v3 11/29] LSM: Introduce
 LSM_FLAG_LEGACY_MAJOR
Date: Mon, 1 Oct 2018 14:15:25 -0700
Message-ID: <2953e6ca-02d0-6a76-b97a-06109e1d2746@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-12-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925001832.18322-12-keescook@chromium.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 09/24/2018 05:18 PM, Kees Cook wrote:
> This adds a flag for the current "major" LSMs to distinguish them when
> we have a universal method for ordering all LSMs. It's called "legacy"
> since the distinction of "major" will go away in the blob-sharing world.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>  include/linux/lsm_hooks.h  | 3 +++
>  security/apparmor/lsm.c    | 1 +
>  security/selinux/hooks.c   | 1 +
>  security/smack/smack_lsm.c | 1 +
>  security/tomoyo/tomoyo.c   | 1 +
>  5 files changed, 7 insertions(+)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 543636f18152..5056f7374b3d 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2039,8 +2039,11 @@ extern char *lsm_names;
>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
>  				char *lsm);
>  
> +#define LSM_FLAG_LEGACY_MAJOR	BIT(0)
> +
>  struct lsm_info {
>  	const char *name;	/* Populated automatically. */
> +	unsigned long flags;	/* Optional: flags describing LSM */
>  	int (*init)(void);
>  };
>  
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 7fa7b4464cf4..4c5f63e9aeba 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1607,5 +1607,6 @@ static int __init apparmor_init(void)
>  }
>  
>  DEFINE_LSM(apparmor)
> +	.flags = LSM_FLAG_LEGACY_MAJOR,
>  	.init = apparmor_init,
>  END_LSM;
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 469a90806bc6..615cf6498c0f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7203,6 +7203,7 @@ void selinux_complete_init(void)
>  /* SELinux requires early initialization in order to label
>     all processes and objects when they are created. */
>  DEFINE_LSM(selinux)
> +	.flags = LSM_FLAG_LEGACY_MAJOR,
>  	.init = selinux_init,
>  END_LSM;
>  
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 1e1ace718e75..4aef844fc0e2 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4883,5 +4883,6 @@ static __init int smack_init(void)
>   * all processes and objects when they are created.
>   */
>  DEFINE_LSM(smack)
> +	.flags = LSM_FLAG_LEGACY_MAJOR,
>  	.init = smack_init,
>  END_LSM;
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index a280d4eab456..528b6244a648 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -551,5 +551,6 @@ static int __init tomoyo_init(void)
>  }
>  
>  DEFINE_LSM(tomoyo)
> +	.flags = LSM_FLAG_LEGACY_MAJOR,
>  	.init = tomoyo_init,
>  END_LSM;
> 
