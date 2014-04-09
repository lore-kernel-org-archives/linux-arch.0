From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 1/2] mm: move FAULT_AROUND_ORDER to arch/
Date: Wed, 09 Apr 2014 07:14:35 +0530
Message-ID: <5344A603.90305@linux.vnet.ibm.com>
References: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com> <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com> <533EDB63.8090909@intel.com> <20140404.135056.2103520199689146670.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:39045 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756284AbaDIBo6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Apr 2014 21:44:58 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <maddy@linux.vnet.ibm.com>;
	Wed, 9 Apr 2014 11:44:56 +1000
In-Reply-To: <20140404.135056.2103520199689146670.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>, dave.hansen@intel.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, benh@kernel.crashing.org, paulus@samba.org, kirill.shutemov@linux.intel.com, rusty@rustcorp.com.au, akpm@linux-foundation.org, riel@redhat.com, mgorman@suse.de, ak@linux.intel.com, peterz@infradead.org, mingo@kernel.org

On Friday 04 April 2014 11:20 PM, David Miller wrote:
> From: Dave Hansen <dave.hansen@intel.com>
> Date: Fri, 04 Apr 2014 09:18:43 -0700
> 
>> On 04/03/2014 11:27 PM, Madhavan Srinivasan wrote:
>>> This patch creates infrastructure to move the FAULT_AROUND_ORDER
>>> to arch/ using Kconfig. This will enable architecture maintainers
>>> to decide on suitable FAULT_AROUND_ORDER value based on
>>> performance data for that architecture. Patch also adds
>>> FAULT_AROUND_ORDER Kconfig element in arch/X86.
>>
>> Please don't do it this way.
>>
>> In mm/Kconfig, put
>>
>> 	config FAULT_AROUND_ORDER
>> 		int
>> 		default 1234 if POWERPC
>> 		default 4
>>
>> The way you have it now, every single architecture that needs to enable
>> this has to go put that in their Kconfig.  That's madness.  This way,
>> you only put it in one place, and folks only have to care if they want
>> to change the default to be something other than 4.
> 
> It looks more like it's necessary only to change the default, not
> to enable it.  Unless I read his patch wrong...
> 
Yes. With current patch, you only need to change the default by which
you enable it.

With regards
Maddy
> 
