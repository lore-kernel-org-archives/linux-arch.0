From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 8/8] x86/mm: Allow to have userspace mappings above
 47-bits
Date: Fri, 7 Apr 2017 19:20:44 +0300
Message-ID: <20170407162044.ntn4w6ukpxhi2ei2@node.shutemov.name>
References: <20170406140106.78087-1-kirill.shutemov@linux.intel.com>
 <20170406140106.78087-9-kirill.shutemov@linux.intel.com>
 <8d68093b-670a-7d7e-2216-bf64b19c7a48@linux.vnet.ibm.com>
 <20170407155945.7lyapjbwacg3ikw6@node.shutemov.name>
 <2A1F4E56-9374-4C41-876C-6E6CBD16DB22@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:33075 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934299AbdDGQUt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2017 12:20:49 -0400
Received: by mail-wr0-f181.google.com with SMTP id g19so68748650wrb.0
        for <linux-arch@vger.kernel.org>; Fri, 07 Apr 2017 09:20:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2A1F4E56-9374-4C41-876C-6E6CBD16DB22@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hpa@zytor.com
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Dmitry Safonov <dsafonov@virtuozzo.com>

On Fri, Apr 07, 2017 at 09:09:27AM -0700, hpa@zytor.com wrote:
> >I think the reasonable way for an application to claim it's 63-bit
> >clean
> >is to make allocations with (void *)-1 as hint address.
> 
> You realize that people have said that about just about every memory

Any better solution?

-- 
 Kirill A. Shutemov
