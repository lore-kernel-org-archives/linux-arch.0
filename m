From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/24] C6X: time management
Date: Wed, 17 Aug 2011 15:31:48 +0200
Message-ID: <201108171531.48327.arnd@arndb.de>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <201108091835.06442.arnd@arndb.de> <1313586910.2306.3.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60867 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465Ab1HQNbw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Aug 2011 09:31:52 -0400
In-Reply-To: <1313586910.2306.3.camel@deneb.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Wednesday 17 August 2011, Mark Salter wrote:
> On Tue, 2011-08-09 at 18:35 +0200, Arnd Bergmann wrote:
> > > +static cycle_t tsc_read(struct clocksource *cs)
> > > +{
> > > +     return get_cycles();
> > > +}
> > 
> > What is this good for? TSC is an x86 specific feature, so you should
> > just
> > be able to use get_cycles directly.
> > 
> 
> TSC (Time Stamp Counter) is how the C6X hardware manuals refer to the
> free running 64-bit core clock counter. The tsc_read function is needed
> to provide a function with the correct prototype for struct clocksource
> read method.

Ok, I see.

	Arnd
