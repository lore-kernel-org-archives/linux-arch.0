Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:10960 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964909AbWIKSna (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Sep 2006 14:43:30 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8BIhQo2002843
	for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2006 14:43:26 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8BIhPmo272038
	for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2006 14:43:25 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8BIhOJa017233
	for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2006 14:43:24 -0400
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20060911005118.GA22161@ccure.user-mode-linux.org>
References: <20060824234445.6B519D52@localhost.localdomain>
	 <20060911005118.GA22161@ccure.user-mode-linux.org>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 11:43:05 -0700
Message-Id: <1158000185.26324.137.camel@localhost.localdomain>
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

When UML needs this, the thing to do is to make a set of UML Kconfig
options, just like sparc64 has.

config UML_PAGE_SIZE_NNNK
	def_bool y

-- Dave

