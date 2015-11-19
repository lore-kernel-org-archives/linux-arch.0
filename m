From: Richard Weinberger <richard@nod.at>
Subject: [RFC] Limiting linker scope
Date: Thu, 19 Nov 2015 23:50:26 +0100
Message-ID: <564E5232.201@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:11949 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751891AbbKSWuc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Nov 2015 17:50:32 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, octavian.purdila@intel.com

Hi!

UML recently had an interesting bug[1] where the host side of UML
tried to call sigsuspend() but as the kernel itself offers a function
with the same name it called sigsuspend() on
the UML kernel side and funny things happened.

The root cause of the problem is that the UML links userspace
code like glibc, libpcap, etc. to the kernel image and symbols can
clash. Especially if one side is a shared library it will not noticed
at compile time.

As this is not the first bug of this kind I'm facing on UML I've
started to think how to deal with that.

Is it somehow possible to limit the linker scope?
Such that we can force LD no not blindly link every symbols of
vmlinux into another object? Maybe using a white list?
I have do admit I've never used LD scripts nor GNU export maps,
maybe they can help. Currently I'm reading their docs and hope
to find a way to implement my idea.

The problem is also not specific to UML, the emerging Linux Kernel
Library will suffer from the same issue.
As random programs will link the kernel as library the chance is
high to face similar symbol conflicts.

Maybe we can also find a nice generic solution to limit the linker
scope within the kernel. Such that it does not hurt when a random device
driver exports a symbol like "i".
It would also help to define subsystem interface more strict manner.

Thanks,
//richard

[1] https://lkml.org/lkml/2015/11/16/601
