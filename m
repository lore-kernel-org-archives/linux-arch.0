Return-Path: <SRS0=84jE=65=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59862 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726722AbgEOQxd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 May 2020 12:53:33 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <954ef5ce2e47472f8b41300bf59209c5@garmin.com>
References: <954ef5ce2e47472f8b41300bf59209c5@garmin.com> <20200515152321.9280-1-nate.karstens@garmin.com> <20200515160342.GE23230@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2] Implement close-on-fork
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <197933.1589561600.1@warthog.procyon.org.uk>
Date: Fri, 15 May 2020 17:53:20 +0100
Message-ID: <197934.1589561600@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Karstens, Nate" <Nate.Karstens@garmin.com>
Cc: dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, David Laight <David.Laight@aculab.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Changli Gao <xiaosuo@gmail.com>
Message-ID: <20200515165320.5AhNyWaYZWad0qxGdG1p4o0FpB-tSR6peQYyRISQtkY@z>

Karstens, Nate <Nate.Karstens@garmin.com> wrote:

> > already has a portable solution
> 
> What is the solution?

sys_spawn(const char *path, const char **argv, const char **envv,
	  unsigned long clone_flags, unsigned int nfds, int *fds);

maybe?

David
