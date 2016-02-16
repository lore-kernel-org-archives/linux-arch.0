Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:50834 "EHLO
	resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751929AbcBPQTJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 16 Feb 2016 11:19:09 -0500
Date: Tue, 16 Feb 2016 10:10:55 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH RFC] Introduce atomic and per-cpu add-max and sub-min
 operations
In-Reply-To: <CALYGNiOpnVSpmL0smMu7xCT78GJ4J02LGeiuZBdVxROEpfrH+Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1602161010280.3986@east.gentwo.org>
References: <145544094056.28219.12239469516497703482.stgit@zurg> <20160214165133.GB3965@htj.duckdns.org> <CALYGNiOpnVSpmL0smMu7xCT78GJ4J02LGeiuZBdVxROEpfrH+Q@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20160216161055.uNmb_7sTee6ckndwqvyy46wO_ak3VPVAbCE0wM2nlYY@z>

On Sun, 14 Feb 2016, Konstantin Khlebnikov wrote:

> Yep, they are just abstraction around cmpxchg, as well as a half of atomic
> operations. Probably some architectures could implement this differently.

Ok then use this_cpu_cmpxchg and cmpxchg to implement it instead?
