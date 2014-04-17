From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 00/18] Cross-architecture definitions of relaxed MMIO
 accessors
Date: Thu, 17 Apr 2014 17:36:38 +0200
Message-ID: <20140417153638.GA7317@ravnborg.org>
References: <1397742261-15621-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from asavdk3.altibox.net ([109.247.116.14]:41002 "EHLO
	asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbaDQPgp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Apr 2014 11:36:45 -0400
Content-Disposition: inline
In-Reply-To: <1397742261-15621-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, monstr@monstr.eu, dhowells@redhat.com, broonie@linaro.org, benh@kernel.crashing.org, peterz@infradead.org, paulmck@linux.vnet.ibm.com

On Thu, Apr 17, 2014 at 02:44:03PM +0100, Will Deacon wrote:
> Hello,
> 
> This RFC series attempts to define a portable (i.e. cross-architecture)
> definition of the {readX,writeX}_relaxed MMIO accessor functions. These
> functions are already in widespread use amongst drivers (mainly those supporting
> devices embedded in ARM SoCs), but lack any well-defined semantics and,
> subsequently, any portable definitions to allow these drivers to be compiled for
> other architectures.

Could this be made in such a way that only architectures that need
to provide their own versions actually have to add them?

The current patch-set adds the same dummy defines all over,
and will put this burden also on new architectures.

	Sam
