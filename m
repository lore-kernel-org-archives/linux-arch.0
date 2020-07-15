From: Mike Rapoport <rppt@kernel.org>
Subject: [ANNOUNCE] linux/arch/* Microconference Accepted into 2020 Linux
 Plumbers Conference
Date: Wed, 15 Jul 2020 11:46:48 +0300
Message-ID: <20200715084648.GC1181712@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729377AbgGOIqy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jul 2020 04:46:54 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>

Hi all,

This year we'll hold linux/arch/* micro-conference at Linux Plumbers [1]
to discuss, well, the code in linux/arch/*.

The purpose of this micro-conference is to bring architecture
maintainers and people working on the arch-specific code together and
see how can we consolidate and generalize this functionality.

Possible topics for the discussion could be:

* Reducing code duplication and generalizing the common code in arch/
* Moving syscall processing to C
* Memory models (FLAT, DISCONTIGOUS and SPARSE)
* Devicetree
* Future of highmem
* Identifying old machine support:
  - Still in active use
  - Only in hobbyist/retro-computing
  - Completely obsolete and broken

Please send your topic proposals to the Linux Plumber's website using the
linux/arch/* as the Track you're submitting at:

https://linuxplumbersconf.org/event/7/abstracts/

The deadline for the submissions is August, 10, 2020.

Mike and Arnd.
