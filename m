Return-Path: <SRS0=W/Kb=6W=kvack.org=owner-linux-mm@kernel.org>
MIME-Version: 1.0
References: <20200508144043.13893-1-joro@8bytes.org> <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
 <20200508213609.GU8135@suse.de>
In-Reply-To: <20200508213609.GU8135@suse.de>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 8 May 2020 16:49:17 -0700
Message-ID: <CALCETrVxP87o2+aaf=RLW--DSpMrs=BXSQphN6bG5Y4X+OY8GQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-mm@kvack.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200508234917.7rdffsnvbLoouWpkDkR9qu-zJPfjsRc2u__HQTKYbSo@z>

On Fri, May 8, 2020 at 2:36 PM Joerg Roedel <jroedel@suse.de> wrote:
>
> On Fri, May 08, 2020 at 02:33:19PM -0700, Andy Lutomirski wrote:
> > On Fri, May 8, 2020 at 7:40 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> > What's the maximum on other system types?  It might make more sense to
> > take the memory hit and pre-populate all the tables at boot so we
> > never have to sync them.
>
> Need to look it up for 5-level paging, with 4-level paging its 64 pages
> to pre-populate the vmalloc area.
>
> But that would not solve the problem on x86-32, which needs to
> synchronize unmappings on the PMD level.

What changes in this series with x86-32?  We already do that
synchronization, right?  IOW, in the cases where the vmalloc *fault*
code does anything at all, we should have a small bound for how much
memory to preallocate and, if we preallocate it, then there is nothing
to sync and nothing to fault.  And we have the benefit that we never
need to sync anything on 64-bit, which is kind of nice.

Do we actually need PMD-level things for 32-bit?  What if we just
outlawed huge pages in the vmalloc space on 32-bit non-PAE?

Or maybe the net result isn't much of a cleanup after all given the
need to support 32-bit.

>
>
>         Joerg
