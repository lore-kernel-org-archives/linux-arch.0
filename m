From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC Patch v1 45/55] ARC: unaligned access emulation
Date: Thu, 20 Dec 2012 08:51:14 +0000
Message-ID: <201212200851.15350.arnd@arndb.de>
References: <1352720953-24321-1-git-send-email-vgupta@synopsys.com> <201211121400.13046.arnd@arndb.de> <50D2C78B.4060109@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:50024 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab2LTIvW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Dec 2012 03:51:22 -0500
In-Reply-To: <50D2C78B.4060109@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de

On Thursday 20 December 2012, Vineet Gupta wrote:
> Are you OK if we keep this support build time - provided that once it is
> build time enabled - we have the additional runtime sysctl based
> toggle-ability as you suggested.

Yes, sounds good.

> Only one of our customers need this feature and this gives people
> reasons to moan about the kernel .text size and such.

Ok.

	Arnd
