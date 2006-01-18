Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:2959 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161019AbWARVxO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Jan 2006 16:53:14 -0500
Subject: Re: new syscalls
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20060118133629.1cda96fd.akpm@osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05737A9F@scsmsx401.amr.corp.intel.com>
	 <20060118133629.1cda96fd.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 08:53:07 +1100
Message-Id: <1137621188.30084.67.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-arch@vger.kernel.org, JANAK DESAI <janak@us.ibm.com>, Ulrich Drepper <drepper@redhat.com>, David Howells <dhowells@redhat.com>, Davide Libenzi <davidel@xmailserver.org>, Christoph Lameter <christoph@lameter.com>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2006-01-18 at 13:36 -0800, Andrew Morton wrote:
> That's an excellent point.
> 
> Guys, architecture maintainers need test suites to verify that the syscalls
> actually work as they wire them up.  Please share.  A stable URL would be
> preferred - something which can go into the changlog or conceivably into
> the kernel source.

http://david.woodhou.se/sigmasking.c is a good one for testing
sigsuspend after hooking up TIF_RESTORE_SIGMASK stuff and the generic
sys_rt_sigsuspend(), although it's not actually my code. There were a
bunch of other tests in a tarball with that (on linux-arch a year or two
ago) which arch maintainers should also use occasionally when they play
with signal or ptrace code.

When I get back home I'll tidy up and publish the hacks I used for
testing pselect() and ppoll() so that those can be tested without
actually rebuilding glibc.

-- 
dwmw2

