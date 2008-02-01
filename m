Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53273 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755164AbYBAQny (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 1 Feb 2008 11:43:54 -0500
Message-ID: <47A34C47.9040306@garzik.org>
Date: Fri, 01 Feb 2008 11:43:51 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
Subject: Re: Are Section mismatches out of control?
References: <20080201104718.GA11717@uranus.ravnborg.org> <20080201030329.9b760777.akpm@linux-foundation.org>
In-Reply-To: <20080201030329.9b760777.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>

Andrew Morton wrote:
> On Fri, 1 Feb 2008 11:47:18 +0100 Sam Ravnborg <sam@ravnborg.org> wrote:
> 
>> James said in a related posting that the Section mismatch
>> warnings were getting out of control.
> 
> eh.  They're easy - the build system tells you about them!
> 
>> The list is here:
> 
> Question is: why do people keep adding new ones when they are so easy to
> detect and fix?
> 
> Asnwer: because neither they nor their patch integrators are doing adequate
> compilation testing.
> 
>> I will look at drivers/isdn as next step.
> 
> Thanks.

Another way to look at it...  All of a sudden, different from 2.6.24, 
kernel 2.6.25-git build spews so many warnings that I need to disable 
section mismatch checking completely, because there is so much noise 
that __normal build messages scroll off the screen__.

	Jeff




