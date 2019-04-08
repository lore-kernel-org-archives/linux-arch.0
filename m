From: Christoph Hellwig <hch@lst.de>
Subject: CONFIG_* symbols in UAPI headers?
Date: Mon, 8 Apr 2019 14:46:40 +0200
Message-ID: <20190408124640.GA607@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jie Zhang <jie.zhang@analog.com>
Cc: Mike Frysinger <vapier@gentoo.org>, David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

I just stumbled over the MAP_UNINITIALIZED defintion, initially
added by:

commit ea637639591def87a54cea811cbac796980cb30d
Author: Jie Zhang <jie.zhang@analog.com>
Date:   Mon Dec 14 18:00:02 2009 -0800

    nommu: fix malloc performance by adding uninitialized flag

The defintion depends on CONFIG_MMAP_ALLOW_UNINITIALIZED, which
will never be set by userspace.  How is this supposed to work?

Shoudn't we define the symbol unconditionally and just turn it
into a no-op in the implementation?


There are a few similar issues, like struct elf_prstatus having
a different layout depending on CONFIG_BINFMT_ELF_FDPIC, or
MAX_SHARED_LIBS defending on CONFIG_BINFMT_SHARED_FLAT.
