From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: down_spin() implementation
Date: Sat, 29 Mar 2008 00:48:21 +0100
Message-ID: <200803290048.22931.arnd@arndb.de>
References: <1FE6DD409037234FAB833C420AA843ECE9DF60@orsmsx424.amr.corp.intel.com> <20080328124517.GQ16721@parisc-linux.org> <1FE6DD409037234FAB833C420AA843ECF237C0@orsmsx424.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1FE6DD409037234FAB833C420AA843ECF237C0-7XlYjKTK0pM64kNsxIetb7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Nick Piggin <nickpiggin-/E1597aS9LT0CCvOHzKKcA@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Friday 28 March 2008, Luck, Tony wrote:
> > So it makes little sense to add this to semaphores. =A0Better to in=
troduce
> > a spinaphore, as you say.
>=20
> > struct {
> > =A0 atomic_t cur;
> > =A0 int max;
> > } ss_t;
>=20
> Could this API sneak into the bottom of one or the other of
> linux/include/{spinlock,semaphore}.h ... or should it get its own
> spinaphore.h file?
>
> Or should I follow Alan's earlier advice and keep this as an ia64
> only thing (since I'll be the only user).

If you use the simple version suggested last by Willy, I think it
could even be open-coded in your TLB management code.

Should we decided to make it an official interface, I'd suggest
putting it into atomic.h, because it operates on a plain atomic_t.

	Arnd <><
