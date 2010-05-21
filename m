From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH 2/2]: atomic_t: Remove volatile from atomic_t definition
Date: Fri, 21 May 2010 08:44:52 +0200
Message-ID: <1274424292.2439.6.camel@edumazet-laptop>
References: <20100521052746.GL2516@laptop>
	 <20100520.225454.37197037.davem@davemloft.net>
	 <20100521060600.GM2516@laptop>
	 <20100520.231037.200798708.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:37038 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985Ab0EUGo5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 21 May 2010 02:44:57 -0400
In-Reply-To: <20100520.231037.200798708.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: npiggin@suse.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, anton@samba.org, akpm@linux-foundation.org, willy@linux.intel.com, benh@kernel.crashing.org, paulus@samba.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Le jeudi 20 mai 2010 =C3=A0 23:10 -0700, David Miller a =C3=A9crit :
> From: Nick Piggin <npiggin@suse.de>
> Date: Fri, 21 May 2010 16:06:00 +1000
>=20
> > Actually, I bet we have a lot of bugs there with loading integers a=
nd
> > pointers atomically, where the code assumes the loaded value will n=
ot
> > be reloaded by the compiler, because it is an easy thing to assume.
>=20
> Alexey Kuznetsov was aware of this problem 8+ years ago when we were
> first adding fine-grained locking the the networking.
>=20
> > atomic_read_light could be useful though, for sure.
>=20
> I definitely think so. And every usage of it should have a big fat
> comment right next to it explaining how it's usage is valid in that
> spot :-)
> -

I really doubt a valid (and dully commented) usage of
atomic_read_light() will bring anything, but added complexity to API.

Generated code will be the same than atomic_read() in these cases,
unless some real factorization can be done inside a loop.

We still have some uneeded RMW atomic ops to remove, before even
thinking to optimise reads ;)
