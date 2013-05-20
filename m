From: Greg KH <greg@kroah.com>
Subject: Re: Get rid of cpuinit?
Date: Mon, 20 May 2013 16:12:03 -0700
Message-ID: <20130520231203.GA21682@kroah.com>
References: <519AA53F.1020107@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52240 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756021Ab3ETXMH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 20 May 2013 19:12:07 -0400
Content-Disposition: inline
In-Reply-To: <519AA53F.1020107@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, May 20, 2013 at 03:35:43PM -0700, H. Peter Anvin wrote:
> We have gotten rid of devinit markup.  A recent patch of Linus' makes me
> wonder if we similarly should get rid of cpuinit markup?
> 
> Just as with devices, the CPU hotplug machinery has been leveraged to
> support a number of pieces of functionality such as suspend, which means
> that on anything but the most embedded systems this functionality is
> likely needed anyway.
> 
> On x86-64, for an "allyesconfig" build, the total amount of space in all
> the .cpu* sections combined is 100K.

No objection from me on removing it, it just causes problems from what I
can tell.

thanks,

greg k-h
