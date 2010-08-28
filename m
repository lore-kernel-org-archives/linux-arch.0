From: Piotr Hosowicz <piotr@hosowicz.com>
Subject: Re: [PATCH 00/20] mm: Preemptibility -v4
Date: Sat, 28 Aug 2010 16:56:52 +0200
Message-ID: <4C7923B4.6030208@example.com>
References: <20100828141637.421594670@chello.nl>
Reply-To: piotr@hosowicz.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 63.mail-out.ovh.net ([91.121.185.56]:56355 "HELO
	63.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752057Ab0H1O63 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 28 Aug 2010 10:58:29 -0400
In-Reply-To: <20100828141637.421594670@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>

On 28.08.2010 16:16, Peter Zijlstra wrote:

> Full series (including the Sparc64 gup_fast bits) also available in -=
git
> form from (against Linus' tree as of about an hour ago):

How come? I tried this:

aapi205:/usr/src/linus/tmp# git pull
Already up-to-date.

=2E.. and don't see an update. Maybe I don't do something right. If the=
re=20
is newer code I should receive it, am I correct? I use this link:

git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

--=20
Janusz Korwin-Mikke:
"Generalnie rzecz bior=B1c, ja jestem w jednej dziedzinie za
r=F3wnouprawnieniem, a mianowicie: =BFeby w ma=B3=BFe=F1stwie by=B3o
50% m=EA=BFczyzn i 50% kobiet."
NP: Peter Green Splinter Group - Turn Your Love Away
NB: 2.6.36-rc2-next-20100827
