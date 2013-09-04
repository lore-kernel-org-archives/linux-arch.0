From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 13/25] mips: Use Kbuild infrastructure to handle
 asm-generic headers
Date: Wed, 4 Sep 2013 11:43:50 -0400
Message-ID: <20130904114350.07a40c95@gandalf.local.home>
References: <20121013022632.024527228@goodmis.org>
	<20121013022954.289710602@goodmis.org>
	<5224529D.10009@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:32941 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934868Ab3IDPnw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Sep 2013 11:43:52 -0400
In-Reply-To: <5224529D.10009@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>

On Mon, 2 Sep 2013 09:55:57 +0100
James Hogan <james.hogan@imgtec.com> wrote:

> On 13/10/12 03:26, Steven Rostedt wrote:

> Also note, as I said in the commit message:
> >     We can't do the same for uapi/asm/kvm_para.h because it's presence is
> >     explicitly checked in include/uapi/linux/Kbuild to decide whether to add
> >     kvm_para.h to header-y.
> 
> so I guess that may need fixing first before half of these patches can
> be accepted.
> 

Sure.

Thanks,

-- Steve
