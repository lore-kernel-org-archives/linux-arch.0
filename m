From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 7/8] x86: Enable 5-level paging support
Date: Thu, 6 Apr 2017 17:56:47 +0200
Message-ID: <a2cc767b-40c2-ff1e-3385-f16985a69b19@suse.com>
References: <20170406140106.78087-1-kirill.shutemov@linux.intel.com>
 <20170406140106.78087-8-kirill.shutemov@linux.intel.com>
 <469e1232-617c-daaa-90a6-a90d6f80059f@suse.com>
 <20170406152438.ekpu34qe2wzevf4h@node.shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:32798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753506AbdDFP4w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Apr 2017 11:56:52 -0400
In-Reply-To: <20170406152438.ekpu34qe2wzevf4h@node.shutemov.name>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On 06/04/17 17:24, Kirill A. Shutemov wrote:
> On Thu, Apr 06, 2017 at 04:52:11PM +0200, Juergen Gross wrote:
>> On 06/04/17 16:01, Kirill A. Shutemov wrote:
>>> Most of things are in place and we can enable support of 5-level paging.
>>>
>>> Enabling XEN with 5-level paging requires more work. The patch makes XEN
>>> dependent on !X86_5LEVEL.
>>>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> ---
>>>  arch/x86/Kconfig     | 5 +++++
>>>  arch/x86/xen/Kconfig | 1 +
>>>  2 files changed, 6 insertions(+)
>>>
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index 4e153e93273f..7a76dcac357e 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -318,6 +318,7 @@ config FIX_EARLYCON_MEM
>>>  
>>>  config PGTABLE_LEVELS
>>>  	int
>>> +	default 5 if X86_5LEVEL
>>>  	default 4 if X86_64
>>>  	default 3 if X86_PAE
>>>  	default 2
>>> @@ -1390,6 +1391,10 @@ config X86_PAE
>>>  	  has the cost of more pagetable lookup overhead, and also
>>>  	  consumes more pagetable space per process.
>>>  
>>> +config X86_5LEVEL
>>> +	bool "Enable 5-level page tables support"
>>> +	depends on X86_64
>>> +
>>>  config ARCH_PHYS_ADDR_T_64BIT
>>>  	def_bool y
>>>  	depends on X86_64 || X86_PAE
>>> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
>>> index 76b6dbd627df..b90d481ce5a1 100644
>>> --- a/arch/x86/xen/Kconfig
>>> +++ b/arch/x86/xen/Kconfig
>>> @@ -5,6 +5,7 @@
>>>  config XEN
>>>  	bool "Xen guest support"
>>>  	depends on PARAVIRT
>>> +	depends on !X86_5LEVEL
>>>  	select PARAVIRT_CLOCK
>>>  	select XEN_HAVE_PVMMU
>>>  	select XEN_HAVE_VPMU
>>>
>>
>> Just a heads up: this last change will conflict with the Xen tree.
> 
> It should be trivial to fix, right? It's one-liner after all.

Right. Just wanted to mention it.


Juergen
