From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v8 03/28] x86/asm: annotate relocate_kernel
Date: Thu, 15 Aug 2019 10:37:37 +0200
Message-ID: <20190815083737.GD15313@zn.tnic>
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-4-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190808103854.6192-4-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 08, 2019 at 12:38:29PM +0200, Jiri Slaby wrote:
> There are functions in relocate_kernel which are not annotated. This
					^
					_{32,64}.c

> makes automatic annotations rather hard. So annotate all the functions
> now.
> 
> Note that these are not C-like functions, so we do not use FUNC, but
> CODE markers. Also they are not aligned, so we use the NOALIGN versions:
> - SYM_CODE_START_NOALIGN
> - SYM_CODE_START_LOCAL_NOALIGN
> - SYM_CODE_END
> 
> In return, we get:
>   0000   108 NOTYPE  GLOBAL DEFAULT    1 relocate_kernel
>   006c   165 NOTYPE  LOCAL  DEFAULT    1 identity_mapped
>   0146   127 NOTYPE  LOCAL  DEFAULT    1 swap_pages
>   0111    53 NOTYPE  LOCAL  DEFAULT    1 virtual_mapped

It would be cool if those NOTYPE objects could be marked as OS-specific:

From /usr/include/elf.h:

#define STT_LOOS        10              /* Start of OS-specific */

to denote that they're special but gas doesn't seem to support that type
out of the box at least.

Oh well...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
