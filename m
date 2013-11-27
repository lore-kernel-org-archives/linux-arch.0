Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44]:40848 "EHLO
	mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758996Ab3K0BiS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2013 20:38:18 -0500
Message-ID: <52954D04.8090101@hitachi.com>
Date: Wed, 27 Nov 2013 10:38:12 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
Subject: Re: Re: [PATCH -tip v3 13/23] x86/trap: Use NOKPROBE_SYMBOL macro
 in trap.c
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal> <20131120042221.15296.85443.stgit@kbuild-fedora.novalocal> <20131122212119.GE19762@tassilo.jf.intel.com>
In-Reply-To: <20131122212119.GE19762@tassilo.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, systemtap@sourceware.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Seiji Aguchi <seiji.aguchi@hds.com>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20131127013812.SKDm0H-6IToeLrnEFvesSpRGBV9gruDiZPc6XYI1pvw@z>

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

After considering this problem deeper, I decide to say NO against
to your opinion. IMHO, the LTO is just an optimization, on the other
hand, NOKPROBE_SYMBOL is more important because it is for avoiding
kernel crash. I mean, the safety and stability should be prior to
the performance. Anyway, such side-effect of NOKPROBE_SYMBOL looks
very limited. Perhaps, less than 1% of functions will be marked.
How much does it affect for the optimization?

Thank you,

-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com


