Return-Path: <linux-arch-owner@vger.kernel.org>
From: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: Re: [PATCH] ?mb() -> smp_?mb() conversion
Date: Tue, 22 Mar 2005 10:09:09 -0800
References: <20050322163428.GD21986@parcelfarce.linux.theplanet.co.uk> <20050322091331.7b2967a1.davem@davemloft.net> <1111513463.5520.53.camel@mulgrave>
In-Reply-To: <1111513463.5520.53.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503221009.10046.jbarnes@engr.sgi.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Howells <dhowells@redhat.com>, matthew@wil.cx, anton@samba.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tuesday, March 22, 2005 9:44 am, James Bottomley wrote:
> As an aside, the main ordering problem it prevents is the SMP one where
> two CPUs do writes into the PCI domain that they order with spinlocks.
> Even though, temporally, the writes are sequenced leaving the CPUs, the
> altix PCI domain can still re-order them if the mmiowb() isn't present
> (so it sounds like it's really a smp_mmiowb()...)

Correct.  And it's necessary because spin_unlock* don't do any I/O ordering by 
default (in fact they're only one way memory barriers on alpha and ia64 
iirc).

Jesse
