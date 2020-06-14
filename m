From: David Howells <dhowells@redhat.com>
Subject: Re: Good idea to rename files in include/uapi/ ?
Date: Sun, 14 Jun 2020 21:19:25 +0100
Message-ID: <174102.1592165965@warthog.procyon.org.uk>
References: <9feded75-4b45-2821-287b-af00ec5f910f@al2klimov.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20148 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726857AbgFNUTk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Jun 2020 16:19:40 -0400
In-Reply-To: <9feded75-4b45-2821-287b-af00ec5f910f@al2klimov.de>
Content-ID: <174101.1592165965.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: dhowells@redhat.com, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, linux-arch@vger.kernel.

Alexander A. Klimov <grandmaster@al2klimov.de> wrote:

> *Is it a good idea to rename files in include/uapi/ ?*

Very likely not.  If programs out there are going to be built on a
case-sensitive filesystem (which happens all the time), they're going to break
if you rename the headers.  We're kind of stuck with them.

David
