From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] restrict /dev/mem to idle io memory ranges
Date: Tue, 24 Nov 2015 14:25:21 -0800
Message-ID: <20151124142521.e6d23e44a8b2c24c044c2dec@linux-foundation.org>
References: <20151124000553.26360.57819.stgit@dwillia2-desk3.jf.intel.com>
	<20151124000604.26360.56945.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55159 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307AbbKXWZW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Nov 2015 17:25:22 -0500
In-Reply-To: <20151124000604.26360.56945.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org

On Mon, 23 Nov 2015 16:06:04 -0800 Dan Williams <dan.j.williams@intel.com> wrote:

> This effectively promotes IORESOURCE_BUSY to IORESOURCE_EXCLUSIVE
> semantics by default.  If userspace really believes it is safe to access
> the memory region it can also perform the extra step of disabling an
> active driver.  This protects device address ranges with read side
> effects and otherwise directs userspace to use the driver.

I don't think I'm sufficiently understanding what this is all needed
for, sorry.  A better changelog would help: what's wrong with the
current code, how you propose it be changed, how the kernel's
externally-visible behaviour is altered, etc.

Please pay particular attention to the back-compatibility issues which
will be encountered when people enable these options.

Perhaps when all that material is described, I'll understand why the
heck we're doing this with a build-time switch rather than a runtime
one...

> Persistent memory presents a large "mistake surface" to /dev/mem as now
> accidental writes can corrupt a filesystem.

Is that the motivation?  root can come in and accidentally alter
persistent memory contents?  If so, 

- why do we care?  There are all sorts of ways in which root can muck
  up the persistent memory, starting with dd(1).  What's special about
  /dev/mem?

- why is the patch mucking with access to PCI and BIOS space?  Is the
  persistent memory even mappable in those regions?  Or is the concern
  that userspace can access control registers associated with the
  persistent memory?  What is the problem scenario?


IOW, a very good description of the problem-being-solved would help out
a lot here...
