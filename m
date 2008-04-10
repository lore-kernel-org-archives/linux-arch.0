Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:50153 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756747AbYDJWBJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Apr 2008 18:01:09 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1207864537.22001.47.camel@brick>
References: <1207864537.22001.47.camel@brick> <1207856646.22001.25.camel@brick> <11527.1207863801@redhat.com>
Subject: Re: [PATCH 1/8] kernel: add common infrastructure for unaligned access
Date: Thu, 10 Apr 2008 23:01:04 +0100
Message-ID: <11814.1207864864@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20080410220104.vFSHR0OyWYOEYLFBP-pRx5BB58MMovNvkEhyci7MC2U@z>

Harvey Harrison <harvey.harrison@gmail.com> wrote:

> > Actually, you probably _ought_ to have casts, but it should look like this:
> > 
> > 	return (u16)p[0] | (u16)p[1] << 8;
> 
> I've been looking at that thinking I needed something different, I
> believe it is ok as u8 will expand to int when shifted... correct?  Or
> do I actually need the cast on each p[] term...anyone?

Hmmm... I think you may be right:

	#include <stdio.h>

	int main()
	{
		unsigned char x;
		printf("%u, %u\n", sizeof(x), sizeof(x << 8));
		return 0;
	}

Says:

	1, 4

In which case, the cast you do have is superfluous, and casting the retrievals
is unnecessary.

David
