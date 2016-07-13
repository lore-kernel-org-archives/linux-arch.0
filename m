From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] locking/qrwlock: Let qrwlock has same layout
 regardless of the endian
Date: Wed, 13 Jul 2016 22:40:57 +0200
Message-ID: <20160713204057.GM30927@twins.programming.kicks-ass.net>
References: <1466403652-2931-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160713195423.GD30921@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45012 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbcGMUlO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jul 2016 16:41:14 -0400
Content-Disposition: inline
In-Reply-To: <20160713195423.GD30921@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, arnd@arndb.de, Waiman.Long@hpe.com

On Wed, Jul 13, 2016 at 09:54:23PM +0200, Peter Zijlstra wrote:

> Urgh, I hate this stuff :/

> + * Writer states & reader shift and bias.
> + *
> + *       | +0 | +1 | +2 | +3 |
> + *   ----+----+----+----+----+
> + *    LE | 12 | 34 | 56 | 78 | 0x12345678
> + *   ----+----+----+----+----+
> + *    BE | 78 | 56 | 34 | 12 | 0x12345678
> + *   ----+----+----+----+----+

And of course I got that wrong.. its 0x78563412 in both cases.
