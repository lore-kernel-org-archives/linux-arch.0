From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 01/22] pci-dma-compat: Add pci_zalloc_consistent helper
Date: Wed, 25 Jun 2014 15:14:00 -0700
Message-ID: <1403734440.24788.15.camel@joe-AO725>
References: <cover.1403530604.git.joe@perches.com>
	 <2248b3ffe86cd8995a809bf7e2871f38039979c1.1403530604.git.joe@perches.com>
	 <20140625122755.152685fadbc9cffe7a298dc6@linux-foundation.org>
	 <1403733111.24788.8.camel@joe-AO725>
	 <20140625145744.9cb4ec9e3ea7a63bf630eeaa@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0068.hostedemail.com ([216.40.44.68]:51264 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757058AbaFYWOD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jun 2014 18:14:03 -0400
In-Reply-To: <20140625145744.9cb4ec9e3ea7a63bf630eeaa@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

On Wed, 2014-06-25 at 14:57 -0700, Andrew Morton wrote:
> On Wed, 25 Jun 2014 14:51:51 -0700 Joe Perches <joe@perches.com> wrote:
> 
> > > People sometimes address this by using
> > > 
> > > 	"drivers: net: ethernet: amd: use pci_zalloc_consistent"
> > > 
> > > which strikes me as utterly perverse.  We already have a nice way of
> > > representing the hierarchy and that's using '/'.
> > 
> > I used to do that until several people complained.
> 
> Slap 'em.

And get booked for assault?  No thanks.
My mild-mannered persona thinks that a poor plan.

My actual feeling is I don't much care.

btw:  https://lkml.org/lkml/2010/11/15/387

I also proposed a scheme where the prescriptive
patch subject pedants could put some pattern
into MAINTAINERS so that these subject lines
could be more automatically generated.

https://lkml.org/lkml/2010/11/16/245

> I don't know where this thing is coming from - I'd suspected there must
> be some misguided doc somewhere but I don't know where it is.  Some
> vast conspiracy against common sense.

> I don't want to be overly proscriptive here, but it's a bit maddening
> when you're skimming patch titles and cannot work out which part of the
> kernel is being patched :(

Yup.
