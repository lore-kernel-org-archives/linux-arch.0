From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH security-next v4 21/32] LSM: Finalize centralized LSM
 enabling logic
Date: Mon, 1 Oct 2018 18:18:31 -0700
Message-ID: <ccfbe049-392d-4df5-5eb5-ea18576d4afd@infradead.org>
References: <20181002005505.6112-1-keescook@chromium.org>
 <20181002005505.6112-22-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002005505.6112-22-keescook@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 10/1/18 5:54 PM, Kees Cook wrote:
> Prior to this patch, default "enable" behavior was unchanged: SELinux
> and AppArmor were controlled separately from the centralized control
> defined by CONFIG_LSM_ENABLE and "lsm.enable=...". This changes the
> logic to give all control over to the central logic.
> 
> Instead of allowing SELinux and AppArmor to override the central LSM
> enabling logic, by having separate CONFIG and boot parameters, this
> forces all "enable" variables to disabled, then enables any listed in
> the CONFIG_LSM_ENABLE and "lsm.enable=..." settings, and finally disables
> any listed in "lsm.disable=...".
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |  6 ++--
>  include/linux/lsm_hooks.h                     |  2 +-
>  security/security.c                           | 32 +++++++------------
>  3 files changed, 15 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 67c90985d2b8..f646cfab5613 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2279,14 +2279,12 @@
>  	lsm.disable=lsm1,...,lsmN
>  			[SECURITY] Comma-separated list of LSMs to disable
>  			at boot time. This overrides "lsm.enable=",

better:			              This overrides "lsm.enable=" and

> -			CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and boot
> -			parameters.
> +			CONFIG_LSM_ENABLE.
>  
>  	lsm.enable=lsm1,...,lsmN
>  			[SECURITY] Comma-separated list of LSMs to enable
>  			at boot time. This overrides any omissions from
> -			CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and
> -			boot parameters.
> +			CONFIG_LSM_ENABLE.
>  
>  	machvec=	[IA-64] Force the use of a particular machine-vector
>  			(machvec) in a generic kernel.


-- 
~Randy
