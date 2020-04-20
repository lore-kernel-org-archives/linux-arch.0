Return-Path: <SRS0=YOFp=6E=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-dm6nam12on2117.outbound.protection.outlook.com ([40.107.243.117]:57049
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbgDTHQN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Apr 2020 03:16:13 -0400
From: Nate Karstens <nate.karstens@garmin.com>
Subject: Implement close-on-fork
Date: Mon, 20 Apr 2020 02:15:44 -0500
Message-ID: <20200420071548.62112-1-nate.karstens@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Changli Gao <xiaosuo@gmail.com>
Message-ID: <20200420071544.ZYciH2HcDcXT9ozBjfk4lUaBZ7-aWPEDGtQRKkPewDQ@z>

Series of 4 patches to implement close-on-fork. Tests have been
published to https://github.com/nkarstens/ltp/tree/close-on-fork.

close-on-fork addresses race conditions in system(), which
(depending on the implementation) is non-atomic in that it
first calls a fork() and then an exec().

This functionality was approved by the Austin Common Standards
Revision Group for inclusion in the next revision of the POSIX
standard (see issue 1318 in the Austin Group Defect Tracker).

[PATCH 1/4] fs: Implement close-on-fork
[PATCH 2/4] fs: Add O_CLOFORK flag for open(2) and dup3(2)
[PATCH 3/4] fs: Add F_DUPFD_CLOFORK to fcntl(2)
[PATCH 4/4] net: Add SOCK_CLOFORK
