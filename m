From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 12/14] docs: move remaining stuff under
 Documentation/*.txt to Documentation/staging
Date: Sun, 03 May 2020 17:47:11 -0700
Message-ID: <a88be1298aa1600f46e868dd45f83a6075c7162e.camel@perches.com>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
         <28687056965ff46c0e6c81663a419bc59cfb94b4.1588345503.git.mchehab+huawei@kernel.org>
         <20200504085415.db8e0e3b40e795f2fb4af009@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:53038 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726549AbgEDArR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 May 2020 20:47:17 -0400
In-Reply-To: <20200504085415.db8e0e3b40e795f2fb4af009@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Lecopzer Chen <lecopzer.chen@mediatek.com>, Sameer Rahmani <lxsameer@gnu.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, Thomas Gleixner <tg>

On Mon, 2020-05-04 at 08:54 +0900, Masami Hiramatsu wrote:
> On Fri,  1 May 2020 17:37:56 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
[]
> > diff --git a/MAINTAINERS b/MAINTAINERS
[]
> > @@ -9855,7 +9855,7 @@ L:	linux-kernel@vger.kernel.org
> >  L:	linux-arch@vger.kernel.org
> >  S:	Supported
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
> > -F:	Documentation/atomic_bitops.txt
> > +F:	Documentation/staging/atomic_bitops.txt

Can you please keep the file lists in alphabetic order
and move this entry down appropriately?  Thanks.

> >  F:	Documentation/atomic_t.txt
> >  F:	Documentation/core-api/atomic_ops.rst
> >  F:	Documentation/core-api/refcount-vs-atomic.rst
