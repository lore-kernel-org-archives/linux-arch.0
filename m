From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] Add dev.mem.restricted sysctl
Date: Sun, 16 Nov 2008 00:07:38 +0000
Message-ID: <20081116000738.5c70daf5@lxorguk.ukuu.org.uk>
References: <1226793823-32360-1-git-send-email-bwalle@suse.de>
	<1226793823-32360-3-git-send-email-bwalle@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:42067 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751685AbYKPAHh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 15 Nov 2008 19:07:37 -0500
In-Reply-To: <1226793823-32360-3-git-send-email-bwalle@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bernhard Walle <bwalle@suse.de>

On Sun, 16 Nov 2008 01:03:43 +0100
Bernhard Walle <bwalle@suse.de> wrote:

> When CONFIG_STRICT_DEVMEM is set, live debugging is not possible with the
> crash utility (see http://people.redhat.com/~anderson). For distributors
> who ship a generic kernel it's difficult: Disabling CONFIG_STRICT_DEVMEM
> is possible, but in general the protection provided by CONFIG_STRICT_DEVMEM
> is useful. However, live debugging should be still neceessary.

Why not just turn strictmem off - as you've correctly demonstrated its
completely useless and always was.

A switchable configurable piece of turd is still at the end of the day a
piece of turd.
