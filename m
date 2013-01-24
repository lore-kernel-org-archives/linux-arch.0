From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 00/76] Synopsys ARC Linux kernel Port
Date: Thu, 24 Jan 2013 09:52:33 +0000
Message-ID: <51010461.20604@imgtec.com>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <201301181512.14441.arnd@arndb.de> <5100F6AD.5050001@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:43346 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731Ab3AXJwi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 24 Jan 2013 04:52:38 -0500
In-Reply-To: <5100F6AD.5050001@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>

Hi Vineet,

On 24/01/13 08:54, Vineet Gupta wrote:
> (3) That branch will be ARC patches on top of Linus's 3.8 rc4. Actually for my
> development, I'd also cherry picked a few patches from linux-next (soft and hard
> dependencies from several different *next trees) - hard ones being
> 
> f13a366 CONFIG_GENERIC_SIGALTSTACK build breakage with asm-generic/syscalls.h [Al]

FYI this one has now been merged into Linus' master.

Cheers
James
