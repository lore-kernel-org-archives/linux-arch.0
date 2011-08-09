From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 22/24] C6X: specific board support
Date: Tue, 09 Aug 2011 13:16:17 -0400
Message-ID: <1312910178.2356.16.camel@deneb.redhat.com>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com>
	 <1312839879-13592-23-git-send-email-msalter@redhat.com>
	 <201108091904.43047.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37988 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753893Ab1HIRQV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 9 Aug 2011 13:16:21 -0400
In-Reply-To: <201108091904.43047.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

On Tue, 2011-08-09 at 19:04 +0200, Arnd Bergmann wrote:
> On Monday 08 August 2011, Mark Salter wrote:
> > Signed-off-by: Mark Salter <msalter@redhat.com>
> > ---
> >  arch/c6x/platforms/board-dsk6455.c |  102
> ++++++++++++++++++++++++++++++++++++
> >  arch/c6x/platforms/board-evm6457.c |   51 ++++++++++++++++++
> >  arch/c6x/platforms/board-evm6472.c |   51 ++++++++++++++++++
> >  arch/c6x/platforms/board-evm6474.c |   53 +++++++++++++++++++
> >  4 files changed, 257 insertions(+), 0 deletions(-)
> 
> I would argue that none of these should exist. When you have device
> tree probing,
> you should be able to do all the initialization according to the
> device tree contents.
> 

Yes, one of your previous replies touched on this point and got me to
thinking about it. I think it would be fairly easy to get rid of them.

--Mark
