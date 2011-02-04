Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:38791 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab1BDEfc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Feb 2011 23:35:32 -0500
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH 22/25] mm: Convert anon_vma->lock to a mutex
In-Reply-To: <1296745495.26581.370.camel@laptop>
References: <20110203142716.93C5.A69D9226@jp.fujitsu.com> <1296745495.26581.370.camel@laptop>
Message-ID: <20110204133458.17CE.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Date: Fri,  4 Feb 2011 13:35:27 +0900 (JST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: kosaki.motohiro@jp.fujitsu.com, Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Hugh Dickins <hughd@google.com>
Message-ID: <20110204043527.6rIXwQYEAMmb_muQTQtJ7QeRDLuQJ8OtVds1YtawM8s@z>

> On Thu, 2011-02-03 at 14:27 +0900, KOSAKI Motohiro wrote:
> > > Straight fwd conversion of anon_vma->lock to a mutex.
> > > 
> > > Acked-by: Hugh Dickins <hughd@google.com>
> > > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > 
> > Don't I ack this series at previous iteration? If not, Hmmm.. I haven't remenber
> > the reason.
> 
> I got a +1 email from you on the spinlock to mutex conversion patch, I
> wasn't quite sure to what tag that translated.

I'm sorry. Maybe Im busy and I wrote unkindly mail. yes, it's my fault.


> >  Anyway
> > 	Reviewed-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
> 
> Is this for this particular patch, or for the series? 

series. please.


