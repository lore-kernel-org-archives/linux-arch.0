From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v5] arm: Preserve the user r/w register TPIDRURW on
	context switch and fork
Date: Fri, 7 Jun 2013 21:28:18 +0100
Message-ID: <20130607202818.GB18614@n2100.arm.linux.org.uk>
References: <519D32E2.5050102@dawncrow.de> <51B22F01.3030905@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39098 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755868Ab3FGU21 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2013 16:28:27 -0400
Content-Disposition: inline
In-Reply-To: <51B22F01.3030905@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonathan Austin <jonathan.austin@arm.com>
Cc: =?iso-8859-1?Q?Andr=E9?= Hentschel <nerv@dawncrow.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Will Deacon <Will.Deacon@arm.com>

On Fri, Jun 07, 2013 at 08:05:37PM +0100, Jonathan Austin wrote:
> If you're using git-format-patch and git-send-email then the main point  
> to note is the need to add the KernelVersion: tag described in that  
> documentation and also that Russell doesn't want '[Patch]' tags in  
> subject lines.

The main thing is the kernelversion: tag, which can appear anywhere before
the patch diff itself.  [PATCH] stuff in the subject line is ignored and
removed.

> There's a form for creating yourself an account on the patch system at  
> http://www.arm.linux.org.uk/developer/patches/add.php - I'm not actually  
> sure that an account is necessary to submit via email - but I *do* have  
> one and I've only ever used email so I suspect it might be!

Yes, the system automatically creates an "account" on the initial email -
it's not really an "account" from the email side, but just a name/email
association with the patch itself, which can then be "converted" to an
"account" for the website by the addition of a password.
