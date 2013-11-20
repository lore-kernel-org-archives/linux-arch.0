From: fche@redhat.com (Frank Ch. Eigler)
Subject: Re: [PATCH -tip v3 00/23] kprobes: introduce NOKPROBE_SYMBOL() and general cleaning of kprobe blacklist
Date: Wed, 20 Nov 2013 09:26:59 -0500
Message-ID: <y0mvbznxi6k.fsf@fche.csb>
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13885 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858Ab3KTO1c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Nov 2013 09:27:32 -0500
In-Reply-To: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal> (Masami Hiramatsu's message of "Wed, 20 Nov 2013 04:21:48 +0000")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, systemtap@sourceware.org, "David S. Miller" <davem@davemloft.net>


masami.hiramatsu.pt wrote:

> [...]  This series also includes a change which prohibits probing on
> the address in .entry.text because the code is used for very
> low-level sensitive interrupt/syscall entries. Probing such code may
> cause unexpected result (actually most of that area is already in
> the kprobe blacklist).  So I've decide to prohibit probing all of
> them. [...]

Does this new blacklist cover enough that the kernel now survives a
broadly wildcarded perf-probe, e.g. over e.g. all of its kallsyms?


- FChE
