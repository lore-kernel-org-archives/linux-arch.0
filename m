From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Thu, 29 May 2008 14:53:38 -0700
Message-ID: <200805291453.38492.jbarnes@virtuousgeek.org>
References: <1211852026.3286.36.camel@pasglop> <yq0iqwxrwuh.fsf@jaguar.mkp.net> <1212097223.8888.55.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759730AbYE2VyZ@vger.kernel.org>
In-Reply-To: <1212097223.8888.55.camel@pasglop>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Jes Sorensen <jes@sgi.com>, Roland Dreier <rdreier@cisco.com>, Arjan van de Ven <arjan@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tpiepho@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com, torvalds@linux-foundation.org, David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: linux-arch.vger.kernel.org

On Thursday, May 29, 2008 2:40 pm Benjamin Herrenschmidt wrote:
> On Thu, 2008-05-29 at 10:47 -0400, Jes Sorensen wrote:
> > The only way to guarantee ordering in the above setup, is to either
> > make writel() fully ordered or adding the mmiowb()'s inbetween the two
> > writel's. On Altix you have to go and read from the PCI brige to
> > ensure all writes to it have been flushed, which is also what mmiowb()
> > is doing. If writel() was to guarantee this ordering, it would make
> > every writel() call extremely expensive :-(
>
> Interesting. I've always been taught by ia64 people that mmiowb() was
> intended to be used solely between writel() and spin_unlock().

Well, that *was* true, afaik, but maybe these days multipath isn't just for 
fail-over.  If that's true, then yeah making every single writeX ordered 
would be the only way to go...

> If this is a performance problem, then provide relaxed variants and
> use them in selected drivers.

Sounds reasonable.  That way drivers "just work" and important drivers can be 
optimized.

Jesse
