From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] memcg: remove unneeded preempt_disable
Date: Thu, 25 Aug 2011 20:49:32 +0200
Message-ID: <1314298173.27911.86.camel@twins>
References: <1313650253-21794-1-git-send-email-gthelen@google.com>
	 <20110818144025.8e122a67.akpm@linux-foundation.org>
	 <1314284272.27911.32.camel@twins>
	 <alpine.DEB.2.00.1108251009120.27407@router.home>
	 <1314289208.3268.4.camel@mulgrave>
	 <alpine.DEB.2.00.1108251128460.27407@router.home>
	 <986ca4ed-6810-426f-b32f-5c8687e3a10b@email.android.com>
	 <alpine.DEB.2.00.1108251206440.27407@router.home>
	 <1e295500-5d1f-45dd-aa5b-3d2da2cf1a62@email.android.com>
	 <alpine.DEB.2.00.1108251341230.27407@router.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <alpine.DEB.2.00.1108251341230.27407@router.home>
Sender: owner-linux-mm@kvack.org
To: Christoph Lameter <cl@linux.com>
Cc: James Bottomley <James.bottomley@HansenPartnership.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Balbir Singh <bsingharora@gmail.com>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 2011-08-25 at 13:46 -0500, Christoph Lameter wrote:
>=20
> RISC cpus have instruction to construct complex atomic actions by the cpu
> as I have shown before for ARM.=20

Right, but it only makes sense if the whole thing remains cheaper than
the trivial implementation already available.

For instance, the ARM LL/SC constraints pretty much mandate we do
preempt_disable()/preempt_enable() around them, at which point the point
of doing LL/SC is gone (except maybe for the irqsafe_this_cpu_* stuff).

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
