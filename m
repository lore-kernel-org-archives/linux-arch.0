From: "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: [RFC PATCH 00/28] Linux Kernel Library
Date: Sat, 7 Nov 2015 10:48:06 +0000
Message-ID: <20151107104806.GV29330@redhat.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
 <CAFLxGvzZozV0rDpY_VcQaFH+dx_+tHGyEy+22kgL=wdS5pSqCw@mail.gmail.com>
 <20151103224545.GI29330@redhat.com>
 <CAE1zotKa5B4xW5dzbrkGFcf7=ZTyVRLjvxnHtXV2nUzZ8HW_0g@mail.gmail.com>
 <20151104135015.GN29330@redhat.com>
 <CAE1zotLMxGH1BWXg6JRSs9HD=Wfhee9OSsaufUjmxQXsTRqs=Q@mail.gmail.com>
 <563D4758.9080507@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38519 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbbKGKsI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 7 Nov 2015 05:48:08 -0500
Content-Disposition: inline
In-Reply-To: <563D4758.9080507@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Octavian Purdila <octavian.purdila@intel.com>, Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Hajime Tazaki <thehajime@gmail.com>


I just pushed a (very early) WIP branch that contains changes to
libguestfs to add an LKL backend:

  https://github.com/rwmjones/libguestfs/tree/lkl

Read the README file in the libguestfs sources before starting,
followed by the instructions in the commit message:

  https://github.com/rwmjones/libguestfs/commit/e38525f0b984d0a426f3348d95f2033673d4eaa4

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
