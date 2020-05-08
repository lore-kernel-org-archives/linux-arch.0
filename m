Return-Path: <SRS0=W/Kb=6W=kvack.org=owner-linux-mm@kernel.org>
Date: Fri, 8 May 2020 23:24:32 +0200
From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [RFC PATCH 6/7] mm: Remove vmalloc_sync_(un)mappings()
Message-ID: <20200508212432.GS8135@suse.de>
References: <20200508144043.13893-1-joro@8bytes.org>
 <20200508144043.13893-7-joro@8bytes.org>
 <20200508145822.07fcc32b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508145822.07fcc32b@gandalf.local.home>
Sender: owner-linux-mm@kvack.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200508212432.xN1UfjGbAw-8B6n3SKJVQtd6eklVIaWHMZwDh0rTUqs@z>

On Fri, May 08, 2020 at 02:58:22PM -0400, Steven Rostedt wrote:
> You'll need to fold this into this patch, as my patch has already hit
> Linus's tree.

Yeah, have it on my todo-list already when I rebase this.

> But I applied your whole series and I'm not able to reproduce the bug.
> 
> Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks a lot for testing!


	Joerg
