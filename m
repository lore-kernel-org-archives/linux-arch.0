From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: RE: [PATCH 07/56] microblaze_v2: Signal support
Date: Mon, 5 May 2008 14:32:45 -0700
Message-ID: <20080505213244.8DC757A0084@mail70-wa4.bigfish.com>
References: <a4a778e34c66d126f5c4bf1ca423cf32950ea5ab.1209897266.git.monstr@monstr.eu> <9a7c6646e5dd9724c1cf34767adec181481fa3ef.1209897266.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]:51777 "EHLO
	outbound2-wa4-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758240AbYEEVcp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 5 May 2008 17:32:45 -0400
Content-class: urn:content-classes:message
In-reply-to: <9a7c6646e5dd9724c1cf34767adec181481fa3ef.1209897266.git.monstr@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, John Linn <linnj@xilinx.com>, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>


(multiple places)  can this code (and flush_cache_sigtramp()) go away?

+#if 0
+		flush_cache_sigtramp((unsigned long)frame->tramp);
+#endif
