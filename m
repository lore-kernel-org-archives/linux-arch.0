From: Christoph Lameter <clameter-sJ/iWh9BUns@public.gmane.org>
Subject: Re: What if a TLB flush needed to sleep?
Date: Wed, 26 Mar 2008 12:25:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0803261222090.31000@schroedinger.engr.sgi.com>
References: <1FE6DD409037234FAB833C420AA843ECE9DF60@orsmsx424.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1FE6DD409037234FAB833C420AA843ECE9DF60-7XlYjKTK0pM64kNsxIetb7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 25 Mar 2008, Luck, Tony wrote:

> 2) Is it feasible to rearrange the MM code so that we don't
> hold any locks while doing a TLB flush?  Or should I implement
> some sort of spin_only_semaphore?

The EMM notifier V2 patchset contains two patches that 
convert the immap_lock and the anon_vma lock to semaphores. After that
much of the TLB flushing is (tlb_finish_mmu, tlb_gather etc) is running 
without holding any spinlocks. There would need to be additional measures 
for flushing inherent in macros (like ptep_clear_flush). Currently the 
pte functions are called under pte lock.
