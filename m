From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: [PATCH -tip v6 00/22] kprobes: introduce NOKPROBE_SYMBOL(), cleanup
 and fixes crash bugs
Date: Mon, 10 Feb 2014 13:02:41 +0900
Message-ID: <52F84F61.7060103@hitachi.com>
References: <20131219090353.14309.15496.stgit@kbuild-fedora.novalocal> <y0m38loefhx.fsf@fche.csb> <52B3C5E6.2040802@hitachi.com> <20131220082056.GA15934@gmail.com> <52B40E79.8040701@hitachi.com> <20131220104615.GA22609@gmail.com> <52E8E487.2090007@hitachi.com> <20140209143709.GA31608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140209143709.GA31608@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, systemtap@sourceware.org, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

(2014/02/09 23:37), Ingo Molnar wrote:
> 
> * Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:
> 
>> I guess the second reason is why the stap takes so long time to set 
>> probes. stap tries to register kprobes without disabled flag, that 
>> means we enables thousands of probes (overheads).
>>
>> So the similar thing happens when we enables events as below;
>>
>>   # for i in /sys/kernel/debug/tracing/events/kprobes/* ; do date; echo 1 > $i; done
>>   Wed Jan 29 10:44:50 UTC 2014
>>   ...
>>
>> I tried it and canceled after 4 min passed. It enabled about 17k 
>> events and slowed down my system very much(I almost got hang check 
>> timer).
> 
> Ok, I guess that's the slowdown bug that Frank reported.
> 
>> I think we should have some performance statistics (hit count?) and 
>> if it goes over a threshold, we should stop enabling other events.
> 
> That really feels like a hack. How about fixing the root cause? Does 
> the enabling of all probes have to be so slow?

When I tried to use perf top, most of the time was consumed in
kprobe_ftrace_handler and optimized_callback, both of them
are the handler of kprobes. Since I just tried on a VM guest and it
didn't support NMI nor PMU, thus I have to use a bare metal machine
for deeper investigation (and I'll do).
And yes, it seems that the performance problem comes from probing
and tracing itself.

Thank you,

-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
