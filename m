From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Date: Fri, 8 May 2020 23:36:09 +0200
Message-ID: <20200508213609.GU8135@suse.de>
References: <20200508144043.13893-1-joro@8bytes.org>
 <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
List-Id: linux-arch.vger.kernel.org

On Fri, May 08, 2020 at 02:33:19PM -0700, Andy Lutomirski wrote:
> On Fri, May 8, 2020 at 7:40 AM Joerg Roedel <joro@8bytes.org> wrote:

> What's the maximum on other system types?  It might make more sense to
> take the memory hit and pre-populate all the tables at boot so we
> never have to sync them.

Need to look it up for 5-level paging, with 4-level paging its 64 pages
to pre-populate the vmalloc area.

But that would not solve the problem on x86-32, which needs to
synchronize unmappings on the PMD level.


	Joerg
