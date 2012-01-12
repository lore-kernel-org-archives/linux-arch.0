From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] kconfig: untangle EXPERT and EMBEDDED
Date: Thu, 12 Jan 2012 09:18:52 +0000
Message-ID: <201201120918.53026.arnd@arndb.de>
References: <1326295008-29795-1-git-send-email-drjones@redhat.com> <alpine.DEB.2.00.1201111353330.21755@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61812 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135Ab2ALJT6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jan 2012 04:19:58 -0500
In-Reply-To: <alpine.DEB.2.00.1201111353330.21755@chino.kir.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: Andrew Jones <drjones@redhat.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, mingo@elte.hu, david.woodhouse@intel.com, gregkh@suse.de, davem@davemloft.net, axboe@kernel.dk, holt@sgi.com, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, hskinnemoen@gmail.com, egtvedt@samfundet.no, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, takata@linux-m32r.org, geert@linux-m68k.org, yasutake.koichi@jp.panasonic.com, jonas@southpole.se, kyle@mcmartin.ca, deller@gmx.de, jejb@parisc-linux.org, chris@zankel.net, greg@kroah.com, davej@redhat.com, airlied@linux.ie, jkosina@suse.cz, mchehab@infradead.org, johannes@sipsolutions.net, linville@tuxdriver.com

On Wednesday 11 January 2012, David Rientjes wrote:
> We discussed this when the patch was made to change EMBEDDED to EXPERT and 
> we knew that things like CONFIG_SLOB exist that would only make sense on a 
> platform with a very small memory footprint.  So what criteria are you 
> using to determine what makes sense for EMBEDDED or not and what would be 
> generally useful for platforms with very small memory footprints?
> 
> I would think that something like CONFIG_SMALLMEM would identify those 
> candidates (for things like SLOB) and then you could separate the rest 
> based on the platform they exist for since you're essentially introducing 
> a new config symbol here that existed in the past but are now using it 
> with different semantics.

The CONFIG_SMALLMEM would also require people to know what they are doing,
beyond what we expect the average person building a kernel to, which is
just what CONFIG_EXPERT means, and the same reason why we ended up renaming
CONFIG_EMBEDDED to CONFIG_EXPERT. People have a very different understanding
of what "embedded" actually means, and not all of those require small
memory footprint or even a custom kernel. Let's just stay with CONFIG_EXPERT.

	Arnd
