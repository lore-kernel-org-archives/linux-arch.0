Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <11202.1134730942@warthog.cambridge.redhat.com> 
References: <11202.1134730942@warthog.cambridge.redhat.com>  <43A21E55.3060907@yahoo.com.au> <1134560671.2894.30.camel@laptopd505.fenrus.org> <439EDC3D.5040808@nortel.com> <1134479118.11732.14.camel@localhost.localdomain> <dhowells1134431145@warthog.cambridge.redhat.com> <3874.1134480759@warthog.cambridge.redhat.com> <15167.1134488373@warthog.cambridge.redhat.com> <1134490205.11732.97.camel@localhost.localdomain> <1134556187.2894.7.camel@laptopd505.fenrus.org> <1134558188.25663.5.camel@localhost.localdomain> <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain> <20051214033536.05183668.akpm@osdl.org> <15412.1134561432@warthog.cambridge.redhat.com> 
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
Date: Fri, 16 Dec 2005 11:30:01 +0000
Message-ID: <12186.1134732601@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
To: David Howells <dhowells@redhat.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, cfriesen@nortel.com, torvalds@osdl.org, hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells <dhowells@redhat.com> wrote:

> No, they're not. LL/SC is more flexible than CMPXCHG because under some
> circumstances, you can get away without doing the SC,

Of course, CMPXCHG doesn't have to store either, though it still performs a
locked-write-cycle on x86 if I remember correctly.

David
