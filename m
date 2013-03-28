From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Generic syscall ABI support
Date: Thu, 28 Mar 2013 07:44:27 +0000
Message-ID: <201303280744.27477.arnd@arndb.de>
References: <1364440182.2289.45.camel@leyfoon-vm> <5153D698.6010102@zytor.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:62538 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755865Ab3C1Hoc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Mar 2013 03:44:32 -0400
In-Reply-To: <5153D698.6010102@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ley Foon Tan <lftan@altera.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thursday 28 March 2013, H. Peter Anvin wrote:
> On 03/27/2013 08:09 PM, Ley Foon Tan wrote:

> > The question is, is it a requirement for new arch to support generic
> > syscall ABI when upstreaming? Can we upstream a non-generic syscall ABI
> > first and migrate to generic syscall ABI in future?
> > Thanks.
>
> In general, you should use the generic ABI for a new port unless you
> have very strong and convincing reasons not to.

Yes, absolutely. What a couple of the previous architectures have done is
to keep out of tree patches for their old ABI for a while, and to submit
only code that follows the generic ABI upstream. Usually it doesn't take
long for users to migrate to a new user space after that, but it gives
people a migration strategy. Normally you have other patches that are
required on top of the stuff that is already upstream while you are
getting everything merged, so this is not much different to a device
driver that needs to get rewritten to adapt to a new kernel subsystem.

	Arnd
