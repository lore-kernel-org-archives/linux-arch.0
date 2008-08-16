From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: drivers/usb/musb/musb_io.h
Date: Fri, 15 Aug 2008 18:53:07 -0700
Message-ID: <200808151853.08302.david-b@pacbell.net>
References: <20080814215200.27f79a59.akpm@linux-foundation.org> <200808151446.45855.david-b@pacbell.net> <20080815222238.GC25069@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080815222238.GC25069@frodo>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org
Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Friday 15 August 2008, Felipe Balbi wrote:
> Hmm... but how about the other version?
>=20
> +#ifndef readsl
> =A0static inline void readsl(const void __iomem *addr, void *buf, int=
 len)
> =A0 =A0 =A0 =A0 { insl((unsigned long)addr, buf, len); }
> +#endif
> +#ifndef readsw
> =A0static inline void readsw(const void __iomem *addr, void *buf, int=
 len)
> =A0 =A0 =A0 =A0 { insw((unsigned long)addr, buf, len); }
> +#endif

Any arch defining an inline readsl() etc will break.  And
inlines are the preferred style lately.  :)

Someone commented that this is what caused creation of
the mmio_insl() family of routines ...

=2E.. but I notice that at least on ARM (current primary home
for this driver!) those calls don't end up using optimized
code. Since those optimimzed loops are a *big* win in terms
of performance -- using LDM/STM to burst memory acccess to/from
registers -- I'd rather not go that way for now.

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
