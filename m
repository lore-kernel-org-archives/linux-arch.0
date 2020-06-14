From: Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: Good idea to rename files in include/uapi/ ?
Date: Mon, 15 Jun 2020 00:01:01 +0200
Message-ID: <20200614220101.GA9367@salvia>
References: <9feded75-4b45-2821-287b-af00ec5f910f@al2klimov.de>
 <174102.1592165965@warthog.procyon.org.uk>
 <nycvar.YFH.7.77.849.2006142244200.30230@n3.vanv.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from correo.us.es ([193.147.175.20]:33352 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbgFNWBF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 14 Jun 2020 18:01:05 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id EB525FF90D
        for <linux-arch@vger.kernel.org>; Mon, 15 Jun 2020 00:01:04 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DE6FFDA86E
        for <linux-arch@vger.kernel.org>; Mon, 15 Jun 2020 00:01:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.77.849.2006142244200.30230@n3.vanv.qr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Engelhardt <jengelh@inai.de>
Cc: David Howells <dhowells@redhat.com>, "Alexander A. Klimov" <grandmaster@al2klimov.de>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org

On Sun, Jun 14, 2020 at 11:08:08PM +0200, Jan Engelhardt wrote:
> 
> On Sunday 2020-06-14 22:19, David Howells wrote:
> >Alexander A. Klimov <grandmaster@al2klimov.de> wrote:
> >
> >> *Is it a good idea to rename files in include/uapi/ ?*
> >
> >Very likely not.  If programs out there are going to be built on a
> >case-sensitive filesystem (which happens all the time), they're going to break
> >if you rename the headers.  We're kind of stuck with them.
> 
> Netfilter has precedent for removing old headers, e.g.
> 7200135bc1e61f1437dc326ae2ef2f310c50b4eb's ipt_ULOG.h.

That's only because NFLOG has been there for ~10 years, so it was safe
to remove ULOG support.
