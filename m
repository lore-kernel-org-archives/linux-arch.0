Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48938 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751044Ab1DSUIN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Apr 2011 16:08:13 -0400
Date: Tue, 19 Apr 2011 13:06:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 13/20] lockdep, mutex: Provide mutex_lock_nest_lock
Message-ID: <20110419130654.95a14117.akpm@linux-foundation.org>
In-Reply-To: <20110401121725.940769985@chello.nl>
References: <20110401121258.211963744@chello.nl>
	<20110401121725.940769985@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>
Message-ID: <20110419200654.giOulTTwpfyC8COucTPD6ngTjtnT7JD5sSi-g056pVE@z>

On Fri, 01 Apr 2011 14:13:11 +0200
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> Provide the mutex_lock_nest_lock() annotation.

why?

Neither the changelog nor the code provide any documentation for this addition to
the lokdep API.

