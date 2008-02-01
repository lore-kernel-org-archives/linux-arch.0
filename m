Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54236 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753834AbYBAUYI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 1 Feb 2008 15:24:08 -0500
Message-ID: <47A37FE5.2060200@garzik.org>
Date: Fri, 01 Feb 2008 15:24:05 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
Subject: Re: Are Section mismatches out of control?
References: <20080201104718.GA11717@uranus.ravnborg.org> <20080201030329.9b760777.akpm@linux-foundation.org> <47A34C47.9040306@garzik.org> <20080201201713.GA15905@uranus.ravnborg.org>
In-Reply-To: <20080201201713.GA15905@uranus.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, Linus Torvalds <torvalds@linux-foundation.org>

Sam Ravnborg wrote:
> One can ignore or one can fix...
> I decided to spend some of my friday on fixing section mismatch
> warnings as I've got a bit irritated over people spending time
> complaining but failing to provide patches.

> 	Sam - who expected more people to actually fix this stuff :-(

Well, with due respect, it's a bit presumptuous to add a bunch of 
warnings to the kernel build (due to more strict checking), and then get 
annoyed when people aren't jumping up and fixing this stuff immediately.

There were no build complaints in 2.6.24 for my stuff (libata and 
drivers/net) during my test builds, nor were there any for my 2.6.25-git 
merge window pushes, nor were there any complaints when I last checked 
Andrew's -mm tree.

So from our perspective, you dumped a lot of work in our laps from out 
of the blue, getting irritated at us along the way.

Maybe we can resolve this in a more kinder, gentler, coordinated 
fashion?  :)

What could be done to prevent this sort of situation in the future? 
Maybe add these checks to -mm, and then not push your strict checking 
upstream until the build noise is reduced?

	Jeff


