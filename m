From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 17/31] arm64: System calls handling
Date: Mon, 3 Sep 2012 12:39:51 +0000
Message-ID: <201209031239.51515.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <20120822171309.GC2582@arm.com> <20120903114831.GA3313@mbp>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:50542 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab2ICMj7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Sep 2012 08:39:59 -0400
In-Reply-To: <20120903114831.GA3313@mbp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>

On Monday 03 September 2012, Catalin Marinas wrote:
> I forgot about this at the KS and we haven't got to a clear conclusion.
> 
> Do we (1) stick with the sys_mmap() for 64-bit systems and avoid offset
> conversion in both glibc and kernel or (2) use sys_mmap2() with a 12
> shift in glibc and (PAGE_SHIFT - 12) in the kernel wrapper?
> 
> I personally prefer (1) as it doesn't require a kernel wrapper and we
> avoid the double shifting. 

Yes, I think it's ok this way.

> A reason for (2) would be if we ever need file offsets greater than 16EB.

Let's not worry about this for now, all the other architectures will
have the same problem when we get there.

	Arnd
