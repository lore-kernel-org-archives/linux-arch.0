Return-Path: <SRS0=z9eI=7A=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgERQ3d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 12:29:33 -0400
Date: Mon, 18 May 2020 17:29:28 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 14/14] prctl.2: Add PR_PAC_RESET_KEYS (arm64)
Message-ID: <20200518162928.GP32394@willie-the-truck>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-15-git-send-email-Dave.Martin@arm.com>
 <20200513072530.GA18196@willie-the-truck>
 <20200513143653.GQ21779@arm.com>
 <20200513210022.GA28594@willie-the-truck>
 <20200518161128.GB21779@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518161128.GB21779@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Amit Daniel Kachhap <amit.kachhap@arm.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20200518162928.qVA5TOT45CvRv4pYjVySSQeqjOdJsw5Mv94eTMIMIRI@z>

On Mon, May 18, 2020 at 05:11:28PM +0100, Dave Martin wrote:
> How about summarising the key error cases here, and just putting a cross-
> reference in the ERRORS section rather than trying to describe them
> there?  I really don't want to duplicate this stuff -- that will get
> unmaintanable, fast (if it hasn't already).

Makes sense to me.

Will
