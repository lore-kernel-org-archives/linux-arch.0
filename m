From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 17/35] Make asm-generic/cmpxchg.h #include
	asm-generic/cmpxchg-local.h [ver #2]
Date: Mon, 19 Mar 2012 10:51:27 +0000
Message-ID: <4913.1332154287@redhat.com>
References: <1331746607.5104.93.camel@jerome.southpole.se>
	<1331738610.5104.84.camel@jerome.southpole.se>
	<1331736182.5104.74.camel@jerome.southpole.se>
	<CACM3HyHaFqVBaALMNB9dTE+7JrT1qD0jrYtV2PzwTskv8sW4Hg@mail.gmail.com>
	<20120312233602.13888.27659.stgit@warthog.procyon.org.uk>
	<20120312233858.13888.34822.stgit@warthog.procyon.org.uk>
	<201203130900.41993.arnd@arndb.de>
	<11556.1331723400@redhat.com> <18016.1331738258@redhat.com>
	<21309.1331744879@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
In-Reply-To: <1331746607.5104.93.camel@jerome.southpole.se>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux@openrisc.net, linux-kernel@vger.kernel.org, dhowells@redhat.com, paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Jonas Bonn <jonas@southpole.se> wrote:

> or32-linux is supported in the toolchain from openrisc.net.  Likewise
> or32-elf... follow the instructions (the easy ones should work) on the
> link I sent you -- the submodules in the "toolchain" repo are from the
> openrisc git repo and contain everything that is needed.

I would like to include support as part of my mass-build cross-compiler RPMs.
Do you have patches anywhere against upstream binutils and gcc that I might
apply to mine?

David
