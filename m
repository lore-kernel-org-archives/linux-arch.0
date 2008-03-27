Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.171.30]:38470 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755193AbYC0BVZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 Mar 2008 21:21:25 -0400
Date: Wed, 26 Mar 2008 18:19:26 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: What if a TLB flush needed to sleep?
In-Reply-To: <alpine.LFD.1.00.0803262121440.3781@apollo.tec.linutronix.de>
Message-ID: <Pine.LNX.4.64.0803261817110.1115@schroedinger.engr.sgi.com>
References: <1FE6DD409037234FAB833C420AA843ECE9DF60@orsmsx424.amr.corp.intel.com>
 <Pine.LNX.4.64.0803261222090.31000@schroedinger.engr.sgi.com>
 <alpine.LFD.1.00.0803262121440.3781@apollo.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20080327011926.xi29fMQPxoogONE4ZNXxNYBE-wwYdj5I7qZlZjNFbPw@z>

On Wed, 26 Mar 2008, Thomas Gleixner wrote:

> Please use a mutex, not a semaphore. semaphores should only be used
> when you need a counting sempahore.

Seems that mutexes are mainly useful for 2 processor systems since they 
do not allow concurrent read sections. We want multiple processors able 
to reclaim pages within the same vma or file concurrently. This means 
processors need to be able to concurrently walk potentially long lists of 
vmas.
