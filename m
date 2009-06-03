From: David VomLehn <dvomlehn@cisco.com>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
	the Kernel Summit
Date: Tue, 2 Jun 2009 17:03:12 -0700
Message-ID: <20090603000312.GA21055@cuplxvomd02.corp.sa.net>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <20090602172941.GL3095@hansolo.jdub.homelinux.org> <1243964577.4229.49.camel@mulgrave.int.hansenpartnership.com> <20090602175244.GB10973@cuplxvomd02.corp.sa.net> <20090602185143.GA8655@zod.rchland.ibm.com> <4A257DF0.6040607@am.sony.com> <1243975064.6342.10.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sj-iport-6.cisco.com ([171.71.176.117]:50586 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbZFCADK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jun 2009 20:03:10 -0400
Content-Disposition: inline
In-Reply-To: <1243975064.6342.10.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Tim Bird <tim.bird@am.sony.com>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, linux-arch@vger.kernel.org, ksummit-2009-discuss@lists.linux-foundation.org, linux-embedded@vger.kernel.org

On Tue, Jun 02, 2009 at 03:37:44PM -0500, James Bottomley wrote:
...
> This is what made us suggest the presentation driven approach.  We can
> send people who understand how the kernel development process out
> anointed as embedded maintainers.  However, looking at the arch
> directory, you have a ton of new kids on the block.  We wondered if,
> perhaps, rather than having seasoned kernel developers reach out to the
> embedded community, we might try giving the embedded community the
> opportunity to reach out to us.  The topic of "flattened device tree"
> look interesting to me (perhaps because I'm a hardened device driver
> person and things like that always look interesting to me) ... if we can
> get a few more like that out of the woodwork, this approach might end up
> being successful.

Failure reporting is the one area where embedded applications have
little overlap with other Linux application domains. The cable settop box
environment has:
o Limited peristent storage
o Low or no upstream bandwidth
o Little access to hundreds of thousands of devices in the field

When a kernel panics in the field, we have no place to put a core dump
and, if we had a place to put it, it would take way too long to upload
it when the box comes back up. And most people just don't understand when
you knock at their door at midnight, JTAG probe in hand.

We hook in a panic notifier and have it generate a really rich report.
At present, this report stays in memory until we reboot and send it
upstream (or write it to flash), but we could really write it to any
device with which we can use polled I/O (interrupts being questionable
at this point). Generic interfaces to support this would be useful.

Many embedded devices have highly integrated stacks, so failures in user
space lead to device reboots, and you want to leverage much of the same
ability to store and send failure reports.

Our failure report includes things you'd expect as well as various pieces
of history, such as:
o IRQs
o softirq dispatches (including max times)
o selected /proc info, e.g. /proc/meminfo

We also report info on the current thread, like backtracing and
/proc/<pid>/maps, though I'm not sure it's as useful as it might be.

Though I'm working on pushing this stuff out, other things that might be
helpful are:
o If you get to panic() by way of die(), you've lost the registers passed to
  die(). We save a pointer off, but it's really a kludge.
o The implementation of die() varies from platform to platform and isn't even
  called die() everywhere.
o It is truly nasty trying to get /proc information when you are in a panic
  situation--any semaphores being held are not going to be released, so you
  have to duplicate a lot of the code, minus the semaphores. Pretty gross
  and there is no way our implementation will be acceptable.
o Increased reporting on what's happening in user/kernel space interaction.
  For example, a signal sent in good faith might kill a buggy process. It
  would be helpful to log signals that result in a process' death.
o Then there is more speculative stuff. For example, your caches would
  have a copy of the most recently accessed code and data.  If your
  processor supports dumping cache, it might help determing what went wrong.

> James
