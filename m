From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH -tip v6 00/22] kprobes: introduce NOKPROBE_SYMBOL(), cleanup and fixes crash bugs
Date: Mon, 23 Dec 2013 14:04:38 +0100
Message-ID: <20131223130438.GA5076@gmail.com>
References: <20131219090353.14309.15496.stgit@kbuild-fedora.novalocal> <y0m38loefhx.fsf@fche.csb> <52B3C5E6.2040802@hitachi.com> <20131220082056.GA15934@gmail.com> <52B40E79.8040701@hitachi.com> <20131220104615.GA22609@gmail.com> <52B75542.7040600@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <systemtap-return-21863-gls-systemtap=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:systemtap-unsubscribe-##L=##H@sourceware.org>
List-Subscribe: <mailto:systemtap-subscribe@sourceware.org>
List-Post: <mailto:systemtap@sourceware.org>
List-Help: <mailto:systemtap-help@sourceware.org>, <http://sourceware.org/lists.html#faqs>
Sender: systemtap-owner@sourceware.org
Content-Disposition: inline
In-Reply-To: <52B75542.7040600@hitachi.com>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, systemtap@sourceware.org, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org


* Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:

> > I can reproduce one weirdness, with just 13 probes added, 'perf probe 
> > -l' [which should really be 'perf probe list'!] executes very slowly:
> > 
> >  # perf stat --null --repeat 3 perf probe -l
> > 
> >  Performance counter stats for 'perf probe -l' (3 runs):
> > 
> >        0.763640098 seconds time elapsed                                          ( +-  1.61% )
> > 
> > 0.7 seconds is ridiculously long.
> 
> This comes from the perf-probe's internal issue. It tries to get 
> actual lines and files by using debuginfo. I guess most of the time 
> consumed when processing huge kernel debuginfo.

No, I don't have any debuginfo, I never use it.

Thanks,

	Ingo
