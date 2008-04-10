Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:41144 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477AbYDJWiK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Apr 2008 18:38:10 -0400
Received: by wr-out-0506.google.com with SMTP id c48so232187wra.1
        for <linux-arch@vger.kernel.org>; Thu, 10 Apr 2008 15:38:03 -0700 (PDT)
Subject: Re: [PATCH 1/8] kernel: add common infrastructure for unaligned
	access
From: Harvey Harrison <harvey.harrison@gmail.com>
In-Reply-To: <11989.1207866793@redhat.com>
References: <1207866046.22001.53.camel@brick>
	 <1207865183.22001.49.camel@brick> <1207864537.22001.47.camel@brick>
	 <1207856646.22001.25.camel@brick> <11527.1207863801@redhat.com>
	 <11814.1207864864@redhat.com> <11907.1207865758@redhat.com>
	 <11989.1207866793@redhat.com>
Content-Type: text/plain
Date: Thu, 10 Apr 2008 15:37:59 -0700
Message-ID: <1207867079.22001.60.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20080410223759.GMGnxlQaOL23I7qx3wEPzqclm_6J2x-i8BbMuLqXrRU@z>

On Thu, 2008-04-10 at 23:33 +0100, David Howells wrote:
> Harvey Harrison <harvey.harrison@gmail.com> wrote:
> 
> > Well, for the u16 case, won't the compiler warn about truncating the
> > return if I return an int when the function returns u16?
> 
> It doesn't for me for:
> 
> 	u16 test(const u8 *p)
> 	{
> 		return (u16) (p[0] | p[1] << 8);
> 	}
> 
> > In the u64 case, I need the cast to ensure it expands to u64 rather than
> > int from the shift.  Agreed in the u32 case, but then it looks different
> > than the u16/u64 case (cargo-cult I know, but nice for consistency).
> 
> Agreed, the u64 cast is necessary, but I was talking about casts generally of:
> 
> 	<TYPE> function(...)
> 	{
> 		return (<TYPE>) (...);
> 	}
> 

OK, I'll see what other comments come in and keep it in mind for the
next iteration.  I'll also move frv over to the generic C code in that
submission as we discussed.

Harvey

