Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269338AbUIIEhJ@vger.kernel.org>
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:33665
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269334AbUIIEhJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Sep 2004 00:37:09 -0400
Date: Wed, 8 Sep 2004 21:36:58 -0700
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: RFC: being more anal about iospace accesses..
Message-Id: <20040908213658.6865a4e2.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0409081611550.5912@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	<20040908160737.7c1dfb5a.davem@redhat.com>
	<Pine.LNX.4.58.0409081611550.5912@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org, linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Wed, 8 Sep 2004 18:19:08 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> On Wed, 8 Sep 2004, David S. Miller wrote:
> > 
> > I wish we could make it fail with the compiler too somehow, that
> > way people other than us sparse geeks would see and fix this stuff
> > up.
> 
> I don't want to break a stable release too much. As-is, the _code_ 
> generated should be 100% the same, even if gcc complains. So afaik, my 
> patch is very safe indeed, which I like.

Agreed.  I wish GCC had a way to define a type which is offsetable
yet not an "int".  Surprise surprise, that works out to be your
address space thing in sparse. :)
