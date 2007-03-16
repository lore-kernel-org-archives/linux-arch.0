Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fallback.mail.elte.hu ([157.181.151.13]:35523 "EHLO
	fallback.mail.elte.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933142AbXCPJey (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Mar 2007 05:34:54 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim)
	id 1HS8po-0006F0-69
	from <mingo@elte.hu>
	for <linux-arch@vger.kernel.org>; Fri, 16 Mar 2007 10:34:52 +0100
Date: Fri, 16 Mar 2007 10:27:36 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 09/26] Xen-paravirt_ops: remove HAVE_ARCH_MM_LIFETIME, define no-op architecture implementations
Message-ID: <20070316092736.GO23174@elte.hu>
References: <20070301232443.195603797@goop.org> <20070301232527.362011844@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070301232527.362011844@goop.org>
Sender: linux-arch-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org, James Bottomley <James.Bottomley@steeleye.com>
List-ID: <linux-arch.vger.kernel.org>


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> akpm:
> > Can we lose __HAVE_ARCH_MM_LIFETIME?  Just define these (preferably in C,
> > not in cpp) in the appropriate include/asm-foo/ files?

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
