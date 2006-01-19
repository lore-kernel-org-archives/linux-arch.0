Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:53122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161144AbWASB2c (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Jan 2006 20:28:32 -0500
Date: Wed, 18 Jan 2006 17:28:02 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: new syscalls
Message-Id: <20060118172802.5155048f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0601181714330.6878@localhost.localdomain>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05737A9F@scsmsx401.amr.corp.intel.com>
	<20060118133629.1cda96fd.akpm@osdl.org>
	<Pine.LNX.4.63.0601181714330.6878@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Davide Libenzi <davidel@xmailserver.org>
Cc: tony.luck@intel.com, linux-arch@vger.kernel.org, janak@us.ibm.com, drepper@redhat.com, dwmw2@infradead.org, dhowells@redhat.com, christoph@lameter.com
List-ID: <linux-arch.vger.kernel.org>

Davide Libenzi <davidel@xmailserver.org> wrote:
>
> On Wed, 18 Jan 2006, Andrew Morton wrote:
> 
> > "Luck, Tony" <tony.luck@intel.com> wrote:
> >>
> >>> Various new syscalls which are trickling their way Linuswards and will need
> >>> testing and wiring up once they get there:
> >>
> >> Are there test-suites for any/all of these new calls?
> >>
> >
> > That's an excellent point.
> >
> > Guys, architecture maintainers need test suites to verify that the syscalls
> > actually work as they wire them up.  Please share.  A stable URL would be
> > preferred - something which can go into the changlog or conceivably into
> > the kernel source.
> 
> How sophisticated this has to be?

umm

- test basic functionality

- test things which should fail: syscall arguments out-of-bounds,
  negative syscall args, etc.  invalid fd.  valid fd but for the wrong type
  of file.

- if you can, something which will test the 32bit->64bit->32bit
  conversions which 32-bit userspace on 64-bit kernel needs to do.

> And what's the expected ETA?

Well the patch isn't even in -mm yet and you still have an argument to win ;)

Once it's been in -mm for a week or so it'd be nice to have a little test
app please.


> epoll_pwait is really a wrapper around epoll_wait (that did not change at 
> all), so the test in this case should just make sure that the signal 
> behaviour is the one expected.

