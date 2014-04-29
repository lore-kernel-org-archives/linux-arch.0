From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 1/2] mm: move FAULT_AROUND_ORDER to arch/
Date: Tue, 29 Apr 2014 15:03:30 +0530
Message-ID: <535F71EA.6070604@linux.vnet.ibm.com>
References: <1398675690-16186-1-git-send-email-maddy@linux.vnet.ibm.com> <1398675690-16186-2-git-send-email-maddy@linux.vnet.ibm.com> <20140428090649.GD27561@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20140428090649.GD27561@twins.programming.kicks-ass.net>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, benh@kernel.crashing.org, paulus@samba.org, kirill.shutemov@linux.intel.com, rusty@rustcorp.com.au, akpm@linux-foundation.org, riel@redhat.com, mgorman@suse.de, ak@linux.intel.com, mingo@kernel.org, dave.hansen@intel.com
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
