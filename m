From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCHv2] bitops: add _local bitops
Date: Sun, 13 May 2012 13:13:21 +0300
Message-ID: <4FAF8941.2010308@redhat.com>
References: <20120509162819.GA21328@redhat.com> <alpine.DEB.2.00.1205101401010.18664@router.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47724 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722Ab2EMKNv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 13 May 2012 06:13:51 -0400
In-Reply-To: <alpine.DEB.2.00.1205101401010.18664@router.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Rob Landley <rob@landley.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Akinobu Mita <akinobu.mita@gmail.com>, Alexey Dobriyan <adobriyan@gmail.com>, Herbert Xu <herbert@gondor.hengli.com.au>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On 05/10/2012 10:04 PM, Christoph Lameter wrote:
> On Wed, 9 May 2012, Michael S. Tsirkin wrote:
>
> > kvm needs to update some hypervisor variables atomically
> > in a sense that the operation can't be interrupted
> > in the middle. However the hypervisor always runs
> > on the same CPU so it does not need any memory
> > barrier or lock prefix.
> >
> > Add _local bitops for this purpose: define them
> > as non-atomics for x86 and (for now) atomics for
> > everyone else.
>
> Have you tried to use the this_cpu_ops for that purpose? They create the
> per cpu atomic instructions that you want without a lock prefix and can
> also relocate the per cpu pointer to the correct processor via a
> segment register prefix.
>
> There are no bit operations provided right now but those can either be
> improvised using this_cpu_cmpxchg or added.

this_cpu_xchg() should be sufficient, since only bit zero has any
meaning in our use case (so xchg with zero is equivalent to
test_and_clear_bit).


-- 
error compiling committee.c: too many arguments to function
