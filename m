Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54724 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439Ab2BVMXN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Feb 2012 07:23:13 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 02/30] x86-64: Use explicit sizes in sigcontext.h, prepare for x32
Date: Wed, 22 Feb 2012 12:22:58 +0000
References: <1329696488-16970-1-git-send-email-hpa@zytor.com> <CA+55aFy__c1j=APK9tjJ__daYtZN74GySANxBZ9kT9e1Zx9DXQ@mail.gmail.com> <4F419A28.1060903@zytor.com>
In-Reply-To: <4F419A28.1060903@zytor.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <201202221222.58399.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, akpm@linux-foundation.org, hjl.tools@gmail.com
Message-ID: <20120222122258.EOiy_zL9yvuxhqfSR98zZ7kUZ_3ur3-tmlJS7_bXrdA@z>

On Monday 20 February 2012, H. Peter Anvin wrote:
> We are using __u64 as x86-32 compatible since we are sharing most of the
> really complex path (like ioctl) with i386 much more so than x86-64.  So
> it is defined in userspace as:
> 
> typedef unsigned long long __u64 __attribute__((aligned(4)));
> 
> __aligned_u64 obviously is naturally aligned, which matches uint64_t is
> userspace.

Has someone audited the interfaces to check if there are data structures that
use a plain signed or unsigned "long long" instead of __s64/__u64 in places
where i386 differs from the other compat implementations?

I found DRM_IOCTL_UPDATE_DRAW, but there could be more like this one.

	Arnd
