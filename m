Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:6319 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751355AbWERMYs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 May 2006 08:24:48 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: Replace i386/x86_64 nmi_callback RCU code with atomic notifier chain
Date: Thu, 18 May 2006 14:23:41 +0200
References: <5851.1147954253@ocs3>
In-Reply-To: <5851.1147954253@ocs3>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605181423.41880.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Keith Owens <kaos@sgi.com>
Cc: linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Zwane Mwaikambo <zwane@linuxpower.ca>
List-ID: <linux-arch.vger.kernel.org>


> Where is this 'firstfloor' tree?  The only google references are to
> http://www.firstfloor.org/~andi which gives "You don't have permission
> to access /~andi/ on this server".  Google also lists ~andi/35,
> ~andi/softnet/, ~andi/numa.html, ~andi/mbind.html, but they all get 404
> errors.

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/

It's the staging tree for x86-64 and some i386 merges
It's also mirrored into -mm* with some lag.

-Andi

