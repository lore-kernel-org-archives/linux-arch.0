Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:49551 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759225AbXGYRgV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jul 2007 13:36:21 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20070725172648.GH27237@ftp.linux.org.uk>
References: <20070725172648.GH27237@ftp.linux.org.uk> <21803.1185331847@ocs10w.ocs.com.au> <46A6DB04.3000003@zytor.com> <46A6ECB7.7090208@goop.org> <20070724.232914.56812376.davem@davemloft.net> <alpine.LFD.0.999.0707250954400.3607@woody.linux-foundation.org> <20070725171956.GF27237@ftp.linux.org.uk> <46A786C7.9020604@zytor.com> 
Subject: Re: [PATCH][RFC] getting rid of stupid loop in BUG()
Date: Wed, 25 Jul 2007 18:35:43 +0100
Message-ID: <9602.1185384943@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, jeremy@goop.org, kaos@ocs.com.au, xyzzy@speakeasy.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Al Viro <viro@ftp.linux.org.uk> wrote:

> Where do you see passing &&<label> to assembly?  More interesting question
> is whether gcc believes it to be const...

Passing labels like that to assembly didn't used to work, which is a pity as
we could speed up things like get_user() if it could be made to.

David
