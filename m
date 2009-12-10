Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3772 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760874AbZLJRZc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 12:25:32 -0500
Message-ID: <4B212EEC.3060808@caviumnetworks.com>
Date: Thu, 10 Dec 2009 09:25:00 -0800
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
Subject: [PATCH 0/5] More unreachable() conversions.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, linux-am33-list@redhat.com, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>, uclinux-dist-devel@blackfin.uclinux.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20091210172500.2xjlh9hGqnFSIoqoLNTGq5c0mI9QlZHx3oGObpS_J8Y@z>

Back in commit 38938c879eb0c39edf85d5164aa0cffe2874304c the new macro
unreachable() was added.  We can use it in BUG instead of a variety of
ad hoc endless loops.

This patch set consists of the patches from the original set that were
never Acked-by anyone.  Although they are completely untested, they
seem plausible.

I don't plan on pushing these things out any more, so if you
like them please merge them via your architecture trees.

I will reply with the 5 patches.

David Daney (5):
   mn10300: Convert BUG() to use unreachable()
   parisc: Convert BUG() to use unreachable()
   powerpc: Convert BUG() to use unreachable()
   alpha: Convert BUG() to use unreachable()
   blackfin: Convert BUG() to use unreachable()

  arch/alpha/include/asm/bug.h    |    3 ++-
  arch/blackfin/include/asm/bug.h |    2 +-
  arch/mn10300/include/asm/bug.h  |    3 ++-
  arch/parisc/include/asm/bug.h   |    4 ++--
  arch/powerpc/include/asm/bug.h  |    2 +-
  5 files changed, 8 insertions(+), 6 deletions(-)

