Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:32847 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730944AbfFYI4t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Jun 2019 04:56:49 -0400
Date: Tue, 25 Jun 2019 10:56:16 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: [RFC] remove arch/sh?
Message-ID: <20190625085616.GA32399@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190625085616.5YZr2b6sj2PFjDrNsTjLWp0ktC7T9obr2sJ3iTNqB1k@z>

Hi Linus and maintainers,

arch/sh seems pretty much unmaintained these days.  The last time I got
any reply to sh patches from the list maintainers, and the last maintainer
pull request was over a year ago, and even that has been rather sporadic.

In the meantime we've not really seen any updates for new kernel features
and code seems to be bitrotting.
