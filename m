From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 01/22] pci-dma-compat: Add pci_zalloc_consistent helper
Date: Wed, 25 Jun 2014 14:57:44 -0700
Message-ID: <20140625145744.9cb4ec9e3ea7a63bf630eeaa@linux-foundation.org>
References: <cover.1403530604.git.joe@perches.com>
	<2248b3ffe86cd8995a809bf7e2871f38039979c1.1403530604.git.joe@perches.com>
	<20140625122755.152685fadbc9cffe7a298dc6@linux-foundation.org>
	<1403733111.24788.8.camel@joe-AO725>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:48294 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbaFYV5p (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jun 2014 17:57:45 -0400
In-Reply-To: <1403733111.24788.8.camel@joe-AO725>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

On Wed, 25 Jun 2014 14:51:51 -0700 Joe Perches <joe@perches.com> wrote:

> > People sometimes address this by using
> > 
> > 	"drivers: net: ethernet: amd: use pci_zalloc_consistent"
> > 
> > which strikes me as utterly perverse.  We already have a nice way of
> > representing the hierarchy and that's using '/'.
> 
> I used to do that until several people complained.

Slap 'em.

I don't know where this thing is coming from - I'd suspected there must
be some misguided doc somewhere but I don't know where it is.  Some
vast conspiracy against common sense.

> Now I don't.  btw:  Documentation/SubmittingPatches says:
> 
> 15) The canonical patch format
> 
> The canonical patch subject line is:
> 
>     Subject: [PATCH 001/123] subsystem: summary phrase

Yes, that doesn't go into how to identify the subsystem.

I don't want to be overly proscriptive here, but it's a bit maddening
when you're skimming patch titles and cannot work out which part of the
kernel is being patched :(
