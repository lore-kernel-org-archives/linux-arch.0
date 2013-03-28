From: Ley Foon Tan <lftan@altera.com>
Subject: Re: Generic syscall ABI support
Date: Thu, 28 Mar 2013 16:32:02 +0800
Message-ID: <1364459522.2308.6.camel@leyfoon-vm>
References: <1364440182.2289.45.camel@leyfoon-vm>
	 <5153D698.6010102@zytor.com> <201303280744.27477.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:45658
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755989Ab3C1IcY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 28 Mar 2013 04:32:24 -0400
In-Reply-To: <201303280744.27477.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, 2013-03-28 at 07:44 +0000, Arnd Bergmann wrote:

> Yes, absolutely. What a couple of the previous architectures have done is
> to keep out of tree patches for their old ABI for a while, and to submit
> only code that follows the generic ABI upstream. Usually it doesn't take
> long for users to migrate to a new user space after that, but it gives
> people a migration strategy. Normally you have other patches that are
> required on top of the stuff that is already upstream while you are
> getting everything merged, so this is not much different to a device
> driver that needs to get rewritten to adapt to a new kernel subsystem.
> 
> 	Arnd
> 
Thanks for the reply. 
We will working on generic ABI for kernel and Glibc. This might take
some times.

Regards
LFTAN
