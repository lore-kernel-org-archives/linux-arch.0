From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: + kthread-numa-aware-kthread_create_on_cpu.patch added to -mm
 tree
Date: Wed, 19 Jan 2011 21:50:47 +0100
Message-ID: <1295470247.2653.9.camel@edumazet-laptop>
References: <201012100044.oBA0ivp3016990@imap1.linux-foundation.org>
	 <1293131522.2170.798.camel@laptop>
	 <20110119120756.cd554fb1.akpm@linux-foundation.org>
	 <1295468119.2653.2.camel@edumazet-laptop>
	 <20110119201716.GH22288@tassilo.jf.intel.com>
	 <1295468515.2653.4.camel@edumazet-laptop>
	 <20110119124411.864d9d97.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60255 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab1ASUux (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jan 2011 15:50:53 -0500
Received: by fxm20 with SMTP id 20so1315779fxm.19
        for <linux-arch@vger.kernel.org>; Wed, 19 Jan 2011 12:50:52 -0800 (PST)
In-Reply-To: <20110119124411.864d9d97.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, davem@davemloft.net, dhowells@redhat.com, fenghua.yu@intel.com, linux-arch@vger.kernel.org, rusty@rustcorp.com.au, tj@kernel.org, tony.luck@intel.com

Le mercredi 19 janvier 2011 =C3=A0 12:44 -0800, Andrew Morton a =C3=A9c=
rit :
> On Wed, 19 Jan 2011 21:21:55 +0100
> Eric Dumazet <eric.dumazet@gmail.com> wrote:
>=20
> > Le mercredi 19 janvier 2011 __ 12:17 -0800, Andi Kleen a __crit :
> > > >=20
> > > > I wont discuss about a function _name_ Andrew.
> > > >=20
> > > > If nobody can chose one better than the one I chosed, what can =
I do ?
> > >=20
> > > kthread_create_node() would seem logical (with a node parameter)
> > >=20
> > > -Andi
> >=20
> > I already explained why I dont like this suggestion.
> >=20
> > 1) My plan was to later add cpu affinity.
>=20
> That would be called kthread_create_on_cpu() except whoops, this patc=
h
> already took that.
>=20

I surrender :)

I'll send a patch, or do you prefer I respin the 4 patches ?

> > 2) All users I converted want to create one kthread per cpu, not pe=
r
> > node.
>=20
> kswapd is a potential user.  It would want one kthread per node.
