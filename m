Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42]:53811 "EHLO
	mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426Ab3KUCPL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 Nov 2013 21:15:11 -0500
Message-ID: <528D6C9F.8050809@hitachi.com>
Date: Thu, 21 Nov 2013 11:14:55 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
Subject: Re: [PATCH -tip v3 00/23] kprobes: introduce NOKPROBE_SYMBOL() and
 general cleaning of kprobe blacklist
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal> <y0mvbznxi6k.fsf@fche.csb> <20131120153801.GA9743@gmail.com> <20131120173600.GK8993@redhat.com>
In-Reply-To: <20131120173600.GK8993@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, systemtap@sourceware.org, "David S. Miller" <davem@davemloft.net>
Message-ID: <20131121021455.yLtdLOIpa2E6crsFYsAwHZGG_aGD440qMUVRyBHKHkM@z>

(2013/11/21 2:36), Frank Ch. Eigler wrote:
> Hi -
> 
>>> Does this new blacklist cover enough that the kernel now survives a 
>>> broadly wildcarded perf-probe, e.g. over e.g. all of its kallsyms?
>>
>> That's generally the purpose of the annotations - if it doesn't then 
>> that's a bug.
> 
> AFAIK, no kernel since kprobes was introduced has ever stood up to
> that test.  perf probe lacks the wildcarding powers of systemtap, so
> one needs to resort to something like:
> 
> # cat /proc/kallsyms | grep ' [tT] ' | while read addr type symbol; do
>    perf probe $symbol
> done
> 
> then wait for a few hours for that to finish. Then, or while the loop
> is still running, run
> 
> # perf record -e 'probe:*' -aR sleep 1
> 
> to take a kernel down.

Um, indeed, current blacklist is not perfect. As I reported in this
series, I've found 2 more patterns. I guess there still have some
others.

But anyway, I don't think it is good to fix all such bugs
in this series.
This is just the first step to do it. :)

Thank you,

-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com


