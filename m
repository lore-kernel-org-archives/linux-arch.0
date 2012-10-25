From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC][PATCH 0/5] tools, perf: Fix up for x86 UAPI disintegration
Date: Thu, 25 Oct 2012 08:57:20 +0100
Message-ID: <8477.1351151840@warthog.procyon.org.uk>
References: <20121024194619.GC17945@liondog.tnic> <20121019165558.23037.40181.stgit@warthog.procyon.org.uk> <20121024184337.GD13993@ghostprotocols.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121024194619.GC17945@liondog.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: dhowells@redhat.com, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Namhyung Kim <namhyung@gmail.com>, mingo@kernel.org, tglx@linutronix.de, davem@davemloft.net, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

Borislav Petkov <bp@alien8.de> wrote:

> David, where can get that x86 UAPI disintegration patch?

The tip tree has it in branch x86/uapi or you can get it from:

	git://git.infradead.org/users/dhowells/linux-headers.git

branch disintegrate-x86 or tag disintegrate-x86-20121009.

I've posted a couple of additional patches to deal with files that became
empty, but they're only for dealing with people who construct their kernel
sources with the patch program.

David
