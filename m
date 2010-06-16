From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH -v18 00/37] Use lmb with x86
Date: Tue, 15 Jun 2010 23:10:45 -0700
Message-ID: <AANLkTinhO5sFs4YRP3nraC_ldZ8ZgzJBOQYYv9jLd_Dw@mail.gmail.com>
References: <1276666966-14259-1-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47875 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756024Ab0FPGL1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 Jun 2010 02:11:27 -0400
In-Reply-To: <1276666966-14259-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Tuesday, June 15, 2010, Yinghai Lu <yinghai@kernel.org> wrote:
>
> =A046 files changed, 1476 insertions(+), 1282 deletions(-)

So what was the advantage again? It's adding more lines than it
removes. Wasn't the point to simplify things, not make them bigger?

      Linus
