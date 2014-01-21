From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/8] Update kernel uabi header files for x32
Date: Tue, 21 Jan 2014 07:43:15 -0800
Message-ID: <52DE9593.9050107@zytor.com>
References: <1388182464-28428-1-git-send-email-hjl.tools@gmail.com> <20131228163308.GA1638@infradead.org> <52DD6101.4010708@zytor.com> <20140121120440.GD14830@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:37379 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754783AbaAUPnz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Jan 2014 10:43:55 -0500
In-Reply-To: <20140121120440.GD14830@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>, "H.J. Lu" <hjl.tools@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>, Will Deacon <Will.Deacon@arm.com>

On 01/21/2014 04:04 AM, Catalin Marinas wrote:
> 
> ILP32 for arm64 is still work in progress and subject to change. So far
> the preliminary ABI
> (http://git.kernel.org/cgit/linux/kernel/git/cmarinas/linux-aarch64.git/log/?h=ilp32)
> redefines kernel_(u)long_t is defined as (unsigned) long long. Most of
> the syscalls are 64-bit generic with ~23 routed to compat. I would like
> to simplify these further and even use native 64-bit signal handling but
> it requires some changes to generic structures.
> 

That would be highly useful feedback.

	-hpa
