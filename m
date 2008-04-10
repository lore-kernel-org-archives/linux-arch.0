Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:15032 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759432AbYDJWG0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Apr 2008 18:06:26 -0400
Received: by wa-out-1112.google.com with SMTP id m16so143360waf.23
        for <linux-arch@vger.kernel.org>; Thu, 10 Apr 2008 15:06:23 -0700 (PDT)
Subject: Re: [PATCH 1/8] kernel: add common infrastructure for unaligned
	access
From: Harvey Harrison <harvey.harrison@gmail.com>
In-Reply-To: <11814.1207864864@redhat.com>
References: <1207864537.22001.47.camel@brick>
	 <1207856646.22001.25.camel@brick> <11527.1207863801@redhat.com>
	 <11814.1207864864@redhat.com>
Content-Type: text/plain
Date: Thu, 10 Apr 2008 15:06:23 -0700
Message-ID: <1207865183.22001.49.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20080410220623.KqE0F43Rzke3tZBwMLqdwmeolUzvd-DVqXn5vZ_7HOo@z>

On Thu, 2008-04-10 at 23:01 +0100, David Howells wrote:
> Harvey Harrison <harvey.harrison@gmail.com> wrote:
> 
> > > Actually, you probably _ought_ to have casts, but it should look like this:
> > > 
> > > 	return (u16)p[0] | (u16)p[1] << 8;
> > 
> > I've been looking at that thinking I needed something different, I
> > believe it is ok as u8 will expand to int when shifted... correct?  Or
> > do I actually need the cast on each p[] term...anyone?
> 
> Hmmm... I think you may be right:
> 
> 	#include <stdio.h>
> 
> 	int main()
> 	{
> 		unsigned char x;
> 		printf("%u, %u\n", sizeof(x), sizeof(x << 8));
> 		return 0;
> 	}
> 
> Says:
> 
> 	1, 4
> 
> In which case, the cast you do have is superfluous, and casting the retrievals
> is unnecessary.

Expands to int, not unsigned int, I think that cast is still needed?

Harvey

