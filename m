From: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] memcg: remove unneeded preempt_disable
Date: Thu, 25 Aug 2011 14:19:26 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.1108251413130.27407@router.home>
References: <1313650253-21794-1-git-send-email-gthelen@google.com>  <20110818144025.8e122a67.akpm@linux-foundation.org>  <1314284272.27911.32.camel@twins>  <alpine.DEB.2.00.1108251009120.27407@router.home>  <1314289208.3268.4.camel@mulgrave>
 <alpine.DEB.2.00.1108251128460.27407@router.home>  <986ca4ed-6810-426f-b32f-5c8687e3a10b@email.android.com>  <alpine.DEB.2.00.1108251206440.27407@router.home>  <1e295500-5d1f-45dd-aa5b-3d2da2cf1a62@email.android.com>  <alpine.DEB.2.00.1108251341230.27407@router.home>
 <1314299115.26922.2.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp105.prem.mail.ac4.yahoo.com ([76.13.13.44]:31663 "HELO
	smtp105.prem.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752070Ab1HYTTb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 25 Aug 2011 15:19:31 -0400
In-Reply-To: <1314299115.26922.2.camel@twins>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: James Bottomley <James.bottomley@HansenPartnership.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Balbir Singh <bsingharora@gmail.com>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, linux-arch@vger.kernel.org

On Thu, 25 Aug 2011, Peter Zijlstra wrote:

> Also, I thought this_cpu thing's were at best locally atomic. If you
> make them full blown atomic ops then even __this_cpu ops will have to be
> full atomic ops, otherwise:
>
>
> CPU0			CPU(1)
>
> this_cpu_inc(&foo);	preempt_disable();
> 			__this_cpu_inc(&foo);
> 			preempt_enable();
>
> might step on each other's toes.

They would both have their own instance of "foo". per cpu atomicity is
only one requirement of this_cpu_ops. The other is the ability to relocate
accesses relative to the current per cpu area.

Full blown atomicity is almost a superset of per cpu atomicity but its
only usable if the full atomic instructions can also relocate accesses
relative to some base.
