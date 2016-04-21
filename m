Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:37949 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008AbcDULfh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 21 Apr 2016 07:35:37 -0400
Date: Thu, 21 Apr 2016 13:35:16 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 10/11] x86, rwsem: provide __down_write_killable
Message-ID: <20160421113516.GB28821@pd.tnic>
References: <20160413091625.GF14351@dhcp22.suse.cz>
 <20160413091943.GA17858@gmail.com>
 <20160413102731.GA29896@gmail.com>
 <20160413124943.GH14351@dhcp22.suse.cz>
 <20160420134019.GX3448@twins.programming.kicks-ass.net>
 <91A11395-ACAA-4043-B770-2DF6CBAED54C@zytor.com>
 <20160420204501.GA6815@pd.tnic>
 <5717EF59.1030709@zytor.com>
 <20160420213637.GA4978@pd.tnic>
 <FB0197A2-6A76-43FC-A30E-BE619D3BC67E@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <FB0197A2-6A76-43FC-A30E-BE619D3BC67E@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Message-ID: <20160421113516.ajIiRnc2QQ7ZreOWDuMjxUIFUPVGD4i0YTFWNiU4XOY@z>

On Wed, Apr 20, 2016 at 03:29:30PM -0700, H. Peter Anvin wrote:
> Since it is a fixed register we could just mark edx clobbered, but
> with more flexible register constraints it can permit gcc to allocate
> a temp resister for us. --

Right.

I'll try to hack up a cleanup ontop once the dust here settles and Ingo
pushes out the pile.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
