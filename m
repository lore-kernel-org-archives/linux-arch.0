From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
Date: Wed, 28 Nov 2018 11:19:15 -0800
Message-ID: <CAHk-=whcbiSxSUprsKjVPEdN5-+o8WnTGiKxEV-+HbKNDs=iNA@mail.gmail.com>
References: <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
	<20181122170715.GI30658@n2100.armlinux.org.uk>
	<CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
	<11829e3c-7302-f821-cf5c-863e5267a17b@arm.com>
	<CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com>
	<20181123065511.GA17856@lst.de> <20181128074117.GA21126@lst.de>
	<CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com>
	<20181128174545.GJ30658@n2100.armlinux.org.uk>
	<CAHk-=whnz4Kty6cas11bc2Gh=9zTzeeRS2k=dV9Hfc4B=xnHkQ@mail.gmail.com>
	<20181128180841.GM30658@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7217814610407056271=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181128180841.GM30658-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, the arch/x86 maintainers <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux List Kernel Mailing <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

--===============7217814610407056271==
Content-Type: multipart/alternative; boundary="000000000000de3c2d057bbe713a"

--000000000000de3c2d057bbe713a
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 28, 2018, 10:08 Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
wrote:

> >
> > You already cannot do that kmalloc(), exactly because of ERR_PTR().
>
> I'm very sorry, but I think you are confused.
>
> kmalloc() returns a _virtual_ address, which quite rightly must not be
> in the top 4K of 4GB, exactly due to ERR_PTR().  That is fine.
>
> However, that is a completely different kettle of fish from a physical
> or DMA address - neither of which are virtual addresses.
>

You cut away the part that showed that I'm not in the least confused.

Let me just paste it back in here:

  "Which is what we ALREADY do for these exact reasons. If the DMA
mappings means that you'd need to add one more page to that list of
reserved pages, then so be it."

So no, I'm not at all confused.

Let me re-iterate: the argument that all addresses have to be dma'able is
garbage.

*Exactly* as with kmalloc and limited virtual addresses, we can limit
physical addresses.

      Linus

--000000000000de3c2d057bbe713a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">=
On Wed, Nov 28, 2018, 10:08 Russell King - ARM Linux &lt;<a href=3D"mailto:=
linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org">linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org</a> wrote:</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
&gt; <br>
&gt; You already cannot do that kmalloc(), exactly because of ERR_PTR().<br=
>
<br>
I&#39;m very sorry, but I think you are confused.<br>
<br>
kmalloc() returns a _virtual_ address, which quite rightly must not be<br>
in the top 4K of 4GB, exactly due to ERR_PTR().=C2=A0 That is fine.<br>
<br>
However, that is a completely different kettle of fish from a physical<br>
or DMA address - neither of which are virtual addresses.<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">You cut away the pa=
rt that showed that I&#39;m not in the least confused.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Let me just paste it back in here:</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">=C2=A0 &quot;Which is what we ALR=
EADY do for these exact reasons. If the DMA</div>mappings means that you&#3=
9;d need to add one more page to that list of<br style=3D"">reserved pages,=
 then so be it.&quot;<div dir=3D"auto"><br></div><div dir=3D"auto">So no, I=
&#39;m not at all confused.=C2=A0</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Let me re-iterate: the argument that all addresses have to be dma=
&#39;able is garbage.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">*Exactly* as with kmalloc and limited virtual addresses, we can limit p=
hysical addresses.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=C2=
=A0 =C2=A0 =C2=A0 Linus</div></div>

--000000000000de3c2d057bbe713a--

--===============7217814610407056271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7217814610407056271==--
