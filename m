From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Date: Tue, 12 May 2020 11:13:32 -0400
Message-ID: <20200512111332.24f5cd7a@gandalf.local.home>
References: <20200511191414.GY8135@suse.de>
        <8D6745B7-0EC2-4FCC-B6FC-E7E1557EB18E@amacapital.net>
        <20200512150250.GC8135@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200512150250.GC8135@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <joro@8bytes.org>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
List-Id: linux-arch.vger.kernel.org

On Tue, 12 May 2020 17:02:50 +0200
Joerg Roedel <jroedel@suse.de> wrote:

> On Mon, May 11, 2020 at 12:36:19PM -0700, Andy Lutomirski wrote:
> > I’m guessing the right solution is either your series or your series
> > plus preallocation on 64-bit. I’m just grumpy about it...  
> 
> Okay, so we can do the pre-allocation when it turns out the pgd_list
> lock-times become a problem on x86-64. The tracking code in vmalloc.c is
> needed anyway for 32-bit and there is no reason why 64-bit shouldn't use
> it as well for now.
> I don't think that taking the lock _will_ be a problem, as it is only
> taken when a new PGD/P4D entry is populated. And it is pretty unlikely
> that a system will populate all 64 of them, with 4-level paging each of
> these entries will map 512GB of address space. But if I am wrong here
> pre-allocating is still an option.
> 

256TB of RAM isn't too far in the future ;-)

-- Steve
