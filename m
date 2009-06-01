From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -tip v8 5/7] x86: add pt_regs register and stack access
	APIs
Date: Tue, 2 Jun 2009 01:40:06 +0200
Message-ID: <20090601234006.GA12629@elte.hu>
References: <20090529000326.17532.70868.stgit@localhost.localdomain> <20090529000347.17532.34038.stgit@localhost.localdomain> <20090530081303.GB15755@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090530081303.GB15755@infradead.org>
Sender: kvm-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Masami Hiramatsu <mhiramat@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, lkml <linux-kernel@vger.kernel.org>, systemtap <systemtap@sources.redhat.com>, kvm <kvm@vger.kernel.org>, DLE <dle-develop@lists.sourceforge.net>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Roland McGrath <roland@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> > +	if (n < NR_REGPARMS) {
> > +		switch (n) {
> > +		case 0: return regs->ax;
> > +		case 1: return regs->dx;
> > +		case 2: return regs->cx;
> > +		}
> 
> Normal kernel style would be
> 
> 		switch (n) {
> 		case 0:
> 			return regs->ax;
> 		case 1:
> 			return regs->dx;
> 		case 2:
> 			return regs->cx;
> 		}

the original single-line shortcut is acceptable too.

	Ingo
