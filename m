From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2.5/13] memblock: Use __meminit[data] instead of
 __init[data]
Date: Fri, 15 Jul 2011 07:45:12 +0200
Message-ID: <20110715054512.GK3455@htj.dyndns.org>
References: <1310462166-31469-1-git-send-email-tj@kernel.org>
 <20110714094203.GE3455@htj.dyndns.org>
 <CAE9FiQU92k-GAy3DVB4HYpn6D6_u=4T7t9_8FOGh8BLDEAKD=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE9FiQU92k-GAy3DVB4HYpn6D6_u=4T7t9_8FOGh8BLDEAKD=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, benh@kernel.crashing.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

Hello,

On Thu, Jul 14, 2011 at 02:00:51PM -0700, Yinghai Lu wrote:
> > =A0#ifdef ARCH_DISCARD_MEMBLOCK
> > -#define __init_memblock __init
> > -#define __initdata_memblock __initdata
> > +#define __init_memblock __meminit
> > +#define __initdata_memblock __meminitdata
> > =A0#else
> > =A0#define __init_memblock
> > =A0#define __initdata_memblock
>=20
> that is not good. It will keep memblock.reserved related data and
> functions after boot.
> and those data/func are not used after slab is ready.

Yeah, if MEMORY_HOTPLUG is enabled.  It isn't too big area to begin
with and early_node_map[] and related code removal should offset it.
The problem is that refining different __init tags here is a bit
complex thanks to DISCARD_MEMBLOCK.  We end up having to deal with the
combination of DISCARD_MEMBLOCK and MEMORY_HOTPLUG.  I was hoping that
once we get memblock usage more consistent across different archs, we
could do away with DISCARD_MEMBLOCK.

Thank you.

--=20
tejun
