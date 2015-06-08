From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [42/73] rtc: delete non-required instances of include
 <linux/init.h>
Date: Mon, 8 Jun 2015 17:06:34 -0400
Message-ID: <20150608210634.GJ7125@windriver.com>
References: <1390339396-3479-43-git-send-email-paul.gortmaker@windriver.com>
 <20150608195455.GF5222@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:46035 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbbFHVJ2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2015 17:09:28 -0400
Content-Disposition: inline
In-Reply-To: <20150608195455.GF5222@piout.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com

[Re: [42/73] rtc: delete non-required instances of include <linux/init.h>] On 08/06/2015 (Mon 21:54) Alexandre Belloni wrote:

> On 21/01/2014 at 16:22:45 -0500, Paul Gortmaker wrote :
> > None of these files are actually using any __init type directives
> > and hence don't need to include <linux/init.h>.  Most are just a
> > left over from __devinit and __cpuinit removal, or simply due to
> > code getting copied from one driver to the next.
> > 
> > Cc: Alessandro Zummo <a.zummo@towertech.it>
> > Cc: rtc-linux@googlegroups.com
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> I've contemplated applying that patch but I'm not sure it is actually a
> good idea because those 46 drivers are using a variant of module_driver
> which actually uses __init and __exit. After your patch it is still
> working simply because init.h gets included that way:

Firstly, I am kind of curious why an 18 month old patch is getting
replied to now.   That aside, this interdependence between module.h and
init.h was reconsidered and you can see the resolution solution here:

https://lkml.kernel.org/r/1433276168-21550-1-git-send-email-paul.gortmaker@windriver.com

To summarize what is said there, yes - you can ignore the one line
removals for now.  We will revisit them after the above is merged.

Thanks,
Paul.
--

> 
> linux/module.h:9
> linux/list.h:8
> linux/kernel.h:13
> linux/printk.h:5
> 
> -- 
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
