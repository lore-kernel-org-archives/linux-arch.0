Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:59752 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752501AbXB0Syc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 27 Feb 2007 13:54:32 -0500
Subject: Re: [patch 09/26] Xen-paravirt_ops: remove HAVE_ARCH_MM_LIFETIME,
	define no-op architecture implementations
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <45E47D08.5020802@goop.org>
References: <20070227081337.434798469@goop.org>
	 <20070227081632.356636957@goop.org>
	 <1172589358.3408.2.camel@mulgrave.il.steeleye.com>
	 <45E46889.9090801@goop.org>
	 <1172597726.3408.25.camel@mulgrave.il.steeleye.com>
	 <45E470D6.7050401@goop.org>
	 <1172599480.3408.28.camel@mulgrave.il.steeleye.com>
	 <45E47D08.5020802@goop.org>
Content-Type: text/plain
Date: Tue, 27 Feb 2007 12:53:14 -0600
Message-Id: <1172602394.3408.30.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2007-02-27 at 10:48 -0800, Jeremy Fitzhardinge wrote:
> Well, I'm happy to create asm-generic/mm_hooks.h or something, and
> reduce all the changes to asm-*/mmu_context.h to a one-liner.

If no-one else objects, that will certainly make my life easier, thanks!

James


