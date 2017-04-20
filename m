From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH v2 0/6] Signal frame expansion support
Date: Thu, 20 Apr 2017 21:49:36 +1000
Message-ID: <8760hz47u7.fsf@concordia.ellerman.id.au>
References: <1492016239-19511-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:53647 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S943017AbdDTLtk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Apr 2017 07:49:40 -0400
In-Reply-To: <1492016239-19511-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>

Dave Martin <Dave.Martin@arm.com> writes:

> (Note: This is an arm64-specific series, but the concepts introduced may
> be of interest to other arches -- see in particular patch 6.)

Hi Dave,

I think we (powerpc) will probably want to use this too.

I haven't dug into the details yet, I'll try and do that after the 4.12
merge window.

cheers
