From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH -tip v3 13/23] x86/trap: Use NOKPROBE_SYMBOL macro in
 trap.c
Date: Fri, 22 Nov 2013 13:21:19 -0800
Message-ID: <20131122212119.GE19762@tassilo.jf.intel.com>
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal>
 <20131120042221.15296.85443.stgit@kbuild-fedora.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28007 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755248Ab3KVVVU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 22 Nov 2013 16:21:20 -0500
Content-Disposition: inline
In-Reply-To: <20131120042221.15296.85443.stgit@kbuild-fedora.novalocal>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, systemtap@sourceware.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Seiji Aguchi <seiji.aguchi@hds.com>, "David S. Miller" <davem@davemloft.net>

On Wed, Nov 20, 2013 at 04:22:21AM +0000, Masami Hiramatsu wrote:
> Use NOKPROBE_SYMBOL macro to protect functions from kprobes
> instead of __kprobes annotation in trap.c.
> This also applies __always_inline annotation for some cases,
> because NOKPROBE_SYMBOL() will inhibit inlining by referring
> the symbol address.

NOKPROBE_SYMBOL seems to add a reference from some variable to the function?

With LTO we can optimize away unused functions, but not
when there are references to the symbol. So this would likely
prevent optimizations with LTO.

I prefer a simpler "__kprobe" annotation.

-Andi
