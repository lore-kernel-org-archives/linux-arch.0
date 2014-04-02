From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] mm: move FAULT_AROUND_ORDER to arch/
Date: Wed, 02 Apr 2014 10:15:42 +0530
Message-ID: <533B95F6.2010303@linux.vnet.ibm.com>
References: <1395730215-11604-1-git-send-email-maddy@linux.vnet.ibm.com> <1395730215-11604-2-git-send-email-maddy@linux.vnet.ibm.com> <20140325173605.GA21411@node.dhcp.inet.fi> <5331C1C9.5020309@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:58899 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791AbaDBEq0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 Apr 2014 00:46:26 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <maddy@linux.vnet.ibm.com>;
	Wed, 2 Apr 2014 14:46:23 +1000
In-Reply-To: <5331C1C9.5020309@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, benh@kernel.crashing.org, paulus@samba.org, kirill.shutemov@linux.intel.com, rusty@rustcorp.com.au, akpm@linux-foundation.org, riel@redhat.com, mgorman@suse.de, ak@linux.intel.com, peterz@infradead.org, mingo@kernel.org

On Tuesday 25 March 2014 11:20 PM, Dave Hansen wrote:
> On 03/25/2014 10:36 AM, Kirill A. Shutemov wrote:
>>>> +/*
>>>> + * Fault around order is a control knob to decide the fault around pages.
>>>> + * Default value is set to 0UL (disabled), but the arch can override it as
>>>> + * desired.
>>>> + */
>>>> +#ifndef FAULT_AROUND_ORDER
>>>> +#define FAULT_AROUND_ORDER	0UL
>>>> +#endif
>> FAULT_AROUND_ORDER == 0 case should be handled separately in
>> do_read_fault(): no reason to go to do_fault_around() if we are going to
>> fault in only one page.
> 
> Isn't this the kind of thing we want to do in Kconfig?
> 
> 
I am still investigating this option since this looks better. But it is
taking time, my bad. I will get back on this.

With Regards
Maddy
