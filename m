From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: [PATCH -tip v3 02/23] kprobes: Introduce NOKPROBE_SYMBOL() macro
 for blacklist
Date: Thu, 28 Nov 2013 16:56:15 +0900
Message-ID: <5296F71F.9070603@hitachi.com>
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal> <20131120042153.15296.82087.stgit@kbuild-fedora.novalocal> <20131127133224.GD18422@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42]:40225 "EHLO
	mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935Ab3K1H4m (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Nov 2013 02:56:42 -0500
In-Reply-To: <20131127133224.GD18422@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rob Landley <rob@landley.net>, systemtap@sourceware.org, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, "David S. Miller" <davem@davemloft.net>

(2013/11/27 22:32), Ingo Molnar wrote:
> 
> * Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:
> 
>> +#ifdef CONFIG_KPROBES
>> +/*
>> + * Blacklist ganerating macro. Specify functions which is not probed
>> + * by using this macro.
>> + */
>> +#define __NOKPROBE_SYMBOL(fname)				\
>> +static struct kprobe_blackpoint __used			\
>> +	_kprobe_bp_##fname = {				\
>> +		.name = #fname,				\
>> +		.start_addr = (unsigned long)fname,	\
>> +	};						\
>> +static struct kprobe_blackpoint __used			\
>> +	__attribute__((section("_kprobe_blacklist")))	\
>> +	*_p_kprobe_bp_##fname = &_kprobe_bp_##fname;
> 
> 'kprobe_blackpoint' sounds a bit weird - how about 
> 'kprobe_blacklist_entry' ?

OK, I just tried to reuse existed kprobe_blacklist.

> also, _kprobe_blacklist probably wants to be _kprobes_blacklist, 
> right?

I sse. I'll update it. :)

Thank you,

-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
