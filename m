From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH v3 06/24] C6X: early boot code
Date: Wed, 28 Sep 2011 10:06:59 -0400
Message-ID: <1317218820.2580.64.camel@deneb.redhat.com>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com>
	 <1317155405-26235-7-git-send-email-msalter@redhat.com>
	 <201109281526.07969.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37921 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753108Ab1I1OHC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 28 Sep 2011 10:07:02 -0400
In-Reply-To: <201109281526.07969.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, 2011-09-28 at 15:26 +0200, Arnd Bergmann wrote:
> On Tuesday 27 September 2011, Mark Salter wrote:
> 
> > +int c6x_num_cores;
> > +EXPORT_SYMBOL(c6x_num_cores);
> > +
> > +unsigned int c6x_silicon_rev;
> > +EXPORT_SYMBOL(c6x_silicon_rev);
> > +
> > +/*
> > + * Device status register. This holds information
> > + * about device configuration needed by some drivers.
> > + */
> > +unsigned int c6x_devstat;
> > +EXPORT_SYMBOL(c6x_devstat);
> 
> > +unsigned int ticks_per_ns_scaled;
> > +EXPORT_SYMBOL(ticks_per_ns_scaled);
> > +
> > +unsigned int c6x_core_freq;
> > +EXPORT_SYMBOL(c6x_core_freq);
> 
> These all look like they are used internally (maybe not
> ticks_per_ns_scaled) so it would be more appropriate to make
> them EXPORT_SYMBOL_GPL.

Hmm, we don't need to export c6x_core_freq at all.

c6x_silicon_rev is needed by drivers (though none in the current
patch series) to deal with silicon errata.

c6x_devstat has pin-strap config info some drivers may need.

ticks_per_ns_scale is used in udelay/mdelay.

--Mark
