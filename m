Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:3206 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154Ab1IMBeb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Sep 2011 21:34:31 -0400
Date: Mon, 12 Sep 2011 20:34:29 -0500
From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [patch v3 30/36] Hexagon: Add page-fault support.
Message-ID: <20110913013429.GE6925@codeaurora.org>
References: <20110909010847.294039464@codeaurora.org>
 <20110909010917.578513171@codeaurora.org>
 <1315753729.455.56.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1315753729.455.56.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20110913013429.E0OJuqnhjmlVNoUnUdOTrYKNXGEMCsjmzxjxV2SgX1Q@z>

On Sun, Sep 11, 2011 at 12:08:49PM -0300, Benjamin Herrenschmidt wrote:
> Are you sure about enabling interrupts before going to "no_context" ?
> 
> If somebody does a user access "in atomic" with interrupt disabled (with
> the expectation that a fault would be caught by search_exception_tables
> and returned as -EFAULT), such code probably doesn't expect interrupts
> to be re-enabled implicitely.

I hadn't considered that...  I'll review this and make sure this isn't what
we intended (it probably isn't) and get it fixed.


Thanks,
Richard Kuo


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
