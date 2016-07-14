From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] locking/qrwlock: Let qrwlock has same layout
 regardless of the endian
Date: Thu, 14 Jul 2016 11:46:26 +0200
Message-ID: <20160714094626.GN30927@twins.programming.kicks-ass.net>
References: <1466403652-2931-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160713195423.GD30921@twins.programming.kicks-ass.net>
 <578742EA.7060108@linux.vnet.ibm.com>
 <20160714093733.GF30909@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36468 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbcGNJqc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jul 2016 05:46:32 -0400
Content-Disposition: inline
In-Reply-To: <20160714093733.GF30909@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, arnd@arndb.de, Waiman.Long@hpe.com

On Thu, Jul 14, 2016 at 11:37:33AM +0200, Peter Zijlstra wrote:
> static inline u8 *__qspinlock_lock_byte(struct qspinlock *lock)
> {
> 	return (u8 *)lock + 3 * IS_BUILTIN(__BIG_ENDIAN);
> }

Bugger, that doesn't actually work. IS_BUILTIN expects the symbol to be
defined to "1" and __BIG_ENDIAN is not (its "4321").
