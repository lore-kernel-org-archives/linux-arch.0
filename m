Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hoboe1bl1.telenet-ops.be ([195.130.137.72]:60257 "EHLO
	hoboe1bl1.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S939162AbXGSOOx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jul 2007 10:14:53 -0400
Date: Thu, 19 Jul 2007 16:14:50 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH for review] [11/48] x86_64: During VM oom condition, kill
 all threads in process group
In-Reply-To: <20070719140411.GD16279@infradead.org>
Message-ID: <Pine.LNX.4.64.0707191614180.7377@anakin>
References: <20070719348.540885000@suse.de> <20070719134840.47B5114E6E@wotan.suse.de>
 <20070719140411.GD16279@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Andi Kleen <ak@suse.de>, will_schmidt@vnet.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 19 Jul 2007, Christoph Hellwig wrote:
> On Thu, Jul 19, 2007 at 03:48:40PM +0200, Andi Kleen wrote:
> > From: Will Schmidt <will_schmidt@vnet.ibm.com>
> > 
> > During a VM oom condition, kill all threads in the process group.
> > 
> > We have had complaints where a threaded application is left in a bad state
> > after one of it's threads is killed when we hit a VM: out_of_memory condition.
> > 
> > Killing just one of the process threads can leave the application in a bad
> > state, whereas killing the entire process group would allow for the
> > application to restart, or otherwise handled, and makes it very obvious that
> > something has gone wrong.
> > 
> > This change allows the entire process group to be taken down, rather than just
> > the one thread.
> 
> Shouldn't we have one patc hthat does this for every architecture instead
> of going through arch maintainers and probably losing half of them?

Yes, please ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

return -EMAINTAINER_TOO_BUSY
