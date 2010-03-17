From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 64-syscall args on 32-bit vs syscall()
Date: Thu, 18 Mar 2010 07:35:34 +1100
Message-ID: <1268858134.2335.198.camel@pasglop>
References: <20100315134449.GB1653@linux-mips.org>
	 <4B9E4EB1.9010800@zytor.com>	<4B9E59B7.6060405@redhat.com>
	 <20100315.120004.209998642.davem@davemloft.net>
	 <4B9E8D67.8040209@zytor.com>  <1268685311.2335.38.camel@pasglop>
	 <1268776570.19726.98.camel@spokane1.rchland.ibm.com>
	 <1268785874.2335.137.camel@pasglop>  <4BA06E1B.2040706@redhat.com>
	 <1268816179.2335.187.camel@pasglop>  <4BA11FD2.2090104@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51678 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754648Ab0CQUg5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Mar 2010 16:36:57 -0400
In-Reply-To: <4BA11FD2.2090104@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ulrich Drepper <drepper@redhat.com>, munroesj@us.ibm.com, David Miller <davem@davemloft.net>, ralf@linux-mips.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@teksavvy.com, torvalds@linux-foundation.org

On Wed, 2010-03-17 at 11:30 -0700, H. Peter Anvin wrote:
> Again, this is *exactly* symbol versioning done by hand... we have 
> proper symbol versioning, let's use it.

Yeah, whatever, I don't mind what technique you use for the versionning,
ultimately, if the approach works, we can look at those details :-) We
-do- need the macro to strip the dummy argument though, unless we use
a slightly different technique which is to make the __sysno argument
itself 64-bit, which works as well I believe.

Cheers,
Ben.
