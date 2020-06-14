Return-Path: <SRS0=o+GD=73=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from a3.inai.de ([88.198.85.195]:39502 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbgFNVIO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 14 Jun 2020 17:08:14 -0400
Date: Sun, 14 Jun 2020 23:08:08 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: Good idea to rename files in include/uapi/ ?
In-Reply-To: <174102.1592165965@warthog.procyon.org.uk>
Message-ID: <nycvar.YFH.7.77.849.2006142244200.30230@n3.vanv.qr>
References: <9feded75-4b45-2821-287b-af00ec5f910f@al2klimov.de> <174102.1592165965@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200614210808.Zn_ztU9kZWmulCZPvqDVhH6Cbv4bD13Bk0RFOBgfyHI@z>


On Sunday 2020-06-14 22:19, David Howells wrote:
>Alexander A. Klimov <grandmaster@al2klimov.de> wrote:
>
>> *Is it a good idea to rename files in include/uapi/ ?*
>
>Very likely not.  If programs out there are going to be built on a
>case-sensitive filesystem (which happens all the time), they're going to break
>if you rename the headers.  We're kind of stuck with them.

Netfilter has precedent for removing old headers, e.g.
7200135bc1e61f1437dc326ae2ef2f310c50b4eb's ipt_ULOG.h.

Even if kernels would not remove such headers, the iptables userspace
code wants to be buildable with all kinds of kernels, including past
releases, which do not have modern headers like xt_l2tp.h.

The mantra for userspace programs is therefore "copy the headers" —
because you never know what /usr/include/linux you get. iptables and
iproute2 are two example codebases that employ this. And when headers
do get copied, header removals from the kernel side are no longer a
big deal either.

A header file rename is no problem. We even have dummy headers
already because of this... or related changes. Just look at
xt_MARK.h, all it does is include xt_mark.h. Cf.
28b949885f80efb87d7cebdcf879c99db12c37bd .

The boilerplate for xt_*h is quite high thanks to the miniscule
splitting of headers. Does not feel right in this day and age.
