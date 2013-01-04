From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2 43/44] tty/metag_da: Add metag DA TTY driver
Date: Fri, 4 Jan 2013 17:00:13 +0000
Message-ID: <20130104170013.74b6dbe2@pyramind.ukuu.org.uk>
References: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com>
	<1354723742-6195-44-git-send-email-james.hogan@imgtec.com>
	<20121205172446.41aa464e@pyramind.ukuu.org.uk>
	<50E6E322.8070108@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:37761 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755056Ab3ADQxa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jan 2013 11:53:30 -0500
In-Reply-To: <50E6E322.8070108@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>


> >> +static int put_data(void *arg)
> >> +{
> >> +	struct dashbuf *dbuf;
> >> +	int number_written;
> >> +
> >> +	__set_current_state(TASK_RUNNING);
> >> +	while (!kthread_should_stop()) {
> >> +		/*
> >> +		 * Pick up all the output buffers and write them out.
> >> +		 *
> >> +		 * FIXME: should we check with ASE how much room we have?
> >> +		 * Ideally, this will already have been done by write_room ??
> >> +		 */
> > 
> > 
> > No because your writer is asynchronous to your query so you need to
> > manage the difference yourself. You also need to get it right on the
> > queue length for close to work right.
> 
> Regarding closing working right, do you mean making sure that all data
> in the asynchronous output buffer is written out by the final close
> (e.g. port_shutdown before freeing it)? Is that something the driver
> needs to do itself? (at the moment it does seem to be necessary, however
> I could be missing something)

You have no locking guaranteeing that the write_room is correct any given
put while put_data is running - both threads of execution can end up
changing it at the same time.

> >> +	/* Determine the channel */
> >> +	channel = FIRST_TTY_CHANNEL + tty->index;
> >> +	dtty = dashtty_ttys[channel];
> >> +	BUG_ON(!dtty);
> > 
> > What is your locking model to prevent this ?
> > What is your reference counting model for the ttys - I don't see one.
> 
> The new version has an array of dashtty_ports (not pointers, each
> containing a tty_port) and uses that to get at the output buffer.
> 
> Would it need to ensure that the tty isn't hung up though, or is a write
> prevented from occurring in that case?

The core tty code will hold a reference to the tty object when calling
your methods which pass a "tty" pointer, so it won't vanish itself under
those conditions. For any other way of accessing you need to handle any
locking between write and hangup yourself - eg by deferring any clearing
down of the array until the tty_port itself is destroyed.

> Agreed and done. I didn't realise the TTY layer was so prone to
> providing lots of itty bitty fragments (even with a single 4k write from
> userland). The thing that really hurt was not the allocations but that
> each one was written out to the DA separately each incurring it's own
> large latency. Using a write buffer makes it a lot faster :)

Think about typing a command and the echo - you get a lot of very small
writes !

> It's still possible that the debugger isn't draining the DA buffers in
> which case they'll fill up, and the output buffer in the driver will
> fill and then the space reported to the tty layer will drop to 0.

At that point the tty layer will throttle.

> 
> > 
> >> +}
> > 
> >> +static const struct tty_operations dashtty_ops = {
> >> +	.open = dashtty_open,
> >> +	.close = dashtty_close,
> >> +	.write = dashtty_write,
> > 
> > You need a hangup method. You may need a termios method.
> 
> Is it sufficient for a hangup method to just call tty_port_hangup or
> should it drop the contents of the output buffer too? (as opposed to
> waiting for it to drain in port_shutdown).

The behaviour there is undefined - up to you, whatever makes sense.

> As far as I can tell none of the termios stuff is really relevant to
> this driver.

In which case the default behaviour will be fine - and it will allow non
hardware parameters to change but not hardware ones like baud rates.

> >> +	channel_driver->init_termios = tty_std_termios;
> >> +	channel_driver->init_termios.c_cflag =
> >> +	    B38400 | CS8 | CREAD | HUPCL | CLOCAL;
> >> +	channel_driver->flags = TTY_DRIVER_REAL_RAW;
> > 
> > Need to set the speed flags
> 
> Do you mean c_ispeed, and c_ospeed? These are set in tty_std_termios,
> and they aren't meaningful in the context of this driver anyway, so are
> they still necessary?

You update c_cflag to B38400 so you should set c_ispeed/c_ospeed
accordingly. For a virtual interface it really only exists so that
applications have an answer. You want a higher speed like 38400 so that
apps don't try and do clever stuff for low speed links, that is all
really.

Alan
