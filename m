Return-Path: <SRS0=nPx+=65=kvack.org=owner-linux-mm@kernel.org>
Date: Fri, 15 May 2020 15:03:13 +0200
From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Message-ID: <20200515130313.GI8135@suse.de>
References: <20200513152137.32426-1-joro@8bytes.org>
 <CALCETrW1Y2Q7dWwv4X7PHf3yxOGMcDaBG0NK7BWPAR=FiqsoPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrW1Y2Q7dWwv4X7PHf3yxOGMcDaBG0NK7BWPAR=FiqsoPQ@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200515130313.iWO5mdDmtTxn1FAsFUQ58amrGA8KtVJIURYywmBIzWU@z>

On Wed, May 13, 2020 at 09:01:04AM -0700, Andy Lutomirski wrote:
> I would love to see a followup patch that preallocates the vmalloc
> region on 64-bit and compiles out pgd_list and all of the associated
> gunk.

Looked a bit into this, with pre-allocation and a few more changes all
but one users of pgd_list and pgd_lock can be get rid of on x86-64. But
there is the XEN-PV code which also needs to traverse pgd_list, and I am
not sure how to get rid of that.

Regards,

	Joerg
