Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:1728 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750710AbWERGTa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 May 2006 02:19:30 -0400
From: Keith Owens <kaos@sgi.com>
Subject: Replace i386/x86_64 nmi_callback RCU code with atomic notifier chain
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 May 2006 16:17:12 +1000
Message-ID: <8256.1147933032@kao2.melbourne.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Paul Mackerras <paulus@au.ibm.com>, Alan Stern <stern@rowland.harvard.edu>, Hariprasad Nellitheertha <hari@in.ibm.com>, Zwane Mwaikambo <zwane@linuxpower.ca>
List-ID: <linux-arch.vger.kernel.org>

i386 and x86_64 have low level RCU code to handle dynamic registration
and unregistration of the NMI callback function.  With the rewrite of
the general notifier chains, we can remove the low level RCU hacking
from these NMI handlers and replace them with an atomic notifier chain,
making the code much simpler.  set_nmi_callback() gets replaced by yet
another notify chain.  The only affected code outside the main NMI
handler is crash and oprofile.  Any objections?

