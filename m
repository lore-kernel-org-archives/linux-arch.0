Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53604 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754464Ab3LJPuF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Dec 2013 10:50:05 -0500
Message-ID: <1386690596.1979.43.camel@deneb.redhat.com>
Subject: Re: [PATCH v2 00/11] Consolidate asm/fixmap.h files
From: Mark Salter <msalter@redhat.com>
Date: Tue, 10 Dec 2013 10:49:56 -0500
In-Reply-To: <CACM3HyGCPMbw3t+DFFSySEytvDMnGGQMS6pVFpGbhkAoDzjhXg@mail.gmail.com>
References: <1385396045-15852-1-git-send-email-msalter@redhat.com>
	 <CACM3HyGCPMbw3t+DFFSySEytvDMnGGQMS6pVFpGbhkAoDzjhXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas.bonn@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20131210154956.ll-ZgX0WF5aHQEONJ42ZL1Vq6yX7d-N6t0g-oGrn2Vo@z>

On Tue, 2013-12-10 at 09:48 +0100, Jonas Bonn wrote:
> Hi Mark,
> 
> Is there some reason you've excluded OpenRISC here?  Did you just miss
> it, or does the implementation diverage too much to be usable with
> your generic version?

It was the runtime BUG() in fix_to_virt() instead of the usual build
time check. I thought that might be a toolchain issue and I didn't have
a toolchain to try it with. If you're okay with the build time check, I
don't see why you couldn't use the generic macros.

--Mark


