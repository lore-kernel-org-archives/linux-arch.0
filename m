Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:58533 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751348AbWERLQg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 May 2006 07:16:36 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: Replace i386/x86_64 nmi_callback RCU code with atomic notifier chain
Date: Thu, 18 May 2006 12:15:27 +0200
References: <8256.1147933032@kao2.melbourne.sgi.com>
In-Reply-To: <8256.1147933032@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605181215.28289.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Keith Owens <kaos@sgi.com>
Cc: linux-arch@vger.kernel.org, Paul Mackerras <paulus@au.ibm.com>, Alan Stern <stern@rowland.harvard.edu>, Hariprasad Nellitheertha <hari@in.ibm.com>, Zwane Mwaikambo <zwane@linuxpower.ca>
List-ID: <linux-arch.vger.kernel.org>

On Thursday 18 May 2006 08:17, Keith Owens wrote:
> i386 and x86_64 have low level RCU code to handle dynamic registration
> and unregistration of the NMI callback function.  With the rewrite of
> the general notifier chains, we can remove the low level RCU hacking
> from these NMI handlers and replace them with an atomic notifier chain,
> making the code much simpler.  set_nmi_callback() gets replaced by yet
> another notify chain.  The only affected code outside the main NMI
> handler is crash and oprofile.  Any objections?

It has been already done. Check -mm or firstfloor tree. However I don't 
know if the module unload case is fully correct. If you find holes
feel free to submit patches for that.

But normally just for module unloading you don't need individual
RCU because the module unloader does a stop_machine() and that
blocks out most thing.

-Andi
