From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH 2/2] Add dev.mem.restricted sysctl
Date: Sun, 16 Nov 2008 01:09:14 +0100
Message-ID: <20081116010914.1285b884@kopernikus.site>
References: <1226793823-32360-1-git-send-email-bwalle@suse.de>
	<1226793823-32360-3-git-send-email-bwalle@suse.de>
	<20081116000738.5c70daf5@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:44770 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752444AbYKPAJQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 15 Nov 2008 19:09:16 -0500
In-Reply-To: <20081116000738.5c70daf5@lxorguk.ukuu.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

* Alan Cox [2008-11-16 00:07]:
>
> On Sun, 16 Nov 2008 01:03:43 +0100
> Bernhard Walle <bwalle@suse.de> wrote:
> 
> > When CONFIG_STRICT_DEVMEM is set, live debugging is not possible with the
> > crash utility (see http://people.redhat.com/~anderson). For distributors
> > who ship a generic kernel it's difficult: Disabling CONFIG_STRICT_DEVMEM
> > is possible, but in general the protection provided by CONFIG_STRICT_DEVMEM
> > is useful. However, live debugging should be still neceessary.
> 
> Why not just turn strictmem off - as you've correctly demonstrated its
> completely useless and always was.
> 
> A switchable configurable piece of turd is still at the end of the day a
> piece of turd.

Well, I think that option makes sense to protect the system
from processes that *accidentally* read/write to the wrong memory
location (like the X server that always runs as root).


Regards,
Bernhard
