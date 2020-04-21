From: Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 00/12] "Task_isolation" mode
Date: Tue, 21 Apr 2020 08:21:48 -0700
Message-ID: <20200421152148.GA16576@yury-thinkpad>
Reply-To: 4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgDUPVx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Apr 2020 11:21:53 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Belits <abelits@marvell.com>
Cc: yury.norov@gmail.com, "frederic@kernel.org" <frederic@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prasun Kapoor <pkapoor@marvell.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

> This is an update of task isolation work that was originally done by
> Chris Metcalf <cmetcalf@mellanox.com> and maintained by him until
> November 2017. It is adapted to the current kernel and cleaned up to
> make this functionality both more complete (as in, prevent isolation
> breaking in situations that were not covered before) and cleaner (as
> in, avoid any dubious or fragile use of kernel interfaces, and provide
> clean and reliable isolation breaking procedure).
> 
> I guess, I have to explain why such a thing exists.
> 
> ...
> 
> My thanks to Chris Metcalf for design and maintenance of the original
> task isolation patch, Francis Giraldeau <francis.giraldeau@gmail.com>
> and Yuri Norov <ynorov@marvell.com> for various contributions to this
> work, and Frederic Weisbecker <frederic@kernel.org> for his work on
> CPU isolation and housekeeping that made possible to remove some less
> elegant solutions that I had to devise for earlier, <4.17 kernels.
> 
> The previous patch (v16 by Chris Metcalf) is at:
> 
> https://lore.kernel.org/lkml/1509728692-10460-1-git-send-email-cmetcalf@mellanox.com

Alex,

For patches that are not authored by you, you removed authors' SOB, like in
patch 8 of this series.

Please CC me for next revisions.

Thanks,
Yury
