Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3157 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935030AbXFFUr7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jun 2007 16:47:59 -0400
Date: Wed, 6 Jun 2007 21:47:49 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 0/9] Thumb-2 ISA kernel port
Message-ID: <20070606204748.GA12482@flint.arm.linux.org.uk>
References: <20070606172409.6689.26641.stgit@localhost.localdomain> <20070606182914.GB6303@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070606182914.GB6303@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Wed, Jun 06, 2007 at 08:29:14PM +0200, Sam Ravnborg wrote:
> #define FUNCTION(name)   .type name, %function
> Introducing this simple macro in the generic ARM codebase would
> bring down the diff significantly

We have such a macro already - ENDPROC().  Recently introduced,
we should probably make more use of it.
