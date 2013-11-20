From: "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [PATCH -tip v3 00/23] kprobes: introduce NOKPROBE_SYMBOL() and general cleaning of kprobe blacklist
Date: Wed, 20 Nov 2013 12:36:00 -0500
Message-ID: <20131120173600.GK8993@redhat.com>
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal> <y0mvbznxi6k.fsf@fche.csb> <20131120153801.GA9743@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21972 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283Ab3KTRgW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Nov 2013 12:36:22 -0500
Content-Disposition: inline
In-Reply-To: <20131120153801.GA9743@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, systemtap@sourceware.org, "David S. Miller" <davem@davemloft.net>

Hi -

> > Does this new blacklist cover enough that the kernel now survives a 
> > broadly wildcarded perf-probe, e.g. over e.g. all of its kallsyms?
> 
> That's generally the purpose of the annotations - if it doesn't then 
> that's a bug.

AFAIK, no kernel since kprobes was introduced has ever stood up to
that test.  perf probe lacks the wildcarding powers of systemtap, so
one needs to resort to something like:

# cat /proc/kallsyms | grep ' [tT] ' | while read addr type symbol; do
   perf probe $symbol
done

then wait for a few hours for that to finish. Then, or while the loop
is still running, run

# perf record -e 'probe:*' -aR sleep 1

to take a kernel down.


- FChE
