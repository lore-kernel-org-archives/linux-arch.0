From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] bitops: add _local bitops
Date: Wed, 09 May 2012 07:03:37 -0700
Message-ID: <4FAA7939.6040706@zytor.com>
References: <20120509134528.GA18044@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20120509134528.GA18044@redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Rob Landley <rob@landley.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Akinobu Mita <akinobu.mita@gmail.com>, Alexey Dobriyan <adobriyan@gmail.com>, Herbert Xu <herbert@gondor.hengli.com.au>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On 05/09/2012 06:45 AM, Michael S. Tsirkin wrote:
> kvm needs to update some hypervisor variables atomically
> in a sense that the operation can't be interrupted
> in the middle. However the hypervisor always runs
> on the same CPU so it does not need any memory
> barrier or lock prefix.
> 
> At Peter Anvin's suggestion, add _local bitops for this purpose:
> define them as non-atomics for x86 and (for now) atomics
> for everyone else.
> 
> Uses are not restricted to virtualization: they
> might be useful to communicate with an interrupt
> handler if we know that it's running on the same CPU.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

I don't think you can use the x86 nonatomics as-is, because they don't
contain optimization barriers.

	-hpa

