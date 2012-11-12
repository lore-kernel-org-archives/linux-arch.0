From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 00/40] Meta Linux Kernel Port
Date: Mon, 12 Nov 2012 19:10:08 +0000
Message-ID: <201211121910.09395.arnd@arndb.de>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <509D2D4F.20304@imgtec.com> <50A12AE3.4090404@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50500 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614Ab2KLTKO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Nov 2012 14:10:14 -0500
In-Reply-To: <50A12AE3.4090404@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch <linux-arch@vger.kernel.org>

On Monday 12 November 2012, James Hogan wrote:
> Using inline assembly actually causes us a few problems. There is no way
> for inline assembly to allow the compiler to intelligently generate
> [Reg+Reg] or [Reg+#imm] memory addressing like it can with volatile (and
> even if it could, the constraints would be hard/impossible to express
> due to the different encodings of GET and SET that have different
> immediate lengths and restrictions on register units). This results in
> extra code to do an ADD prior to the memory access, and will also
> increase register pressure.

Probably not something to do right away, but you should consider extending
your gcc so you can express the more complex constraints. That will likely
also improve the normal code that gcc generates.

> Note that Meta doesn't support unaligned accesses anyway so use of
> __packed on MMIO is likely broken from the outset.

The problem is actually the opposite: Some people incorrectly annotate
structures that are always aligned to be __packed. This has no effect
on architectures that support unaligned accesses, but causes the
access to be split into byte sized loads and stores on architectures
like Meta that cannot.

Note also that gcc is free to split any accesses for whatever reason
it deems necessary.

> I'd like to therefore
> keep using the <asm-generic/io.h> implementations of the __raw_* functions.

Ok, just be aware that if something breaks in device drivers because of
this, it can be a problem that is very hard to debug.

	Arnd
