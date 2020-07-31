From: Arnd Bergmann <arnd@arndb.de>
Subject: [TECH TOPIC] Planning code obsolescence
Date: Fri, 31 Jul 2020 17:00:12 +0200
Message-ID: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:35595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731692AbgGaPAb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 11:00:31 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: ksummit <ksummit-discuss@lists.linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

I have submitted the below as a topic for the linux/arch/* MC that Mike
and I run, but I suppose it also makes sense to discuss it on the
ksummit-discuss mailing list (cross-posted to linux-arch and lkml) as well
even if we don't discuss it at the main ksummit track.

     Arnd

8<---
The majority of the code in the kernel deals with hardware that was made
a long time ago, and we are regularly discussing which of those bits are
still needed. In some cases (e.g. 20+ year old RISC workstation support),
there are hobbyists that take care of maintainership despite there being
no commercial interest. In other cases (e.g. x.25 networking) it turned
out that there are very long-lived products that are actively supported
on new kernels.

When I removed support for eight instruction set architectures in 2018,
those were the ones that no longer had any users of mainline kernels,
and removing them allowed later cleanup of cross-architecture code that
would have been much harder before.

I propose adding a Documentation file that keeps track of any notable
kernel feature that could be classified as "obsolete", and listing
e.g. following properties:

* Kconfig symbol controlling the feature

* How long we expect to keep it as a minimum

* Known use cases, or other reasons this needs to stay

* Latest kernel in which it was known to have worked

* Contact information for known users (mailing list, personal email)

* Other features that may depend on this

* Possible benefits of eventually removing it

With that information, my hope is that it becomes easier to plan when
some code can be removed after the last users have stopped upgrading
their kernels, while also preventing code from being removed that is
actually still in active use.

In the discussion at the linux/arch/* MC, I would hope to answer these
questions:

* Do other developers find this useful to have?

* Where should the information be kept (Documentation/*, Kconfig,
MAINTAINERS, wiki.kernel.org, ...)

* Which information should be part of an entry?

* What granularity should this be applied to -- only high-level features
like CPU architectures and subsystems, or individual drivers and machines?
