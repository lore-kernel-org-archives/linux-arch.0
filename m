From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 08/29] Disintegrate asm/system.h for C6X
Date: Wed, 07 Mar 2012 22:42:19 +0000
Message-ID: <20518.1331160139@redhat.com>
References: <1331156636.12805.18.camel@deneb.redhat.com> <1331155726.12805.16.camel@deneb.redhat.com> <20120307194548.15987.36073.stgit@warthog.procyon.org.uk> <20120307194725.15987.99209.stgit@warthog.procyon.org.uk> <18700.1331156191@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1331156636.12805.18.camel@deneb.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: dhowells@redhat.com, paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org, sfr@canb.auug.org.au, mingo@redhat.com, arnd@arndb.de, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Mark Salter <msalter@redhat.com> wrote:

> Kbuild takes care of it. See arch/c6x/include/Kbuild for the generic
> headers C6X uses as-is.

I'm still not clear on how that actually works.  Does it copy the headers to
asm/ from asm-generic/?

David
