From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Turn CONFIG_STRICT_DEVMEM in sysctl dev.mem.restricted
Date: Sun, 16 Nov 2008 15:07:56 +0000
Message-ID: <20081116150756.3cece2de@lxorguk.ukuu.org.uk>
References: <1226846868-9595-1-git-send-email-bwalle@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51835 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752179AbYKPPIW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 16 Nov 2008 10:08:22 -0500
In-Reply-To: <1226846868-9595-1-git-send-email-bwalle@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, crash-utility@redhat.com, Bernhard Walle <bwalle@suse.de>

> The protection in the general case and the ability to do live debugging.

What protection. You've completely failed to explain or provide a single
example of any protection provided by the STRICT_DEVMEM code.

> only a half of the story. The truth is that at least RHEL has /dev/crash
> exactly to circumvent that /dev/mem restriction. Don't tell me that this
> is better than having that sysctl entry. ;-)

Which nicely illustrates what a waste of time the whole thing is.

Please do the decent thing and just turn the crap concerned off. The fact
other vendors get it wrong doesn't mean you need to copy. Even better
submit a patch to remove this rubbish from the kernel completely.

Your patch is still adding bells and whistles to a useless turd. In fact
this patch is worse. Without this patch the turd can be disabled and left
out, with your patch everyone now has to compile in said turd pile.

NAK this changeset.

Alan
