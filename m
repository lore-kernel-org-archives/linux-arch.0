Return-Path: <linux-arch-owner@vger.kernel.org>
From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Date: Sat, 17 Dec 2005 09:22:34 -0800
References: <Pine.LNX.4.64.0512161429500.3698@g5.osdl.org> <20051216.231056.124758189.davem@davemloft.net> <Pine.LNX.4.64.0512162336210.3698@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512162336210.3698@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512170922.34830.jbarnes@virtuousgeek.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, dhowells@redhat.com, nickpiggin@yahoo.com.au, arjan@infradead.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, cfriesen@nortel.com, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Friday, December 16, 2005 11:40 pm, Linus Torvalds wrote:
> Side note: there may be hardware cache protocol _scheduling_ reasons
> why some particular hw platform might prefer to go through the
> "Shared" state in their cache protocol.
>
> For example, you might have hardware that otherwise ends up being
> very unfair, where the two-stage lock aquire might actually allow
> another node to come in at all. Fairness and balance often comes at a
> cost, both in hw and in sw.
>
> Arguably such hardware sounds pretty broken, but the point is that
> these things can certainly depend on the platform around the CPU as
> well as on what the CPU itself does.
>
> I'm not saying that that is necessarily what Jesse was arguing about,
> but lock contention behaviour can be "interesting".

Yeah, that's a good point.  Getting lock behavior 'just right' can get 
pretty platform specific.  For instance, on a CMP type machine, 
bouncing a lock between CPUs can be nearly free, whereas on a large 
directory based machine like the Altix, pretty much any cache line 
write (or fake write like ia64's ld.bias) is an expensive operation 
since it involves lots of relatively slow network activity.

Jesse
