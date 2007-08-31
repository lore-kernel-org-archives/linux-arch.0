Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37044 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbXHaWVI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 31 Aug 2007 18:21:08 -0400
Message-ID: <46D89451.9050904@garzik.org>
Date: Fri, 31 Aug 2007 18:21:05 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
Subject: Re: Heads Up: Next Batch Of Serial/TTY Changes
References: <20070831221105.2fce9023@the-village.bc.nu>	<20070831.144115.48807246.davem@davemloft.net> <20070831231613.6b0fcdfd@the-village.bc.nu>
In-Reply-To: <20070831231613.6b0fcdfd@the-village.bc.nu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-serial@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Alan Cox wrote:
> On Fri, 31 Aug 2007 14:41:15 -0700 (PDT)
> David Miller <davem@davemloft.net> wrote:
> 
>> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>> Date: Fri, 31 Aug 2007 22:11:05 +0100
>>
>>> Firstly some architecture maintainers still haven't updated their
>>> platform for arbitary tty speeds. The kernel is going to start whining
>>> and issuing warnings on your platform if you don't keep up with the
>>> programme (its been 6 months).
>> I took a look at this for sparc and I'm currently balking the same way
>> you did :-) The current bit usage on sparc just don't work properly
>> for what you're trying to do.
> 
> I don't see a real problem. You aren't using
> 
> 	c_cflags & CBAUD = 0x00001000
> 
> so that could become BOTHER.

Pooh says:  oh, bother!

	Jeff



