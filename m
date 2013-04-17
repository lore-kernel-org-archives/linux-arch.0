From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 2/3] mutex: Queue mutex spinners with MCS lock to
 reduce cacheline contention
Date: Wed, 17 Apr 2013 09:50:55 +0200
Message-ID: <20130417075055.GC31607@gmail.com>
References: <1366036679-9702-1-git-send-email-Waiman.Long@hp.com>
 <1366036679-9702-3-git-send-email-Waiman.Long@hp.com>
 <20130416091026.GB9569@gmail.com>
 <516D5F97.9050203@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <516D5F97.9050203@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, Dave Jones <davej@redhat.com>, Clark Williams <williams@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, "Chandramouleeswaran, Aswin" <aswin@hp.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, "Norton, Scott J" <scott.norton@hp.com>, Rik van Riel <riel@redhat.com>
List-Id: linux-arch.vger.kernel.org


* Waiman Long <Waiman.Long@hp.com> wrote:

> > I'd suggest a preparatory patch that gets rid of that flag and moves these two
> > functions from sched/core.c to mutex.c where they belong.
> >
> > This will also allow the removal of the mutex prototypes from sched.h.
> 
> Yes, I can certainly prepare a patch to remove SCHED_FEAT_OWNER_SPIN & move 
> those functions back to mutex.c after my patch set goes in. As for the timing, 
> do you want me to do it now or it can wait as I will start my vacation later 
> this week and will be back by the end of the month.

I'd suggest waiting with the latest series until you are back, so that you can 
address regressions, should there be any.

Thanks,

	Ingo
