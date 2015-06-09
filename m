From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [42/73] rtc: delete non-required instances of include
 <linux/init.h>
Date: Tue, 9 Jun 2015 09:49:46 +0200
Message-ID: <20150609074946.GG5222@piout.net>
References: <1390339396-3479-43-git-send-email-paul.gortmaker@windriver.com>
 <20150608195455.GF5222@piout.net>
 <20150608210634.GJ7125@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:59903 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751377AbbFIHtt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 03:49:49 -0400
Content-Disposition: inline
In-Reply-To: <20150608210634.GJ7125@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com

On 08/06/2015 at 17:06:34 -0400, Paul Gortmaker wrote :
> > I've contemplated applying that patch but I'm not sure it is actually a
> > good idea because those 46 drivers are using a variant of module_driver
> > which actually uses __init and __exit. After your patch it is still
> > working simply because init.h gets included that way:
> 
> Firstly, I am kind of curious why an 18 month old patch is getting
> replied to now.   That aside, this interdependence between module.h and
> init.h was reconsidered and you can see the resolution solution here:
> 
> https://lkml.kernel.org/r/1433276168-21550-1-git-send-email-paul.gortmaker@windriver.com
> 
> To summarize what is said there, yes - you can ignore the one line
> removals for now.  We will revisit them after the above is merged.
> 

I've taken the RTC subsystem maintainership and I've been sorting the
2372 patches left in patchwork down to 126 and yours was one of these.

Seeing your answer, I think my question was legitimate. I'll be happy to
take your revised patch once ready.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
