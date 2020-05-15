Return-Path: <SRS0=84jE=65=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726162AbgEOQ0a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 12:26:30 -0400
Date: Fri, 15 May 2020 09:26:18 -0700
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] Implement close-on-fork
Message-ID: <20200515162618.GG16070@bombadil.infradead.org>
References: <20200515152321.9280-1-nate.karstens@garmin.com>
 <20200515155730.GF16070@bombadil.infradead.org>
 <5b1929aa9f424e689c7f430663891827@garmin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b1929aa9f424e689c7f430663891827@garmin.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Karstens, Nate" <Nate.Karstens@garmin.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, David Laight <David.Laight@aculab.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Changli Gao <xiaosuo@gmail.com>, "a.josey@opengroup.org" <a.josey@opengroup.org>
Message-ID: <20200515162618.SSf6KWeeQ7VbiQTn7zzjZlPZqYO9z_nBfH7jOXCZLWc@z>

On Fri, May 15, 2020 at 04:07:33PM +0000, Karstens, Nate wrote:
> Matthew,
> 
> What alternative would you suggest?
> 
> >From an earlier email:
> 
> > ...nothing else addresses the underlying issue: there is no way to
> > prevent a fork() from duplicating the resource. The close-on-exec
> > flag partially-addresses this by allowing the parent process to
> > mark a file descriptor as exclusive to itself, but there is still
> > a period of time the failure can occur because the auto-close only
> > occurs during the exec(). Perhaps this would not be an issue with
> > a different process/threading model, but that is another discussion
> > entirely.
> 
> Do you disagree there is an issue?

Yes.  system() is defined as being unsafe for a threaded application
to call.  I pointed this out in the last thread.
