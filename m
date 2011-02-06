From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH -mm 2/6] powerpc: convert little-endian bitops macros
 to static inline functions
Date: Mon, 07 Feb 2011 10:14:46 +1100
Message-ID: <1297034086.14982.8.camel@pasglop>
References: <1296136583-13815-1-git-send-email-akinobu.mita@gmail.com>
	 <1296136583-13815-3-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41610 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754100Ab1BFXPo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 6 Feb 2011 18:15:44 -0500
In-Reply-To: <1296136583-13815-3-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org

On Thu, 2011-01-27 at 22:56 +0900, Akinobu Mita wrote:
> (This patch is intended to be folded into the patch in -mm:
> powerpc-introduce-little-endian-bitops.patch)
> 
> The little-endian bitops on powerpc are written as preprocessor
> macros with the cast to "unsigned long *".
> This means that even non-pointers will be accepted without an error, and
> that is a Very Bad Thing.
> 
> This converts the little-endian bitops macros to static inline functions
> with proper prototypes.

No objection to the powerpc variant of the patches. What is the status
with the wholes series tho ? Does it looks like its going to be
accepted ? Do you expect my Ack and will merge the whole thing at once ?
Does it break bisection unless it's merged as one single giant patch ?

Cheers,
Ben.
