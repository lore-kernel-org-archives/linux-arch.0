From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH-mm] byteorder: wire up arches to use new headers
Date: Thu, 17 Jul 2008 16:44:51 -0700
Message-ID: <20080717164451.99377cdb.akpm@linux-foundation.org>
References: <1216337353.6029.66.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51298 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754085AbYGQXox (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Jul 2008 19:44:53 -0400
In-Reply-To: <1216337353.6029.66.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: torvalds@linux-foundation.org, linux-arch@vger.kernel.org

On Thu, 17 Jul 2008 16:29:13 -0700
Harvey Harrison <harvey.harrison@gmail.com> wrote:

> Acked-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> ---
> AKPM, this is the arch wire-up, has ack for AVR32, if you want
> one-per-arch, just ask, but this at least gets it out there.

Well there are two approaches

a) one-per-arch.  We merge the base patches and once they're in
   mainline I trickle the per-arch patches out to maintainers.

b) single megapatch.  I gather as many acks as poss them slam it all
   into 2.6.28-rc1.


Option a) is more work and fuss for everyone, but it does produce a
better end result.  People look more closely at the change and it gets
better testing, etc.

Once I get my mm-into-linux-next act together things will be better -
at least the megapatch would be in linux-next and as the
arch maintainers are testing linux-next (rofl) any problems _should_ be
detected.

So, err, umm, looking at the fiddliness of this stuff, yes, I think
one-per-arch would be a little bit better, please.
