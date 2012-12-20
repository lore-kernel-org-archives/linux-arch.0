From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 17/40] metag: IRQ handling
Date: Thu, 20 Dec 2012 10:14:37 +0000
Message-ID: <50D2E50D.5080605@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <201211201615.30481.arnd@arndb.de> <50D06EAF.4050200@imgtec.com> <201212191558.57271.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:56709 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326Ab2LTKPX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 20 Dec 2012 05:15:23 -0500
In-Reply-To: <201212191558.57271.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Grant <grant.likely@secretlab.ca>

On 19/12/12 15:58, Arnd Bergmann wrote:
> On Tuesday 18 December 2012, James Hogan wrote:
>> So what would be the expected way to do that with linear irq domains?
> 
> I think the best answer to that is "you're screwed".  There may be
> a way to change the interfaces to just EXPORT_SYMBOL if you can make
> a good case about a specific driver needing it, but my suspicion is
> that that's not likely to be successful when coming from an imgtec.com
> address or without details about the driver that needs it ;-)

:-)
Well after further research it appears all the drivers I had in mind
will be GPL anyway, so it shouldn't be a problem after all.

Thanks
James
