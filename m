From: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] memcg: remove unneeded preempt_disable
Date: Thu, 25 Aug 2011 13:46:27 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.1108251341230.27407@router.home>
References: <1313650253-21794-1-git-send-email-gthelen@google.com> <20110818144025.8e122a67.akpm@linux-foundation.org> <1314284272.27911.32.camel@twins> <alpine.DEB.2.00.1108251009120.27407@router.home> <1314289208.3268.4.camel@mulgrave>
 <alpine.DEB.2.00.1108251128460.27407@router.home> <986ca4ed-6810-426f-b32f-5c8687e3a10b@email.android.com> <alpine.DEB.2.00.1108251206440.27407@router.home> <1e295500-5d1f-45dd-aa5b-3d2da2cf1a62@email.android.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp103.prem.mail.ac4.yahoo.com ([76.13.13.42]:30262 "HELO
	smtp103.prem.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753617Ab1HYSqb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 25 Aug 2011 14:46:31 -0400
In-Reply-To: <1e295500-5d1f-45dd-aa5b-3d2da2cf1a62@email.android.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.bottomley@HansenPartnership.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Balbir Singh <bsingharora@gmail.com>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, linux-arch@vger.kernel.org

On Thu, 25 Aug 2011, James Bottomley wrote:

> >Well then what is "really risc"? RISC is an old beaten down marketing
> >term
> >AFAICT and ARM claims it too.
>
> Reduced Instruction Set Computer.  This is why we're unlikely to have
> complex atomic instructions: the principle of risc is that you build
> them up from basic ones.

RISC cpus have instruction to construct complex atomic actions by the cpu
as I have shown before for ARM.

Principles always have exceptions to them.

(That statement in itself is a principle that should have an exception I
guess. But then language often only makes sense when it contains
contradictions.)
