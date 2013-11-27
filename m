From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH -tip v3 02/23] kprobes: Introduce NOKPROBE_SYMBOL() macro
	for blacklist
Date: Wed, 27 Nov 2013 14:32:24 +0100
Message-ID: <20131127133224.GD18422@gmail.com>
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal>
	<20131120042153.15296.82087.stgit@kbuild-fedora.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20131120042153.15296.82087.stgit@kbuild-fedora.novalocal>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: linux-arch@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Rob Landley <rob@landley.net>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alok Kataria <akataria@vmware.com>, systemtap@sourceware.org
List-Id: linux-arch.vger.kernel.org


* Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:

> +#ifdef CONFIG_KPROBES
> +/*
> + * Blacklist ganerating macro. Specify functions which is not probed
> + * by using this macro.
> + */
> +#define __NOKPROBE_SYMBOL(fname)				\
> +static struct kprobe_blackpoint __used			\
> +	_kprobe_bp_##fname = {				\
> +		.name = #fname,				\
> +		.start_addr = (unsigned long)fname,	\
> +	};						\
> +static struct kprobe_blackpoint __used			\
> +	__attribute__((section("_kprobe_blacklist")))	\
> +	*_p_kprobe_bp_##fname = &_kprobe_bp_##fname;

'kprobe_blackpoint' sounds a bit weird - how about 
'kprobe_blacklist_entry' ?

also, _kprobe_blacklist probably wants to be _kprobes_blacklist, 
right?

Thanks,

	Ingo
