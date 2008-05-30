From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 05/37] ata: use get/put_endian helpers
Date: Thu, 29 May 2008 20:37:40 -0700
Message-ID: <1212118661.28403.175.camel@brick>
References: <1212092282.28403.107.camel@brick> <483F65CA.4050507@rtr.ca>
	 <20080529195225.5665ae9c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:28011 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbYE3Dhp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 23:37:45 -0400
Received: by wr-out-0506.google.com with SMTP id c48so3707306wra.1
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 20:37:45 -0700 (PDT)
In-Reply-To: <20080529195225.5665ae9c.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Lord <liml@rtr.ca>, linux-arch <linux-arch@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>

On Thu, 2008-05-29 at 19:52 -0700, Andrew Morton wrote:
> On Thu, 29 May 2008 22:26:18 -0400 Mark Lord <liml@rtr.ca> wrote:
> 

> otoh,
> 
> - I think the args are backwards
> 

It was made to look like put_unaligned_* and put_unaligned()

I think of it as put_le16(source, dest)

> - I don't like the use of the put_*() namespace.  It makes it look
>   like a uaccess operation.

I'm flexible...although I'd probably get nailed to a cross for changing
it again so soon. (the unaligned versions, that is)

Harvey
