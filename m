Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:50525 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933437AbbFIMfw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 08:35:52 -0400
Date: Tue, 9 Jun 2015 14:35:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 22/28] ARCv2: STAR 9000837815 workaround hardware
 exclusive transactions livelock
Message-ID: <20150609123548.GZ3644@twins.programming.kicks-ass.net>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
 <1433850508-26317-23-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1433850508-26317-23-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, arc-linux-dev@synopsys.com
Message-ID: <20150609123548.jOkY8MFDvw_CEjmcPBf8vtLXnmmKbrTexRiPnz-mVns@z>

On Tue, Jun 09, 2015 at 05:18:22PM +0530, Vineet Gupta wrote:

This really really wants a Changelog describing the actual hardware fail
and why this workaround is sufficient.
