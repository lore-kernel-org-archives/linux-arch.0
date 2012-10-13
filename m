From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 23/25] unicore32: Use Kbuild infrastructure for
 kvm_para.h
Date: Sat, 13 Oct 2012 10:03:00 -0400
Message-ID: <1350136980.24256.98.camel@gandalf.local.home>
References: <20121013022632.024527228@goodmis.org>
	 <20121013022955.738395112@goodmis.org>
	 <4190.124.205.227.162.1350131263.squirrel@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:14146 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339Ab2JMODC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 13 Oct 2012 10:03:02 -0400
In-Reply-To: <4190.124.205.227.162.1350131263.squirrel@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: guanxuetao@mprc.pku.edu.cn
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>

On Sat, 2012-10-13 at 20:27 +0800, guanxuetao@mprc.pku.edu.cn wrote:
> > From: Steven Rostedt <srostedt@redhat.com>
> >
> > All the headers but kvm_para.h use the Kbuild infrastructure to
> > get to the asm-generic headers.
> 
> I merged the uapi patch for unicore32.
> In that patch, kvm_para.h was moved to
> arch/unicore32/include/uapi/asm/kvm_para.h.
> Anyway, I'd like to apply this patch based on uapi modification.
> 

Sure, do whatever you want ;-)

-- Steve
