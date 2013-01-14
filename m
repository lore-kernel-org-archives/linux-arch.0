Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:64434 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab3ANKVG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jan 2013 05:21:06 -0500
Message-ID: <50F3DAA5.50709@suse.cz>
Date: Mon, 14 Jan 2013 11:15:01 +0100
From: Jiri Slaby <jslaby@suse.cz>
MIME-Version: 1.0
Subject: Re: [PATCH v3 43/44] tty/metag_da: Add metag DA TTY driver
References: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com> <1357831872-29451-44-git-send-email-james.hogan@imgtec.com> <50EEE642.20608@suse.cz> <50EFEE71.4000706@imgtec.com>
In-Reply-To: <50EFEE71.4000706@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@redhat.com>, Cesar Eduardo Barros <cesarb@cesarb.net>, Joe Perches <joe@perches.com>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20130114101501.zmF-bln_HLt9OUg23UiUYJYMLTf6ACZpGxnd_w1tuD0@z>

Hi,

On 01/11/2013 11:50 AM, James Hogan wrote:
>>> +	channel_driver->driver_name = "ttyDA";
>> 
>> This should be rather "metag".
> 
> Yes, I'll set to "metag_da" if that's okay since the transport is
> the DA. I presume this is pretty much just to appear in
> /proc/tty/drivers?

Yes.

>>> +static void dashtty_exit(void) +{ +
>>> del_timer_sync(&put_timer); +	kthread_stop(dashtty_thread); +
>>> del_timer_sync(&poll_timer); +
>>> tty_unregister_driver(channel_driver); +
>>> put_tty_driver(channel_driver);
>> 
>> No tty_port_destroy anywhere?
> 
> Ah yes, I've added a loop to do this before put_tty_driver() both
> here and in the error handling of dashtty_init().
> 
> This driver isn't actually buildable as a module at the moment, but
> if it was, would the module owner being set ensure that the
> ttys/ports are closed down prior to dashtty_exit being called?
> (i.e. is it racy?)

Yeah, dashtty_exit won't be called until all openers are gone.

regards,
-- 
js
suse labs
