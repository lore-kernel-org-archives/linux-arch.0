From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCHv2 00/29] 5-level paging
Date: Thu, 5 Jan 2017 19:57:15 +0300
Message-ID: <20170105165715.GF17319@node.shutemov.name>
References: <20161227015413.187403-1-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20161227015413.187403-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Dec 27, 2016 at 04:53:44AM +0300, Kirill A. Shutemov wrote:
> Here is v2 of 5-level paging patchset.
> 
> Please consider applying first 7 patches.

It's probably useful to describe all pieces and the order in which they can
be be merged:

  - The first seven patches of this patchset I would like to get applied now:

    + Detect la57 feature for /proc/cpuinfo.

    + Brings 5-level paging to generic code and convert all architectures
      to it using <asm-generic/5level-fixup.h>

    This is preparation for the next batch of patches.

  - Basic LA57 enabling

    The rest of the patches of the patchset, except rlimit proposal.

    This would enable 5-level paging for kernel.

    Userspace upper address would be limited to current TASK_SIZE_MAX --
    47-bit - PAGE_SIZE, until we will figure out the right interface to
    opt-in full 56-bit VA.

    We still working on getting XEN into shape. We need to get it up and
    running at least for 4-level paging to not regress any configuration.

The reset can be merged independently after basic LA57 enabling:

  - Large VA opt-in mechanism

    I've proposed rlimit handle to enable large VA for userspace.

    Andy is not fan of it. We need to decide what is right way to go.

    Any help with that is welcome.

  - Boottime switch for 5-level paging.

    I haven't started looking into this yet.

  - MPX - MAWA enabling required.

    It requires changes into GCC (libmpx and libmpxwrappers) which are
    not ready yet.

  - Virtualization - EPT5

    There's RFC patchset by Liang Li. Work in progress.

Does it sound reasonable from maintainer's point of view?
Or should I shift priorities somewhere?

-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
