From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [Suggestion] arch: s390: mm: the warnings with allmodconfig and
 "EXTRA_CFLAGS=-W"
Date: Tue, 25 Jun 2013 08:50:06 +0200
Message-ID: <20130625085006.01a7f368@mschwide>
References: <51C8F685.6000209@asianux.com>
	<51C8F861.9010101@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <51C8F861.9010101@asianux.com>
Sender: owner-linux-mm@kvack.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, cornelia.huck@de.ibm.com, mtosatti@redhat.com, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Tue, 25 Jun 2013 09:54:41 +0800
Chen Gang <gang.chen@asianux.com> wrote:

> Hello Maintainers:
>=20
> When allmodconfig for " IBM zSeries model z800 and z900"
>=20
> It will report the related warnings ("EXTRA_CFLAGS=3D-W"):
>   mm/slub.c:1875:1: warning: =E2=80=98deactivate_slab=E2=80=99 uses dynam=
ic stack allocation [enabled by default]
>   mm/slub.c:1941:1: warning: =E2=80=98unfreeze_partials.isra.32=E2=80=99 =
uses dynamic stack allocation [enabled by default]
>   mm/slub.c:2575:1: warning: =E2=80=98__slab_free=E2=80=99 uses dynamic s=
tack allocation [enabled by default]
>   mm/slub.c:1582:1: warning: =E2=80=98get_partial_node.isra.34=E2=80=99 u=
ses dynamic stack allocation [enabled by default]
>   mm/slub.c:2311:1: warning: =E2=80=98__slab_alloc.constprop.42=E2=80=99 =
uses dynamic stack allocation [enabled by default]
>=20
> Is it OK ?

Yes, these warnings should be ok. They are enabled by CONFIG_WARN_DYNAMIC_S=
TACK,
the purpose is to find all functions with dynamic stack allocations. The ch=
eck
if the allocations are truly ok needs to be done manually as the compiler
can not find out the maximum allocation size automatically.

--=20
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
