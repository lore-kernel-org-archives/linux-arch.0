From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] bitops: add _local bitops
Date: Wed, 09 May 2012 13:10:04 -0700
Message-ID: <4FAACF1C.2060504@zytor.com>
References: <20120509134528.GA18044@redhat.com> <20120509121940.459e93ba.akpm@linux-foundation.org> <20120509200735.GA22743@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20120509200735.GA22743@redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rob Landley <rob@landley.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Akinobu Mita <akinobu.mita@gmail.com>, Alexey Dobriyan <adobriyan@gmail.com>, Herbert Xu <herbert@gondor.hengli.com.au>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On 05/09/2012 01:07 PM, Michael S. Tsirkin wrote:
> 
> In practice ATM any of the above will work. We probably don't even need
> to add barrier() calls since what we do afterwards is apic access which
> has an optimization barrier anyway.  But I'm fine with adding them in
> there just in case if that's what people want.
> 

If you have the optimization barrier anyway, then I'd be fine with you
just using __test_and_clear_bit() and add to a comment in
arch/x86/include/asm/bitops.h that KVM needs it to be locally atomic.

	-hpa
