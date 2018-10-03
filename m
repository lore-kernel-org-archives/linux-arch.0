Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbeJDBrY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Oct 2018 21:47:24 -0400
Date: Wed, 3 Oct 2018 20:58:06 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
Subject: Re: [RFC PATCH v4 2/9] x86/cet/ibt: User-mode indirect branch
 tracking support
Message-ID: <20181003185802.GE32759@asgard.redhat.com>
References: <20180921150553.21016-1-yu-cheng.yu@intel.com>
 <20180921150553.21016-3-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921150553.21016-3-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20181003185806.3zFR0HnLOJzKgy7_VBJ_6gJaNntNO6E_hXXA6byf_OM@z>

On Fri, Sep 21, 2018 at 08:05:46AM -0700, Yu-cheng Yu wrote:

> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index bffa9ef47832..230f65ee881e 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c

> @@ -434,6 +435,23 @@ static __init int setup_disable_shstk(char *s)
>  __setup("no_cet_shstk", setup_disable_shstk);
>  #endif
>  
> +#ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
> +static __init int setup_disable_ibt(char *s)
> +{
> +	/* require an exact match without trailing characters */
> +	if (strlen(s))
> +		return 0;

"s[0] (!= '\0')" will do the same check in constant time.
