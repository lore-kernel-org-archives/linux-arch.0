Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:21702 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932115AbWIKRdh
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Sep 2006 13:33:37 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8BHXYHD013071
	for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2006 13:33:34 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8BHXYh0323566
	for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2006 11:33:34 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8BHXXSu028936
	for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2006 11:33:34 -0600
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20060911005118.GA22161@ccure.user-mode-linux.org>
References: <20060824234445.6B519D52@localhost.localdomain>
	 <20060911005118.GA22161@ccure.user-mode-linux.org>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 10:33:16 -0700
Message-Id: <1157995996.26324.109.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2006-09-10 at 20:51 -0400, Jeff Dike wrote:
> > +     default "12" # arm || h8300 || i386 | m68knommu |ppc
> > +                  # s390 || um || v850 || xtensa
> 
> UML inherits its page size from the host architecture.  So far, that's
> always 4096, but as soon as that changes, the construction above
> breaks it. 

Did you have any plans on how to inherit this from the host?  You'd need
to use something like getpagesize() from userspace at kernel
configuration time, right?

-- Dave

