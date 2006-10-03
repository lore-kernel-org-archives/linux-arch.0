Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.226]:53065 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965545AbWJCAg4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Oct 2006 20:36:56 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1863728wxc
        for <linux-arch@vger.kernel.org>; Mon, 02 Oct 2006 17:36:56 -0700 (PDT)
Message-ID: <21d7e9970610021736s2335a04ap42f3b5bf961cb704@mail.gmail.com>
Date: Tue, 3 Oct 2006 10:36:53 +1000
From: "Dave Airlie" <airlied@gmail.com>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
In-Reply-To: <Pine.LNX.4.64.0610021349090.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
	 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
	 <20061002132116.2663d7a3.akpm@osdl.org>
	 <20061002201836.GB31365@elte.hu>
	 <Pine.LNX.4.64.0610021349090.3952@g5.osdl.org>
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, Alan Stern <stern@rowland.harvard.edu>
List-ID: <linux-arch.vger.kernel.org>

>
> Things like the kernel graphics direct-rendering code, for example -
> mostly maintained in X.org trees that then want to compile with other
> kernels too.

Well in the DRM case we don't worry about that too much, the external
DRM git tree has all the compat code hidden away and I've got lots of
version check macros, so one more won't make a difference, the in-tree
version has none of the that stuff anyways....

Now it might break nvidia and ATI but that is all code that is in
their "public" source...

Dave.
