From: Michal Simek <michal.simek@petalogix.com>
Subject: Microblaze arch merging
Date: Tue, 17 Mar 2009 10:01:30 +0100
Message-ID: <49BF66EA.9030101@petalogix.com>
Reply-To: michal.simek@petalogix.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:62672 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbZCQJBg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Mar 2009 05:01:36 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-next@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, lkml <linux-arch@vger.kernel.org>

Hi Stephen and others,

I am preparing first pack for Microblaze CPU (If you want to review I
can send bunch of patches very soon).
This pack was reviewed in past on LKML and of course I have done some
changes there and move to latest kernel code.

Could you tell me what the right way is for adding to Microblaze code to
linux-next for testing and merging?
I don't expect that microblaze code break any other arch because all the
code is in arch/microblaze folder + some minor changes in
Kconfig for drivers.

We have ready git server for pushing too.
What is the best way for you? Code based on current linus-head on based
on linux-next?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
