From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: [PATCH -tip v6 00/22] kprobes: introduce NOKPROBE_SYMBOL(), cleanup and fixes crash bugs
Date: Fri, 20 Dec 2013 18:31:37 +0900
Message-ID: <52B40E79.8040701@hitachi.com>
References: <20131219090353.14309.15496.stgit@kbuild-fedora.novalocal> <y0m38loefhx.fsf@fche.csb> <52B3C5E6.2040802@hitachi.com> <20131220082056.GA15934@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <systemtap-return-21835-gls-systemtap=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:systemtap-unsubscribe-##L=##H@sourceware.org>
List-Subscribe: <mailto:systemtap-subscribe@sourceware.org>
List-Post: <mailto:systemtap@sourceware.org>
List-Help: <mailto:systemtap-help@sourceware.org>, <http://sourceware.org/lists.html#faqs>
Sender: systemtap-owner@sourceware.org
In-Reply-To: <20131220082056.GA15934@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, systemtap@sourceware.org, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

(2013/12/20 17:20), Ingo Molnar wrote:
> 
> * Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:
> 
>>>  But a closer look indicates that the insertion of kprobes is 
>>> taking about three (!!) orders of magnitude longer than before, as 
>>> judged by the rate of increase of 'wc -l 
>>> /sys/kernel/debug/kprobes/list'.
>>
>> Right, because kprobes are not designed for thousands of probes.
> 
> Then this needs to be fixed, because right now this bug is making it 
> near impossible to properly test kprobes robustness.
> 
> For example a hash table (hashed by probe address) could be used in 
> addition to the list, to speed up basic operations.

kprobe itself is already using hlist (6bits hash table).
Maybe we'd better expand the table bits. However, the iteration
of the list on debugfs is just doing seq_printf()s. I'm not exactly
sure what Frank complaints about...
I recommend Frank to use perf record and perf annotation to clarify
which part caused that slow down.

Thank you,

-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
