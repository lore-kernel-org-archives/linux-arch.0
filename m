From: Stefano Brivio <sbrivio@redhat.com>
Subject: Re: Good idea to rename files in include/uapi/ ?
Date: Sun, 14 Jun 2020 22:34:56 +0200
Message-ID: <20200614223456.13807a00@redhat.com>
References: <9feded75-4b45-2821-287b-af00ec5f910f@al2klimov.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <9feded75-4b45-2821-287b-af00ec5f910f@al2klimov.de>
Sender: netdev-owner@vger.kernel.org
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, 14 Jun 2020 21:41:17 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> Hello there!
>=20
> At the moment one can't checkout a clean working directory w/o any=20
> changed files on a case-insensitive FS as the following file names have=20
> lower-case duplicates:

They are not duplicates: matching extensions are lowercase, target
extensions are uppercase. DSCP is the extension to set DSCP bits, dscp
is the extension to match on those packet bits.

> =E2=9E=9C  linux git:(96144c58abe7) git ls-files |sort -f |uniq -id
> include/uapi/linux/netfilter/xt_CONNMARK.h
> include/uapi/linux/netfilter/xt_DSCP.h
> include/uapi/linux/netfilter/xt_MARK.h
> include/uapi/linux/netfilter/xt_RATEEST.h
> include/uapi/linux/netfilter/xt_TCPMSS.h
> include/uapi/linux/netfilter_ipv4/ipt_ECN.h
> include/uapi/linux/netfilter_ipv4/ipt_TTL.h
> include/uapi/linux/netfilter_ipv6/ip6t_HL.h
> net/netfilter/xt_DSCP.c
> net/netfilter/xt_HL.c
> net/netfilter/xt_RATEEST.c
> net/netfilter/xt_TCPMSS.c
> tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
> =E2=9E=9C  linux git:(96144c58abe7)
>=20
> Also even on a case-sensitive one VIm seems to have trouble with editing=
=20
> both case-insensitively equal files at the same time.

...what trouble exactly?

> I was going to make a patch renaming the respective duplicates, but I'm=20
> not sure:
>=20
> *Is it a good idea to rename files in include/uapi/ ?*

I'm not sure it's a good idea to even use git on a case-insensitive
filesystem. I'm curious, what is your use case?

--=20
Stefano
