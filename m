From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH V2 1/2] mm: move FAULT_AROUND_ORDER to arch/
Date: Fri, 04 Apr 2014 13:50:56 -0400 (EDT)
Message-ID: <20140404.135056.2103520199689146670.davem@davemloft.net>
References: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com>
	<1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com>
	<533EDB63.8090909@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:53341 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800AbaDDRtW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Apr 2014 13:49:22 -0400
In-Reply-To: <533EDB63.8090909@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dave.hansen@intel.com
Cc: maddy@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, benh@kernel.crashing.org, paulus@samba.org, kirill.shutemov@linux.intel.com, rusty@rustcorp.com.au, akpm@linux-foundation.org, riel@redhat.com, mgorman@suse.de, ak@linux.intel.com, peterz@infradead.org, mingo@kernel.org

From: Dave Hansen <dave.hansen@intel.com>
Date: Fri, 04 Apr 2014 09:18:43 -0700

> On 04/03/2014 11:27 PM, Madhavan Srinivasan wrote:
>> This patch creates infrastructure to move the FAULT_AROUND_ORDER
>> to arch/ using Kconfig. This will enable architecture maintainers
>> to decide on suitable FAULT_AROUND_ORDER value based on
>> performance data for that architecture. Patch also adds
>> FAULT_AROUND_ORDER Kconfig element in arch/X86.
> 
> Please don't do it this way.
> 
> In mm/Kconfig, put
> 
> 	config FAULT_AROUND_ORDER
> 		int
> 		default 1234 if POWERPC
> 		default 4
> 
> The way you have it now, every single architecture that needs to enable
> this has to go put that in their Kconfig.  That's madness.  This way,
> you only put it in one place, and folks only have to care if they want
> to change the default to be something other than 4.

It looks more like it's necessary only to change the default, not
to enable it.  Unless I read his patch wrong...
