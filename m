From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 02/30] x86-64: Use explicit sizes in sigcontext.h, prepare
 for x32
Date: Wed, 22 Feb 2012 13:55:23 -0800
Message-ID: <4F45644B.2070904@zytor.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com> <201202221222.58399.arnd@arndb.de> <4F453086.8030602@zytor.com> <201202222123.38816.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201202222123.38816.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, akpm@linux-foundation.org, hjl.tools@gmail.com
List-Id: linux-arch.vger.kernel.org

On 02/22/2012 01:23 PM, Arnd Bergmann wrote:
> 
> Depends on how you want to do it. In some cases, the easiest answer
> would be to change the data structure to use __u64 and be compatible
> with i386. Once there are distros built using data structure with
> padding around a long long, you have to use a run-time conditional
> in the compat handler.
> 

That we'd like to avoid, but as you said, they'd be broken or might
already be broken.

> I'd say we should fix at least the ones that are easy to spot because
> they already use compat_u64 or have an #ifdef CONFIG_X86_64 in compat
> code. I've looked at everything I could find that fits into that category
> and found only two locations. My expectation is that all other data
> structures that would fall into this category are already broken
> for 32 bit emulation on x86.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/include/drm/drm.h b/include/drm/drm.h
> index 49d94ed..73b7c33 100644
> --- a/include/drm/drm.h
> +++ b/include/drm/drm.h
> @@ -438,7 +438,7 @@ struct drm_update_draw {
>  	drm_drawable_t handle;
>  	unsigned int type;
>  	unsigned int num;
> -	unsigned long long data;
> +	__u64 data;
>  };
>  
>  /**
> diff --git a/include/sound/asound.h b/include/sound/asound.h
> index a2e4ff5..a17e96c 100644
> --- a/include/sound/asound.h
> +++ b/include/sound/asound.h
> @@ -824,8 +824,8 @@ struct snd_ctl_elem_value {
>  			long *value_ptr;	/* obsoleted */
>  		} integer;
>  		union {
> -			long long value[64];
> -			long long *value_ptr;	/* obsoleted */
> +			__s64 value[64];
> +			__s64 *value_ptr;	/* obsoleted */
>  		} integer64;
>  		union {
>  			unsigned int item[128];
> 	Arnd

Right, those are good starts.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
