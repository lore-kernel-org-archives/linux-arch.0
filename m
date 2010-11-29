From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2 0/4] kthread: NUMA aware kthread_create_on_cpu()
Date: Tue, 30 Nov 2010 10:01:55 +1030
Message-ID: <201011301001.55968.rusty@rustcorp.com.au>
References: <20101129090510.GA15763@basil.fritz.box> <20101129.093942.104054089.davem@davemloft.net> <1291053583.3435.1269.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:50563 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687Ab0K2Xb5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Nov 2010 18:31:57 -0500
In-Reply-To: <1291053583.3435.1269.camel@edumazet-laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, andi@firstfloor.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org, tony.luck@intel.com, fenghua.yu@intel.com

On Tue, 30 Nov 2010 04:29:43 am Eric Dumazet wrote:
> Le lundi 29 novembre 2010 =C3=A0 09:39 -0800, David Miller a =C3=A9cr=
it :
> > From: Eric Dumazet <eric.dumazet@gmail.com>
> > Date: Mon, 29 Nov 2010 16:13:23 +0100
> >=20
> > > Note : compiled and tested on x86_32 and x86_64 only, but these p=
atches
> > > take care of other arches as well.
> > >=20
> > > Cc: linux-arch@vger.kernel.org=20
> > >=20
> > > Thanks for your feedback Andi !
> >=20
> > I'm fine with these changes:
> >=20
> > Acked-by: David S. Miller <davem@davemloft.net>
> >=20
> > Since the majority is non-networking it is pretty clear
> > that someone other than me should integrate these patches.
> > :-)
>=20
> Sure !
>=20
> I was thinking Andrew was the guy to carry this patch series, once
> things settle down of course...

I'm happy with that.

Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Cheers,
Rusty.
