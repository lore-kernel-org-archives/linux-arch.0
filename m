From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: Arch specific mmap attributes (Was: mprotect pgprot handling weirdness)
Date: Tue,  6 Apr 2010 15:24:55 +0900 (JST)
Message-ID: <20100406151751.7E4E.A69D9226@jp.fujitsu.com>
References: <20100406143928.7E4B.A69D9226@jp.fujitsu.com> <1270534061.13812.56.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1270534061.13812.56.camel@pasglop>
Sender: owner-linux-mm@kvack.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kosaki.motohiro@jp.fujitsu.com, linux-mm@kvack.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

> On Tue, 2010-04-06 at 14:52 +0900, KOSAKI Motohiro wrote:
>=20
> (Adding linux-arch)
>=20
> > This check was introduced the following commit. yes now we don't
> > consider arch specific PROT_xx flags. but I don't think it is odd.
> >=20
> > Yeah, I can imagine at least embedded people certenary need arch
> > specific PROT_xx flags and they hope to change it. but I don't=20
> > think mprotect() fit for your usage. I mean mprotect() is widely=20
> > used glibc internally. then, If mprotec can change which flags,=20
> > glibc might turn off such flags implictly.
> >=20
> > So, Why can't we proper new syscall? It has no regression risk.=20
>=20
> I don't care much personally whether we use mprotect() or a new syscall=
,
> but at this stage we already have PROT_SAO going that way for powerpc s=
o
> that would be an ABI change.
>=20
> However, the main issue isn't really there. The main issue is that righ=
t
> now, everything we do in mmap.c, mprotect.c, ... revolves around having
> everything translated into the single vm_flags field. VMA merging
> decisions, construction of vm_page_prot, etc... everything is there.
>=20
> However, this is a 32-bit field on 32-bit archs, and we already use all
> possible bits in there. It's also a field entirely defined in generic
> code with no provision for arch specific bits.
>=20
> The question here thus boils down to what direction do we want to go to
> if we want to untangle that and provide the ability to expose mapping
> "attributes" basically. In fact, I suspect even x86 might have good use
> of that to create things like relaxed ordering mappings no ?
>=20
> This boils down, so far to a few facts/questions to be resolved:
>=20
>  - Do we want to use the existing PROT_ argument to mmap, mprotect,... =
?
> There's plenty of bit space, and we already have at least one example o=
f
> an arch adding something to it (powerpc with PROT_SAO - aka Strong
> Access Ordering - aka Make It Look Like An x86 :-)
>=20
>  - If not, while a separate syscall would be fine with me for setting
> attributes after the fact, it makes it harder to pass them via mmap, is
> that a big deal ? IE. Ie it means one -always- has to call it after mma=
p
> to change the attributes. That means for example that mmap will
> potentially create a VMA merged with another one, just to be re-split
> due to the attribute change. A bit gross...
>=20
>  - Do we want to keep the current "Funnel everything into vm_flags"
> approach ? That leaves no option that I can see but to extend it into a
> u64 so it grows on 32-bit archs.=20
>=20
>  - If not, I see two approaches here: Either having a separate / new
> "attribute" field in the VMA or going straight for the vm_page_prot (ie=
.
> the pgprot). In both cases, things like vma_merge() need to grow a new
> argument since obviously we can't merge things with different
> attributes.
>=20
>  - ... Unless we just replace VM_SAO with VM_CANT_MERGE and set that
> whenever a VMA has a non-0 attributes. Sad but simpler
>=20
> Any other / better idea ?

I guess you haven't catch my intention. I didn't say we have to remove=20
PROT_SAO and VM_SAO.
I mean mmap(PROT_SAO) is ok, it's only append new flag, not change exitin=
g
flags meanings. I'm only against mprotect(PROT_NONE) turn off PROT_SAO
implicitely.

IOW I recommend we use three syscall
	mmap()		create new mappings
	mprotect()	change a protection of mapping (as a name)
	mattribute(): (or similar name)
			change an attribute of mapping (e.g. PROT_SAO or
			another arch specific flags)

I'm not against changing mm/protect.c for PROT_SAO.



--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
