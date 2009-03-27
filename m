From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/13] score - New architecure port to SunplusCT S+CORE
 processor
Date: Fri, 27 Mar 2009 11:29:26 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0903271125380.3397@localhost.localdomain>
References: <OF39905543.8F85F55B-ON48257586.000793DC-48257586.0007F946@sunplusct.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:40816 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754080AbZC0KaQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Mar 2009 06:30:16 -0400
In-Reply-To: <OF39905543.8F85F55B-ON48257586.000793DC-48257586.0007F946@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: Will Newton <will.newton@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org

On Fri, 27 Mar 2009, liqin.chen@sunplusct.com wrote:
> > >> > We would like to release a patch for kernel 2.6.29-rc8.
> > >> > This patch include score header files, arch files and serial driver
> > > for
> > >> > spct6600(score core) platform.
> > >> >
> > >> > For the other driver patches, I'll send them one by one in
> > >> > small size latter. Thanks!
> > >> >
> > >> > Would you merge them to the stock kernel?
> > >> >
> > >> > Patch information is slightly bigger, so I placed it on our 
> SunplusCT
> > > web
> > >> > site.
> > >> >
> > > 
> http://www.sunplusct.com/images/linux-score-patch/linux-score-20090324.patch

Please split the patches further into logical and reviewable
pieces. Also each patch needs a patch description which will be the
change log in the git repository and your Signed-off-by line. Also
each patch needs a unique and useful subject line in the mail.

Download references for such patches are useless.

See Documentation/SubmittingPatches

Thanks,

	tglx
