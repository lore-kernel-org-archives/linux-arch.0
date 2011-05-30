From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] ptrace: unify show_regs() prototype
Date: Mon, 30 May 2011 21:07:13 +0200
Message-ID: <20110530190713.GA20616@redhat.com>
References: <1302759489-10645-1-git-send-email-vapier@gentoo.org> <1306726753-16128-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1306726753-16128-1-git-send-email-vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 05/29, Mike Frysinger wrote:
>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
> andrew: can you pick this up ?  sent a few months ago w/no love.

The patch looks obviously fine, I can put it into ptrace tree.

Cough. Yes it is simple, but perhaps it still needs the changelog?
Even a single line.

One nit,

> --- a/include/linux/ptrace.h
> +++ b/include/linux/ptrace.h
> @@ -100,6 +100,7 @@
>  #include <linux/sched.h>		/* For struct task_struct.  */
>
>
> +extern void show_regs(struct pt_regs *);

Not sure ptrace.h is the right place. show_regs() has the callers which
have nothing to do with ptrace.

Hmm. You know what? show_regs() is already defined in sched.h, probably
you can simply remove this chunk.

Oleg.
