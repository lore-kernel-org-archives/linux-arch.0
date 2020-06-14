From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: Good idea to rename files in include/uapi/ ?
Date: Sun, 14 Jun 2020 21:41:17 +0200
Message-ID: <9feded75-4b45-2821-287b-af00ec5f910f@al2klimov.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hello there!

At the moment one can't checkout a clean working directory w/o any 
changed files on a case-insensitive FS as the following file names have 
lower-case duplicates:

➜  linux git:(96144c58abe7) git ls-files |sort -f |uniq -id
include/uapi/linux/netfilter/xt_CONNMARK.h
include/uapi/linux/netfilter/xt_DSCP.h
include/uapi/linux/netfilter/xt_MARK.h
include/uapi/linux/netfilter/xt_RATEEST.h
include/uapi/linux/netfilter/xt_TCPMSS.h
include/uapi/linux/netfilter_ipv4/ipt_ECN.h
include/uapi/linux/netfilter_ipv4/ipt_TTL.h
include/uapi/linux/netfilter_ipv6/ip6t_HL.h
net/netfilter/xt_DSCP.c
net/netfilter/xt_HL.c
net/netfilter/xt_RATEEST.c
net/netfilter/xt_TCPMSS.c
tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
➜  linux git:(96144c58abe7)

Also even on a case-sensitive one VIm seems to have trouble with editing 
both case-insensitively equal files at the same time.

I was going to make a patch renaming the respective duplicates, but I'm 
not sure:

*Is it a good idea to rename files in include/uapi/ ?*

Best,
AK
