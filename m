Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:34684 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758874AbYDJVnn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Apr 2008 17:43:43 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1207856646.22001.25.camel@brick>
References: <1207856646.22001.25.camel@brick>
Subject: Re: [PATCH 1/8] kernel: add common infrastructure for unaligned access
Date: Thu, 10 Apr 2008 22:43:21 +0100
Message-ID: <11527.1207863801@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20080410214321.nsdfXa3dW1SHgaAEdo7WOnkbsOZZaKzv71Y1-uLIj7Y@z>

Harvey Harrison <harvey.harrison@gmail.com> wrote:

> +static inline u16 __get_unaligned_le16(const u8 *p)
> +{
> +	return (u16)(p[0] | p[1] << 8);
> +}

You shouldn't need these casts.  return is going to cast it anyway.

Actually, you probably _ought_ to have casts, but it should look like this:

	return (u16)p[0] | (u16)p[1] << 8;

You are shifting an 8-bit value left by 8 bits, so the compiler may be at
liberty to instruct the RHS to end up zero.

I presume the compiler is guaranteed not to merge the two memory accesses?  It
can't seem to make it do so, though I seem to remember there were cases where
it did, though I can't reproduce them.  I assume that's why you're passing in
a u8 pointer and not a u16/u32/u64 pointer.

David
