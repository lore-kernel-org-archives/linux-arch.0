Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050322163428.GD21986@parcelfarce.linux.theplanet.co.uk> 
References: <20050322163428.GD21986@parcelfarce.linux.theplanet.co.uk>  <20050321150619.2ea75257.davem@davemloft.net> <20050321225904.GF23908@krispykreme> <20072.1111488229@redhat.com> <20050322131316.GC21986@parcelfarce.linux.theplanet.co.uk> <20050322160324.GA4980@krispykreme> 
Subject: Re: [PATCH] ?mb() -> smp_?mb() conversion 
Date: Tue, 22 Mar 2005 16:48:14 +0000
Message-ID: <11333.1111510094@redhat.com>
Sender: dhowells@redhat.com
To: Matthew Wilcox <matthew@wil.cx>
Cc: Anton Blanchard <anton@samba.org>, "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Matthew Wilcox <matthew@wil.cx> wrote:

>  - io_*mb() are equivalent, for io memory.

I don't think these actually exist at the moment. My suggestion was that we
rename {r,w,}mb() to io_{r,w,}mb().

David
