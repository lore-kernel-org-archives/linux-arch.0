From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 2/6] avr32: get rid of useless args in signal.c before
 other work there
Date: Mon, 1 Nov 2010 08:02:01 +0000
Message-ID: <20101101080201.GZ19804@ZenIV.linux.org.uk>
References: <E1P0QNo-0008S7-Vr@ZenIV.linux.org.uk>
 <1288598309.2843.12.camel@hcegtvedt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1288598309.2843.12.camel@hcegtvedt>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 01, 2010 at 08:58:29AM +0100, Hans-Christian Egtvedt wrote:
> On Tue, 2010-09-28 at 03:57 +0100, Al Viro wrote: 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> <snipp>
> 
> > @@ -261,11 +261,12 @@ handle_signal(unsigned long sig, struct k_sigaction *ka, siginfo_t *info,
> >   * doesn't want to handle. Thus you cannot kill init even with a
> >   * SIGKILL even by mistake.
> >   */
> > -int do_signal(struct pt_regs *regs, sigset_t *oldset, int syscall)
> > +static void do_signal(struct pt_regs *regs, int syscall)
> >  {
> >  	siginfo_t info;
> >  	int signr;
> >  	struct k_sigaction ka;
> > +	sigset_t *oldset;
> 
> Should be initialized as it is checked in the else if block further
> below.

That else if should be simply else...
