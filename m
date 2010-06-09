From: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH 03/28] rename anon_vma_lock to vma_lock_anon_vma
Date: Wed, 9 Jun 2010 11:59:18 +0100
Message-ID: <20100609105917.GD5650@csn.ul.ie>
References: <20100607110654.606530953@chello.nl> <20100607111406.662536918@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gir.skynet.ie ([193.1.99.77]:45164 "EHLO gir.skynet.ie"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463Ab0FIK7g (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 9 Jun 2010 06:59:36 -0400
Content-Disposition: inline
In-Reply-To: <20100607111406.662536918@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Nick Piggin <npiggin@suse.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

On Mon, Jun 07, 2010 at 01:06:57PM +0200, Peter Zijlstra wrote:
> From: Rik van Riel <riel@redhat.com>
>=20
> Rename anon_vma_lock to vma_lock_anon_vma.  This matches the
> naming style used in page_lock_anon_vma and will come in really
> handy further down in this patch series.
>=20
> Signed-off-by: Rik van Riel <riel@redhat.com>
> Acked-by: Mel Gorman <mel@csn.ul.ie>
> Acked-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> LKML-Reference: <20100526153853.55b72183@annuminas.surriel.com>

One rename was missed I think. With this patch applied, I get

mm/mmap.c: In function =E2=80=98expand_downwards=E2=80=99:
mm/mmap.c:1786: error: implicit declaration of function =E2=80=98anon_v=
ma_unlock=E2=80=99
make[1]: *** [mm/mmap.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [mm] Error 2


--=20
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
