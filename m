From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: memmap_init_zone() performance improvement
Date: Tue, 30 Oct 2012 08:14:22 -0700
Message-ID: <508FEECE.2070402@linux.vnet.ibm.com>
References: <1349276174-8398-1-git-send-email-mike.yoknis@hp.com> <20121008151656.GM29125@suse.de> <1349794597.29752.10.camel@MikesLinux.fc.hp.com> <1350676398.1169.6.camel@MikesLinux.fc.hp.com> <20121020082858.GA2698@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20121020082858.GA2698@suse.de>
Sender: owner-linux-mm@kvack.org
To: Mel Gorman <mgorman@suse.de>
Cc: Mike Yoknis <mike.yoknis@hp.com>, mingo@redhat.com, akpm@linux-foundation.org, linux-arch@vger.kernel.org, mmarek@suse.cz, tglx@linutronix.de, hpa@zytor.com, arnd@arndb.de, sam@ravnborg.org, minchan@kernel.org, kamezawa.hiroyu@jp.fujitsu.com, mhocko@suse.cz, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On 10/20/2012 01:29 AM, Mel Gorman wrote:
> I'm travelling at the moment so apologies that I have not followed up on
> this. My problem is still the same with the patch - it changes more
> headers than is necessary and it is sparsemem specific. At minimum, try
> the suggestion of 
> 
> if (!early_pfn_valid(pfn)) {
>       pfn = ALIGN(pfn + MAX_ORDER_NR_PAGES, MAX_ORDER_NR_PAGES) - 1;
>       continue;
> }

Sorry I didn't catch this until v2...

Is that ALIGN() correct?  If pfn=3, then it would expand to:

(3+MAX_ORDER_NR_PAGES+MAX_ORDER_NR_PAGES-1) & ~(MAX_ORDER_NR_PAGES-1)

You would end up skipping the current MAX_ORDER_NR_PAGES area, and then
one _extra_ because ALIGN() aligns up, and you're adding
MAX_ORDER_NR_PAGES too.  It doesn't matter unless you run in to a
!early_valid_pfn() in the middle of a MAX_ORDER area, I guess.

I think this would work, plus be a bit smaller:

	pfn = ALIGN(pfn + 1, MAX_ORDER_NR_PAGES) - 1;

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
