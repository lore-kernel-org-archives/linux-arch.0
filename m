From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 2 Jun 2009 12:46:11 -0600
Message-ID: <fa686aa40906021146o42a9412ta1ea7c724655c80@mail.gmail.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
	<fa686aa40906021029macf3c72g5261f8d4dbea935a@mail.gmail.com>
	<20090602174538.GA10973@cuplxvomd02.corp.sa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:50552 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbZFBSq3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jun 2009 14:46:29 -0400
In-Reply-To: <20090602174538.GA10973@cuplxvomd02.corp.sa.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David VomLehn <dvomlehn@cisco.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Tim Bird <tim.bird@am.sony.com>

On Tue, Jun 2, 2009 at 11:45 AM, David VomLehn <dvomlehn@cisco.com> wrote:
> Should we decide to go this way, there probably a next step wherein we
> standardize the device tree entries for those devices that are shared across
> multiple architectures and platorms. This will likely be a never-ending
> and mostly thankless task, but will again make things easier in the long run.

devicetree-discuss@ozlabs.org mailing list is your friend here.  In
PowerPC land we've mostly settled on the policy of not merging a
driver before the device tree binding is documented, posted and
reviewed.  This weeds out a lot of common mistakes.

I also think the stuff in Documentation/powerpc/dts-bindings needs to
be moved out to a common location.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
