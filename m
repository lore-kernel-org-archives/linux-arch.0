Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:37545 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756719AbaD2Jf4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Apr 2014 05:35:56 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <maddy@linux.vnet.ibm.com>;
	Tue, 29 Apr 2014 19:35:53 +1000
Message-ID: <535F71EA.6070604@linux.vnet.ibm.com>
Date: Tue, 29 Apr 2014 15:03:30 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH V3 1/2] mm: move FAULT_AROUND_ORDER to arch/
References: <1398675690-16186-1-git-send-email-maddy@linux.vnet.ibm.com> <1398675690-16186-2-git-send-email-maddy@linux.vnet.ibm.com> <20140428090649.GD27561@twins.programming.kicks-ass.net>
In-Reply-To: <20140428090649.GD27561@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, benh@kernel.crashing.org, paulus@samba.org, kirill.shutemov@linux.intel.com, rusty@rustcorp.com.au, akpm@linux-foundation.org, riel@redhat.com, mgorman@suse.de, ak@linux.intel.com, mingo@kernel.org, dave.hansen@intel.com
Message-ID: <20140429093330.0nQ9VC3ztdhTt_hI8pXzONx7nAXxkM8m3u5IvRE3vME@z>

On Monday 28 April 2014 02:36 PM, Peter Zijlstra wrote:
> On Mon, Apr 28, 2014 at 02:31:29PM +0530, Madhavan Srinivasan wrote:
>> +unsigned int fault_around_order = CONFIG_FAULT_AROUND_ORDER;
> 
> __read_mostly?
> 
Agreed. Will add it.

Thanks for review.
With regards
Maddy

