Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.ocs.com.au ([202.147.117.210]:61635 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751002AbWERMMM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 May 2006 08:12:12 -0400
From: Keith Owens <kaos@sgi.com>
Subject: Re: Replace i386/x86_64 nmi_callback RCU code with atomic notifier chain 
In-reply-to: Your message of "Thu, 18 May 2006 12:15:27 +0200."
             <200605181215.28289.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 May 2006 22:10:53 +1000
Message-ID: <5851.1147954253@ocs3>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Zwane Mwaikambo <zwane@linuxpower.ca>
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen (on Thu, 18 May 2006 12:15:27 +0200) wrote:
>On Thursday 18 May 2006 08:17, Keith Owens wrote:
>> i386 and x86_64 have low level RCU code to handle dynamic registration
>> and unregistration of the NMI callback function.  With the rewrite of
>> the general notifier chains, we can remove the low level RCU hacking
>> from these NMI handlers and replace them with an atomic notifier chain,
>> making the code much simpler.  set_nmi_callback() gets replaced by yet
>> another notify chain.  The only affected code outside the main NMI
>> handler is crash and oprofile.  Any objections?
>
>It has been already done. Check -mm or firstfloor tree.

Where is this 'firstfloor' tree?  The only google references are to
http://www.firstfloor.org/~andi which gives "You don't have permission
to access /~andi/ on this server".  Google also lists ~andi/35,
~andi/softnet/, ~andi/numa.html, ~andi/mbind.html, but they all get 404
errors.

