From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Turn CONFIG_STRICT_DEVMEM in sysctl dev.mem.restricted
Date: Sun, 16 Nov 2008 17:19:52 +0100
Message-ID: <20081116171952.632947a7@kopernikus.site>
References: <1226846868-9595-1-git-send-email-bwalle@suse.de>
	<20081116150756.3cece2de@lxorguk.ukuu.org.uk>
	<20081116162003.04267538@kopernikus.site>
	<20081116154541.1f196f1e@lxorguk.ukuu.org.uk>
	<20081116080342.3d6c6976@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:48430 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbYKPQTy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 16 Nov 2008 11:19:54 -0500
In-Reply-To: <20081116080342.3d6c6976@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, crash-utility@redhat.com

* Arjan van de Ven [2008-11-16 08:03]:

> 
> the point of the /dev/mem restrictions is to not allow things you know
> you don't need, while still allowing X to function where it can access
> the crap it does. Now in Bernhard's case he DOES need them, so he
> shouldn't use the restrictions.

Right. But shipping two kernel images is a bit too much to turn a
restriction on or off. Get away from that "recompile your kernel".

But I get more and more convinced that we really want to just turn that
configuration option off. I'm no expert in security, and at some point,
I just have to believe what people write.


Regards,
Bernhard
