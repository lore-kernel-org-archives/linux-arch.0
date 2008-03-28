From: "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: down_spin() implementation
Date: Fri, 28 Mar 2008 14:16:55 -0700
Message-ID: <1FE6DD409037234FAB833C420AA843ECF237C0@orsmsx424.amr.corp.intel.com>
References: <1FE6DD409037234FAB833C420AA843ECE9DF60@orsmsx424.amr.corp.intel.com> <1FE6DD409037234FAB833C420AA843ECE9EB1C@orsmsx424.amr.corp.intel.com> <20080327141508.GL16721@parisc-linux.org> <200803281101.25037.nickpiggin@yahoo.com.au> <20080328124517.GQ16721@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
In-reply-to: <20080328124517.GQ16721-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Nick Piggin <nickpiggin-/E1597aS9LT0CCvOHzKKcA@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

> So it makes little sense to add this to semaphores.  Better to introduce
> a spinaphore, as you say.

> struct {
>   atomic_t cur;
>   int max;
> } ss_t;

Could this API sneak into the bottom of one or the other of
linux/include/{spinlock,semaphore}.h ... or should it get its own
spinaphore.h file?

Or should I follow Alan's earlier advice and keep this as an ia64
only thing (since I'll be the only user).

-Tony
