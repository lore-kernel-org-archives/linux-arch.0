From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 10/24] C6X: time management
Date: Wed, 17 Aug 2011 09:15:09 -0400
Message-ID: <1313586910.2306.3.camel@deneb.redhat.com>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com>
	 <1312839879-13592-11-git-send-email-msalter@redhat.com>
	 <201108091835.06442.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15872 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890Ab1HQNPN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Aug 2011 09:15:13 -0400
In-Reply-To: <201108091835.06442.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

On Tue, 2011-08-09 at 18:35 +0200, Arnd Bergmann wrote:
> > +static cycle_t tsc_read(struct clocksource *cs)
> > +{
> > +     return get_cycles();
> > +}
> 
> What is this good for? TSC is an x86 specific feature, so you should
> just
> be able to use get_cycles directly.
> 

TSC (Time Stamp Counter) is how the C6X hardware manuals refer to the
free running 64-bit core clock counter. The tsc_read function is needed
to provide a function with the correct prototype for struct clocksource
read method.

--Mark
