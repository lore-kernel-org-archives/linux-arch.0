From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 03/25] avr32: Use Kbuild infrastructure to handle
 asm-generic headers
Date: Wed, 4 Sep 2013 11:44:26 -0400
Message-ID: <20130904114426.72b979c5@gandalf.local.home>
References: <20121013022632.024527228@goodmis.org>
	<20121013022952.855483404@goodmis.org>
	<20130901205551.GA21140@samfundet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:18932 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934868Ab3IDPo1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Sep 2013 11:44:27 -0400
In-Reply-To: <20130901205551.GA21140@samfundet.no>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>

On Sun, 1 Sep 2013 22:55:51 +0200
Hans-Christian Egtvedt <egtvedt@samfundet.no> wrote:

> Around Fri 12 Oct 2012 22:26:35 -0400 or thereabout, Steven Rostedt wrote:
> 
> Hello Steven,
> 
> > Use Kbuild infrastructure to handle the asm-generic headers
> > and remove the wrapper headers that call them.
> > 
> > This only affects headers that do nothing but include the generic
> > equivalent. It does not touch any header that does a little more.
> 
> Thank you for cleaning. A bit old this patch (yikes, almost a year), but I
> cleaned it up a bit, and added it to my for-linus branch.
> 

Thanks,

-- Steve
