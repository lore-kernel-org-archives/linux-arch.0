Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:53609 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbaETH24 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 20 May 2014 03:28:56 -0400
Date: Tue, 20 May 2014 00:28:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V4 2/2] powerpc/pseries: init fault_around_order for
 pseries
Message-ID: <20140520002834.aefb5a90.akpm@linux-foundation.org>
In-Reply-To: <1399541296-18810-3-git-send-email-maddy@linux.vnet.ibm.com>
References: <1399541296-18810-1-git-send-email-maddy@linux.vnet.ibm.com>
	<1399541296-18810-3-git-send-email-maddy@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, benh@kernel.crashing.org, paulus@samba.org, kirill.shutemov@linux.intel.com, rusty@rustcorp.com.au, riel@redhat.com, mgorman@suse.de, ak@linux.intel.com, peterz@infradead.org, mingo@kernel.org, dave.hansen@intel.com
Message-ID: <20140520072834.-Q2YigybrOPVCK_AUyQZTCAu8hzY8mr5cfOrZJ3qirc@z>

On Thu,  8 May 2014 14:58:16 +0530 Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> --- a/arch/powerpc/platforms/pseries/pseries.h
> +++ b/arch/powerpc/platforms/pseries/pseries.h
> @@ -17,6 +17,8 @@ struct device_node;
>  extern void request_event_sources_irqs(struct device_node *np,
>  				       irq_handler_t handler, const char *name);
>  
> +extern unsigned int fault_around_order;

This isn't an appropriate header file for exporting something from core
mm - what happens if arch/mn10300 wants it?.

I guess include/linux/mm.h is the place.

