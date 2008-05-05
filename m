From: John Williams <john.williams@petalogix.com>
Subject: Re: [PATCH 12/56] microblaze_v2: lmb support
Date: Mon, 05 May 2008 12:11:39 +1000
Message-ID: <1209953499.5798.57.camel@localhost>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz>
	 <a4a778e34c66d126f5c4bf1ca423cf32950ea5ab.1209897266.git.monstr@monstr.eu>
	 <c805caeb1dd7f6d1349c4a463cb88a5342a170d2.1209897266.git.monstr@monstr.eu>
	 <f120ababf2bade9aab7199bffb3014aa606e5a1c.1209897266.git.monstr@monstr.eu>
	 <684c36e5ad3f598e5079e88ec195545c4a7150c2.1209897266.git.monstr@monstr.eu>
	 <ed3695121faf485d491cecdd96d5d4dcc498411d.1209897266.git.monstr@monstr.eu>
	 <0674b1f7abb9a3d564b68c95bc28adc2c2fe9551.1209897266.git.monstr@monstr.eu>
	 <9a7c6646e5dd9724c1cf34767adec181481fa3ef.1209897266.git.monstr@monstr.eu>
	 <932956128c9c655a218a940eaf02017a5dd0bdf9.1209897266.git.monstr@monstr.eu>
	 <2f801c33caee22e112af51ae927c264ce99ead01.1209897266.git.monstr@monstr.eu>
	 <2391e49379fb6639f57d9d6e5811f3d49a4c6fda.1209897266.git.monstr@monstr.eu>
	 <0873f3a1f3b72591735c6461b51964693cac52e5.1209897266.git.monstr@monstr.eu>
	 <0ba1f259d3c17eba54e334622493577493f5065f.1209897266.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from uki.us.mooball.net ([66.98.178.13]:49156 "EHLO
	uki.us.mooball.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbYEECMQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 22:12:16 -0400
In-Reply-To: <0ba1f259d3c17eba54e334622493577493f5065f.1209897266.git.monstr@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>


> --- /dev/null
> +++ b/include/asm-microblaze/lmb.h

Since LMB has a very specific (and different) meaning the microblaze
context (LMB = Local Memory Bus), can we have a comment or explanation
from the PPC folks on what LMB actually stands for?

That can then become a disambiguating comment in the microblaze source
code that refers to it.
