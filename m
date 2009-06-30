From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] reduce export symbol CRC table size on 64-bit archs
Date: Wed, 1 Jul 2009 00:09:32 +0200
Message-ID: <20090630220932.GE1241@elte.hu>
References: <4A4A18780200007800008345@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:46439 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612AbZF3WJo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 30 Jun 2009 18:09:44 -0400
Content-Disposition: inline
In-Reply-To: <4A4A18780200007800008345@vpn.id2.novell.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: tony.luck@intel.com, Thomas Gleixner <tglx@linutronix.de>, Rusty Russell <rusty@rustcorp.com.au>, hpa@zytor.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org


* Jan Beulich <JBeulich@novell.com> wrote:

> Since these CRCs are really only 32-bit quantities, there's no 
> need to store them in 64-bit slots. Since, however, gcc doesn't 
> allow respective initializations, asm() constructs get used to 
> create the CRC tables (and its for that reason that the patch only 
> makes x86-64 and ia64 utilize that functionality, as I can't 
> verify this doesn't break in some subtle way elsewhere).
> 
> Observed size reduction (x86-64):
> - 16k kernel resident size
> - 2k module resident size
> - 1M vmlinux image size
> 
> If the asm() construct could be extended to all architectures, and 
> if modpost would guarantee generation of CRCs for all exported, 
> then the __crc_* symbols wouldn't need to be declared weak 
> anymore, could hence remain local to the exporting object. By 
> adding -Wa,-strip-local-absolute to the second compilation step 
> the __crc_* symbols could even be prevented from making it into 
> any object file at all.
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>

> 
> ---
>  arch/ia64/include/asm/module.h |    2 ++
>  arch/x86/include/asm/module.h  |    1 +
>  include/linux/module.h         |   41 ++++++++++++++++++++++++++---------------
>  include/linux/moduleparam.h    |   10 +++++++++-
>  kernel/module.c                |   26 +++++++++++++-------------
>  scripts/genksyms/genksyms.c    |   16 ++++++++--------
>  6 files changed, 59 insertions(+), 37 deletions(-)

No objections to the (minor) x86 bits.

	Ingo
