From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2] Add preadv and pwritev system calls.
Date: Fri, 12 Dec 2008 21:02:31 +0100
Message-ID: <4942C357.4060801@redhat.com>
References: <1229090440-32120-1-git-send-email-kraxel@redhat.com> <20081212152929.GM26095@parisc-linux.org> <200812122047.31405.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:37843 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093AbYLLUCr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 12 Dec 2008 15:02:47 -0500
In-Reply-To: <200812122047.31405.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Arnd Bergmann wrote:
> Aside from that, have you considered doing something even more flexible,
> like this?
> 
> struct piovec {
> 	void __user *iov_base;
> 	__kernel_size_t	iov_len;
> 	__kernel_loff_t pos;
> };
> 
> asmlinkage ssize_t sys_pwritev(unsigned long fd,
>                                const struct piovec __user *vec,
>                                unsigned long vlen);

There is little point in doing so because I *really* want the
user-visible API being identical to the existing ones in the *BSD
family.  Anything else is just a PITA for the applications using this.

cheers,
  Gerd
