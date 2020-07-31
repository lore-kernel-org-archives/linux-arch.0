From: josh@joshtriplett.org
Subject: Re: [Ksummit-discuss] [TECH TOPIC] Planning code obsolescence
Date: Fri, 31 Jul 2020 14:27:21 -0700
Message-ID: <20200731212721.GC32670@localhost>
References: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:39629 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgGaV1a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jul 2020 17:27:30 -0400
Content-Disposition: inline
In-Reply-To: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: ksummit <ksummit-discuss@lists.linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Jul 31, 2020 at 05:00:12PM +0200, Arnd Bergmann wrote:
> The majority of the code in the kernel deals with hardware that was made
> a long time ago, and we are regularly discussing which of those bits are
> still needed. In some cases (e.g. 20+ year old RISC workstation support),
> there are hobbyists that take care of maintainership despite there being
> no commercial interest. In other cases (e.g. x.25 networking) it turned
> out that there are very long-lived products that are actively supported
> on new kernels.
> 
> When I removed support for eight instruction set architectures in 2018,
> those were the ones that no longer had any users of mainline kernels,
> and removing them allowed later cleanup of cross-architecture code that
> would have been much harder before.
> 
> I propose adding a Documentation file that keeps track of any notable
> kernel feature that could be classified as "obsolete", and listing
> e.g. following properties:
> 
> * Kconfig symbol controlling the feature
> 
> * How long we expect to keep it as a minimum
> 
> * Known use cases, or other reasons this needs to stay
> 
> * Latest kernel in which it was known to have worked
> 
> * Contact information for known users (mailing list, personal email)
> 
> * Other features that may depend on this
> 
> * Possible benefits of eventually removing it

We had this once, in the form of feature-removal-schedule.txt. It was,
itself, removed in commit 9c0ece069b32e8e122aea71aa47181c10eb85ba7.

I *do* think there'd be value in having policies and processes for "how
do we carefully remove a driver/architecture/etc we think nobody cares
about". That's separate from having an actual in-kernel list of "things
we think we can remove".
