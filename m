Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:45694 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbcDTVJL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Apr 2016 17:09:11 -0400
Subject: Re: [PATCH 10/11] x86, rwsem: provide __down_write_killable
References: <1460041951-22347-1-git-send-email-mhocko@kernel.org>
 <1460041951-22347-11-git-send-email-mhocko@kernel.org>
 <20160413090829.GB29579@gmail.com> <20160413091625.GF14351@dhcp22.suse.cz>
 <20160413091943.GA17858@gmail.com> <20160413102731.GA29896@gmail.com>
 <20160413124943.GH14351@dhcp22.suse.cz>
 <20160420134019.GX3448@twins.programming.kicks-ass.net>
 <91A11395-ACAA-4043-B770-2DF6CBAED54C@zytor.com>
 <20160420204501.GA6815@pd.tnic>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <5717EF59.1030709@zytor.com>
Date: Wed, 20 Apr 2016 14:06:33 -0700
MIME-Version: 1.0
In-Reply-To: <20160420204501.GA6815@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Message-ID: <20160420210633.EQclLuEW5CGzAx6kqy6gIrbwuolHXwBF98JBH85rO_c@z>

On 04/20/2016 01:45 PM, Borislav Petkov wrote:
> On Wed, Apr 20, 2016 at 11:04:05AM -0700, H. Peter Anvin wrote:
>> The reason it breaks is because the same register can't be an
>> input-output register and a separate input. However, the input side of
>> the input-output is probably undefined, and so gcc may not notice.
> 
> So Michal and I talked about this a while ago. Why do we need the '"a"
> (sem)' input dependency if '"+a" (ret)' already supplies the same thing?
> 

Setting ret to sem doesn't make any sense.  Just use "=a" and "a".

	-hpa


