From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Thu, 18 Jun 2009 12:05:19 +0900
Message-ID: <20090618030519.GC26531@linux-sh.org>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <4A373EE6.6070201@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:37197 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbZFRDGJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jun 2009 23:06:09 -0400
Content-Disposition: inline
In-Reply-To: <4A373EE6.6070201@compulab.co.il>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Rapoport <mike@compulab.co.il>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org

On Tue, Jun 16, 2009 at 09:42:46AM +0300, Mike Rapoport wrote:
> James Bottomley wrote:
> > We've got to the point where there are simply too many embedded
> > architectures to invite all the arch maintainers to the kernel summit.
> > So, this year, we thought we'd do embedded via topic driven invitations
> > instead.  So what we're looking for is a proposal to discuss the issues
> > most affecting embedded architectures, or preview any features affecting
> > the main kernel which embedded architectures might need ... or any other
> > topics from embedded architectures which might need discussion or
> > debate.
> 
> Another issue that affects embedded architectures is drivers initialization
> order. There are a lot of cases when you need the drivers to be initialized in
> particular order, and current initcalls scheme does not allow fine grained
> control for it.
> 
Look at the early platform device abstraction, this allows specific
fine-grained control over when certain drivers are initialized, well
before the driver core is available. On SH this is how we deal with 
our system timers as clockevents/clocksources while just using regular
platform devices, and having no other abstraction. You can read more in
Documentation/driver-model/platform.txt.  For an example,  you can grep
for earlytimer in arch/sh as well as in drivers/clocksource.
