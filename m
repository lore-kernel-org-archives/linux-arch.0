From: "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [PATCH -tip v6 00/22] kprobes: introduce NOKPROBE_SYMBOL(), cleanup and fixes crash bugs
Date: Sun, 9 Feb 2014 16:27:24 -0500
Message-ID: <20140209212724.GA6892@redhat.com>
References: <20131219090353.14309.15496.stgit@kbuild-fedora.novalocal> <y0m38loefhx.fsf@fche.csb> <52B3C5E6.2040802@hitachi.com> <20131220082056.GA15934@gmail.com> <52B40E79.8040701@hitachi.com> <20131220104615.GA22609@gmail.com> <52E8E487.2090007@hitachi.com> <20140209143709.GA31608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <systemtap-return-21992-gls-systemtap=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:systemtap-unsubscribe-gls-systemtap=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:systemtap-subscribe@sourceware.org>
List-Post: <mailto:systemtap@sourceware.org>
List-Help: <mailto:systemtap-help@sourceware.org>, <http://sourceware.org/lists.html#faqs>
Sender: systemtap-owner@sourceware.org
Content-Disposition: inline
In-Reply-To: <20140209143709.GA31608@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, systemtap@sourceware.org, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

Hi -

> > So the similar thing happens when we enables events as below;
> > 
> >   # for i in /sys/kernel/debug/tracing/events/kprobes/* ; do date; echo 1 > $i; done
> >   Wed Jan 29 10:44:50 UTC 2014
> >   ...
> >
> > I tried it and canceled after 4 min passed. It enabled about 17k 
> > events and slowed down my system very much(I almost got hang check 
> > timer).
> 
> Ok, I guess that's the slowdown bug that Frank reported.

It could be, but it feels a bit different.  In my testing from
December, it's as though it wasn't the activated probes *hitting* that
were associated with the slowdown, but them merely being activated.
It was as though something with the kprobes/ftrace probe-registration
code performed a lot more work than it did longer ago.  (One way to
test this could be to be more careful in the selection of kprobes
being enabled.  For examle, emplace thousands, but only unused loaded
modules.)  I'm sorry I didn't get time to investigate further.

- FChE
