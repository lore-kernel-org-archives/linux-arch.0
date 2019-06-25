From: Christoph Hellwig <hch@lst.de>
Subject: [RFC] remove arch/sh?
Date: Tue, 25 Jun 2019 10:56:16 +0200
Message-ID: <20190625085616.GA32399@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Linus and maintainers,

arch/sh seems pretty much unmaintained these days.  The last time I got
any reply to sh patches from the list maintainers, and the last maintainer
pull request was over a year ago, and even that has been rather sporadic.

In the meantime we've not really seen any updates for new kernel features
and code seems to be bitrotting.
