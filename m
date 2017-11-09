From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 17/31] nds32: Signal handling support
Date: Thu, 9 Nov 2017 01:26:20 +0000
Message-ID: <20171109012620.GY21978@ZenIV.linux.org.uk>
References: <cover.1510118606.git.green.hu@gmail.com>
 <82ac0fc50f8fcdaf423b6ef1a66ee4d1d88d366b.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:37196 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbdKIB0Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2017 20:26:24 -0500
Content-Disposition: inline
In-Reply-To: <82ac0fc50f8fcdaf423b6ef1a66ee4d1d88d366b.1510118606.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, Vincent Chen <vincentc@andestech.com>

On Wed, Nov 08, 2017 at 01:55:05PM +0800, Greentime Hu wrote:

> +static int restore_sigframe(struct pt_regs *regs,
> +			    struct rt_sigframe __user * sf)
> +{

[snip]

> +	err |= !valid_user_regs(regs);

IDGI...  Where do you modify ->ipsw at all and how can valid_user_regs() come
to be false here?

> +asmlinkage int sys_rt_sigreturn(struct pt_regs *regs)
> +{
> +	struct rt_sigframe __user *frame;
> +
> +	/* Always make any pending restarted system calls return -EINTR */
> +	current->restart_block.fn = do_no_restart_syscall;
> +
> +	/*
> +	 * Since we stacked the signal on a 64-bit boundary,
> +	 * then 'sp' should be two-word aligned here.  If it's
> +	 * not, then the user is trying to mess with us.
> +	 */
> +	if (regs->sp & 7)
> +		goto badframe;
> +
> +	frame = (struct rt_sigframe __user *)regs->sp;
> +
> +	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
> +		goto badframe;
> +
> +	if (restore_sigframe(regs, frame))
> +		goto badframe;
> +
> +	if (restore_altstack(&frame->uc.uc_stack))
> +		goto badframe;
> +
> +	return regs->uregs[0];
> +
> +badframe:
> +	force_sig(SIGSEGV, current);
> +	return 0;
> +}

AFAICS, you are copying arm; take a good look at sys_rt_sigreturn_wrapper
there - specifically, the 'mov why, #0' part.  Consider what happens if
you get an interrupt at the moment when $r0 contains -ERESTARTSYS (for
example) and signal arrives while we are processing the interrupt.  It
will be handled on the way out, without any syscall restart crap ('why'
is 0 on that codepath).  So far, so good, but think what'll happen when
you are done with the signal handler.  sigreturn() is called, the values
we had stashed in sigcontext go back into registers (OK, pt_regs on
kernel stack that will be used to reload the registers on return to
userland)... and the signals that had been blocked for the duration of
handlers (see sa_mask in sigaction(2)) get unblocked.  And it turns
out that you have one of those pending - it had arrived while we'd been
in the handler.

Now we are fucked.  You have TIF_SIGPENDING set, so do_notify_resume()
is called.  And everything looks exactly as if you had a syscall restart
situation - regs->uregs[0] being one of -ERESTART... and 'syscall' flag
being true.  So we go into the second signal handler (as we ought to)
with saved ->ipc set 4 bytes back from where we were going to return.
It would've been the right thing to do if it *was* a syscall restart,
but we were returning to the location where the original interrupt
had caught us.

Result: with the right timing, an interrupt arriving when userland process
has $r0 equal -512 may lead to instruction pointer jumping 4 bytes back.
Pity the poor sod trying to debug that kind of breakage...

Restart should *NOT* be triggered upon sigreturn(2).

> +static int
> +setup_return(struct pt_regs *regs, struct ksignal *ksig, void __user * frame)
> +{
> +	unsigned long handler = (unsigned long)ksig->ka.sa.sa_handler;
> +	unsigned long retcode;
> +
> +	/*
> +	 * Maybe we need to deliver a 32-bit signal to a 26-bit task.

Deliver to what, again?  That comment made sense (if rather sad one) on arm, but
what is it doing here?

> +static int do_signal(struct pt_regs *regs, int syscall)
> +{
> +	unsigned int retval = 0, continue_addr = 0, restart_addr = 0;
> +	struct ksignal ksig;
> +	int restart = 0;
> +
> +	/*
> +	 * We want the common case to go fast, which
> +	 * is why we may in certain cases get here from
> +	 * kernel mode. Just return without doing anything
> +	 * if so.
> +	 */
> +	if (!user_mode(regs))
> +		return 0;

Which cases would those be?
