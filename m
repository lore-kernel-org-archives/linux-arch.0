Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fallback.mail.elte.hu ([157.181.151.13]:35626 "EHLO
	fallback.mail.elte.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932991AbXCPJgz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Mar 2007 05:36:55 -0400
Date: Fri, 16 Mar 2007 10:30:16 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 08/26] Xen-paravirt_ops: add hooks to intercept mm creation and destruction
Message-ID: <20070316093016.GP23174@elte.hu>
References: <20070301232443.195603797@goop.org> <20070301232527.110592372@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070301232527.110592372@goop.org>
Sender: linux-arch-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Add hooks to allow a paravirt implementation to track the lifetime of 
> an mm.

(i guess this one should be merged with the ARCH-define cleanup patch)

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
