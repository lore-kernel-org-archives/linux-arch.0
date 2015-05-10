From: Richard Weinberger <richard@nod.at>
Subject: VERIFY_READ/WRITE in uaccess.h?
Date: Sun, 10 May 2015 11:44:44 +0200
Message-ID: <554F288C.3000300@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65276 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752195AbbEJJos (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 10 May 2015 05:44:48 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linux-Arch <linux-arch@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>

Hi!

While cleaning up UML's uaccess code I've noticed that not a single architecture
is using VERIFY_READ/WRITE in access_ok().
One exception is UML, it uses the access type in one check which is in vain anyways.
Also asm-generic/uaccess.h drops the type parameter silently.

Why do we still carry it around?

Is it because we want it for some future architecture which can benefit
from it or just because nobody cared enough to do a tree-wide cleanup?
I fear it is the latter... ;)

Thanks,
//richard
