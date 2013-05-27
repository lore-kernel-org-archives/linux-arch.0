From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3-resend 00/11] uaccess: better might_sleep/might_fault
 behavior
Date: Mon, 27 May 2013 18:35:30 +0200
Message-ID: <20130527163530.GB19373@twins.programming.kicks-ass.net>
References: <1369575487-26176-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1369575487-26176-1-git-send-email-mst@redhat.com>
Sender: owner-linux-mm@kvack.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, May 26, 2013 at 05:21:30PM +0300, Michael S. Tsirkin wrote:
> If the changes look good, would sched maintainers
> please consider merging them through sched/core because of the
> interaction with the scheduler?
> 
> Please review, and consider for 3.11.

I'll stick them in my queue, we'll see if anything falls over ;-)

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
