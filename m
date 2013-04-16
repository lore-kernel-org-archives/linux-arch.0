From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/3 v2] mutex: Improve mutex performance by doing less
 atomic-ops & better spinning
Date: Tue, 16 Apr 2013 11:12:59 +0200
Message-ID: <20130416091259.GC9569@gmail.com>
References: <1366036679-9702-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1366036679-9702-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, Dave Jones <davej@redhat.com>, Clark Williams <williams@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, "Chandramouleeswaran, Aswin" <aswin@hp.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, "Norton, Scott J" <scott.norton@hp.com>, Rik van Riel <riel@redhat.com>
List-Id: linux-arch.vger.kernel.org


* Waiman Long <Waiman.Long@hp.com> wrote:

> [...]
> 
> Patches 2 improves the mutex spinning process by reducing contention among the 
> spinners when competing for the mutex. This is done by using a MCS lock to put 
> the spinners in a queue so that only the first spinner will try to acquire the 
> mutex when it is available. This patch showed significant performance 
> improvement of +30% on the AIM7 fserver and new_fserver workload.

Ok, that's really nice - and this approach has no arbitrary limits/tunings in it.

Do you have a performance comparison to your first series (patches 1+2+3 IIRC) - 
how does this new series with MCS locking compare to the best previous result from 
that old series? Do we now achieve that level of performance?

Thanks,

	Ingo
