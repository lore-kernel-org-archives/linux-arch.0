From: KOSAKI Motohiro <kosaki.motohiro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 2/6] arch: mm: do not invoke OOM killer on kernel fault
 OOM
Date: Mon, 29 Jul 2013 14:58:05 -0400
Message-ID: <51F6BB3D.6000700@gmail.com>
References: <1374791138-15665-1-git-send-email-hannes@cmpxchg.org> <1374791138-15665-3-git-send-email-hannes@cmpxchg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <cgroups-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1374791138-15665-3-git-send-email-hannes-druUgvl0LCNAfugRpC6u6w@public.gmane.org>
Sender: cgroups-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johannes Weiner <hannes-druUgvl0LCNAfugRpC6u6w@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Michal Hocko <mhocko-AlSwsSmVLrQ@public.gmane.org>, David Rientjes <rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, azurIt <azurit-Rm0zKEqwvD4@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, cgroups-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kosaki.motohiro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-arch.vger.kernel.org

(7/25/13 6:25 PM), Johannes Weiner wrote:
> Kernel faults are expected to handle OOM conditions gracefully (gup,
> uaccess etc.), so they should never invoke the OOM killer.  Reserve
> this for faults triggered in user context when it is the only option.
> 
> Most architectures already do this, fix up the remaining few.
> 
> Signed-off-by: Johannes Weiner <hannes-druUgvl0LCNAfugRpC6u6w@public.gmane.org>

OK. but now almost all arch have the same page fault handler. So, I think
we can implement arch generic page fault handler in future. Ah, ok, never
mind if you are not interest.

Acked-by: KOSAKI Motohiro <kosaki.motohiro-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
