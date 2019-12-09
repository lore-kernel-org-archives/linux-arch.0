From: Christoph Hellwig <hch@lst.de>
Subject: RFC: kill off ioremap_nocache
Date: Mon,  9 Dec 2019 14:58:20 +0100
Message-ID: <20191209135823.28465-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi all,

with the ioremap changes that did land in 5.5-rc1 ioremap_nocache is
now equal to ioremap for all architectures.  For most architectures
including the common one this has been the case for about 20 years,
but we had a few holdouts.

That means ioremap_nocache is entirely superflous now and can be
killed off.  This series has one big scripted patch to do just that
after a little prep patch to fix up the not entirely obvious mips
definition.

Let me know what you think and if this is something acceptable for
just after -rc1.
