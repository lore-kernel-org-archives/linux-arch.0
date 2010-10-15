From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/3] ftrace/x86: Add support for C version of recordmcount
Date: Fri, 15 Oct 2010 04:50:47 +0200
Message-ID: <20101015025047.GA9640@elte.hu>
References: <20101014210014.895157788@goodmis.org>
 <20101014210136.230687571@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101014210136.230687571@goodmis.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org, John Reiser <jreiser@bitwagon.com>
List-Id: linux-arch.vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <srostedt@redhat.com>
> 
> This patch adds the support for the C version of recordmcount and
> compile times show ~ 12% improvement.

I reported this recordmcount performance problem 2 years ago. Better 
later than never i guess.

> +ifdef CONFIG_DYNAMIC_FTRACE
> +	ifdef CONFIG_HAVE_C_MCOUNT_RECORD
> +		BUILD_C_RECORDMCOUNT := y
> +		export BUILD_C_RECORDMCOUNT

> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -33,6 +33,7 @@ config X86
>  	select HAVE_KRETPROBES
>  	select HAVE_OPTPROBES
>  	select HAVE_FTRACE_MCOUNT_RECORD
> +	select HAVE_C_MCOUNT_RECORD

The naming is inconsistent here - it should be HAVE_C_RECORDMCOUNT, like 
the build variable has, and like the utility is called. If we are going 
to add this flag to most architectures we should name it consistently.

Thanks,

	Ingo
