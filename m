From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 04/24] C6X: build infrastructure
Date: Wed, 24 Aug 2011 14:47:18 +0100
Message-ID: <1314193639.16478.3.camel@i7.infradead.org>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com>
	 <1314043785-2880-5-git-send-email-msalter@redhat.com>
	 <20110822205509.GA7940@merkur.ravnborg.org>
	 <1314105799.2404.40.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:55882 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab1HXNrn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 24 Aug 2011 09:47:43 -0400
In-Reply-To: <1314105799.2404.40.camel@deneb.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-arch@vger.kernel.org

On Tue, 2011-08-23 at 09:23 -0400, Mark Salter wrote:
> 
> > > +cflags-y := -D__linux__ -D__TMS320C6X__
> > 
> > Why is __linux__ and __TMS3206C6X__ neeeded?
> > and why are they not needed for CHECKFLAGS ?
> 
> I think these two defines were left over from trying to compensate
> for differences between TI compiler and GCC. They aren't needed.

Last time I looked, the Coda file system was broken and would not
compile if __linux__ wasn't defined. This is the *only* thing that
prevents you from building a kernel with a generic $ARCH-elf toolchain,
IIRC.

-- 
dwmw2
