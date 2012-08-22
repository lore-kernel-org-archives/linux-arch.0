From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 17/31] arm64: System calls handling
Date: Wed, 22 Aug 2012 12:27:14 +0000
Message-ID: <201208221227.14274.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <201208220756.31149.arnd@arndb.de> <20120822102953.GA24136@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53045 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab2HVM1U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Aug 2012 08:27:20 -0400
In-Reply-To: <20120822102953.GA24136@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>

On Wednesday 22 August 2012, Catalin Marinas wrote:
> But what's more important - moving this wrapper to glibc causes issues
> with the page size. We support both 4KB and 64KB pages on 64-bit systems
> (the latter without compat support). The kernel is in a better position
> to do the shift by a compile-time constant. Glibc would need to enquire
> the actual page size to do the shift before calling sys_mmap_pgoff. If
> we assume in glibc that the shift is always 12, we need another wrapper
> in the kernel anyway for 64KB page configuration. So passing the offset
> in bytes worked best for us.

Right, the kernel interface should really be independent of the page
size, as sys_mmap2 normally is, and sys_mmap2 is not provided here.

	Arnd
