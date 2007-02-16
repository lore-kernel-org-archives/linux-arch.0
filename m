Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:49179 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946212AbXBPSi7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 Feb 2007 13:38:59 -0500
Message-ID: <45D5F2EC.5000402@goop.org>
Date: Fri, 16 Feb 2007 10:07:40 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: [RFC] killing the NR_IRQS arrays.
References: <m1ire2e20p.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ire2e20p.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-ID: <linux-arch.vger.kernel.org>

Eric W. Biederman wrote:
> So I propose we remove all assumptions from the code that we actually
> have an array of irqs.  That will allow for irq_desc to be dynamically
> allocated instead of statically allocated saving memory and reducing
> kernel complexity.
>   

Sounds good to me.  In Xen we have 1024 event channels which we need to
map down into a smaller irq.  Aside from the complexity of maintaining a
mapping table, that's not a huge issue for now, but when we start
exposing pci devices to guests it all becomes more complex.  The ideal
for us is to simply use event channel == irq, which this would allow.

    J
