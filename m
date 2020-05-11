Return-Path: <SRS0=pOir=6Z=kvack.org=owner-linux-mm@kernel.org>
Date: Mon, 11 May 2020 09:42:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Message-ID: <20200511074243.GE2957@hirez.programming.kicks-ass.net>
References: <20200508144043.13893-1-joro@8bytes.org>
 <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
 <20200508213609.GU8135@suse.de>
 <CALCETrVxP87o2+aaf=RLW--DSpMrs=BXSQphN6bG5Y4X+OY8GQ@mail.gmail.com>
 <20200509175217.GV8135@suse.de>
 <CALCETrVU-+G3K5ABBRSEMiwnskL4mZsVcoTESZXnu34J7TaOqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVU-+G3K5ABBRSEMiwnskL4mZsVcoTESZXnu34J7TaOqw@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>, Joerg Roedel <joro@8bytes.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200511074243.54tJKd0UkObDGtH-R5MoXGH9mdn1WlyKzSXzbnCkrHA@z>

On Sat, May 09, 2020 at 12:05:29PM -0700, Andy Lutomirski wrote:

> On x86_64, the only real advantage is that the handful of corner cases
> that make vmalloc faults unpleasant (mostly relating to vmap stacks)
> go away.  On x86_32, a bunch of mind-bending stuff (everything your
> series deletes but also almost everything your series *adds*) goes
> away.  There may be a genuine tiny performance hit on 2-level systems
> due to the loss of huge pages in vmalloc space, but I'm not sure I
> care or that we use them anyway on these systems.  And PeterZ can stop
> even thinking about RCU.
> 
> Am I making sense?

I think it'll work for x86_64 and that is really all I care about :-)
