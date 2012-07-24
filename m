From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 00/13] UAPI header file split
Date: Tue, 24 Jul 2012 14:19:12 +0100
Message-ID: <28702.1343135952@warthog.procyon.org.uk>
References: <CAHO5Pa0NOUk=Z8SNQ9t=Oi6aU96o-JtMuAytAoXJ2v1L0ntNww@mail.gmail.com> <20120720215636.14854.41208.stgit@warthog.procyon.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHO5Pa0NOUk=Z8SNQ9t=Oi6aU96o-JtMuAytAoXJ2v1L0ntNww@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@kernel.org, davej@redhat.com
List-Id: linux-arch.vger.kernel.org

Michael Kerrisk <mtk.manpages@gmail.com> wrote:

> In the uapi-split branch, there are now 44 empty Kbuild files. Was
> that intended? Or, should these files rather be removed by your
> patches?

To be removed by a later patch, I think.  Getting rid of some of them isn't
trivial - ones in arch/x/include/asm/Kbuild for example - because that Kbuild
is referenced by common code IIRC as a function of the arch.

David
