Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:54380 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516AbYDJVzg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Apr 2008 17:55:36 -0400
Received: by wa-out-1112.google.com with SMTP id m16so140140waf.23
        for <linux-arch@vger.kernel.org>; Thu, 10 Apr 2008 14:55:36 -0700 (PDT)
Subject: Re: [PATCH 1/8] kernel: add common infrastructure for unaligned
	access
From: Harvey Harrison <harvey.harrison@gmail.com>
In-Reply-To: <11527.1207863801@redhat.com>
References: <1207856646.22001.25.camel@brick>  <11527.1207863801@redhat.com>
Content-Type: text/plain
Date: Thu, 10 Apr 2008 14:55:37 -0700
Message-ID: <1207864537.22001.47.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20080410215537.6Jno_rTQoCvsiLBMf7eX_e53tI_yZG6ah3J7JQqnov8@z>

On Thu, 2008-04-10 at 22:43 +0100, David Howells wrote:
> Harvey Harrison <harvey.harrison@gmail.com> wrote:
> 
> > +static inline u16 __get_unaligned_le16(const u8 *p)
> > +{
> > +	return (u16)(p[0] | p[1] << 8);
> > +}
> 
> You shouldn't need these casts.  return is going to cast it anyway.
> 
> Actually, you probably _ought_ to have casts, but it should look like this:
> 
> 	return (u16)p[0] | (u16)p[1] << 8;

I've been looking at that thinking I needed something different, I
believe it is ok as u8 will expand to int when shifted... correct?  Or
do I actually need the cast on each p[] term...anyone?

> 
> You are shifting an 8-bit value left by 8 bits, so the compiler may be at
> liberty to instruct the RHS to end up zero.
> 
> I presume the compiler is guaranteed not to merge the two memory accesses?  It
> can't seem to make it do so, though I seem to remember there were cases where
> it did, though I can't reproduce them.  I assume that's why you're passing in
> a u8 pointer and not a u16/u32/u64 pointer.

Yes, that is the reason.  The implementation is nearly identical to the
existing arm version in-tree (minus the register keywords of course).

Harvey

