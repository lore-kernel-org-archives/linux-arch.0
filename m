From: John Dorminy <jdorminy@redhat.com>
Subject: Re: [PATCH 21/29] mm: remove the pgprot argument to __vmalloc
Date: Thu, 30 Apr 2020 22:33:28 -0400
Message-ID: <CAMeeMh8Q3Od76WaTasw+BpYVF58P-HQMaiFKHxXbZ_Q3tQPZ=A@mail.gmail.com>
References: <20200414131348.444715-1-hch@lst.de>
 <20200414131348.444715-22-hch@lst.de>
 <20200414151344.zgt2pnq7cjq2bgv6@debian>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0000000000004b5c5705a48d02f1"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
In-Reply-To: <20200414151344.zgt2pnq7cjq2bgv6@debian>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
To: Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Michael Kelley <mikelley@microsoft.com>, linux-mm@kvack.org, "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org, Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>, Gao Xiang <xiang@kernel.org>, Laura Abbott <labbott@redhat.com>, Nitin Gupta <ngupta@vflare.org>, Daniel Vetter <daniel@ffwll.ch>, Haiyang Zhang <haiyangz@microsoft.com>, linaro-mm-sig@lists.linaro.org, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Minchan Kim <minchan@kernel.org>, iommu@lists.linux-foundation.org, Sakari Ailus <sakari.ailus@linux.i>
List-Id: linux-arch.vger.kernel.org

--0000000000004b5c5705a48d02f1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greetings;

I recently noticed this change via the linux-next tree.

It may not be possible to edit at this late date, but the change
description refers to PROT_KERNEL, which is a symbol which does not appear
to exist; perhaps PAGE_KERNEL was meant? The mismatch caused me and a
couple other folks some confusion briefly until we decided it was supposed
to be PAGE_KERNEL; if it's not too late, editing the description to clarify
so would be nice.

Many thanks.

John Dorminy



On Tue, Apr 14, 2020 at 11:15 AM Wei Liu <wei.liu@kernel.org> wrote:

> On Tue, Apr 14, 2020 at 03:13:40PM +0200, Christoph Hellwig wrote:
> > The pgprot argument to __vmalloc is always PROT_KERNEL now, so remove
> > it.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com> [hyperv]
> > Acked-by: Gao Xiang <xiang@kernel.org> [erofs]
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/hyperv/hv_init.c              |  3 +--
> [...]
> >
> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > index 5a4b363ba67b..a3d689dfc745 100644
> > --- a/arch/x86/hyperv/hv_init.c
> > +++ b/arch/x86/hyperv/hv_init.c
> > @@ -95,8 +95,7 @@ static int hv_cpu_init(unsigned int cpu)
> >        * not be stopped in the case of CPU offlining and the VM will
> hang.
> >        */
> >       if (!*hvp) {
> > -             *hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO,
> > -                              PAGE_KERNEL);
> > +             *hvp =3D __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
> >       }
>
> Acked-by: Wei Liu <wei.liu@kernel.org>
>
>

--0000000000004b5c5705a48d02f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Greetings;<br><br></div><div>I recently noticed this =
change via the linux-next tree.</div><div><br></div><div>It may not be poss=
ible to edit at this late date, but the change description refers to PROT_K=
ERNEL, which is a symbol which does not appear to exist; perhaps PAGE_KERNE=
L was meant? The mismatch caused me and a couple other folks some confusion=
 briefly until we decided it was supposed to be PAGE_KERNEL; if it&#39;s no=
t too late, editing the description to clarify so would be nice.<br><br></d=
iv><div>Many thanks.<br><br></div><div>John Dorminy<br></div><div><br><br><=
/div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Tue, Apr 14, 2020 at 11:15 AM Wei Liu &lt;<a href=3D"mailto:wei.liu=
@kernel.org">wei.liu@kernel.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Tue, Apr 14, 2020 at 03:13:40PM +0200, =
Christoph Hellwig wrote:<br>
&gt; The pgprot argument to __vmalloc is always PROT_KERNEL now, so remove<=
br>
&gt; it.<br>
&gt; <br>
&gt; Signed-off-by: Christoph Hellwig &lt;<a href=3D"mailto:hch@lst.de" tar=
get=3D"_blank">hch@lst.de</a>&gt;<br>
&gt; Reviewed-by: Michael Kelley &lt;<a href=3D"mailto:mikelley@microsoft.c=
om" target=3D"_blank">mikelley@microsoft.com</a>&gt; [hyperv]<br>
&gt; Acked-by: Gao Xiang &lt;<a href=3D"mailto:xiang@kernel.org" target=3D"=
_blank">xiang@kernel.org</a>&gt; [erofs]<br>
&gt; Acked-by: Peter Zijlstra (Intel) &lt;<a href=3D"mailto:peterz@infradea=
d.org" target=3D"_blank">peterz@infradead.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 arch/x86/hyperv/hv_init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 3 +--<br>
[...]<br>
&gt; <br>
&gt; diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c<br>
&gt; index 5a4b363ba67b..a3d689dfc745 100644<br>
&gt; --- a/arch/x86/hyperv/hv_init.c<br>
&gt; +++ b/arch/x86/hyperv/hv_init.c<br>
&gt; @@ -95,8 +95,7 @@ static int hv_cpu_init(unsigned int cpu)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * not be stopped in the case of CPU offlini=
ng and the VM will hang.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!*hvp) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*hvp =3D __vmalloc(PA=
GE_SIZE, GFP_KERNEL | __GFP_ZERO,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PAGE_KERNEL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*hvp =3D __vmalloc(PA=
GE_SIZE, GFP_KERNEL | __GFP_ZERO);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
Acked-by: Wei Liu &lt;<a href=3D"mailto:wei.liu@kernel.org" target=3D"_blan=
k">wei.liu@kernel.org</a>&gt;<br>
<br>
</blockquote></div>

--0000000000004b5c5705a48d02f1--
