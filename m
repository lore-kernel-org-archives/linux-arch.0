From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH 2/2] Add dev.mem.restricted sysctl
Date: Sun, 16 Nov 2008 10:30:05 +0100
Message-ID: <20081116103005.72a28833@kopernikus.site>
References: <1226793823-32360-1-git-send-email-bwalle@suse.de>
	<1226793823-32360-3-git-send-email-bwalle@suse.de>
	<20081115194914.6791b96c@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:60502 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbYKPJaJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 16 Nov 2008 04:30:09 -0500
In-Reply-To: <20081115194914.6791b96c@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

* Arjan van de Ven [2008-11-15 19:49]:
>
> On Sun, 16 Nov 2008 01:03:43 +0100
> Bernhard Walle <bwalle@suse.de> wrote:
> 
> > When CONFIG_STRICT_DEVMEM is set, live debugging is not possible with
> > the crash utility (see http://people.redhat.com/~anderson). For
> > distributors who ship a generic kernel it's difficult: Disabling
> > CONFIG_STRICT_DEVMEM is possible, but in general the protection
> > provided by CONFIG_STRICT_DEVMEM is useful. However, live debugging
> > should be still neceessary.
> > 
> > This patch now adds a dev.mem.restricted sysctl that defaults to 0
> > (off). When set to 1 (on), /dev/mem access is unrestricted and crash
> > can be used.
> 
> sounds like a really bad idea to me.
> If you want to use /dev/mem like this, don't enable the config option
> to restrict it. Really.

So, what's that restriction really for? Maybe it would make sense to
remove that CONFIG option entirely and turn it into the systl? Just an
idea.


Regards,
Bernhard
