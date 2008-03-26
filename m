From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: What if a TLB flush needed to sleep?
Date: Wed, 26 Mar 2008 21:29:13 +0100 (CET)
Message-ID: <alpine.LFD.1.00.0803262121440.3781@apollo.tec.linutronix.de>
References: <1FE6DD409037234FAB833C420AA843ECE9DF60@orsmsx424.amr.corp.intel.com> <Pine.LNX.4.64.0803261222090.31000@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0803261222090.31000-RYO/mD75kfhx2SFC9UQUAuF7EQX82lMiAL8bYrjMMd8@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter-sJ/iWh9BUns@public.gmane.org>
Cc: "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, 26 Mar 2008, Christoph Lameter wrote:

> On Tue, 25 Mar 2008, Luck, Tony wrote:
> 
> > 2) Is it feasible to rearrange the MM code so that we don't
> > hold any locks while doing a TLB flush?  Or should I implement
> > some sort of spin_only_semaphore?
> 
> The EMM notifier V2 patchset contains two patches that 
> convert the immap_lock and the anon_vma lock to semaphores.

Please use a mutex, not a semaphore. semaphores should only be used
when you need a counting sempahore.

Thanks,

	tglx
