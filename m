From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 0/7] COMPAT_USE_64BIT_TIME v2
Date: Sun, 19 Feb 2012 18:22:43 -0800
Message-ID: <1329704570-3792-1-git-send-email-hpa@zytor.com>
References: <CA+55aFwiV3N-9-pB6ofN-5GBS0mnPTBGAdPH1M70wK8qr-=PQg@mail.gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:58035 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688Ab2BTCXf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 19 Feb 2012 21:23:35 -0500
In-Reply-To: <CA+55aFwiV3N-9-pB6ofN-5GBS0mnPTBGAdPH1M70wK8qr-=PQg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org, akpm@linux-foundation.org, davem@davemloft.net, hjl.tools@gmail.com, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <greg@kroah.com>, "H. Peter Anvin" <hpa@zytor.com>

From: "H. Peter Anvin" <hpa@zytor.com>

This is a respin of the COMPAT_USE_64BIT_TIME bits of the x32
patchset.  It replaces patches 07/30-10/30 out of that patchset.

The differences in this respin are:

1. Use helper functions as suggested by Linus, and
2. Add support in the networking stack (this bit got inadvertently
   left out of the previous patchset.)

Linus, is this more what you were looking for?

This is the diffstat for this set:

 drivers/char/lp.c            |    5 +--
 drivers/input/input-compat.c |    4 +-
 drivers/input/input-compat.h |    2 +-
 include/linux/compat.h       |   20 ++++++++++++
 kernel/compat.c              |   70 +++++++++++++++++++++++++++++++++++++-----
 net/bluetooth/hci_sock.c     |    3 +-
 net/compat.c                 |   65 ++++++++++++++++++++++++---------------
 net/socket.c                 |   18 +++++------
 8 files changed, 136 insertions(+), 51 deletions(-)
