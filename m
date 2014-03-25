From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 1/1] mm: move FAULT_AROUND_ORDER to arch/
Date: Tue, 25 Mar 2014 10:50:01 -0700
Message-ID: <5331C1C9.5020309@intel.com>
References: <1395730215-11604-1-git-send-email-maddy@linux.vnet.ibm.com> <1395730215-11604-2-git-send-email-maddy@linux.vnet.ibm.com> <20140325173605.GA21411@node.dhcp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20140325173605.GA21411@node.dhcp.inet.fi>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, benh@kernel.crashing.org, paulus@samba.org, kirill.shutemov@linux.intel.com, rusty@rustcorp.com.au, akpm@linux-foundation.org, riel@redhat.com, mgorman@suse.de, ak@linux.intel.com, peterz@infradead.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

On 03/25/2014 10:36 AM, Kirill A. Shutemov wrote:
>> > +/*
>> > + * Fault around order is a control knob to decide the fault around pages.
>> > + * Default value is set to 0UL (disabled), but the arch can override it as
>> > + * desired.
>> > + */
>> > +#ifndef FAULT_AROUND_ORDER
>> > +#define FAULT_AROUND_ORDER	0UL
>> > +#endif
> FAULT_AROUND_ORDER == 0 case should be handled separately in
> do_read_fault(): no reason to go to do_fault_around() if we are going to
> fault in only one page.

Isn't this the kind of thing we want to do in Kconfig?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
