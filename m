Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39914 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752505Ab1DSUIt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Apr 2011 16:08:49 -0400
Date: Tue, 19 Apr 2011 13:07:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 19/20] mm: Convert anon_vma->lock to a mutex
Message-ID: <20110419130732.da620ce7.akpm@linux-foundation.org>
In-Reply-To: <20110401121726.230302401@chello.nl>
References: <20110401121258.211963744@chello.nl>
	<20110401121726.230302401@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Hugh Dickins <hughd@google.com>
Message-ID: <20110419200732.G0Uwix3fkrcGAodT_-A2k8sNHT_es1P2JvHDTVcHyoE@z>

On Fri, 01 Apr 2011 14:13:17 +0200
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> Straight fwd conversion of anon_vma->lock to a mutex.

What workloads do we expect might be adversely affected by this? 
Were such workloads tested?  With what results?



