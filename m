From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 18/24] C6X: headers
Date: Wed, 24 Aug 2011 06:53:45 +0200
Message-ID: <20110824045345.GB17879@merkur.ravnborg.org>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com> <1314043785-2880-19-git-send-email-msalter@redhat.com> <1328178.VkYhLNAX5s@wuerfel> <1314106998.2404.47.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:13929 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab1HXExq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 24 Aug 2011 00:53:46 -0400
Content-Disposition: inline
In-Reply-To: <1314106998.2404.47.camel@deneb.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org

On Tue, Aug 23, 2011 at 09:43:17AM -0400, Mark Salter wrote:
> On Mon, 2011-08-22 at 23:14 +0200, Arnd Bergmann wrote:
> > On Monday 22 August 2011 16:09:39 Mark Salter wrote:
> > > Signed-off-by: Mark Salter <msalter@redhat.com>
> > 
> > > 
> > > diff --git a/arch/c6x/include/asm/asm-offsets.h b/arch/c6x/include/asm/asm-offsets.h
> > > new file mode 100644
> > > index 0000000..d370ee3
> > > --- /dev/null
> > > +++ b/arch/c6x/include/asm/asm-offsets.h
> > > @@ -0,0 +1 @@
> > > +#include <generated/asm-offsets.h>
> > 
> > I wonder if it makes sense to install this file in asm-generic/asm-offsets.h
> > and referencing it like the other files.
> 
> I think so. It is the same for all arches.

It was just a hack we used when we introduced generated/...
This avoided the need to fix up all files that includes asm-offsets.h

So it should not be needed.

	Sam
