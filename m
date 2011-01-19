From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: + kthread-numa-aware-kthread_create_on_cpu.patch added to -mm
 tree
Date: Wed, 19 Jan 2011 21:15:19 +0100
Message-ID: <1295468119.2653.2.camel@edumazet-laptop>
References: <201012100044.oBA0ivp3016990@imap1.linux-foundation.org>
	 <1293131522.2170.798.camel@laptop>
	 <20110119120756.cd554fb1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35691 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab1ASUPZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jan 2011 15:15:25 -0500
Received: by fxm20 with SMTP id 20so1279967fxm.19
        for <linux-arch@vger.kernel.org>; Wed, 19 Jan 2011 12:15:23 -0800 (PST)
In-Reply-To: <20110119120756.cd554fb1.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, ak@linux.intel.com, davem@davemloft.net, dhowells@redhat.com, fenghua.yu@intel.com, linux-arch@vger.kernel.org, rusty@rustcorp.com.au, tj@kernel.org, tony.luck@intel.com

Le mercredi 19 janvier 2011 =C3=A0 12:07 -0800, Andrew Morton a =C3=A9c=
rit :
> On Thu, 23 Dec 2010 20:12:02 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> > On Thu, 2010-12-09 at 16:44 -0800, akpm@linux-foundation.org wrote:
> > > +struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *=
data),
> > > +                                         void *data,
> > > +                                         int cpu,
> > > +                                         const char namefmt[],
> > > +                                         ...)
> >=20
> > I thought it was agreed that name sucked too much to live?
>=20
> I agreed ;)
>=20
> > All other *_on_cpu() interfaces actually do stuff on that cpu, but =
this
> > does not in fact create a cpu affine task.
>=20
> The patches are stuck in my tree awaiting some movement here..

Oh well.

I wont discuss about a function _name_ Andrew.

If nobody can chose one better than the one I chosed, what can I do ?
