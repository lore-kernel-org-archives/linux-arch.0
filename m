From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Mon, 09 Jun 2008 22:15:58 +0200
Message-ID: <484D8F7E.4070104@cosmosbay.com>
References: <20080530035620.587204923@sgi.com>	<20080529215827.b659d032.akpm@linux-foundation.org>	<4846AFCF.30500@sgi.com> <4848CC22.6090109@cosmosbay.com>	<Pine.LNX.4.64.0806091136410.30727@schroedinger.engr.sgi.com> <87abhuqv7p.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp20.orange.fr ([80.12.242.26]:34494 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981AbYFIUQa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jun 2008 16:16:30 -0400
In-Reply-To: <87abhuqv7p.fsf@basil.nowhere.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Christoph Lameter <clameter@sgi.com>, Mike Travis <travis@sgi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>

Andi Kleen a =E9crit :
> Christoph Lameter <clameter@sgi.com> writes:
>=20
>> The problem is that offsets relative to %gs or %fs are limited by th=
e=20
>> small memory model that is chosen.
>=20
> Actually they are not. If you really want you can do=20
> movabs $64bit,%reg ; op ...,%gs:(%reg)=20
> It's just not very efficient compared to small (or rather kernel) mod=
el
> and also older binutils didn't support large model.
>=20

I am not sure Christoph was refering to actual instructions.

I was suggesting using for static percpu (vmlinux or modules) :

vmlinux : (offset31 computed by linker at vmlinux link edit time)
incl  %gs:offset31

modules : (offset31 computed at module load time by module loader)
incl %gs:offset31

(If we make sure all this stuff is allocated in first chunk)

And for dynamic percpu :

movq   field(%rdi),%rax
incl    %gs:(%rax)   /* full 64bits 'offsets' */

I understood (but might be wrong again) that %gs itself could not be us=
ed with an offset > 2GB, because
the way %gs segment is setup. So in the 'dynamic percpu' case, %rax sho=
uld not exceed 2^31
