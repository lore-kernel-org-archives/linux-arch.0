Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267231AbUHZAbs@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:25985 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267251AbUHZAbK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 20:31:10 -0400
Date: Wed, 25 Aug 2004 17:34:31 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/8] signal handling race fix
Message-Id: <20040825173431.379bc000.akpm@osdl.org>
In-Reply-To: <20040825165438.558b60c3.davem@redhat.com>
References: <200408252140.i7PLeL131496@mail.osdl.org>
	<Pine.LNX.4.58.0408251536360.17766@ppc970.osdl.org>
	<20040825164900.727422e1.akpm@osdl.org>
	<20040825165438.558b60c3.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org, minyard@acm.org
List-ID: <linux-arch.vger.kernel.org>

"David S. Miller" <davem@redhat.com> wrote:
>
> > OK, I edited all the diffs.  I'll let this cook for a bit longer.
> 
> Andrew please no, this bug fix has been gathering dust long
> enough. :-)  I remember seeing the first version of it half
> a year ago.

OK.  It compiles on three architectures..
