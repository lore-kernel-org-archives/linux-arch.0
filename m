Return-Path: <jpoimboe@redhat.com>
Date: Wed, 23 Oct 2019 17:06:18 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch V2 07/17] x86/entry/64: Remove redundant interrupt disable
Message-ID: <20191023220618.qsmog2k5oaagj27v@treble>
References: <20191023122705.198339581@linutronix.de>
 <20191023123118.296135499@linutronix.de>
MIME-Version: 1.0
In-Reply-To: <20191023123118.296135499@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Miroslav Benes <mbenes@suse.cz>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191023220618.S8Yc86tvJ7dEt_OW9MG7CBJ2449Qq7KHFF9TRG3Uc3M@z>

On Wed, Oct 23, 2019 at 02:27:12PM +0200, Thomas Gleixner wrote:
> Now that the trap handlers return with interrupts disabled, the
> unconditional disabling of interrupts in the low level entry code can be
> removed along with the trace calls.
>=20
> Add debug checks where appropriate.

This seems a little scary.  Does anybody other than Andy actually run
with CONFIG_DEBUG_ENTRY?  What happens if somebody accidentally leaves
irqs enabled?  How do we know you found all the leaks?

--=20
Josh
