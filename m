From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] bitops: add _local bitops
Date: Wed, 09 May 2012 12:23:30 -0700
Message-ID: <4FAAC432.5080503@zytor.com>
References: <20120509134528.GA18044@redhat.com> <20120509121940.459e93ba.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20120509121940.459e93ba.akpm@linux-foundation.org>
Sender: linux-doc-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Rob Landley <rob@landley.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Akinobu Mita <akinobu.mita@gmail.com>, Alexey Dobriyan <adobriyan@gmail.com>, Herbert Xu <herbert@gondor.hengli.com.au>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On 05/09/2012 12:19 PM, Andrew Morton wrote:
> 
> Secondly: can KVM just use __set_bit() and friends?  I suspect those
> interfaces happen to meet your requirements.  At least on architectures
> you care about.
> 

__set_bit() and friends right now don't have optimization barriers,
meaning the compiler is free to move them around.

	-hpa
