From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: [PATCH -tip v6 00/22] kprobes: introduce NOKPROBE_SYMBOL(), cleanup and fixes crash bugs
Date: Fri, 20 Dec 2013 13:21:58 +0900
Message-ID: <52B3C5E6.2040802@hitachi.com>
References: <20131219090353.14309.15496.stgit@kbuild-fedora.novalocal> <y0m38loefhx.fsf@fche.csb>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <systemtap-return-21830-gls-systemtap=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:systemtap-unsubscribe-##L=##H@sourceware.org>
List-Subscribe: <mailto:systemtap-subscribe@sourceware.org>
List-Post: <mailto:systemtap@sourceware.org>
List-Help: <mailto:systemtap-help@sourceware.org>, <http://sourceware.org/lists.html#faqs>
Sender: systemtap-owner@sourceware.org
In-Reply-To: <y0m38loefhx.fsf@fche.csb>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, systemtap@sourceware.org, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

(2013/12/20 5:46), Frank Ch. Eigler wrote:
> 
> Hi, Masami -
> 
> 
> masami.hiramatsu.pt wrote:
> 
>> Here is the version 6 of NOKPROBE_SYMBOL series. :)
>> [...]
> 
> Some preliminary results from building these on top of tip/master on
> x86-64.  
> 
> # stap -te "probe kprobe.function("*") {}"
> 
> starts up OK, without crashes, which looks like great progress.

That's a good news :)

>  But a
> closer look indicates that the insertion of kprobes is taking about
> three (!!) orders of magnitude longer than before, as judged by the
> rate of increase of 'wc -l /sys/kernel/debug/kprobes/list'.

Right, because kprobes are not designed for thousands of probes.

>  So, one
> has to let the thing run for several hours just to get all the kprobes
> inserted, never mind letting stress-testing begin.
> 
> For reference, here's the steady-state "perf top" output during all this
> insertion work:
> 
>  54.81%  [kernel]                    [k] _raw_spin_unlock_irqrestore
>  38.13%  [kernel]                    [k] __slab_alloc
>   1.11%  [kernel]                    [k] kprobe_ftrace_handler
>   0.88%  [kernel]                    [k] _raw_spin_unlock_irq

Hmm, interesting. Those probes are registered as disabled?
Thank you,


-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
