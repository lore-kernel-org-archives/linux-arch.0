Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269356AbUIIF4z@vger.kernel.org>
Received: from are.twiddle.net ([64.81.246.98]:34945 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S269353AbUIIF4z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Sep 2004 01:56:55 -0400
Date: Wed, 8 Sep 2004 22:56:42 -0700
From: Richard Henderson <rth@twiddle.net>
Subject: Re: RFC: being more anal about iospace accesses..
Message-ID: <20040909055642.GA1084@twiddle.net>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <20040908160737.7c1dfb5a.davem@redhat.com> <Pine.LNX.4.58.0409081611550.5912@ppc970.osdl.org> <20040908213658.6865a4e2.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908213658.6865a4e2.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org, linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Wed, Sep 08, 2004 at 09:36:58PM -0700, David S. Miller wrote:
> Agreed.  I wish GCC had a way to define a type which is offsetable
> yet not an "int".

Some people might claim you want to be programming in Ada.  ;-)


r~
