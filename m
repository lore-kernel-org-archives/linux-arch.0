From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCHv4 3/6] byteorder: add get/put endian helpers for the
	aligned case
Date: Fri, 30 May 2008 12:09:46 -0700
Message-ID: <1212174586.28403.204.camel@brick>
References: <Pine.LNX.4.44L0.0805301452270.18142-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:41419 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbYE3TJt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 15:09:49 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2599143ywe.1
        for <linux-arch@vger.kernel.org>; Fri, 30 May 2008 12:09:48 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.0805301452270.18142-100000@netrider.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>

On Fri, 2008-05-30 at 15:05 -0400, Alan Stern wrote:
> On Thu, 29 May 2008, Harvey Harrison wrote:
> 
> > Add a set of endian helpers for the pattern:
> > *(__le16 *)ptr = cpu_to_le16(val);
> > 
> > put_le16(val, (__le16 *)ptr);
> > 
> > The argument order follows that of the get/put_unaligned_{endian}
> > helpers.
> > 
> > The get_ helpers are exactly equivalent to the existing {endian}_to_cpup
> > functions, but have been added anyway for symmetry in the apis.
> > 
> > Myrinet had a put_be32 helper that has been changed to myri_put_be32 to
> > avoid namespace collisions.
> > 
> > Private helpers in the usb-gadget drivers have been removed and switched
> > over to the common ones.  Note that the put helpers here had the args in
> > the opposite order from the common version.
> 

Sorry about that, it completely went out of my head that the usb-helper 
was ok for unaligned access...I do know better.

I'll send a patch that move the unaligned ones over to the unaligned
access api and the aligned cases to be32_to_cpup and resend shortly.

Harvey
