Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:26674 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbYDJWU6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Apr 2008 18:20:58 -0400
Received: by wr-out-0506.google.com with SMTP id c48so224540wra.1
        for <linux-arch@vger.kernel.org>; Thu, 10 Apr 2008 15:20:46 -0700 (PDT)
Subject: Re: [PATCH 1/8] kernel: add common infrastructure for unaligned
	access
From: Harvey Harrison <harvey.harrison@gmail.com>
In-Reply-To: <11907.1207865758@redhat.com>
References: <1207865183.22001.49.camel@brick>
	 <1207864537.22001.47.camel@brick> <1207856646.22001.25.camel@brick>
	 <11527.1207863801@redhat.com> <11814.1207864864@redhat.com>
	 <11907.1207865758@redhat.com>
Content-Type: text/plain
Date: Thu, 10 Apr 2008 15:20:46 -0700
Message-ID: <1207866046.22001.53.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20080410222046.svNnMRvoTpFJb_Vc-YzR23LUvy_5h1pXKp2sjklCCWk@z>

On Thu, 2008-04-10 at 23:15 +0100, David Howells wrote:
> Harvey Harrison <harvey.harrison@gmail.com> wrote:
> 
> > Expands to int, not unsigned int, I think that cast is still needed?
> 
> What for?  The return is going to do the same cast anyway because of the
> function return type.
> 
> David

Well, for the u16 case, won't the compiler warn about truncating the
return if I return an int when the function returns u16?

In the u64 case, I need the cast to ensure it expands to u64 rather than
int from the shift.  Agreed in the u32 case, but then it looks different
than the u16/u64 case (cargo-cult I know, but nice for consistency).

Harvey

