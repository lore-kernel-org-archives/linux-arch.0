Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.136]:54059 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751013AbeEPXLB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 May 2018 19:11:01 -0400
Subject: Re: [RFC PATCH] UAPI: Document auxvec AT_* namespace policy and note
 reservations
References: <1526480447-18185-1-git-send-email-Dave.Martin@arm.com>
 <20180516152913.GY1392@brightrain.aerifal.cx>
 <20180516154957.GT7753@e103592.cambridge.arm.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <3e291fda-b27b-7002-9374-23196f18a38f@zytor.com>
Date: Wed, 16 May 2018 16:09:29 -0700
MIME-Version: 1.0
In-Reply-To: <20180516154957.GT7753@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>, Rich Felker <dalias@libc.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Message-ID: <20180516230929.9nLOLf1OQ_5SVqARyJGz0lF7MZolmOKIy9NrdxCFp6Y@z>

On 05/16/18 08:49, Dave Martin wrote:
> 
> Since <linux/auxvec.h> only contains #defines, it may be enough for arch
> <asm/auxvec.h> headers to include <linux/auxvec.h>.
> 

<asm/auxvec.h> doesn't seem to have any reason to exist at all. If
anyone includes it now, they are Doing It Wrong[TM] since
<linux/auxvec.h> includes <asm/auxvec.h>.

	-hpa
