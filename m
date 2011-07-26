From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET tip:x86/memblock] memblock: Kill early_node_map[]
Date: Tue, 26 Jul 2011 23:49:59 +0200
Message-ID: <CAOS58YPZLvXKHdy4nSeqNhk71o5hy-o6XQKbohvuUsGMMMirOA@mail.gmail.com>
References: <1311694534-5161-1-git-send-email-tj@kernel.org>
	<CAE9FiQX0i2UwO9fSntwSEMUWiO6KdzbQth8Bf+_9OnKXntasKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52554 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844Ab1GZVuB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jul 2011 17:50:01 -0400
In-Reply-To: <CAE9FiQX0i2UwO9fSntwSEMUWiO6KdzbQth8Bf+_9OnKXntasKQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, benh@kernel.crashing.org, tony.luck@intel.com, ralf@linux-mips.org, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, lethal@linux-sh.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com

Hello,

On Tue, Jul 26, 2011 at 11:14 PM, Yinghai Lu <yhlu.kernel@gmail.com> wrote:
> it passes test with my x86 64bits setups.

Great, thanks for testing.

> looks like tip/master does not include tip/x86/memblock and tip/x86/mm yet.
>
> So tip/x86/memblock, tip/x86/mm will not get into 3.1?

Yeah, I think the whole thing including the last patchset was a bit
too late for this merge window.  These are basically cleanups and
could possibly cause weird boot regressions, so having enough time in
-tip before going mainline seems like a good idea to me.

Thanks.

-- 
tejun
