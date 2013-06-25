From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [Suggestion] arch: s390: mm: the warnings with allmodconfig and
 "EXTRA_CFLAGS=-W"
Date: Tue, 25 Jun 2013 15:25:50 +0800
Message-ID: <51C945FE.2030305@asianux.com>
References: <51C8F685.6000209@asianux.com> <51C8F861.9010101@asianux.com> <20130625085006.01a7f368@mschwide>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:62780 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab3FYH0m (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2013 03:26:42 -0400
In-Reply-To: <20130625085006.01a7f368@mschwide>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, cornelia.huck@de.ibm.com, mtosatti@redhat.com, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org

On 06/25/2013 02:50 PM, Martin Schwidefsky wrote:
> On Tue, 25 Jun 2013 09:54:41 +0800
> Chen Gang <gang.chen@asianux.com> wrote:
>=20
>> > Hello Maintainers:
>> >=20
>> > When allmodconfig for " IBM zSeries model z800 and z900"
>> >=20
>> > It will report the related warnings ("EXTRA_CFLAGS=3D-W"):
>> >   mm/slub.c:1875:1: warning: =E2=80=98deactivate_slab=E2=80=99 use=
s dynamic stack allocation [enabled by default]
>> >   mm/slub.c:1941:1: warning: =E2=80=98unfreeze_partials.isra.32=E2=
=80=99 uses dynamic stack allocation [enabled by default]
>> >   mm/slub.c:2575:1: warning: =E2=80=98__slab_free=E2=80=99 uses dy=
namic stack allocation [enabled by default]
>> >   mm/slub.c:1582:1: warning: =E2=80=98get_partial_node.isra.34=E2=80=
=99 uses dynamic stack allocation [enabled by default]
>> >   mm/slub.c:2311:1: warning: =E2=80=98__slab_alloc.constprop.42=E2=
=80=99 uses dynamic stack allocation [enabled by default]
>> >=20
>> > Is it OK ?
> Yes, these warnings should be ok. They are enabled by CONFIG_WARN_DYN=
AMIC_STACK,
> the purpose is to find all functions with dynamic stack allocations. =
The check
> if the allocations are truly ok needs to be done manually as the comp=
iler
> can not find out the maximum allocation size automatically.

Thank you very much for your details information.

--=20
Chen Gang

Asianux Corporation
