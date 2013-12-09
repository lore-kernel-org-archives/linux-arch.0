From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip v5 12/18] ftrace/kprobes: Use NOKPROBE_SYMBOL macro
 in ftrace
Date: Mon, 9 Dec 2013 12:04:50 -0500
Message-ID: <20131209120450.4da43296@gandalf.local.home>
References: <20131209104717.13397.8864.stgit@kbuild-fedora.novalocal>
	<20131209104746.13397.22146.stgit@kbuild-fedora.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:26878 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1761269Ab3LIREw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Dec 2013 12:04:52 -0500
In-Reply-To: <20131209104746.13397.22146.stgit@kbuild-fedora.novalocal>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, systemtap@sourceware.org, "David S. Miller" <davem@davemloft.net>

On Mon, 09 Dec 2013 10:47:46 +0000
Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:


> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -124,8 +124,8 @@ struct probe_arg {
>  	const struct fetch_type	*type;	/* Type of this argument */
>  };
>  
> -static inline __kprobes void call_fetch(struct fetch_param *fprm,
> -				 struct pt_regs *regs, void *dest)
> +static inline void call_fetch(struct fetch_param *fprm,
> +			      struct pt_regs *regs, void *dest)
>  {
>  	return fprm->fn(regs, fprm->data, dest);
>  }
> 

Is this OK to be probed? I've had cases where a header "static inline"
was not always inlined. Unless you have "__always_inline" this is not
guaranteed to be inlined.

As for the rest of the patch:

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
