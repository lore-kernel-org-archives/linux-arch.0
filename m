From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC Patch v1 33/55] ARC: ptrace support
Date: Mon, 12 Nov 2012 13:51:05 +0000
Message-ID: <201211121351.06023.arnd@arndb.de>
References: <1352720953-24321-1-git-send-email-vgupta@synopsys.com> <1352720953-24321-3-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352720953-24321-3-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet.Gupta1@synopsys.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
List-Id: linux-arch.vger.kernel.org

On Monday 12 November 2012, Vineet.Gupta1@synopsys.com wrote:
> +       case PTRACE_PEEKUSR:
> +               pos = addr;     /* offset in struct user_regs_struct */
> +               count = 4;      /* 1 register only */
> +               u_addr = (unsigned int __user *)data;
> +               kbuf = NULL;
> +               ret = genregs_get(child, NULL, pos, count, kbuf, u_addr);
> +               break;
> +
> +       case PTRACE_POKEUSR:
> +               pos = addr;     /* offset in struct user_regs_struct */
> +               count = 4;      /* 1 register only */
> +
> +               /* Ideally @data would have abeen a user space buffer, from
> +                * where, we do a copy_from_user.
> +                * However this request only involves one word, which courtesy
> +                * our ABI can be passed in a reg.
> +                * regset interface however expects some buffer to copyin from
> +                */
> +               kbuf = &data;
> +               u_addr = NULL;
> +
> +               ret = genregs_set(child, NULL, pos, count, kbuf, u_addr);
> +               break;
> +

I think these should be moved into regsets, as we have done for all
other new architectures. Your arch_ptrace then becomes a trivial wrapper
around ptrace_request.

	Arnd
