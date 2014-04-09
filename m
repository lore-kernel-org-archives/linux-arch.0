Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:49596 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756246AbaDIBch (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Apr 2014 21:32:37 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <maddy@linux.vnet.ibm.com>;
	Wed, 9 Apr 2014 11:32:34 +1000
Message-ID: <5344A312.80802@linux.vnet.ibm.com>
Date: Wed, 09 Apr 2014 07:02:02 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH V2 1/2] mm: move FAULT_AROUND_ORDER to arch/
References: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com> <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com> <533EDB63.8090909@intel.com>
In-Reply-To: <533EDB63.8090909@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, kirill.shutemov@linux.intel.com, rusty@rustcorp.com.au, akpm@linux-foundation.org, riel@redhat.com, mgorman@suse.de, ak@linux.intel.com, peterz@infradead.org, mingo@kernel.org
Message-ID: <20140409013202.3EuF2qbBnbjhI8Ew15PrGjqniSSwVu6pmnsWClcmrNw@z>

On Friday 04 April 2014 09:48 PM, Dave Hansen wrote:
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

I though about it and decided not to do this way because, in future,
sub platforms of the architecture may decide to change the values. Also,
adding an if line for each architecture with different sub platforms
oring to it will look messy.

With regards
Maddy

> you only put it in one place, and folks only have to care if they want
> to change the default to be something other than 4.
> 

