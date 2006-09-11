Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:39623 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751311AbWIKRoL
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Sep 2006 13:44:11 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8BHiBkU029778
	for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2006 13:44:11 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8BHiBcS331660
	for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2006 11:44:11 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8BHiAmp002269
	for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2006 11:44:11 -0600
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20060911133426.GA7952@linux-mips.org>
References: <20060824234445.6B519D52@localhost.localdomain>
	 <20060911133426.GA7952@linux-mips.org>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 10:43:51 -0700
Message-Id: <1157996631.26324.113.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2006-09-11 at 15:34 +0200, Ralf Baechle wrote:
> On Thu, Aug 24, 2006 at 04:44:45PM -0700, Dave Hansen wrote:
> 
> +choice
> +       prompt "Kernel Page Size"
> +       depends on IA64 || SPARC64 || PARISC || MIPS
> +       default PAGE_SIZE_4KB if MIPS
> 
> On MIPS we have a complicated set of rules for what page size is available
> on which CPU and system Kconfig should know about that to avoid offering
> options that result in non-functioning kernels.  That stuff should better
> be kept under arch/mips than littering mm/Kconfig.

Could you take a look at the mips-specific patch?  I does just that;
keeps the MIPS-specific bits in the MIPS Kconfig.  The default 4k page
size thing is pretty simple, and not conditional on anything I could
find, other than MIPS itself.

-- Dave

