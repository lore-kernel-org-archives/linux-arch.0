Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:37066 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755365AbYC0SqQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 27 Mar 2008 14:46:16 -0400
Date: Thu, 27 Mar 2008 11:44:14 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: What if a TLB flush needed to sleep?
In-Reply-To: <1206624052.8514.570.camel@twins>
Message-ID: <Pine.LNX.4.64.0803271143540.7531@schroedinger.engr.sgi.com>
References: <1FE6DD409037234FAB833C420AA843ECE9DF60@orsmsx424.amr.corp.intel.com>
  <Pine.LNX.4.64.0803261222090.31000@schroedinger.engr.sgi.com>
 <alpine.LFD.1.00.0803262121440.3781@apollo.tec.linutronix.de>
 <Pine.LNX.4.64.0803261817110.1115@schroedinger.engr.sgi.com>
 <1206624052.8514.570.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Luck, Tony" <tony.luck@intel.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20080327184414.FMCMzkJoiq2XVpA4g_ee_dWfei66OyBo61k7yfpr5xA@z>

On Thu, 27 Mar 2008, Peter Zijlstra wrote:

> confusion between semaphores and rwsems

rwsem is not a semaphore despite its name? What do you want to call it 
then?

