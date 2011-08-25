From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] memcg: remove unneeded preempt_disable
Date: Fri, 26 Aug 2011 01:01:37 +0200
Message-ID: <1314313297.26922.17.camel@twins>
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
	 <1314300546.3268.8.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1314300546.3268.8.camel@mulgrave>
Sender: owner-linux-mm@kvack.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Balbir Singh <bsingharora@gmail.com>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 2011-08-25 at 12:29 -0700, James Bottomley wrote:
>=20
> Therefore from the risc point of view, most of the this_cpu_xxx
> operations are things that we don't really care about except that the
> result would be easier to read in C.=20

Right, so the current fallback case is pretty much the optimal case for
the RISC machines, which ends up with generic code being better off not
using it much and instead preferring __this_cpu if there's more than
one.

I mean, its absolutely awesome these things are 1 instruction on x86,
but if we pessimize all other 20-odd architectures its just not cool.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
