From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 07/11] signal/arm64: Document conflicts with SI_USER and
 SIGFPE, SIGTRAP, SIGBUS
Date: Wed, 17 Jan 2018 17:39:44 +0000
Message-ID: <20180117173944.GK22781@e103592.cambridge.arm.com>
References: <87373b6ghs.fsf@xmission.com>
 <20180112005940.23279-7-ebiederm@xmission.com>
 <20180115163028.GU22781@e103592.cambridge.arm.com>
 <87h8rnox3c.fsf@xmission.com>
 <20180117171729.GJ22781@e103592.cambridge.arm.com>
 <87h8rkflft.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44860 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753225AbeAQRju (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jan 2018 12:39:50 -0500
Content-Disposition: inline
In-Reply-To: <87h8rkflft.fsf@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, James Morse <james.morse@arm.com>, Al Viro <viro@zeniv.linux.org.uk>, Olof Johansson <olof@lixom.net>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

On Wed, Jan 17, 2018 at 11:24:06AM -0600, Eric W. Biederman wrote:
> Dave Martin <Dave.Martin@arm.com> writes:

[...]

> > Should si_code simply be ignored for the SIGKILL case?
> 
> I know what x86 does in a similar case is it uses force_sig instead of
> force_sig_info.  Then the generic code gets to worry about 
> 
> If the appropriate paths generic paths get to worry about what siginfo
> to fill in in that case.  Which for SI_KERNEL is zero for everything
> except the si_code and the si_signo.
> 
> That seems perfectly reasonable.

OK, I'll go with SI_KERNEL then.

Cheers
---Dave
