Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:35347 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbZFAXkj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 1 Jun 2009 19:40:39 -0400
Date: Tue, 2 Jun 2009 01:40:06 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -tip v8 5/7] x86: add pt_regs register and stack access
	APIs
Message-ID: <20090601234006.GA12629@elte.hu>
References: <20090529000326.17532.70868.stgit@localhost.localdomain> <20090529000347.17532.34038.stgit@localhost.localdomain> <20090530081303.GB15755@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090530081303.GB15755@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Masami Hiramatsu <mhiramat@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, lkml <linux-kernel@vger.kernel.org>, systemtap <systemtap@sources.redhat.com>, kvm <kvm@vger.kernel.org>, DLE <dle-develop@lists.sourceforge.net>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Roland McGrath <roland@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20090601234006.-VRR0jAt0iYj1jfap9CEhVQVMfNWGeIP_DnMV2jalT0@z>


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
