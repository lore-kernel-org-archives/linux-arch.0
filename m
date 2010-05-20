Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48539 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752944Ab0ETMGR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 May 2010 08:06:17 -0400
Date: Thu, 20 May 2010 13:12:30 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Prevent reserving RAM in the region already reserved by
  BIOS
Message-ID: <20100520131230.41a99489@lxorguk.ukuu.org.uk>
In-Reply-To: <AANLkTiltANJ9eaGBkfJJOyZ8skCxxOmkAs1UvCLB_YQ9@mail.gmail.com>
References: <AANLkTimwxXtNnmBuDJxg3i72VwWuHmemjrr1iGqj4j8e@mail.gmail.com>
	<4BF42296.1030905@oracle.com>
	<4BF4235D.3080904@zytor.com>
	<AANLkTikYcu6fM3yLoYIZOGZXgsRUfCgJeWS51Sjo-Fny@mail.gmail.com>
	<4BF46D9B.4090806@zytor.com>
	<AANLkTiltANJ9eaGBkfJJOyZ8skCxxOmkAs1UvCLB_YQ9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Rondonneau <mathieu.rondonneau@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Yinghai <yinghai.lu@oracle.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20100520121230.bGUrNdjafgHn99CHHYzhQUiN4V88A68pP8T2W86vESs@z>

On Wed, 19 May 2010 17:01:41 -0700
Mathieu Rondonneau <mathieu.rondonneau@gmail.com> wrote:

> it' s not in ISA space.
> once loading the NVIDIA driver, the warnign oops shows up.
> 4K starting at 0x9f800 (i.e. to 0xa007ff) overlap with the ISA space
> (starting at 0xa0000).

If this is the proprietary Nvidia driver you need to take the matter up
with Nvidia. I assume they are trying to remap chunks of the EBA for some
reason.

And please can you not top post to this list, it makes it very hard to
follow when you are replying in a different order to everyone else.

Alan
