From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH percpu 1/2] microblaze: include EXIT_TEXT to _stext
Date: Thu, 09 Jul 2009 11:28:49 +0900
Message-ID: <4A5555E1.7000601@kernel.org>
References: <4A546646.70305@kernel.org> <4A5476D2.7040709@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57285 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755573AbZGIC3D (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Jul 2009 22:29:03 -0400
In-Reply-To: <4A5476D2.7040709@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@monstr.eu
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, microblaze-uclinux@itee.uq.edu.au, Sam Ravnborg <sam@ravnborg.org>, Paul Mundt <lethal@linux-sh.org>, Tony Luck <tony.luck@intel.com>, Mike Frysinger <vapier@gentoo.org>

Michal Simek wrote:
>> Michal, I added the commit messaeg and SOB.  If you don't like it
>> please let me know.
> 
> It is ok. I rechecked it and works.

Thanks.  Patches committed to percpu#for-next.

-- 
tejun
