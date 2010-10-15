Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:36058 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755249Ab0JOCvB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 Oct 2010 22:51:01 -0400
Date: Fri, 15 Oct 2010 04:50:47 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/3] ftrace/x86: Add support for C version of recordmcount
Message-ID: <20101015025047.GA9640@elte.hu>
References: <20101014210014.895157788@goodmis.org>
 <20101014210136.230687571@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20101014210136.230687571@goodmis.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org, John Reiser <jreiser@bitwagon.com>
Message-ID: <20101015025047.YXY1VrpeztYsUknJ3hkAyg5Ux7ABL-0dpPBeyy5gWHc@z>


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
