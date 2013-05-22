From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Get rid of cpuinit?
Date: Wed, 22 May 2013 23:04:47 +0200
Message-ID: <20130522210447.GA26123@merkur.ravnborg.org>
References: <519AA53F.1020107@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:64754 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab3EVVEt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2013 17:04:49 -0400
Content-Disposition: inline
In-Reply-To: <519AA53F.1020107@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <greg@kroah.com>

On Mon, May 20, 2013 at 03:35:43PM -0700, H. Peter Anvin wrote:
> We have gotten rid of devinit markup.  A recent patch of Linus' makes me
> wonder if we similarly should get rid of cpuinit markup?
> 
> Just as with devices, the CPU hotplug machinery has been leveraged to
> support a number of pieces of functionality such as suspend, which means
> that on anything but the most embedded systems this functionality is
> likely needed anyway.

If you grep for CPU_HOTPLUG in various defconfig files you will see that
it is only set in a few of these files (at least in arm/configs/).
I did not check it CPU_HOTPLUG would be set when
you actually used the config - but at least we need to pay attention
to the current usage.

	Sam
