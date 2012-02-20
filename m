From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/7] COMPAT_USE_64BIT_TIME v2
Date: Sun, 19 Feb 2012 18:42:05 -0800
Message-ID: <4F41B2FD.9010705@zytor.com>
References: <CA+55aFwiV3N-9-pB6ofN-5GBS0mnPTBGAdPH1M70wK8qr-=PQg@mail.gmail.com> <1329704570-3792-1-git-send-email-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:58240 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751733Ab2BTCmY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Feb 2012 21:42:24 -0500
In-Reply-To: <1329704570-3792-1-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org, akpm@linux-foundation.org, davem@davemloft.net, hjl.tools@gmail.com, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <greg@kroah.com>

On 02/19/2012 06:22 PM, H. Peter Anvin wrote:
> From: "H. Peter Anvin" <hpa@zytor.com>
> 
> This is a respin of the COMPAT_USE_64BIT_TIME bits of the x32
> patchset.  It replaces patches 07/30-10/30 out of that patchset.
> 
> The differences in this respin are:
> 
> 1. Use helper functions as suggested by Linus, and
> 2. Add support in the networking stack (this bit got inadvertently
>    left out of the previous patchset.)
> 
> Linus, is this more what you were looking for?
> 
> This is the diffstat for this set:
> 

(And no, it doesn't even compile... working on that ;)

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
