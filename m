From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch] hugetlb: remove dummy definitions of HPAGE_MASK and HPAGE_SIZE
Date: Mon, 21 Nov 2011 15:43:26 -0800
Message-ID: <CA+55aFzSNqCOFuvtEc2V1THVOsOVnz6NOa1U_9p5=Y4E=sj6qg@mail.gmail.com>
References: <1321567050-13197-1-git-send-email-ddaney.cavm@gmail.com>
 <alpine.DEB.2.00.1111171520130.20133@chino.kir.corp.google.com>
 <alpine.DEB.2.00.1111171522131.20133@chino.kir.corp.google.com>
 <4ECACF68.3020701@gmail.com> <CA+55aFwZxqHfEOemj+OJNKCj2toqGf3rkK-9iuS39L7iZsoH1Q@mail.gmail.com>
 <4ECADD83.3090108@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38064 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab1KUXns (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2011 18:43:48 -0500
In-Reply-To: <4ECADD83.3090108@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Daney <ddaney@caviumnetworks.com>
Cc: David Daney <ddaney.cavm@gmail.com>, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <david.daney@cavium.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Robin Holt <holt@sgi.com>

On Mon, Nov 21, 2011 at 3:23 PM, David Daney <ddaney@caviumnetworks.com> wrote:
>
> Ok Linus, for you I would recommend against running this git command on your
> tree:
>
> git grep -E '#define.+BUG\(\);'
>
> It's not like there isn't precedence.

So two wrongs make a right?

I do note that almost all the BUG() ones are in the same broken area:
hugepages. There's something wrong with the development there.

I wish people whose code had stuff like that would take a deep look at it.

                        Linus
