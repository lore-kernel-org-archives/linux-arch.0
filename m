From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: What if a TLB flush needed to sleep?
Date: Tue, 25 Mar 2008 21:47:25 +0000
Message-ID: <20080325214725.3d707445@core>
References: <1FE6DD409037234FAB833C420AA843ECE9DF60@orsmsx424.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1FE6DD409037234FAB833C420AA843ECE9DF60-7XlYjKTK0pM64kNsxIetb7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

> 	down(&ptcg_sem);
> 	... execute ptc.g
> 	up(&ptcg_sem);

That will dig you a nice large hole for real time to fall into. If you
want to do rt nicely you want to avoid semaphores and the corresponding
lack of ability to fix priority inversions.

> 2) Is it feasible to rearrange the MM code so that we don't
> hold any locks while doing a TLB flush?  Or should I implement
> some sort of spin_only_semaphore?

Better to keep ia64 perversions in the IA64 code whenever possible and
lower risk for everyone else.

Alan
