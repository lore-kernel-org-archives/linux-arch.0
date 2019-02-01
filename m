From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v7 01/28] linkage: new macros for assembler symbols
Date: Fri, 1 Feb 2019 14:53:58 +0100
Message-ID: <2108c93f-835e-c887-78a6-91e63ec86bc6@suse.cz>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-2-jslaby@suse.cz> <20190131160019.GM6749@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131160019.GM6749@zn.tnic>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, hpa@zytor.com, Ingo Molnar <mingo@kernel.org>, jpoimboe@redhat.com, Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, xen-devel@lists.xenproject.org, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On 31. 01. 19, 17:00, Borislav Petkov wrote:
>>  Documentation/asm-annotations.rst | 217 ++++++++++++++++++++++++++
> 
> I guess you wanna integrate that into the doc hierarchy. Hunk ontop:
> 
> ---
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index c858c2e66e36..754055d9565c 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -91,6 +91,14 @@ needed).
>     vm/index
>     bpf/index
>  
> +Architecture-agnostic documentation
> +-----------------------------------
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   asm-annotations
> +
>  Architecture-specific documentation
>  -----------------------------------

Thanks, all comments applied.

I will wait for a couple of days for more feedback, if any, and respin.
Perhaps for the last time as these patches are slowly starting bother me
after two years of inability to get them upstream (without having NACK
or serious objections either) and the constant need of rebasing
(spectre/meltdown changes were the ugliest to this series).

thanks,
-- 
js
suse labs
