From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [42/73] rtc: delete non-required instances of include
 <linux/init.h>
Date: Mon, 8 Jun 2015 21:54:55 +0200
Message-ID: <20150608195455.GF5222@piout.net>
References: <1390339396-3479-43-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:49456 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753548AbbFHTy5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2015 15:54:57 -0400
Content-Disposition: inline
In-Reply-To: <1390339396-3479-43-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com

On 21/01/2014 at 16:22:45 -0500, Paul Gortmaker wrote :
> None of these files are actually using any __init type directives
> and hence don't need to include <linux/init.h>.  Most are just a
> left over from __devinit and __cpuinit removal, or simply due to
> code getting copied from one driver to the next.
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: rtc-linux@googlegroups.com
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

I've contemplated applying that patch but I'm not sure it is actually a
good idea because those 46 drivers are using a variant of module_driver
which actually uses __init and __exit. After your patch it is still
working simply because init.h gets included that way:

linux/module.h:9
linux/list.h:8
linux/kernel.h:13
linux/printk.h:5

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
