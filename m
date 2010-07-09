From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/23] lmb: Print new doubled array location info
Date: Fri, 09 Jul 2010 16:19:46 +1000
Message-ID: <1278656386.28659.130.camel@pasglop>
References: <1278226587-31213-1-git-send-email-yinghai@kernel.org>
	 <1278226587-31213-4-git-send-email-yinghai@kernel.org>
	 <201007081255.58049.bjorn.helgaas@hp.com>  <4C36300A.7030606@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C36300A.7030606@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


> We can make them to be consistent later.
> 
> current for early mem stage, it is consistent to without -1.
> 
> later I like to see all pci resource could be consistent to without -1 too.

No. You won't change what is the de-facto standard all over the kernel
to make it consistent with x86 crap.

-1 is the right way to print those things.

Ben.
