From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Software prefetching considered harmful
Date: Thu, 19 May 2011 12:38:40 -0700
Message-ID: <BANLkTi=0N55+mQjE1gq8DHdoQ0GU0A7kLw@mail.gmail.com>
References: <BANLkTim5MaJBYSuTnXfmOjgPNVOyZSgQuQ@mail.gmail.com>
 <BANLkTi=428+KWmDcHoFYs5gO_C9wyhxJnQ@mail.gmail.com> <20110519.153259.1670240855485459381.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44976 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934417Ab1ESTjc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 May 2011 15:39:32 -0400
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p4JJd2Fg027932
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <linux-arch@vger.kernel.org>; Thu, 19 May 2011 12:39:03 -0700
Received: by ewy4 with SMTP id 4so965186ewy.19
        for <linux-arch@vger.kernel.org>; Thu, 19 May 2011 12:39:00 -0700 (PDT)
In-Reply-To: <20110519.153259.1670240855485459381.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, mingo@elte.hu, benh@kernel.crashing.org, rmk@arm.linux.org.uk

On Thu, May 19, 2011 at 12:32 PM, David Miller <davem@davemloft.net> wrote:
>
> It's been my experience that prefetch hurts more than it ever helps
> for these list traversal functions.
>
> In fact I had been looking at some assembler output for files in the
> networking and noticed how all of these list prefetch turds just take
> up I-cache space.
>
> Please kill them off, you have my utmost support :-)

Hmm. Networking tends to use both hlist and regular lists. Does it go
for both for you, or is one or the other more of an issue?

                       Lius
