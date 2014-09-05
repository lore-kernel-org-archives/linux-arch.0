Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.orcon.net.nz ([219.88.242.59]:54622 "EHLO
	mail.orcon.net.nz" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752457AbaIEUmB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Sep 2014 16:42:01 -0400
Date: Sat, 6 Sep 2014 08:39:51 +1200
From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: bit fields && data tearing
Message-ID: <20140905203951.GA4053@omega>
References: <1409824374.4246.62.camel@pasglop>
 <5408E458.3@zytor.com>
 <54090AF4.7060406@hurleysoftware.com>
 <54091B30.2090509@zytor.com>
 <20140905081648.GB5281@omega>
 <20140905180950.GU5001@linux.vnet.ibm.com>
 <540A05F7.1070202@hurleysoftware.com>
 <20140905190506.GV5001@linux.vnet.ibm.com>
 <8CA974F497CA064FA9926E10ABCC061F05F97E7B77@MAILSJ4.global.cadence.com>
 <540A19B8.4010907@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <540A19B8.4010907@hurleysoftware.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Marc Gauthier <marc@cadence.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Laight <David.Laight@ACULAB.COM>, Jakub Jelinek <jakub@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>
Message-ID: <20140905203951.4eBAluD1o54udGbQjNuFQPeQEwFPeiTWnHnrDkoWV90@z>

On Fri, Sep 05, 2014 at 04:14:48PM -0400, Peter Hurley wrote:
> Second, in the body of the document:
> 
> "The Linux kernel no longer supports pre-EV56 Alpha CPUs, because these
> older CPUs _do not provide_ atomic one-byte and two-byte loads and stores."

Let's be clear here, the pre-EV56 Alpha CPUs do provide an atomic
one-byte and two-byte load and store; it's just that one must use
locked load and store sequences to achieve atomicity.  The point,
I think, is that the pre-EV56 Alpha CPUs provide non-atomic one-byte
and two-byte load and stores as the norm, and that is the problem.

Cheers
Michael.
