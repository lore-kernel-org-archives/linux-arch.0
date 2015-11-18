From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: spin_lock() ordering on ia64
Date: Wed, 18 Nov 2015 18:41:50 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F39E987AC@ORSMSX114.amr.corp.intel.com>
References: <20151118131106.GE1588@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:7835 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933387AbbKRSlx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2015 13:41:53 -0500
In-Reply-To: <20151118131106.GE1588@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

> AFAIU, ld4.c.nc doesn't provide any ordering semantics, so a load to an
> unrelated address from within the following critical section could be
> speculated before we've actually acquired the lock.
>
> What am I missing? Does the ALAT provide guarantees against other loads
> somehow or does ld4.c.nc provide ordering guarantees that I didn't spot
> in the manuals?

I don't recall.  I pinged the Itanium h/w architect that helped me write that code,
but it may be a while before I get an answer (they said it would require paging
in some old context to the brain, and they are swamped with other work now).

-Tony
