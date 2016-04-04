Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:36334 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbcDDJDk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2016 05:03:40 -0400
Date: Mon, 4 Apr 2016 11:03:36 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 02/11] locking, rwsem: drop explicit memory barriers
Message-ID: <20160404090335.GB10272@dhcp22.suse.cz>
References: <1459508695-14915-1-git-send-email-mhocko@kernel.org>
 <1459508695-14915-3-git-send-email-mhocko@kernel.org>
 <20160402011753.GB5329@linux-uzut.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160402011753.GB5329@linux-uzut.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
Message-ID: <20160404090336.tLiiy8W_UEbnOzADNwpvXgojYbu7uLIqP-FCKQ5NX1o@z>

On Fri 01-04-16 18:17:53, Davidlohr Bueso wrote:
[...]
> I think we can actually get rid of these files altogether. While I
> don't know the archs, it does not appear to be implementing any kind
> of workaround/optimization, which is obviously the whole purpose of
> defining per-arch rwsem internals, unless the redundant barriers are
> actually the purpose. So we could use the generic rwsem.h (which has
> optimizations and ACQUIRE/ RELEASE semantics, although nops for either
> sh or xtensa specifically). A first inspection shows that the code is
> in fact the same and continue to use 32bit rwsems.

OK, so this has passed my defconfig and allnoconfig for xtensa compile
test, allyesconfig has failed due to some unrelated reasons:
clk-qoriq.c:(.init.text+0x3ebd3): dangerous relocation: l32r: literal target out of range (try using text-section-literals): (.init.literal+0x17c60)
and zillions of similar... The same error is without the patch

I do not have a crosscompiler[1] for sh arch so I couldn't have tested
it but there shouldn't be any issues in principal. I will send two
patches as a follow up.

---
[1] https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/ doesn't
seem to have it.
-- 
Michal Hocko
SUSE Labs
