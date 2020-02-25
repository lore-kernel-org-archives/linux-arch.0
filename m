From: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v9 11/27] drm/i915/gvt: Change _PAGE_DIRTY to
 _PAGE_DIRTY_BITS
Date: Tue, 25 Feb 2020 12:13:34 -0800
Message-ID: <202002251213.DFD1E3E27@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-12-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38021 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbgBYUNh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 15:13:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id p7so259500pli.5
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 12:13:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-12-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel

On Wed, Feb 05, 2020 at 10:19:19AM -0800, Yu-cheng Yu wrote:
> After the introduction of _PAGE_DIRTY_SW, a dirty PTE can have either
> _PAGE_DIRTY_HW or _PAGE_DIRTY_SW.  Change _PAGE_DIRTY to _PAGE_DIRTY_BITS.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/gpu/drm/i915/gvt/gtt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
> index 4b04af569c05..e467ca182633 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -1201,7 +1201,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
>  	}
>  
>  	/* Clear dirty field. */
> -	se->val64 &= ~_PAGE_DIRTY;
> +	se->val64 &= ~_PAGE_DIRTY_BITS;
>  
>  	ops->clear_pse(se);
>  	ops->clear_ips(se);
> -- 
> 2.21.0
> 

-- 
Kees Cook
