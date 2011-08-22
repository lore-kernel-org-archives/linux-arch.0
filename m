From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 22/24] C6X: EMIF - External Memory Interface
Date: Mon, 22 Aug 2011 17:34:19 -0400
Message-ID: <1314048859.2404.34.camel@deneb.redhat.com>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com>
	 <1314043785-2880-23-git-send-email-msalter@redhat.com>
	 <6640139.XM528fXZpr@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63247 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204Ab1HVVeW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Aug 2011 17:34:22 -0400
In-Reply-To: <6640139.XM528fXZpr@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

On Mon, 2011-08-22 at 23:17 +0200, Arnd Bergmann wrote:
> > +pure_initcall(c6x_emifa_init);
> 
> It looks like you are missing an iounmap here. Obviously a nop on nommu, but
> it caught my eye anyway and perheps you get an mmu at some point.
> 
>         Arnd

Yes. Good catch.
