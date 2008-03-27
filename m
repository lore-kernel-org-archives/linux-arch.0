From: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: What if a TLB flush needed to sleep?
Date: Thu, 27 Mar 2008 14:20:52 +0100
Message-ID: <1206624052.8514.570.camel@twins>
References: <1FE6DD409037234FAB833C420AA843ECE9DF60@orsmsx424.amr.corp.intel.com>
	 <Pine.LNX.4.64.0803261222090.31000@schroedinger.engr.sgi.com>
	 <alpine.LFD.1.00.0803262121440.3781@apollo.tec.linutronix.de>
	 <Pine.LNX.4.64.0803261817110.1115@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0803261817110.1115-RYO/mD75kfhx2SFC9UQUAuF7EQX82lMiAL8bYrjMMd8@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter-sJ/iWh9BUns@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 2008-03-26 at 18:19 -0700, Christoph Lameter wrote:
> On Wed, 26 Mar 2008, Thomas Gleixner wrote:
> 
> > Please use a mutex, not a semaphore. semaphores should only be used
> > when you need a counting sempahore.
> 
> Seems that mutexes are mainly useful for 2 processor systems since they 
> do not allow concurrent read sections. We want multiple processors able 
> to reclaim pages within the same vma or file concurrently. This means 
> processors need to be able to concurrently walk potentially long lists of 
> vmas.

confusion between semaphores and rwsems
