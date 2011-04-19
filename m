Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47349 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752483Ab1DSUIT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Apr 2011 16:08:19 -0400
Date: Tue, 19 Apr 2011 13:07:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 15/20] mm: Convert i_mmap_lock to a mutex
Message-ID: <20110419130725.38cb638b.akpm@linux-foundation.org>
In-Reply-To: <20110401121726.037173835@chello.nl>
References: <20110401121258.211963744@chello.nl>
	<20110401121726.037173835@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Hugh Dickins <hughd@google.com>
Message-ID: <20110419200725.gEoZLlpsEttezuDSdQRaqDrg4N1sPJM6IXeBWUi52mE@z>

On Fri, 01 Apr 2011 14:13:13 +0200
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> Straight fwd conversion of i_mmap_lock to a mutex

What effect does this have on kernel performance?

Workloads which take the lock at high frequency from multiple threads
should be tested.
