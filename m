Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269196AbUIHXHp@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:61328 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269194AbUIHXHp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Sep 2004 19:07:45 -0400
Date: Wed, 8 Sep 2004 16:07:37 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: RFC: being more anal about iospace accesses..
Message-Id: <20040908160737.7c1dfb5a.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org, linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk
List-ID: <linux-arch.vger.kernel.org>


I'm all for this except a possible naming suggestion that
the thing should be called "iomemspace" not plain "iospace".

We already use similar naming distinctions elsewhere in the tree
and even in user visible things such as /proc/ioport /proc/iomem

I wish we could make it fail with the compiler too somehow, that
way people other than us sparse geeks would see and fix this stuff
up.

Anyways, I like this a lot.
