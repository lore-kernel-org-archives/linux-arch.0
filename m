From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v2 7/7] bug: Move WARN_ON() "cut here" into exception
 handler
Date: Tue, 10 Sep 2019 01:05:39 +0900
Message-ID: <20190909160539.GA989@tigerII.localdomain>
References: <201908200943.601DD59DCE@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201908200943.601DD59DCE@keescook>
Sender: linux-kernel-owner@vger.kernel.org
To: 20190819234111.9019-8-keescook@chromium.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, Drew Davenport <ddavenport@chromium.org>, Arnd Bergmann <arnd@arndb.de>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On (08/20/19 09:47), Kees Cook wrote:
[..]
> @@ -181,6 +181,15 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
>  		}
>  	}
>  
> +	/*
> +	 * BUG() and WARN_ON() families don't print a custom debug message
> +	 * before triggering the exception handler, so we must add the
> +	 * "cut here" line now. WARN() issues its own "cut here" before the
> +	 * extra debugging message it writes before triggering the handler.
> +	 */
> +	if ((bug->flags & BUGFLAG_NO_CUT_HERE) == 0)
> +		printk(KERN_DEFAULT CUT_HERE);

Shouldn't this be pr_warn() or pr_crit()?

	-ss
