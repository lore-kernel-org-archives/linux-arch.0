From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: allow generic unaligned access if the arch supports it
Date: Fri, 28 Mar 2014 19:14:19 +0100
Message-ID: <201403281914.20201.arnd@arndb.de>
References: <1395942387-14177-1-git-send-email-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.130]:62036 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbaC1SOZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Mar 2014 14:14:25 -0400
In-Reply-To: <1395942387-14177-1-git-send-email-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arch@vger.kernel.org, robherring2@gmail.com

On Thursday 27 March 2014, Ard Biesheuvel wrote:
> Switch the default unaligned access method to 'hardware implemented'
> if HAVE_EFFICIENT_UNALIGNED_ACCESS is set.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Is this part of a longer series of patches? If so, please keep
the patch with the others and merge it through an appropriate
tree.

If not, I guess I'll have to send it myself, but it will be
the only asm-generic patch for the merge window ;-)

	Arnd
