Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47621 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755711Ab3LQSps (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Dec 2013 13:45:48 -0500
Message-ID: <1387305938.1979.166.camel@deneb.redhat.com>
Subject: Re: [PATCH 1/4] Create generic early_ioremap() support
From: Mark Salter <msalter@redhat.com>
Date: Tue, 17 Dec 2013 13:45:38 -0500
In-Reply-To: <20131216014813.GA5631@dhcp-16-126.nay.redhat.com>
References: <1385606679-30446-1-git-send-email-msalter@redhat.com>
	 <1385606679-30446-2-git-send-email-msalter@redhat.com>
	 <20131216014813.GA5631@dhcp-16-126.nay.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Young <dyoung@redhat.com>
Cc: linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20131217184538.vz1yBE7xFpXUl5YkE4tCO4nxtttA5qyDsV3cBceztmQ@z>

On Mon, 2013-12-16 at 09:48 +0800, Dave Young wrote:
> On 11/27/13 at 09:44pm, Mark Salter wrote:
> > This patch copies generic bits of x86 early_ioremap() support
> > into a library for potential use by other architectures.
> > 
> > Signed-off-by: Mark Salter <msalter@redhat.com>
> > CC: Arnd Bergmann <arnd@arndb.de>
> > CC: Ingo Molnar <mingo@kernel.org>
> > CC: linux-arch@vger.kernel.org
> > ---
> >  include/asm-generic/early_ioremap.h |  40 ++++++
> >  lib/Kconfig                         |   3 +
> >  lib/Makefile                        |   1 +
> >  lib/early_ioremap.c                 | 243
> ++++++++++++++++++++++++++++++++++++
> 
> I do not understand why these should go to lib/, I feel it's slightly better
> move them to mm/
> 
> ditto about lib/ioremap.c, ...
> 

I hadn't really thought about it. Putting these things in mm doesn't
sound unreasonable, but lib seems to have become the place for a lot
generic code which could also belong in mm, net, etc.


