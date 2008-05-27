From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 27 May 2008 15:23:51 -0600
Message-ID: <483C7BE7.10204@nortel.com>
References: <1211852026.3286.36.camel@pasglop> <20080526.184047.88207142.davem@davemloft.net> <1211854540.3286.42.camel@pasglop> <20080526.192812.184590464.davem@davemloft.net> <20080526204233.75b71bb8@infradead.org>	<1211872130.3286.64.camel@pasglop> <adaprr721c6.fsf@cisco.com> <1211906268.3435.44.camel@localhost.localdomain> <adad4n71wb3.fsf@cisco.com> <1211910825.7160.1.camel@localhost.localdomain> <adamymbvcxi.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759563AbYE0VYV@vger.kernel.org>
In-Reply-To: <adamymbvcxi.fsf@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roland Dreier <rdreier@cisco.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org, scottwood@freescale.com, torvalds@linux-foundation.org, tpiepho@freescale.com, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-arch.vger.kernel.org

Roland Dreier wrote:

> Writes are posted yes, but not reordered arbitrarily.  If I have code like:
> 
> 	spin_lock(&mmio_lock);
> 	writel(val1, reg1);
> 	writel(val2, reg2);
> 	spin_unlock(&mmio_lock);
> 
> then I have a reasonable expectation that if two CPUs run this at the
> same time, their writes to reg1/reg2 won't be interleaved with each
> other (because the whole section is inside a spinlock).  And Altix
> violates that expectation.

Does that necessarily follow?

If you've got a large system with multiple pci bridges, could you end up 
with posted writes coming from different cpus taking a different amount 
of time to propagate to a device and thus colliding?

Chris
