From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] locking/qrwlock: Don't contend with readers when
 setting _QW_WAITING
Date: Tue, 9 Jun 2015 14:04:20 +0200
Message-ID: <20150609120420.GV3644@twins.programming.kicks-ass.net>
References: <1433802045-21298-1-git-send-email-Waiman.Long@hp.com>
 <1433802045-21298-3-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37303 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbbFIME3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 08:04:29 -0400
Content-Disposition: inline
In-Reply-To: <1433802045-21298-3-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On Mon, Jun 08, 2015 at 06:20:44PM -0400, Waiman Long wrote:
> The current cmpxchg() loop in setting the _QW_WAITING flag for writers
> in queue_write_lock_slowpath() will contend with incoming readers
> causing possibly extra cmpxchg() operations that are wasteful. This
> patch changes the code to do a byte cmpxchg() to eliminate contention
> with new readers.

This is very narrow, would not the main cost still be the cacheline
transfers?

Do you have any numbers to back this? I would feel much better about
this if there's real numbers attached.
