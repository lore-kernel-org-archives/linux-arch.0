From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Date: Sat, 9 May 2020 18:11:57 -0700
Message-ID: <20200510011157.GU16070@bombadil.infradead.org>
References: <20200508144043.13893-1-joro@8bytes.org>
 <20200508192000.GB2957@hirez.programming.kicks-ass.net>
 <20200508213407.GT8135@suse.de>
 <20200509092516.GC2957@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200509092516.GC2957@hirez.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joerg Roedel <jroedel@suse.de>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, rjw@rjwysocki.net, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Sat, May 09, 2020 at 11:25:16AM +0200, Peter Zijlstra wrote:
> On Fri, May 08, 2020 at 11:34:07PM +0200, Joerg Roedel wrote:
> > On Fri, May 08, 2020 at 09:20:00PM +0200, Peter Zijlstra wrote:
> > > The only concern I have is the pgd_lock lock hold times.
> > > 
> > > By not doing on-demand faults anymore, and consistently calling
> > > sync_global_*(), we iterate that pgd_list thing much more often than
> > > before if I'm not mistaken.
> > 
> > Should not be a problem, from what I have seen this function is not
> > called often on x86-64.  The vmalloc area needs to be synchronized at
> > the top-level there, which is by now P4D (with 4-level paging). And the
> > vmalloc area takes 64 entries, when all of them are populated the
> > function will not be called again.
> 
> Right; it's just that the moment you do trigger it, it'll iterate that
> pgd_list and that is potentially huge. Then again, that's not a new
> problem.
> 
> I suppose we can deal with it if/when it becomes an actual problem.
> 
> I had a quick look and I think it might be possible to make it an RCU
> managed list. We'd have to remove the pgd_list entry in
> put_task_struct_rcu_user(). Then we can play games in sync_global_*()
> and use RCU iteration. New tasks (which can be missed in the RCU
> iteration) will already have a full clone of the PGD anyway.

One of the things on my long-term todo list is to replace mm_struct.mmlist
with an XArray containing all mm_structs.  Then we can use one mark
to indicate maybe-swapped and another mark to indicate ... whatever it
is pgd_list indicates.  Iterating an XArray (whether the entire thing
or with marks) is RCU-safe and faster than iterating a linked list,
so this should solve the problem?
