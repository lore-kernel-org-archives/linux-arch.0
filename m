Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:17380 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422909AbWHYVEt
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Aug 2006 17:04:49 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7PL4mCs017994
	for <linux-arch@vger.kernel.org>; Fri, 25 Aug 2006 17:04:48 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7PL4m7n346386
	for <linux-arch@vger.kernel.org>; Fri, 25 Aug 2006 15:04:48 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7PL4mBl031687
	for <linux-arch@vger.kernel.org>; Fri, 25 Aug 2006 15:04:48 -0600
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20060825053127.GA9066@localhost.hsdv.com>
References: <20060824234445.6B519D52@localhost.localdomain>
	 <20060825053127.GA9066@localhost.hsdv.com>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 14:04:39 -0700
Message-Id: <1156539879.12011.206.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2006-08-25 at 14:31 +0900, Paul Mundt wrote:
> I like the idea of asm-generic/page_size.h (though why not just use
> asm-generic/page.h?)

One reason is that get_order() is defined on a few architectures.  There
would need to be some separate Kconfig and #ifdef work to get it
conditionally defined.

Do you think doing it in page_size.h is really a problem?

-- Dave

