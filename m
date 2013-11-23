From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: Re: [PATCH -tip v3 13/23] x86/trap: Use NOKPROBE_SYMBOL macro
 in trap.c
Date: Sat, 23 Nov 2013 21:11:22 +0900
Message-ID: <52909B6A.7080905@hitachi.com>
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal> <20131120042221.15296.85443.stgit@kbuild-fedora.novalocal> <20131122212119.GE19762@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5]:37622 "EHLO
	mail4.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab3KWML0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 23 Nov 2013 07:11:26 -0500
In-Reply-To: <20131122212119.GE19762@tassilo.jf.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, systemtap@sourceware.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Seiji Aguchi <seiji.aguchi@hds.com>, "David S. Miller" <davem@davemloft.net>

(2013/11/23 6:21), Andi Kleen wrote:
> On Wed, Nov 20, 2013 at 04:22:21AM +0000, Masami Hiramatsu wrote:
>> Use NOKPROBE_SYMBOL macro to protect functions from kprobes
>> instead of __kprobes annotation in trap.c.
>> This also applies __always_inline annotation for some cases,
>> because NOKPROBE_SYMBOL() will inhibit inlining by referring
>> the symbol address.
> 
> NOKPROBE_SYMBOL seems to add a reference from some variable to the function?
> 
> With LTO we can optimize away unused functions, but not
> when there are references to the symbol. So this would likely
> prevent optimizations with LTO.

Hmm, indeed. I think I can remove the function reference if
the function name is unique, because the macro also stores the
name.
In that case, even if the function itself is optimized out and
there is no entry in kallsyms, we can just ignore it when init
the blacklist.

Thank you,

-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
